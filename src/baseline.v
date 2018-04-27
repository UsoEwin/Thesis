// this is the baseline program 
// modify port size for different modules, default one is linelength
// under testing
module baseline #(

	parameter input_width = 25,
	parameter mid_width1 = 28,  // 25+log(5)
	parameter mid_width2 = 31,	// 28+log(5)
	parameter mid_width3 = 34,	// 31+log(6)
	parameter output_width = 37  // 34+log(8)
	//all computed by input + log(num of inputs) 

)(
	//inputs
	input signed [input_width-1:0] din,
	input en,clk,rst, // en active low

	//outputs
	output wire [output_width-1:0] dout,
	output data_valid
);

// stage 1, compute sliding window for 1s
reg [7:0] counter_1s;
reg [5:0] counter_02s;
wire data_ready_02s;
wire data_valid_1s;

always @(posedge clk) begin
	if (rst || counter_02s >= 50) begin
		// reset
		counter_02s <= 0;
	end
	else 
		counter_02s <= counter_02s + 1;
	
end

assign data_ready_02s = (counter_02s >= 50);

always @(posedge clk) begin
	if (rst || counter_1s >= 250) begin 
		counter_1s <= 0;
	end	
	else begin
		counter_1s <= counter_1s + 1;
	end
	
end

wire signed [input_width-1:0] dout_stage1_1s;
wire signed [input_width-1:0] dout_stage2_1s;
wire signed [input_width-1:0] dout_stage3_1s;
wire signed [input_width-1:0] dout_stage4_1s;
wire signed [input_width-1:0] dout_stage5_1s;

shift_reg #(input_width,5) shift_reg_stage1(

	//input part
	.din(din),.en(en),.rst(rst),.data_ready(data_ready_02s), //always taking new values
	.clk(clk),
	//output part
	.dout_stage1(dout_stage1_1s),.dout_stage2(dout_stage2_1s),
	.dout_stage3(dout_stage3_1s),.dout_stage4(dout_stage4_1s),
	.dout_stage5(dout_stage5_1s),.data_valid(data_valid_1s)
	);

// stage 2, compute sliding window for 5s
wire data_ready_5s;
wire [mid_width1-1:0] dout_1s;
reg [2:0] counter_5s;
wire data_valid_5s;
assign dout_1s = $signed(dout_stage1_1s)+$signed(dout_stage2_1s)+$signed(dout_stage3_1s)+$signed(dout_stage4_1s)+$signed(dout_stage5_1s);

always @(posedge clk) begin
	if (rst || counter_5s >= 5) begin
		counter_5s <= 0;
	end
	else if(counter_1s >= 250) begin
		counter_5s <= counter_5s + 1;
	end
end

assign data_ready_5s = (data_valid_1s && counter_5s >= 5); 
wire signed [mid_width1-1:0] dout_stage1_5s;
wire signed [mid_width1-1:0] dout_stage2_5s;
wire signed [mid_width1-1:0] dout_stage3_5s;
wire signed [mid_width1-1:0] dout_stage4_5s;
wire signed [mid_width1-1:0] dout_stage5_5s;

shift_reg #(mid_width1,5) shift_reg_stage2(

	//input part
	.din(dout_1s),.en(en),.rst(rst),.data_ready(data_ready_5s), //always taking new values
	.clk(clk),
	//output part
	.dout_stage1(dout_stage1_5s),.dout_stage2(dout_stage2_5s),
	.dout_stage3(dout_stage3_5s),.dout_stage4(dout_stage4_5s),
	.dout_stage5(dout_stage5_5s),.data_valid(data_valid_5s)
	);

//stage 3, computing sliding window for 30s
wire data_ready_30s;
wire [mid_width2-1:0] dout_5s;
reg [2:0] counter_30s;
wire data_valid_30s;
assign dout_5s = $signed(dout_stage1_5s)+$signed(dout_stage2_5s)+$signed(dout_stage3_5s)+$signed(dout_stage4_5s)+$signed(dout_stage5_5s);

always @(posedge clk) begin
	if (rst || counter_30s >= 6) begin
		counter_30s <= 0;
	end
	else if(counter_5s >= 5) begin
		counter_30s <= counter_30s + 1;
	end
end

assign data_ready_30s = (data_valid_5s && counter_30s >= 6); 

wire signed [mid_width2-1:0] dout_stage1_30s;
wire signed [mid_width2-1:0] dout_stage2_30s;
wire signed [mid_width2-1:0] dout_stage3_30s;
wire signed [mid_width2-1:0] dout_stage4_30s;
wire signed [mid_width2-1:0] dout_stage5_30s;
wire signed [mid_width2-1:0] dout_stage6_30s;

shift_reg_6 #(mid_width2,6) shift_reg_stage3(

	//input part
	.din(dout_5s),.en(en),.rst(rst),.data_ready(data_ready_30s), //always taking new values
	.clk(clk),
	//output part
	.dout_stage1(dout_stage1_30s),.dout_stage2(dout_stage2_30s),
	.dout_stage3(dout_stage3_30s),.dout_stage4(dout_stage4_30s),
	.dout_stage5(dout_stage5_30s),.dout_stage6(dout_stage6_30s),
	.data_valid(data_valid_30s)
	);

//stage 4,computing sliding window for 240s

wire data_ready_240s;
wire [mid_width3-1:0] dout_30s;
reg [3:0] counter_240s;
wire data_valid_240s;

assign dout_30s = $signed(dout_stage1_30s)+$signed(dout_stage2_30s)+$signed(dout_stage3_30s)+$signed(dout_stage4_30s)+$signed(dout_stage5_30s)+$signed(dout_stage6_30s);

always @(posedge clk) begin
	if (rst || counter_240s >=8) begin
		counter_240s <= 0;
	end
	else if(counter_30s >= 6) begin
		counter_240s <= counter_240s + 1;
	end
end

assign data_ready_240s = (data_valid_30s && counter_30s >= 6);

wire signed [mid_width3-1:0] dout_stage1_240s;
wire signed [mid_width3-1:0] dout_stage2_240s;
wire signed [mid_width3-1:0] dout_stage3_240s;
wire signed [mid_width3-1:0] dout_stage4_240s;
wire signed [mid_width3-1:0] dout_stage5_240s;
wire signed [mid_width3-1:0] dout_stage6_240s;
wire signed [mid_width3-1:0] dout_stage7_240s;
wire signed [mid_width3-1:0] dout_stage8_240s;

shift_reg_8 #(mid_width3,8) shift_reg_stage4(

	//input part
	.din(dout_30s),.en(en),.rst(rst),.data_ready(data_ready_240s), //always taking new values
	.clk(clk),
	//output part
	.dout_stage1(dout_stage1_240s),.dout_stage2(dout_stage2_240s),
	.dout_stage3(dout_stage3_240s),.dout_stage4(dout_stage4_240s),
	.dout_stage5(dout_stage5_240s),.dout_stage6(dout_stage6_240s),
	.dout_stage7(dout_stage7_240s),.dout_stage8(dout_stage8_240s),
	.data_valid(data_valid_240s)
	);

assign data_valid = data_valid_30s;

//output stage
wire signed [output_width-1:0] dout_240s;
assign dout_240s = $signed(dout_stage1_240s)+$signed(dout_stage2_240s)+$signed(dout_stage3_240s)+$signed(dout_stage4_240s); 

assign dout = (dout_240s >>> 10); 

endmodule
