
// full datapath, includes: 
//	ll/ps/ne comp modules, controllers, and filters(in future)


// under testing

module datapath #(
	//overall
	parameter input_width = 32,  

	//for ne and sp
	parameter unit_width = 32,
	parameter mid_width = 37,
	parameter output_width = 40,

	//for ll
	parameter ll_mid_width = 22,
	parameter ll_output_width = 25
)(

	input signed [input_width-1:0] din,
	input en, rst, clk, //rst active high,en active low
  	output stimulation
	
	//please put debugging purpose ports after this line

);
	
//filters
	wire signed [31:0] filter_4to70_out;
	f_4to70 my_filter_4to70(
		.x(din),
		.y(filter_4to70_out),
		.reset(rst),
		.clk(clk)
	);


//computing module

	// line length
	wire signed [input_width + 8:0] ll_out;
	wire data_valid_ll;

	ll_module #(input_width, input_width + 6 , input_width + 9) ll(
		.din(filter_4to70_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ll_out),
		.data_valid(data_valid_ll)
	);

	// non-linear energy
	wire signed [input_width * 2 + 7:0] ne_out;
	wire data_valid_ne;

	ne_module #(input_width, input_width * 2, input_width * 2 + 5, input_width * 2 + 8) ne(
		.din(filter_4to70_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ne_out),
		.data_valid(data_valid_ne)
	);

	// power spectrum 4-70
	wire signed [input_width * 2 + 7:0] ps_out;
	wire data_valid_ps;

	ps_module #(input_width, input_width * 2, input_width * 2 + 5, input_width * 2 + 8) ps(
		.din(filter_4to70_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ps_out),
		.data_valid(data_valid_ps)
	);

	// theta
	wire signed [31:0] theta_out;
	f_4to8 theta_band(
		.clk(clk),
		.reset(rst),
		.x(filter_4to70_out),
		.y(theta_out)
	);

	// alpha
	wire signed [31:0] alpha_out;
	f_8to14 alpha_band(
		.clk(clk),
		.reset(rst),
		.x(filter_4to70_out),
		.y(alpha_out)
	);

	// beta
	wire signed [31:0] beta_out;
	f_14to32 beta_band(
		.clk(clk),
		.reset(rst),
		.x(filter_4to70_out),
		.y(beta_out)
	);

	// power spectrum theta band
	wire signed [output_width-1:0] ps_out_theta;
	wire data_valid_ps_theta;

	ps_module #(input_width,unit_width,mid_width,output_width) ps_theta(
		.din(theta_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ps_out_theta),
		.data_valid(data_valid_ps_theta)
	);

	// power spectrum alpha band
	wire signed [output_width-1:0] ps_out_alpha;
	wire data_valid_ps_alpha;

	ps_module #(input_width,unit_width,mid_width,output_width) ps_alpha(
		.din(alpha_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ps_out_alpha),
		.data_valid(data_valid_ps_alpha)
	);

	// power spectrum beta band
	wire signed [output_width-1:0] ps_out_beta;
	wire data_valid_ps_beta;

	ps_module #(input_width,unit_width,mid_width,output_width) ps_beta(
		.din(beta_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ps_out_beta),
		.data_valid(data_valid_ps_beta)
	);

// baseline

	// line length baseline
	wire [ll_output_width+8:0] ll_baseline_out;
	baseline #(ll_output_width, ll_output_width + 3, ll_output_width + 6, ll_output_width + 9) ll_baseline (
		.din(ll_out),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(ll_baseline_out)
	);

	// non-linear energy baseline
	wire [output_width+8:0] ne_baseline_out;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9) ne_baseline (
		.din(ne_out),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(ne_baseline_out)
	);

	// power spectrum 4-70 baseline
	wire [output_width+8:0] ps_baseline_out;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9) ps_baseline (
		.din(ps_out),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(ps_baseline_out)
	);

	// power spectrum theta baseline
	wire [output_width+8:0] theta_baseline_out;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9) theta_baseline (
		.din(ps_out_theta),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(theta_baseline_out)
	);

	// power spectrum alpha baseline
	wire [output_width+8:0] alpha_baseline_out;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9) alpha_baseline (
		.din(ps_out_alpha),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(alpha_baseline_out)
	);

	// power spectrum beta baseline
	wire [output_width+8:0] beta_baseline_out;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9) beta_baseline (
		.din(ps_out_beta),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(beta_baseline_out)
	);

// binary classification
	wire ll_binary;
	wire ne_binary;
	wire ps_binary;
	wire theta_binary;
	wire alpha_binary;
	wire beta_binary;

	binary_channel #(3891, 11878, 5530, 7680, 11878, 20480) channel_0 (
		.ll_out(ll_out),
		.ll_base(ll_baseline_out),
		.ll_binary(ll_binary),
		.ne_out(ne_out),
		.ne_base(ne_baseline_out),
		.ne_binary(ne_binary),
		.ps_out(ps_out),
		.ps_base(ps_baseline_out),
		.ps_binary(ps_binary),
		.theta_out(ps_out_theta),
		.theta_base(theta_baseline_out),
		.theta_binary(theta_binary),
		.alpha_out(ps_out_alpha),
		.alpha_base(alpha_baseline_out),
		.alpha_binary(alpha_binary),
		.beta_out(ps_out_beta),
		.beta_base(beta_baseline_out),
		.beta_binary(beta_binary)
	);

// weighted sum
	wire signed [11:0] weighted_sum_0;
	weighted_sum #(18, 39, -7, 382, 64, 68) ws0 (
		.ll(ll_bianry),
		.ne(ne_bianry),
		.ps(ps_bianry),
		.theta(theta_bianry),
		.alpha(alpha_bianry),
		.beta(beta_bianry),
		.weighted_sum_out(weighted_sum_0)
	);

// controller
	parameter THRESHOLD = 'd300;
	assign stimulation = (weighted_sum_0 >= THRESHOLD);

	// controller #(input_width + 9, input_width * 2 + 8) myctrl(
	// 	//outcome sigals
	// 	.din_ll(ll_out),
	// 	.din_ne(ne_out),
	// 	.din_ps(ps_out),
		
	// 	//din ready
	// 	.data_ready_ll(data_valid_ll),
	// 	.data_ready_ne(data_valid_ne),
	// 	.data_ready_ps(data_valid_ps),

	// 	//output
	// 	.stimulation(stimulation)
	// );

endmodule

