module shift_reg #(
	parameter input_width = 37, //for 32 bits input, change this for ne and ll
	parameter reg_depth = 8
)(	
	input signed [input_width-1:0] din,
	input en,rst,clk, //rst active high,en active low
	input data_ready, //from accu unit
	output wire signed [input_width-1:0] dout_stage1,
	output wire signed [input_width-1:0] dout_stage2,
	output wire signed [input_width-1:0] dout_stage3,
	output wire signed [input_width-1:0] dout_stage4,
	output wire signed [input_width-1:0] dout_stage5,
	output wire signed [input_width-1:0] dout_stage6,
	output wire signed [input_width-1:0] dout_stage7,
	output wire signed [input_width-1:0] dout_stage8,
	output wire data_valid //from the computing unit
);

	reg [input_width-1:0] shifter [reg_depth-1:0];
    reg [3:0] counter; //for 0.2 sample freq
	integer i;

	always @(posedge clk) begin
		//sync reset
		if (rst) begin
			counter <= 0;
            for(i = 0; i < reg_depth; i = i+1)
				shifter[i] <= 0;
		end

		else if (~en && data_ready) begin
			shifter[0] <= din;
			if(counter < 8)
				counter <= counter + 1;
			else begin
				counter <= counter;
			end
			for(i = 1; i < reg_depth; i=i+1)
				shifter[i] <= shifter[i-1];
		end
		//if en is high, just hold
	end
  
	assign dout_stage1 = shifter[0];
	assign dout_stage2 = shifter[1];
	assign dout_stage3 = shifter[2];
	assign dout_stage4 = shifter[3];
	assign dout_stage5 = shifter[4];
	assign dout_stage6 = shifter[5];
  	assign dout_stage7 = shifter[6];
  	assign dout_stage8 = shifter[7];
  
  
    assign data_valid = (counter == 8); // data is valid the following cycle
endmodule