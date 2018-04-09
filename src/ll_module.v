//
// the sub-datapath of ll, will contain everything to compute a ll value
//
// under testing

module ll_module #(
	parameter input_width = 16,
	parameter mid_width = 22,//computed by 16+log(50) change this for ps and ne
	parameter output_width = 25//computed by 22+log(5)
)
	(	
	//input will be the same as ll unit
	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output wire signed [output_width-1:0] dout, 
	output wire 			   data_valid //to controller

	);

	//ll_comp_unit
	wire signed [input_width:0] unit_out; // 1 bit for carry
	wire data_valid_unit; //useless
	ll_comp_unit #(input_width) myll(
		.din(din),.en(en),.rst(rst),.clk(clk),.dout(unit_out),.data_valid(data_valid_unit)
		);

	//accu_unit
	wire signed [mid_width-1:0] accu_out;
	wire data_valid_accu;
	accu_unit #(mid_width) myaccu(
		.din(unit_out),.en(en),.rst(rst),.clk(clk),.dout(accu_out),.data_valid(data_valid_accu)
		);

	//shift_reg
	wire signed [mid_width-1:0] shift_reg_out1;
	wire signed [mid_width-1:0] shift_reg_out2;
	wire signed [mid_width-1:0] shift_reg_out3;
	wire signed [mid_width-1:0] shift_reg_out4;
	wire signed [mid_width-1:0] shift_reg_out5;
	wire data_valid_shifter;
	shift_reg #(mid_width,5) myshifter(
		//inputs
		.din(accu_out),.en(en),.clk(clk),.rst(rst),.data_ready(data_valid_accu),
		//outputs
		.dout_stage1(shift_reg_out1),.dout_stage2(shift_reg_out2),
		.dout_stage3(shift_reg_out3),.dout_stage4(shift_reg_out4),
		.dout_stage5(shift_reg_out5),.data_valid(data_valid_shifter)
		);
	assign data_valid = data_valid_shifter;// shifter will indicate if output is ok
	
	//adder5
	wire signed [output_width-1:0] adder_out;
	adder5 #(mid_width,output_width) myadder(
		.din1(shift_reg_out1),.din2(shift_reg_out2),
		.din3(shift_reg_out3),.din4(shift_reg_out4),
		.din5(shift_reg_out5),.dout(adder_out)
		);
	//final output
	assign dout = adder_out;
endmodule