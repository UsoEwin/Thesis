


module baseline #(
	parameter input_width = 25,
	parameter mid_width1 = 28,//computed by 25+log(5) 
	parameter mid_width2 = 31,//computed by 28+log(5)
	parameter output_width = 34,//computed by 31+log(6)
)
	(	
	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output wire signed [output_width-1:0] dout, 
	output wire 			   data_valid //to controller

	);

	// Calculate baseline 
	reg [2:0] count0;
	reg [2:0] count1;
	reg [2:0] count2;
	reg [3:0] count3;

	always @(posedge clk) begin
		if (rst) begin
			count0 <= 3'b0;
			count1 <= 3'b0;
			count2 <= 3'b0;
			count3 <= 4'b0;
		end
		count0 <= count0 + 1;
		count1 <= count1 + 1;
		count2 <= count2 + 1;
		count3 <= count3 + 1; 
	end

	wire signed [input_width-1:0] onesecin;
	wire data_valid0;
	// Get value of 1 sec non overlapping
	if count0 == 3'd5 begin
		assign onesecin = din; 
		assign data_valid0 = 1;
		assign count0 = 3'b0;
	end

	wire signed [input_width-1:0] shift_reg0_out1;
	wire signed [input_width-1:0] shift_reg0_out2;
	wire signed [input_width-1:0] shift_reg0_out3;
	wire signed [input_width-1:0] shift_reg0_out4;
	wire signed [input_width-1:0] shift_reg0_out5;
	wire data_valid_shifter0;
	shift_reg #(input_width,5) myshifter0(
		//inputs
		.din(onesecin),.en(en),.clk(clk),.rst(rst),.data_ready(data_valid0),
		//outputs
		.dout_stage1(shift_reg0_out1),.dout_stage2(shift_reg0_out2),
		.dout_stage3(shift_reg0_out3),.dout_stage4(shift_reg0_out4),
		.dout_stage5(shift_reg0_out5),.data_valid(data_valid_shifter0)
		);

	wire signed [mid_width1-1:0] shift_reg0_out;
	assign shift_reg0_dout = $signed(shift_reg0_out5)+$signed(shift_reg0_out4)+$signed(shift_reg0_out3)+$signed(shift_reg0_out2)+$signed(shift_reg0_out1);

	wire signed [mid_width1-1:0] fivesecin;
	wire data_valid1;
	// shift_reg for store 5 sec NON OVERLAPPING
	if count1 == 3'd5 begin
		assign fivesecin = shift_reg0_dout;
		assign datavalid1 = 1;
		assign count1 = 3'b0;
	end

	wire signed [mid_width1-1:0] shift_reg1_out1;
	wire signed [mid_width1-1:0] shift_reg1_out2;
	wire signed [mid_width1-1:0] shift_reg1_out3;
	wire signed [mid_width1-1:0] shift_reg1_out4;
	wire signed [mid_width1-1:0] shift_reg1_out5;
	wire signed [mid_width1-1:0] shift_reg1_out6;
	wire data_valid_shifter1;
	shift_reg_6 #(mid_width1,6) myshifter1(
		//inputs
		.din(fivesecin),.en(en),.clk(clk),.rst(rst),.data_ready(data_valid1),
		//outputs
		.dout_stage1(shift_reg1_out1),.dout_stage2(shift_reg1_out2),
		.dout_stage3(shift_reg1_out3),.dout_stage4(shift_reg1_out4),
		.dout_stage5(shift_reg1_out5),.dout_stage5(shift_reg1_out6),
		.data_valid(data_valid_shifter1)
		);

	wire signed [mid_width2-1:0] shift_reg1_out;
	assign shift_reg1_dout = $signed(shift_reg1_out6)+$signed(shift_reg1_out5)+$signed(shift_reg1_out4)+$signed(shift_reg1_out3)+$signed(shift_reg1_out2)+$signed(shift_reg1_out1);

	wire signed [mid_width2-1:0] thirtysecin;
	wire data_valid2;
	// shift_reg for store 30 sec NON OVERLAPPING segments
	if (count2 == 3'd6) begin
		assign thirtysecin = shift_reg1_dout;
		assign datavalid2 = 1;
		assign count2 = 3'b0;
	end

	wire signed [mid_width2-1:0] shift_reg2_out1;
	wire signed [mid_width2-1:0] shift_reg2_out2;
	wire signed [mid_width2-1:0] shift_reg2_out3;
	wire signed [mid_width2-1:0] shift_reg2_out4;
	wire signed [mid_width2-1:0] shift_reg2_out5;
	wire signed [mid_width2-1:0] shift_reg2_out6;
	wire signed [mid_width2-1:0] shift_reg2_out7;
	wire signed [mid_width2-1:0] shift_reg2_out8;
	wire data_valid_shifter2;
	shift_reg_8 #(mid_width2,8) myshifter2(
		//inputs
		.din(thirtysecin),.en(en),.clk(clk),.rst(rst),.data_ready(data_valid1),
		//outputs
		.dout_stage1(shift_reg2_out1),.dout_stage2(shift_reg2_out2),
		.dout_stage3(shift_reg2_out3),.dout_stage4(shift_reg2_out4),
		.dout_stage5(shift_reg2_out5),.dout_stage5(shift_reg2_out6),
		.dout_stage7(shift_reg2_out7),.dout_stage6(shift_reg2_out8),
		.data_valid(data_valid_shifter2)
		);

	wire signed [output_width-1:0] baseline_out;
	// Output baseline is the first 2 min of this 4 min chunk of non overlapping 30sec
	assign baseline_out = $signed(shift_reg2_out4)+$signed(shift_reg2_out3)+$signed(shift_reg2_out2)+$signed(shift_reg2_out1);

	assign data_valid = (data_valid_shifter2 == 1) && (dout !== 34'bx);

	// final output
	// shift baseline by 8 to compare to feature value <
	assign dout = baseline_out>>>8;

endmodule
