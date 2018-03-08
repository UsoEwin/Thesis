//
//in this project, we are assumimg all inputs are integer
//this module will perform dout = abs(din[i] - din[i-1])
//here i is time stamp
//
module ll_comp_unit #(
	parameter data_width = 32
)(	
	input signed [data_width-1:0] din,
	input en,rst,clk, //rst active high,en active low
	output wire signed [data_width-1:0] dout,
	output wire data_valid //to the mem block, indicate current data is good
	);
	
	reg signed [data_width-1:0] din_delayed = 0;
	reg signed [data_width-1:0] dout_mid1 = 0;
	reg signed [data_width-1:0] dout_mid2 = 0;
	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			dout_mid1 <= 0;
			dout_mid2 <= 0;
			din_delayed <= 0;
		end

		else if (~en) begin
			dout_mid1 <= $signed(din) - $signed(din_delayed); 
			dout_mid2 <= -($signed(din) - $signed(din_delayed));
			
			din_delayed <= din;//from last clk cycle
		end
		//if en is high, just hold
		else begin
			dout_mid1 <= dout_mid1;
			dout_mid2 <= dout_mid2;
			din_delayed <= din_delayed;
		end
	end
	assign dout = (dout_mid1 > 0)? dout_mid1 : dout_mid2; //data can be X
	assign data_valid = (en == 1'b0);
endmodule
