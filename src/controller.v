//
// the naive controller unit, simply using majority gate implementation here
// under testing
// need to add the output valid logic
`define LL_TH 1000
`define PS_TH 1000
`define NE_TH 1000

module shift_reg #(
	parameter ll_width = 25,
	parameter mul_width = 40 //for ps ad ne
)(	
	input signed [input_width-1:0] din_ll,
	input signed [input_width-1:0] din_ps,
	input signed [input_width-1:0] din_ne,
	input data_ready_ll,
	input data_ready_ps,
	input data_ready_ne,
	output stimulation
	);
	
	
endmodule
