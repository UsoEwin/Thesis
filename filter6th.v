// Code your design here
// Code your design here
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Abhinav Moudgil
//////////////////////////////////////////////////////////////////////////////////
module filter6th(clk, reset, x, y) ;

output wire signed [31:0] y;
input wire signed [31:0] x;

// filter coefficients
wire signed [31:0] b1, b2, b3, b4, b5, b6, b7,
                   a2, a3, a4, a5, a6, a7;
input wire clk, reset ;

// filter variables
wire signed [63:0] f1_n0, b1_in, b2_in, b3_in, b4_in, b5_in, b6_in, b7_in;
wire signed [63:0] a2_out, a3_out, a4_out, a5_out, a6_out, a7_out;

// history pipeline regs
reg signed [63:0] f1_n1, f1_n2, f1_n3, f1_n4, f1_n5, f1_n6; 
// history pipeline input
wire signed [63:0] f1_n1_input, f1_n2_input, f1_n3_input, f1_n4_input, f1_n5_input, f1_n6_input; 

// filter coefficients values
assign a2 = -674643275;
assign a3 = 591643272;
assign a4 = -301913879;
assign a5 = 191249543;
assign a6 = -70341809;
assign a7 = -3958336;

assign b1 = 50877193;
assign b2 = -0;
assign b3 = -152631579;
assign b4 = -0;
assign b5 = 152631579;
assign b6 = -0;
assign b7 = -50877193;

// update filter variables
assign b1_in = b1*x;
assign b2_in = b2*x;
assign b3_in = b3*x;
assign b4_in = b4*x;
assign b5_in = b5*x;
assign b6_in = b6*x;
assign b7_in = b7*x;

assign a2_out = a2*f1_n0;
assign a3_out = a3*f1_n0;
assign a4_out = a4*f1_n0;
assign a5_out = a5*f1_n0;
assign a6_out = a6*f1_n0;
assign a7_out = a7*f1_n0;

// add operations
assign f1_n1_input = b2_in + f1_n2 - a2_out;
assign f1_n2_input = b3_in + f1_n3 - a3_out;
assign f1_n3_input = b4_in + f1_n4 - a4_out;
assign f1_n4_input = b5_in + f1_n5 - a5_out;
assign f1_n5_input = b6_in + f1_n6 - a6_out;
assign f1_n6_input = b7_in - a7_out;

// scale the output and turncate for audio codec
assign f1_n0 = $signed((f1_n1 + b1_in) >>> 28);
assign y = f1_n0;

// Run the filter state machine at audio sample rate
always @ (negedge clk) 
begin
    if (reset)
    begin
        f1_n1 <= 0;
        f1_n2 <= 0; 
        f1_n3 <= 0;
        f1_n4 <= 0;
        f1_n5 <= 0;
        f1_n6 <= 0;           
    end
    else 
    begin
        f1_n1 <= f1_n1_input;
        f1_n2 <= f1_n2_input;  
        f1_n3 <= f1_n3_input;
        f1_n4 <= f1_n4_input;
        f1_n5 <= f1_n5_input;
        f1_n6 <= f1_n6_input;            
    end
end 
endmodule

