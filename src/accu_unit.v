//
// accumulator module for our computing 
//
// all test passed
module accu_unit #(
	parameter input_width = 32, //computed by 32+log(50) change this for ps and ne
	parameter output_width = 37
)(	
	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output wire signed [output_width-1:0] dout, 
	output wire 			   data_valid //to the FIFO block, indicate current data is good
	);
  	reg signed [output_width-1:0] dout_mid;
  	reg [5:0] counter;
	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			dout_mid <= 0;
			counter <= 0;
		end

		else if (~en) begin
			dout_mid <= $signed(din) + $signed(dout_mid); 
          	if (counter == 50) begin
				counter <= 0;
				dout_mid <= 0;
			end
			else
				counter <= counter + 1;
		end
		//if en is high, just hold
	end
  	assign dout = dout_mid;
  assign data_valid = (counter == 50);
endmodule