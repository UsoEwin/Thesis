// Code your testbench here
// or browse Examples
`timescale 1ns/100ps

//this is for unit test of ll_comp_unit

//second and ms
`define SEC 1000000000
`define MS 1000000

//clk cycle
`define CLK_PERIOD 30
`define DATA_WIDTH 32
module tb_linelength;
	
  	reg signed [`DATA_WIDTH-1:0] test_din = 0;
	reg test_clk = 0;
	reg test_rst = 0;
	reg test_en = 0;
  	reg signed [`DATA_WIDTH-1:0] test_din_delay = 0;
  	wire signed [`DATA_WIDTH:0] test_dout = 0; //benchmark value.
  	wire test_data_valid = 0;
//generate clk
	always #(`CLK_PERIOD/2) test_clk = ~test_clk;
//instantiate the DUT
	ll_comp_unit #(
		.input_width(`DATA_WIDTH-1)
	) DUT (
		.clk(test_clk),
		.rst(test_rst),
		.din(test_din),
		.en(test_en),
      	.dout(test_dout),
      	.data_valid(test_data_valid)
	);
//test tasks begin here, add more if needed
//it seems that this trivial implementation won't need task

	initial begin: TB
        $dumpfile("dump.vcd");
  		$dumpvars(1);
		test_din <= 0;
		test_din_delay <= 0;
		test_rst <= 0;
		test_en <= 0;

      repeat(1) @ (posedge test_clk);
		test_din <= 1;
		test_din_delay <= test_din;
      repeat(1) @ (posedge test_clk);      
      	test_din <= 10;
      	test_din_delay <= test_din;
      //$display("test_din is = %d", test_din);
      //$display("test_din_delay is = %d", test_din_delay);
      repeat(1) @ (posedge test_clk);
      $display("test_dout is not 0. test_dout = %d", test_dout);
      repeat(4) @ (posedge test_clk);
		$finish();
	end
endmodule