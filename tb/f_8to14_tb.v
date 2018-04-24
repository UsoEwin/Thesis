// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

// Tests the pipelined_iir module for low frequency sinusoidal signal of 2kHz
// The bandstop filter should pass this signal
module filter_8to14_tb;
    // Inputs
    reg clk, reset;
    reg signed [31:0] x;
    reg signed [31:0] fin;
    integer data_file;
    integer scan_file;
    integer write_file;

    // Outputs
    wire signed [31:0] y;

    // Instantiate the Unit Under Test (UUT)
    f_8to14 dut (
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
      write_file = $fopen("fout_8to14", "w");
      if (data_file != 1'b0)
        $display("data_file handle is successful");
        x = 0; reset = 1; clk = 0; 
        #100;
        reset = 1; #200;
        reset = 0; 
      repeat(50000) begin
        scan_file = $fscanf(data_file, "%d\n", fin);
        $fwrite(write_file, "%d\n", y);
        x = fin; #100;
      end
      $finish();
    end
  
  initial begin
    $monitor("din is %d, y is %d, at time %0d",x, y, $time);
  end
  
endmodule

