
// full datapath, includes: 
//	ll/ps/ne comp modules, controllers, and filters(in future)


// under testing

module datapath #(
	//overall
	parameter input_width = 16,  

	//for ne and sp
	parameter unit_width = 32,
	parameter mid_width = 37,
	parameter output_width = 40,

	//for ll
	parameter ll_mid_width = 22,
	parameter ll_output_width = 25
)(

	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output stimulation
	
	//please put debugging purpose ports after this line

);
	
//filters
	wire signed [31:0] filter_4to70_out;
	filter_4to70 my_filter_4to70(
		.x(din),
		.y(filter_4to70_out),
		.reset(rst),
		.clk(clk)
	);


//computing module

	// line length
	wire signed [ll_output_width-1:0] ll_out;
	wire data_valid_ll;

	ll_module #(input_width,ll_mid_width,ll_output_width) ll(
		.din(filter_4to70_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ll_out),
		.data_valid(data_valid_ll)
	);

	// non-linear energy
	wire signed [output_width-1:0] ne_out;
	wire data_valid_ne;

	ne_module #(input_width,unit_width,mid_width,output_width) ne(
		.din(filter_4to70_out),
		.en(en),
		.rst(rst),
		.clk(clk),
		.dout(ne_out),
		.data_valid(data_valid_ne)
	);

	// power spectrum 4-70
	wire signed [output_width-1:0] ps_out;
	wire data_valid_ps;

	ps_module #(input_width,unit_width,mid_width,output_width) ps(
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

//controller

	controller #(ll_output_width,output_width) myctrl(

	//outcome sigals
	.din_ll(ll_out),.din_ne(ne_out),.din_ps(ps_out),
	
	//din ready
	.data_ready_ll(data_valid_ll),.data_ready_ne(data_valid_ne),.data_ready_ps(data_valid_ps),

	//output
	.stimulation(stimulation)
	);

endmodule

