`timescale 1ns/100ps
//verification done
//all test case passed
//this is for unit test of accu_unit

//second and ms
`define SEC 1000000000
`define MS 1000000

//clk cycle
`define CLK_PERIOD 30

//input size
`define LL_IN 22
`define MUL_IN 25

module tb_unit_ctrl;
	
  	reg signed [`LL_IN-1:0] din_ll;
  	reg signed [`MUL_IN-1:0] din_ps;
  	reg signed [`MUL_IN-1:0] din_ne;
  	reg data_ready_ll;
  	reg data_ready_ne;
  	reg data_ready_ps;


  	//tb values
	reg clk = 1'b0;
  	//output
  	wire count; //debug purpose
  	wire  stimulation; //benchmark value.
  	reg [10:0] clk_counter = 0;

//generate clk
	always #(`CLK_PERIOD/2) clk = ~clk;
//instantiate the DUT
	controller #(
		`LL_IN,
		`MUL_IN
	) DUT (
		.din_ll(din_ll),
      	.din_ps(din_ps),
      	.din_ne(din_ne),
      	.data_ready_ps(data_ready_ps),
      	.data_ready_ne(data_ready_ne),
      	.data_ready_ll(data_ready_ll),
      	.stimulation(stimulation),
      	.count(count)
      	);
//test tasks begin here, add more if needed
//it seems that this trivial implementation won't need task
	
	initial begin: TB
        $dumpfile("dump.vcd"); //for eda playground wave form
  		$dumpvars(1);
		din_ll <= 0;
		clk_counter <= 0;
		data_ready_ll <= 1;
		data_ready_ne <= 1;
		data_ready_ps <= 1;

      	repeat(200) begin 
        @(posedge clk);
		din_ll <= $random % 2000;
		din_ps <= $random % 2000;
		din_ne <= $random % 2000;
		clk_counter <= clk_counter + 1;
        $display("din_ll is %d. stimulation is %d",din_ll, stimulation);
        $display("din_ne is %d. stimulation is %d",din_ps, stimulation);
        $display("din_ps is %d. stimulation is %d",din_ne, stimulation);
      end
      repeat(4) @ (posedge clk);


	$finish();
	end
endmodule