
// full datapath, includes: 
//	ll/ps/ne comp modules, controllers, and filters(in future)


// under testing

module datapath_single #(
	//overall
	parameter input_width = 32,  
	//for ne and sp
	parameter output_width = 40,
	//for ll
	parameter ll_output_width = 25,

	parameter w0 = 0,
	parameter w1 = 0,
	parameter w2 = 0,
	parameter w3 = 0,
	parameter w4 = 0,
	parameter w5 = 0,
	parameter ws0 = 0,
	parameter ws1 = 0,
	parameter ws2 = 0,
	parameter ws3 = 0,
	parameter ws4 = 0,
	parameter ws5 = 0
)(

	input signed [input_width-1:0] din,
	input en, rst, clk, //rst active high,en active low

	// for test purpose
	output [31:0] ll_test,
	output [31:0] ne_test,
	output [31:0] ps_test,
	output [31:0] theta_test,
	output [31:0] alpha_test,
	output [31:0] beta_test,

  	output signed [11:0] weight_sum
	
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
	wire signed [input_width * 2 + 7:0] ps_out_theta;
	wire data_valid_ps_theta;

	ps_module #(input_width, input_width * 2, input_width * 2 + 5, input_width * 2 + 8) ps_theta(
		.din(theta_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ps_out_theta),
		.data_valid(data_valid_ps_theta)
	);

	// power spectrum alpha band
	wire signed [input_width * 2 + 7:0] ps_out_alpha;
	wire data_valid_ps_alpha;

	ps_module #(input_width, input_width * 2, input_width * 2 + 5, input_width * 2 + 8) ps_alpha(
		.din(alpha_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ps_out_alpha),
		.data_valid(data_valid_ps_alpha)
	);

	// power spectrum beta band
	wire signed [input_width * 2 + 7:0] ps_out_beta;
	wire data_valid_ps_beta;

	ps_module #(input_width, input_width * 2, input_width * 2 + 5, input_width * 2 + 8) ps_beta(
		.din(beta_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ps_out_beta),
		.data_valid(data_valid_ps_beta)
	);

// baseline

	// line length baseline
	wire [ll_output_width+11:0] ll_baseline_out;
	wire data_valid_base_ll;
	baseline #(ll_output_width, ll_output_width + 3, ll_output_width + 6, ll_output_width + 9, ll_output_width + 12) ll_baseline (
		.din(ll_out),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(ll_baseline_out),
		.data_valid(data_valid_base_ll)
	);

	// non-linear energy baseline
	wire [output_width+11:0] ne_baseline_out;
	wire data_valid_base_ne;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9, output_width + 12) ne_baseline (
		.din(ne_out),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(ne_baseline_out),
		.data_valid(data_valid_base_ne)
	);

	// power spectrum 4-70 baseline
	wire [output_width+11:0] ps_baseline_out;
	wire data_valid_base_ps;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9, output_width + 12) ps_baseline (
		.din(ps_out),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(ps_baseline_out),
		.data_valid(data_valid_base_ps)
	);

	// power spectrum theta baseline
	wire [output_width+11:0] theta_baseline_out;
	wire data_valid_base_theta;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9, output_width + 12) theta_baseline (
		.din(ps_out_theta),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(theta_baseline_out),
		.data_valid(data_valid_base_theta)
	);

	// power spectrum alpha baseline
	wire [output_width+11:0] alpha_baseline_out;
	wire data_valid_base_alpha;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9, output_width + 12) alpha_baseline (
		.din(ps_out_alpha),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(alpha_baseline_out),
		.data_valid(data_valid_base_alpha)
	);

	// power spectrum beta baseline
	wire [output_width+11:0] beta_baseline_out;
	wire data_valid_base_beta;
	baseline #(output_width, output_width + 3, output_width + 6, output_width + 9, output_width + 12) beta_baseline (
		.din(ps_out_beta),
		.en(en),
		.clk(clk),
		.rst(rst),
		.dout(beta_baseline_out),
		.data_valid(data_valid_base_beta)
	);

	assign ll_test = ll_out;
	assign ps_test = ps_out;
	assign ne_test = ne_out;
	assign theta_test = ps_out_theta;
	assign alpha_test = ps_out_alpha;
	assign beta_test = ps_out_beta;

// binary classification
	wire ll_binary;
	wire ne_binary;
	wire ps_binary;
	wire theta_binary;
	wire alpha_binary;
	wire beta_binary;

	binary_channel #(w0, w1, w2, w3, w4, w5) channel_0 (
		.ll_out(ll_out),
		.ll_base(ll_baseline_out),
		.ll_valid(data_valid_base_ll),
		.ll_binary(ll_binary),
		.ne_out(ne_out),
		.ne_base(ne_baseline_out),
		.ne_valid(data_valid_base_ne),
		.ne_binary(ne_binary),
		.ps_out(ps_out),
		.ps_base(ps_baseline_out),
		.ps_valid(data_valid_base_ps),
		.ps_binary(ps_binary),
		.theta_out(ps_out_theta),
		.theta_base(theta_baseline_out),
		.theta_valid(data_valid_base_theta),
		.theta_binary(theta_binary),
		.alpha_out(ps_out_alpha),
		.alpha_base(alpha_baseline_out),
		.alpha_valid(data_valid_base_alpha),
		.alpha_binary(alpha_binary),
		.beta_out(ps_out_beta),
		.beta_base(beta_baseline_out),
		.beta_valid(data_valid_base_beta),
		.beta_binary(beta_binary)
	);

// weighted sum
	
	weighted_sum #(ws0, ws1, ws2, ws3, ws4, ws5) ws (
		.ll(ll_binary),
		.ne(ne_binary),
		.ps(ps_binary),
		.theta(theta_binary),
		.alpha(alpha_binary),
		.beta(beta_binary),
		.weighted_sum_out(weight_sum)
	);

endmodule
