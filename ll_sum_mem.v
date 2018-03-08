//
//this file will store the output from ll_comp_unit
//and perform summation on the data output of this should go to controller
//
module ll_sum_mem #(
	parameter input_width = 32,
	parameter output_width = 64, //please accrodingly modify this line for different data width.
	parameter window_size = 32
)(	
	input signed [input_width-1:0] din,
	input en,rst,clk, //rst active high,en active low
	output wire signed [output_width-1:0] dout,
	output wire data_valid //to the mem block, indicate current data is good
	);
	
	reg signed [input_width-1:0] din_delayed = 0;
	reg signed [input_width-1:0] dout_mid1 = 0;
	reg signed [input_width-1:0] dout_mid2 = 0;
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
	assign data_valid = (en === 1'b0);
endmodule
