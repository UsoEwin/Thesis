//
// giant adder to sum up 5 inputs, we don't care the delay
// you can choose tree adder or whatever
// under testing
module adder #(
	parameter input_width = 37, //for 32 bits input, change this for ne and ll
	parameter output_width = 40 //for 32 bits input
)(	
	input signed [input_width-1:0] din1,
	input signed [input_width-1:0] din2,
	input signed [input_width-1:0] din3,
	input signed [input_width-1:0] din4,
	input signed [input_width-1:0] din5,
	//input en,rst,clk, //pure comb logic
	//input wire data_valid //from the computing unit
	output signed [output_width-1:0] dout
	);

	assign dout = $signed(din5)+$signed(din4)+$signed(din3)+$signed(din2)+$signed(din1);
endmodule

