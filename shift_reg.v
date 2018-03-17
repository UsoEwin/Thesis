//
// the big shift reg for out put, 5 outputs will go into the big adder
// under testing
module shift_reg #(
	parameter input_width = 37, //for 32 bits input, change this for ne and ll
	parameter reg_depth = 5
)(	
	input signed [input_width-1:0] din,
	input en,rst,clk, //rst active high,en active low
	output wire signed [input_width-1:0] dout_stage1,
	output wire signed [input_width-1:0] dout_stage2,
	output wire signed [input_width-1:0] dout_stage3,
	output wire signed [input_width-1:0] dout_stage4,
	output wire signed [input_width-1:0] dout_stage5,
	input wire data_valid //from the computing unit
	);

	reg [input_width-1:0] shifter [reg_depth-1:0];
	integer i;

	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			
			for(i = 0; i< reg_depth; i = i+1)
				shifter[i] <= 0;
		end

		else if (~en) begin
			shifter[0] <= din;
			
			for(i = 1; i < reg_depth; i=i+1)
				shifter[i] <= shifter[i-1];
		end
		//if en is high, just hold
	end
	assign dout_stage1 = shifter[0];
	assign dout_stage2 = shifter[1];
	assign dout_stage3 = shifter[2];
	assign dout_stage4 = shifter[3];
	assign dout_stage5 = shifter[4];
	assign data_valid = (en === 1'b0);
endmodule

