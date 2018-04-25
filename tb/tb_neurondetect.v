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
    
    reg signed [`DATA_WIDTH-1:0] din0;
    reg signed [`DATA_WIDTH-1:0] din1;
    reg signed [`DATA_WIDTH-1:0] din2;
    reg signed [`DATA_WIDTH-1:0] din3;
    reg signed [`DATA_WIDTH-1:0] din4;
    reg signed [`DATA_WIDTH-1:0] din5;
    reg signed [`DATA_WIDTH-1:0] din6;
    reg signed [`DATA_WIDTH-1:0] din7;
    reg signed [`DATA_WIDTH-1:0] din8;
    reg signed [`DATA_WIDTH-1:0] din9;
    reg signed [`DATA_WIDTH-1:0] din10;
    reg signed [`DATA_WIDTH-1:0] din11;
    reg signed [`DATA_WIDTH-1:0] din12;
    reg signed [`DATA_WIDTH-1:0] din13;
    reg signed [`DATA_WIDTH-1:0] din14;
    reg signed [`DATA_WIDTH-1:0] din15;
    
    reg signed [`DATA_WIDTH-1:0] fin0;
    reg signed [`DATA_WIDTH-1:0] fin1;
    reg signed [`DATA_WIDTH-1:0] fin2;
    reg signed [`DATA_WIDTH-1:0] fin3;
    reg signed [`DATA_WIDTH-1:0] fin4;
    reg signed [`DATA_WIDTH-1:0] fin5;
    reg signed [`DATA_WIDTH-1:0] fin6;
    reg signed [`DATA_WIDTH-1:0] fin7;
    reg signed [`DATA_WIDTH-1:0] fin8;
    reg signed [`DATA_WIDTH-1:0] fin9;
    reg signed [`DATA_WIDTH-1:0] fin10;
    reg signed [`DATA_WIDTH-1:0] fin11;
    reg signed [`DATA_WIDTH-1:0] fin12;
    reg signed [`DATA_WIDTH-1:0] fin13;
    reg signed [`DATA_WIDTH-1:0] fin14;
    reg signed [`DATA_WIDTH-1:0] fin15;

    reg [15:0] cycle_count;

    wire seizure;

    integer data_file0;
    integer data_file1;
    integer data_file2;
    integer data_file3;
    integer data_file4;
    integer data_file5;
    integer data_file6;
    integer data_file7;
    integer data_file8;
    integer data_file9;
    integer data_file10;
    integer data_file11;
    integer data_file12;
    integer data_file13;
    integer data_file14;
    integer data_file15;

    integer scan_file0;
    integer scan_file1;
    integer scan_file2;
    integer scan_file3;
    integer scan_file4;
    integer scan_file5;
    integer scan_file6;
    integer scan_file7;
    integer scan_file8;
    integer scan_file9;
    integer scan_file10;
    integer scan_file11;
    integer scan_file12;
    integer scan_file13;
    integer scan_file14;
    integer scan_file15;

    integer write_file_ll;
    integer write_file_ne;
    integer write_file_ps;
    integer write_file_theta;
    integer write_file_alpha;
    integer write_file_beta;

    // Outputs
    wire stimulation;
    // Instantiate the Unit Under Test (UUT)
    neurondetect uut (
        .clk(clk), 
        .rst(rst),
        .en(en),
        .din0(din0),
        .din1(din1),
        .din2(din2),
        .din3(din3),
        .din4(din4),
        .din5(din5),
        .din6(din6),
        .din7(din7),
        .din8(din8),
        .din9(din9),
        .din10(din10),
        .din11(din11),
        .din12(din12),
        .din13(din13),
        .din14(din14),
        .din15(din15),
        .seizure(seizure)
    );

    // Generate clock with 100ns period
    initial clk = 0;
    always #(`CLK_PERIOD/2) clk = ~clk;

    initial begin
      data_file0 = $fopen("ch0_data.txt", "r");
      data_file1 = $fopen("ch1_data.txt", "r");
      data_file2 = $fopen("ch2_data.txt", "r");
      data_file3 = $fopen("ch3_data.txt", "r");
      data_file4 = $fopen("ch4_data.txt", "r");
      data_file5 = $fopen("ch5_data.txt", "r");
      data_file6 = $fopen("ch6_data.txt", "r");
      data_file7 = $fopen("ch7_data.txt", "r");
      data_file8 = $fopen("ch8_data.txt", "r");
      data_file9 = $fopen("ch9_data.txt", "r");
      data_file10 = $fopen("ch10_data.txt", "r");
      data_file11 = $fopen("ch11_data.txt", "r");
      data_file12 = $fopen("ch12_data.txt", "r");
      data_file13 = $fopen("ch13_data.txt", "r");
      data_file14 = $fopen("ch14_data.txt", "r");
      data_file15 = $fopen("ch15_data.txt", "r");

      if (data_file15 != 1'b0)
        $display("data_file15 handle is successful");
        
      rst = 1;
      en = 0; 
      cycle_count<=0;
    din0 = 0;
din1 = 0;
din2 = 0;
din3 = 0;
din4 = 0;
din5 = 0;
din6 = 0;
din7 = 0;
din8 = 0;
din9 = 0;
din10 = 0;
din11 = 0;
din12 = 0;
din13 = 0;
din14 = 0;
din15 = 0;


      #100;
      rst = 1; 
      #200;
      rst = 0; 

      repeat(320000) begin
        @(posedge clk);
        scan_file0 = $fscanf(data_file0, "%d\n", fin0);
        scan_file1 = $fscanf(data_file1, "%d\n", fin1);
        scan_file2 = $fscanf(data_file2, "%d\n", fin2);
        scan_file3 = $fscanf(data_file3, "%d\n", fin3);
        scan_file4 = $fscanf(data_file4, "%d\n", fin4);
        scan_file5 = $fscanf(data_file5, "%d\n", fin5);
        scan_file6 = $fscanf(data_file6, "%d\n", fin6);
        scan_file7 = $fscanf(data_file7, "%d\n", fin7);
        scan_file8 = $fscanf(data_file8, "%d\n", fin8);
        scan_file9 = $fscanf(data_file9, "%d\n", fin9);
        scan_file10 = $fscanf(data_file10, "%d\n", fin10);
        scan_file11 = $fscanf(data_file11, "%d\n", fin11);
        scan_file12 = $fscanf(data_file12, "%d\n", fin12);
        scan_file13 = $fscanf(data_file13, "%d\n", fin13);
        scan_file14 = $fscanf(data_file14, "%d\n", fin14);
        scan_file15 = $fscanf(data_file15, "%d\n", fin15);
        din0 = fin0; 
        din1 = fin1; 
        din2 = fin2; 
        din3 = fin3; 
        din4 = fin4; 
        din5 = fin5; 
        din6 = fin6; 
        din7 = fin7; 
        din8 = fin8; 
        din9 = fin9; 
        din10 = fin10; 
        din11 = fin11; 
        din12 = fin12; 
        din13 = fin13; 
        din14 = fin14; 
        din15 = fin15;
        cycle_count <= cycle_count + 1;
      end
    $finish();
    end
  
  initial begin
    $monitor("seizure is %d, at time %0d", seizure, $time);
  end
  
endmodule
