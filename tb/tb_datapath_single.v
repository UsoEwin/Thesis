// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

// testbench for subdatapath
// using the actual ieeg signal as input, you can find the input at testint_data.txt and bits for seizure in testint_tag.txt
`define CLK_PERIOD 30

//io port sizes
`define DATA_WIDTH 32
`define UNIT_WIDTH 32
`define MID_WIDTH 37
`define OUTPUT_WIDTH 40
`define LL_MID_WIDTH 22
`define LL_OUTPUT_WIDTH 25

module tb_datapath;
    // Inputs
    reg clk, en, rst;
    
    reg signed [`DATA_WIDTH-1:0] din;
    
    reg signed [`DATA_WIDTH-1:0] fin;

    reg [15:0] cycle_count;

    wire [31:0] ll_test;
    wire [31:0] ne_test;
    wire [31:0] ps_test;
    wire [31:0] theta_test;
    wire [31:0] alpha_test;
    wire [31:0] beta_test;

    integer data_file;
    integer scan_file;

    integer write_file_ll;
    integer write_file_ne;
    integer write_file_ps;
    integer write_file_theta;
    integer write_file_alpha;
    integer write_file_beta;

    // Outputs
    wire stimulation;
    // Instantiate the Unit Under Test (UUT)
    datapath uut (
      .clk(clk), 
      .rst(rst),
      .en(en),
      .din(din),
    	.ll_test(ll_test),
     	.ne_test(ne_test),
    	.ps_test(ps_test),
    	.theta_test(theta_test),
    	.alpha_test(alpha_test),
    	.beta_test(beta_test),
      .stimulation(stimulation)
    );

    // Generate clock with 100ns period
    initial clk = 0;
    always #(`CLK_PERIOD/2) clk = ~clk;

    initial begin
      	data_file = $fopen("final_data.txt", "r");
   	write_file_ll = $fopen("datapath_out_ll", "w");
    	write_file_ne = $fopen("datapath_out_ne", "w");
    	write_file_ps = $fopen("datapath_out_ps", "w");
    	write_file_theta = $fopen("datapath_out_theta", "w");
    	write_file_alpha = $fopen("datapath_out_alpha", "w");
    	write_file_beta = $fopen("datapath_out_beta", "w");
    	if (data_file != 1'b0)
        $display("data_file handle is successful");
      din = 0; rst = 1; en = 0; cycle_count<=0;
      #100;
      rst = 1; 
      #200;
      rst = 0; 
      repeat(320000) begin
      	@(posedge clk);
        scan_file = $fscanf(data_file, "%d\n", fin);
        $fwrite(write_file_ll, "%d\n", ll_test);
      	$fwrite(write_file_ne, "%d\n", ne_test);
      	$fwrite(write_file_ps, "%d\n", ps_test);
      	$fwrite(write_file_theta, "%d\n", theta_test);
      	$fwrite(write_file_alpha, "%d\n", alpha_test);
      	$fwrite(write_file_beta, "%d\n", beta_test);
        din = fin; 
        cycle_count <= cycle_count + 1;
      end
    $finish();
    end
  
  initial begin
    $monitor("din is %d, stimulation is %d, at time %0d", din, stimulation, $time);
  end
  
endmodule
