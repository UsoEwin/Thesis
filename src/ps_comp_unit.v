//
//in this project, we are assumimg all inputs are integers
//this module will perform dout = din[i]^2
//here i is time stamp

//all test case passed

module ps_comp_unit #(
	parameter input_width = 16,
	parameter output_width = 32
)(	
	input signed [input_width-1:0] din,
	input en,rst,clk, //rst active high,en active low
	output wire signed [output_width-1:0] dout,
	output wire data_valid
	);
	//initial value, avoid latch
	reg signed [output_width-1:0] dout_buffer = 0; 

	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			dout_buffer <= 0;
		end

		else if (~en) begin
			//IMPORTANT: we can replace multiplications with Xilinx coregen multiplier
			dout_buffer <= $signed(din)*$signed(din);
		end
		//if en is high, just hold
		else begin
			dout_buffer <= dout_buffer;
		end
	end

	assign dout = dout_buffer; //already take care of the invalid output
	assign data_valid = (en == 1'b0) ;
endmodule
