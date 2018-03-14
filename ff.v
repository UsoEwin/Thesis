//a ff used in ll comp unit to perfrom delay
module ff #(
	parameter input_width = 32
)(	
	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output wire signed [input_width-1:0] dout, 
	);
	
  	reg signed [input_width-1:0] dout_delayed = 0;
	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			dout_delayed <= 0;
		end

		else if (~en) begin
			dout_delayed <= din;
		end
	end
  	assign dout = dout_delayed;
endmodule
