// This is the final controller module.
// It takes in the binary number and compute the weighted sum
// The implementation is for 16 channels
// Weights and theshold are scaled by 2^10

module weighted_sum #(
	parameter ll_scale = 18,
	parameter ne_scale = 39,
	parameter ps_scale = -7,
	parameter theta_scale = 382,
	parameter alpha_scale = 64,
	parameter beta_scale = 68
) (
	input ll,
	input ne,
	input ps,
	input theta,
	input alpha,
	input beta,
	output signed [11:0] weighted_sum_out
);

	assign weighted_sum_out = $signed(ll * ll_scale + ne * ne_scale + ps * ps_scale + theta * theta_scale + alpha * alpha_scale + beta * beta_scale);

endmodule



