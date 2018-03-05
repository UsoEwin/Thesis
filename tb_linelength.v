`timescale 1ns/100ps

//second and ms
`define SEC 1000000000
`define MS 1000000

//clk cycle
`define CLK_PERIOD 30
`define DATA_WIDTH 32
module tb_linelength;
	
	reg signed [DATA_WIDTH-1:0] test_din = 0;
	reg test_clk = 0;
	reg signed [DATA_WIDTH-1:0] test_din_delay = 0;
	reg signed [DATA_WIDTH-1:0] test_dout = 0; //benchmark value.
//generate clk
	always #(`CLK_PERIOD/2) test_clk = ~test_clk;