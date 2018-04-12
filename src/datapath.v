
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

//computing module

	//ll
	wire signed [ll_output_width-1:0] ll_out;
	wire data_valid_ll;
	ll_module #(input_width,ll_mid_width,ll_output_width) ll(

	.din(din),.en(en),.rst(rst),.clk(clk),.dout(ll_out),.data_valid(data_valid_ll)
	
	);

	//ps
	wire signed [output_width-1:0] ps_out;
	wire data_valid_ps;
	ps_module #(input_width,unit_width,mid_width,output_width) ps(

	.din(din),.en(en),.rst(rst),.clk(clk),.dout(ps_out),.data_valid(data_valid_ps)
	
	);

	//ne
	wire signed [output_width-1:0] ne_out;
	wire data_valid_ne;
	ne_module #(input_width,unit_width,mid_width,output_width) ne(

	.din(din),.en(en),.rst(rst),.clk(clk),.dout(ne_out),.data_valid(data_valid_ne)
	
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

