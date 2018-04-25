module binary_channel #(
	parameter s0 = 0,
	parameter s1 = 0,
	parameter s2 = 0,
	parameter s3 = 0,
	parameter s4 = 0,
	parameter s5 = 0
)(	
	input signed [40:0] ll_out,
	input signed [33:0] ll_base,
	input ll_valid,
	output ll_binary,
	input signed [71:0] ne_out,
	input signed [49:0] ne_base,
	input ne_valid,
	output ne_binary,
	input signed [71:0] ps_out,
	input signed [49:0] ps_base,
	input ps_valid,
	output ps_binary,
	input signed [71:0] theta_out,
	input signed [49:0] theta_base,
	input theta_valid,
	output theta_binary,
	input signed [71:0] alpha_out,
	input signed [49:0] alpha_base,
	input alpha_valid,
	output alpha_binary,
	input signed [71:0] beta_out,
	input signed [49:0] beta_base,
	input beta_valid,
	output beta_binary
);
	
	assign ll_binary = (ll_out >= ll_base * s0);// & ll_valid;
	assign ne_binary = (ne_out >= ne_base * s1);// & ne_valid;
	assign ps_binary = (ps_out >= ps_base * s2);// & ps_valid;
	assign theta_binary = (theta_out >= theta_base * s3);// & theta_valid;
	assign alpha_binary = (alpha_out >= alpha_base * s4);// & alpha_valid;
	assign beta_binary = (beta_out >= beta_base * s5);// & beta_valid;

endmodule