//
//in this project, we are assumimg all inputs are integer
//this module will perform dout = abs(din[i] - din[i-1])
//here i is time stamp
//
module linelength #(
	parameter data_width = 32
)(	
	input signed [data_width-1:0] din,
	input en,rst,clk, //rst active high,en active low
	output reg signed [data_width-1:0] dout
	);
	
	reg signed [data_width-1:0] din_delayed = 0;

	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			dout <= 0;
			din_delayed <= 0;
		end

		else if (~en) begin
			dout <= $signed(din) - $signed(din_delayed); //need abs
			if (dout[data_width-1] == 1'b1) begin //negative value
				dout <= -dout;
			end
			din_delayed <= din;//from last clk cycle
		end
		//if en is high, just hold
	end
endmodule
