// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module shifter_tb;
  parameter input_width = 37;
  parameter reg_depth = 5;
  reg clk; 
  reg en;
  reg rst;
  reg [input_width-1:0] din;
  reg data_ready;
  wire data_valid;
  wire signed [input_width-1:0] dout_stage1;
  wire signed [input_width-1:0] dout_stage2;
  wire signed [input_width-1:0] dout_stage3;
  wire signed [input_width-1:0] dout_stage4;
  wire signed [input_width-1:0] dout_stage5;
  
  shift_reg uut (
    .din(din), .en(en), .rst(rst), .clk(clk), .data_ready(data_ready), 
    .dout_stage1(dout_stage1),
    .dout_stage2(dout_stage2),
    .dout_stage3(dout_stage3),
    .dout_stage4(dout_stage4),
    .dout_stage5(dout_stage5),
    .data_valid(data_valid)
  );
  
  always begin
    #10 clk = ~clk;
  end
  
  initial begin 
    $dumpvars;
    rst = 1'b1;
    en = 1'b0;
    clk = 1'b0;
    din = 1'b0;
    data_ready = 1'b0;
    @ (negedge clk);
    rst = 1'b0;
    data_ready = 1'b1;
    @ (negedge clk);
    din = 'd100;
    @ (negedge clk);
    din = 'd200;
    @ (negedge clk);
    din = 'd300;
    @ (negedge clk);
    din = 'd400;
    @ (negedge clk);
    din = 'd500;
    @ (negedge clk);
    din = 'd600;
    @ (negedge clk);
    din = 'd700;
    @ (negedge clk);
    din = 'd800;
    @ (negedge clk);
    din = 'd900;
    $finish();
  end
endmodule
    
