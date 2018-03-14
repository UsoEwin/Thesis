// Code your testbench here
// or browse Examples
`timescale 1ns/100ps

//this is for unit test of ps_comp_unit

//second and ms
`define SEC 1000000000
`define MS 1000000

//clk cycle
`define CLK_PERIOD 30
`define DATA_WIDTH 32
module tb_unit_powerspectrum;
	
  	reg signed [`DATA_WIDTH-1:0] test_din;
	reg test_clk = 1'b0;
	reg test_rst;
	reg test_en;
  	wire signed [`DATA_WIDTH:0] test_dout; //benchmark value.
  	wire test_data_valid;
//generate clk
	always #(`CLK_PERIOD/2) test_clk = ~test_clk;
//instantiate the DUT
	ps_comp_unit #(
		.input_width(`DATA_WIDTH)
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
        $dumpfile("dump.vcd"); //for eda playground wave form
  		$dumpvars(1);	
        $monitor($time,,"din is %d. dout is %d",test_din, test_dout);
		test_din <= 0;
		test_rst <= 1'b1;
		test_en <= 0;
        @(posedge test_clk);
      	test_rst <= 1'b0;

        repeat(20) begin 
        @(posedge test_clk);
		test_din <= $random % 100;
      end
      repeat(4) @ (posedge test_clk);
	$finish();
	end
endmodule
