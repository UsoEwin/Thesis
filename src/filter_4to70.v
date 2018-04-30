`timescale 1ns / 1ps
module f_4to70(clk, reset, x, y) ;

output wire signed [31:0] y;
input wire signed [31:0] x;

// filter coefficients
wire signed [31:0] b1, b2, b3,
                   a2, a3;
input wire clk, reset ;

// filter variables
wire signed [63:0] b1_in, b2_in, b3_in;
wire signed [63:0] a2_out, a3_out;

// history pipeline regs
reg signed [63:0] f1_n1, f1_n2;
 
// history pipeline input
wire signed [63:0] f1_n1_input, f1_n2_input, f1_n0; 

/****************** Change coefficients here ***************/
  
// filter coefficients values
// a1 is not necessary because default is 1 >> Q-factor
assign a2 = -113599717;
assign a3 = -5907013;

assign b1 = 70062371;
assign b2 = 0;
assign b3 = -70062371;
  
/****************** End change coefficients*****************/
  
// update filter variables
assign b1_in = b1*x;
assign b2_in = b2*x;
assign b3_in = b3*x;

assign a2_out = a2*f1_n0;
assign a3_out = a3*f1_n0;

// add operations
assign f1_n1_input = b2_in + f1_n2 - a2_out;
assign f1_n2_input = b3_in - a3_out;

// scale the output and turncate for audio codec
  assign f1_n0 = $signed((f1_n1 + b1_in) >>> 27);
  assign y = f1_n0;

// Run the filter state machine at audio sample rate
always @ (negedge clk) 
begin
    if (reset)
    begin
        f1_n1 <= 0;
        f1_n2 <= 0;            
    end
    else 
    begin
        f1_n1 <= f1_n1_input;
        f1_n2 <= f1_n2_input;            
    end
end 
endmodule
