`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Author: Abhinav Moudgil
////////////////////////////////////////////////////////////////////////////////

// Tests the pipelined_iir module for low frequency sinusoidal signal of 2kHz
// The bandstop filter should pass this signal
module testbench_2k;
    // Inputs
    reg clk, reset;
    reg signed [31:0] x;
    reg signed [31:0] fin;
    integer data_file;
    integer scan_file;

    // Outputs
    wire signed [31:0] y;

    // Instantiate the Unit Under Test (UUT)
    filter uut (
        .clk(clk), 
        .reset(reset),
        .x(x), 
        .y(y)
    );

    // Generate clock with 100ns period
    initial clk = 0;
    always #50 clk = ~clk;

    initial begin
      $dumpvars;
      data_file = $fopen("fin", "r");
      if (data_file != 1'b0)
        $display("data_file handle is successful");
        x = 0; reset = 1; clk = 0; 
        #100;
        reset = 1; #200;
        reset = 0; 
        x = -95105652; #100;
      repeat(100) begin
        scan_file = $fscanf(data_file, "%d\n", fin);
        x = fin; #100;
      end
      $finish();
    end
  
  initial begin
    $monitor("din is %d, dout is %d at time %0d",x, y, $time);
  end
  
  initial begin
    
  end
endmodule