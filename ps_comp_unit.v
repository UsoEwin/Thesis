//
//in this project, we are assumimg all inputs are integer
//this module will perform dout = din[i-1]^2 -din[i-2]*din[i+1]
//here i is time stamp
//IMPORTANT: ingnore the 1/(N-2) in the formula due to the cost of division
//
module ps_comp_unit #(
	parameter data_width = 32,
	parameter output_width = 64
)(	
	input signed [data_width-1:0] din,
	input en,rst,clk, //rst active high,en active low
	output wire signed [output_width-1:0] dout,
	output wire data_valid
	);
	//initial value, avoid latch
	reg signed [data_width-1:0] din_delayed_by_1 = 0;
	reg signed [data_width-1:0] din_delayed_by_2 = 0;
	reg signed [output_width-1:0] dout_buffer = 0; 

	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			din_delayed_by_1 <= 0;
			din_delayed_by_2 <= 0;
			dout_buffer <= 0;
		end

		else if (~en) begin
			//IMPORTANT: we can replace multiplications with Xilinx coregen multiplier
			dout_buffer <= $signed(din_delayed_by_1)*$signed(din_delayed_by_1) - $signed(din)*$signed(din_delayed_by_2);
			din_delayed_by_1 <= din;//from last clk cycle
			din_delayed_by_2 <= din_delayed_by_1; //for 2 cycles ago

		end
		//if en is high, just hold
		else begin
			dout_buffer <= dout_buffer;
			din_delayed_by_1 <= din_delayed_by_1;
			din_delayed_by_2 <= din_delayed_by_2;
		end
	end

	assign dout = dout_buffer; //already take care of the invalid output
endmodule
