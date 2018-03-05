module linelength(

	input signed [31:0] din,
	input en,rst,clk, //rst active high,en active low
	output reg signed [31:0] dout
	);
	
	reg signed [31:0] din_delayed = 0;

	always @(posedge clk) begin

		if (rst) begin
			dout <= 31'b0;
			din_delayed <= 31'b0;
		end

		else if (~en) begin
			dout <= $signed(din) - $signed(din_delayed); //need abs
			if (dout[31] == 1'b1) begin
				dout <= -dout;
			end
		end
		din_delayed <= din;//from last clk cycle
	end
endmodule
