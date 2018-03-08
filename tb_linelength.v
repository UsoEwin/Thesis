`timescale 1ns/100ps

//this is for unit test of ll_comp_unit

//second and ms
`define SEC 1000000000
`define MS 1000000

//clk cycle
`define CLK_PERIOD 30
`define DATA_WIDTH 32
module tb_linelength;
	
	reg signed [DATA_WIDTH-1:0] test_din = 0;
	reg test_clk = 0;
	reg test_rst = 0;
	reg test_en = 0;
	reg signed [DATA_WIDTH-1:0] test_din_delay = 0;
	reg signed [DATA_WIDTH-1:0] test_dout = 0; //benchmark value.
//generate clk
	always #(`CLK_PERIOD/2) test_clk = ~test_clk;
//instantiate the DUT
	linelength #(
		.data_width(`DATA_WIDTH-1)
	) DUT (
		.clk(test_clk),
		.rst(test_rst),
		.din(test_din),
		.en(test_en),
		.dout(test_dout)
	);
//test tasks begin here, add more if needed
//it seems that this trivial implementation won't need task
/*
	task feed_random;
		input [`DATA_WIDTH-1:0] din_a;
		input rst_a;
		begin
			
		end
*/
//
	initial begin: TB
		test_din <= 0;
		test_din_delay <= 0;
		test_rst <= 0;
		test_en <= 1;

		repeat(5) @ (posedge test_clk);
		test_din <= $urandom();
		test_rst <= 1'b1;
		repeat(1) @ (posedge test_clk);
		if (test_dout != 0) begin
			
		end
		//expecting 0 as output

		$finish();
	end