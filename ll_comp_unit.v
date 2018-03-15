//
//in this project, we are assumimg all inputs are integers
//this module will perform dout = abs(din[i] - din[i-1])
//here i is time stamp
//
//all test case passed
module ll_comp_unit #(
	parameter input_width = 32
)(	
	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output wire signed [input_width:0] dout, 
	output wire 			   data_valid //to the mem block, indicate current data is good
	);
  reg signed [input_width:0] dout_mid1;
  reg signed [input_width:0] dout_mid2;
  	wire signed [input_width-1:0] din_delayed;
  ff #(input_width) myff (
      .din(din),.en(en),.clk(clk),.rst(rst),.dout(din_delayed)
  		);

	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			dout_mid1 <= 0;
          	dout_mid1 <= 0;
		end

		else if (~en) begin
			dout_mid1 <= $signed(din) - $signed(din_delayed); 
          	dout_mid2 <= -($signed(din) - $signed(din_delayed));
		end
		//if en is high, just hold
	end
  assign dout = (dout_mid1 > 0)? $signed(dout_mid1) : $signed(dout_mid2); //data can be X
  	assign data_valid = (en == 0);
endmodule

//ff
module ff #(
	parameter input_width = 32
)(	
	input signed [input_width-1:0]	din,
	input en,rst,clk, //rst active high,en active low
  	output wire signed [input_width-1:0] dout
	);
	
  	reg signed [input_width-1:0] dout_delayed;
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
