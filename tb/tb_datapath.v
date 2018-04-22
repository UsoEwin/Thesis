// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

// testbench for subdatapath
// using the actual ieeg signal as input, you can find the input at testint_data.txt and bits for seizure in testint_tag.txt
`define CLK_PERIOD 30

//io port sizes
`define DATA_WIDTH 16
`define UNIT_WIDTH 32
`define MID_WIDTH 37
`define OUTPUT_WIDTH 40
`define LL_MID_WIDTH 22
`define LL_OUTPUT_WIDTH 25

module tb_datapath;
    // Inputs
    reg clk, en,rst;
    
    reg signed [`DATA_WIDTH-1:0] din;
    
    reg signed [`DATA_WIDTH-1:0] fin;

    reg [15:0] cycle_count;

    integer data_file;
    integer scan_file;
  	integer write_file;

    // Outputs
    wire stimulation;
    // Instantiate the Unit Under Test (UUT)
    datapath #(`DATA_WIDTH,`UNIT_WIDTH,`MID_WIDTH,`OUTPUT_WIDTH,`LL_MID_WIDTH,`LL_OUTPUT_WIDTH) uut (
        .clk(clk), 
        .rst(rst),
        .en(en),
        .din(din), 
        .stimulation(stimulation)
    );

    // Generate clock with 100ns period
    initial clk = 0;
    always #(`CLK_PERIOD/2) clk = ~clk;

    initial begin
      $dumpvars;
    	
    	
        data_file = $fopen("testin", "r");
     	  write_file = $fopen("fout.txt", "w");
      	if (data_file != 1'b0)
          $display("data_file handle is successful");
    	 if (write_file != 1'b0)
          $display("write_file handle is successful");
        din = 0; rst = 1; en = 0; cycle_count<=0;
        #100;
        rst = 1; 
        #200;
        rst = 0; 
      repeat(50000) begin
      	@(posedge clk);
        scan_file = $fscanf(data_file, "%d\n", fin);
        $fwrite(write_file, "%d\n", stimulation);
        din <= fin; 
        cycle_count <= cycle_count + 1; 
        //#100;
        
      end
    $finish();
    end
  
  initial begin
    $monitor("din is %d, stimulation is %d, at time %0d",din, stimulation, $time);
  end
  
endmodule
