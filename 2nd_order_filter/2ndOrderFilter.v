`timescale 1ns / 1ps

// Butterworth IIR 2nd order 1-70Hz bandpass filter
// if you want to modify this refer to:
// https://github.com/amoudgl/iir-bandstop-filter
//
// we still need filters for: 3 different bands for power spectrum

module filter(clk, reset, x, y) ;

output wire signed [31:0] y;
input wire signed [31:0] x;

// filter coefficients
wire signed [31:0] a1, a2, a3;
input wire clk, reset ;

// filter variables
wire signed [63:0] s1_mult1, s1_mult2, s1_mult3,
                   s1_add1, s1_add2, s1_add3;

// delay regs
reg signed [63:0] s1_n1, s1_n2; 

// filter coefficients values
// Given in MATLAB as decimals, multiplied by 2^20 to get integers
assign a1 = 567208; // scale value of first section
assign a2 = -933924;
assign a3 = -85840;


// update filter variables
// Section 1
assign s1_mult1 = a1*x;
assign s1_add1 = s1_mult1-s1_mult2;
assign s1_add2 = s1_add1-s1_mult3;
assign s1_add3 = s1_add2-s1_n2;
assign s1_mult2 = a2*s1_n1;
assign s1_mult3 = a3*s1_n2;

assign y = $signed(s1_add3 >>> 20);

// Run the filter state machine
always @ (negedge clk) 
begin
    if (reset)
    begin
        s1_n1 <= 64'd0;
        s1_n2 <= 64'd0;   
    end
    else 
    begin
        s1_n1 <= s1_add2;
        s1_n2 <= s1_n1;     
    end
end 

endmodule