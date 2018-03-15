//
// accumulator module for our computing 
//
// unit test done
module accu_unit #(
	parameter input_width = 37 //computed by 32+log(50) change this for ps and ne
)(	
	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output wire signed [input_width:0] dout, 
	output wire 			   data_valid //to the FIFO block, indicate current data is good
	);
  	reg signed [input_width-1:0] dout_mid;
  	reg [4:0] counter;
	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			dout_mid <= 0;
			counter <= 0;
		end

		else if (~en) begin
			dout_mid <= $signed(din) + $signed(dout_mid); 
          	if (counter == 49) begin
				counter <= 0;
			end
			counter <= counter + 1;
		end
		//if en is high, just hold
	end
  	assign dout = dout_mid;
  assign data_valid = (counter === 49);
endmodule