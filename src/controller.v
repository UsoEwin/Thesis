//
// the naive controller unit, simply using majority gate implementation here
// under testing
// need to add the output valid logic
`define LL_TH 1000
`define PS_TH 1000
`define NE_TH 1000

module controller #(
	parameter ll_width = 25,
	parameter mul_width = 40 //for ps ad ne
)(	
	input signed [ll_width-1:0] din_ll,
	input signed [mul_width-1:0] din_ps,
	input signed [mul_width-1:0] din_ne,
	input data_ready_ll,
	input data_ready_ps,
	input data_ready_ne,
	output stimulation
	);
	reg count;
	always @(*) begin

		if (data_ready_ne && data_ready_ll && data_ready_ps) begin
			count = (din_ps >= `PS_TH) + (din_ne >= `NE_TH) + (din_ll >= `LL_TH);
		end
		else begin
			count = 0;
		end
	end

	assign stimulation = (count >= 2);
	
endmodule
