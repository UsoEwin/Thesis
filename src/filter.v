//`timescale 1ns / 1ps

// Butterworth IIR 6th order 1-70Hz bandpass filter
// if you want to modify this refer to:
// https://github.com/amoudgl/iir-bandstop-filter
//
// we still need filters for: 3 different bands for power spectrum

module filter(clk, reset, x, y) ;

output wire signed [31:0] y;
input wire signed [31:0] x;

// filter coefficients
wire signed [31:0] a1, a2, a3, a4, a5, a6, a7, a8, a9;
input wire clk, reset ;

// filter variables
wire signed [63:0] s1_mult1, s1_mult2, s1_mult3, s2_mult1, s2_mult2, s2_mult3, s3_mult1, s3_mult2, s3_mult3,
                   s1_add1, s1_add2, s1_add3, s2_add1, s2_add2, s2_add3, s3_add1, s3_add2, s3_add3;

// delay regs
reg signed [63:0] s1_n1, s1_n2, s2_n1, s2_n2, s3_n1, s3_n2; 

// filter coefficients values
// Given in MATLAB as decimals, multiplied by 10^8 to get integers
assign a1 = 62391772; // scale value of first section
assign a2 = -197481425;
assign a3 = 97544447;
assign a4 = 62391772; // scale value of second section
assign a5 = 24596632;
assign a6 = 34781792;
assign a7 = 54093177; // scale value of third section 
assign a8 = -89065915;
assign a9 = -8186355;

// update filter variables
always @ (*)
begin
    // Section 1
    s1_mult1 <= a1*x;
    s1_add1 <= s1_mult1-s1_mult2;
    s1_add2 <= s1_add1-s1_mult3;
    s1_add3 <= s1_add2-s1_n2;
    s1_mult2 <= a2*s1_n1;
    s1_mult3 <= a3*s1_n2;

    // Section 2
    s2_mult1 <= a4*s1_add3;
    s2_add1 <= s2_mult1-s2_mult2;
    s2_add2 <= s2_add1-s2_mult3;
    s2_add3 <= s2_add2-s2_n2;
    s2_mult2 <= a5*s2_n1;
    s2_mult3 <= a6*s2_n2;

    // Section 3
    s3_mult1 <= a7*s2_add3;
    s3_add1 <= s3_mult1-s3_mult2;
    s3_add2 <= s3_add1-s3_mult3;
    s3_add3 <= s3_add2-s3_n2;
    s3_mult2 <= a8*s3_n1;
    s3_mult3 <= a9*s3_n2;

end 

// Run the filter state machine
always @ (negedge clk) 
begin
    if (reset)
    begin
        s1_n1 <= 64'd0;
        s1_n2 <= 64'd0;
        s2_n1 <= 64'd0;
        s2_n2 <= 64'd0;
        s3_n1 <= 64'd0;
        s3_n2 <= 64'd0;          
    end
    else 
    begin
        s1_n1 <= s1_add2;
        s1_n2 <= s1_n1;
        s2_n1 <= s2_add2;
        s2_n2 <= s2_n1;
        s3_n1 <= s3_add3;
        s3_n2 <= s3_n1;            
    end
end 

endmodule