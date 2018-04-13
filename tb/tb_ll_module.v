// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

// testbench for subdatapath
// using the actual ieeg signal as input, you can find the input at testint_data.txt and bits for seizure in testint_tag.txt
`define CLK_PERIOD 30
`define DATA_WIDTH 16
`define MID_WIDTH 22
`define OUTPUT_WIDTH 25

module tb_ll_module;
    // Inputs
    reg clk, en,rst;
    wire data_valid;
    reg signed [`DATA_WIDTH-1:0] din;
    wire signed [`OUTPUT_WIDTH-1:0] dout;
    reg signed [`DATA_WIDTH-1:0] fin;

    integer data_file;
    integer scan_file;
  	integer write_file;

    // Outputs
    
    // Instantiate the Unit Under Test (UUT)
    ll_module #(`DATA_WIDTH,`MID_WIDTH,`OUTPUT_WIDTH) uut (
        .clk(clk), 
        .rst(rst),
        .en(en),
        .din(din), 
        .dout(dout),
        .data_valid(data_valid)
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
    	
        din = 0; rst = 1; en = 0;
        #100;
        rst = 1; 
        #200;
        rst = 0; 
      repeat(50000) begin
      	@(posedge clk);
        scan_file = $fscanf(data_file, "%d\n", fin);
        $fwrite(write_file, "%d\n", dout);
        din = fin; 
        //#100;
        
        //din <= $random % 100;
      end
      $finish();
    end
  
  initial begin
    $monitor("din is %d, y is %d, at time %0d",din, dout, $time);
  end
  
endmodule
