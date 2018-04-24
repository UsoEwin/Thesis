module final_controller(
	input [15:0] ll,
	input [15:0] ne,
	input [15:0] ps,
	input [15:0] theta,
	input [15:0] alpha,
	input [15:0] beta,
	output seizure
);

	localparam THRESHOLD = 'd35482;

	wire signed [11:0] weighted_sum_0;
	wire signed [11:0] weighted_sum_1;
	wire signed [11:0] weighted_sum_2;
	wire signed [11:0] weighted_sum_3;
	wire signed [11:0] weighted_sum_4;
	wire signed [11:0] weighted_sum_5;
	wire signed [11:0] weighted_sum_6;
	wire signed [11:0] weighted_sum_7;
	wire signed [11:0] weighted_sum_8;
	wire signed [11:0] weighted_sum_9;
	wire signed [11:0] weighted_sum_10;
	wire signed [11:0] weighted_sum_11;
	wire signed [11:0] weighted_sum_12;
	wire signed [11:0] weighted_sum_13;
	wire signed [11:0] weighted_sum_14;
	wire signed [11:0] weighted_sum_15;

	wire signed [15:0] total_sum;

	assign total_sum = weighted_sum_0 + weighted_sum_1 + weighted_sum_2 + weighted_sum_3 + weighted_sum_4 + weighted_sum_5 + weighted_sum_6 + weighted_sum_7 + 
						weighted_sum_8 + weighted_sum_9 + weighted_sum_10 + weighted_sum_11 + weighted_sum_12 + weighted_sum_13 + weighted_sum_14 + weighted_sum_15;
	
	assign seizure = (total_sum >= THRESHOLD);

	weighted_sum #(18, 39, -7, 382, 64, 68) ws0
	(
		.ll(ll[0]),
		.ne(ne[0]),
		.ps(ps[0]),
		.theta(theta[0]),
		.alpha(alpha[0]),
		.beta(beta[0]),
		.weighted_sum_out(weighted_sum_0)
	);

	weighted_sum #(4, -9, -1, 2, 11, 2) ws1
	(
		.ll(ll[1]),
		.ne(ne[1]),
		.ps(ps[1]),
		.theta(theta[1]),
		.alpha(alpha[1]),
		.beta(beta[1]),
		.weighted_sum_out(weighted_sum_1)
	);

	weighted_sum #(62, -89, 55, 43, 81, 130) ws2
	(
		.ll(ll[2]),
		.ne(ne[2]),
		.ps(ps[2]),
		.theta(theta[2]),
		.alpha(alpha[2]),
		.beta(beta[2]),
		.weighted_sum_out(weighted_sum_2)
	);

	weighted_sum #(53, -5, -67, 105, -17, 1) ws3
	(
		.ll(ll[3]),
		.ne(ne[3]),
		.ps(ps[3]),
		.theta(theta[3]),
		.alpha(alpha[3]),
		.beta(beta[3]),
		.weighted_sum_out(weighted_sum_3)
	);

	weighted_sum #(-55, -13, -26, 65, -23, -34) ws4
	(
		.ll(ll[4]),
		.ne(ne[4]),
		.ps(ps[4]),
		.theta(theta[4]),
		.alpha(alpha[4]),
		.beta(beta[4]),
		.weighted_sum_out(weighted_sum_4)
	);

	weighted_sum #(-14, 10, -15, 22, -14, -36) ws5
	(
		.ll(ll[5]),
		.ne(ne[5]),
		.ps(ps[5]),
		.theta(theta[5]),
		.alpha(alpha[5]),
		.beta(beta[5]),
		.weighted_sum_out(weighted_sum_5)
	);

	weighted_sum #(-54, 2, -65, -77, -21, 1) ws6
	(
		.ll(ll[6]),
		.ne(ne[6]),
		.ps(ps[6]),
		.theta(theta[6]),
		.alpha(alpha[6]),
		.beta(beta[6]),
		.weighted_sum_out(weighted_sum_6)
	);

	weighted_sum #(14, -19, 9, -112, 80, -177) ws7
	(
		.ll(ll[7]),
		.ne(ne[7]),
		.ps(ps[7]),
		.theta(theta[7]),
		.alpha(alpha[7]),
		.beta(beta[7]),
		.weighted_sum_out(weighted_sum_7)
	);

	weighted_sum #(43, -19, 40, -25, 2, -10) ws8
	(
		.ll(ll[8]),
		.ne(ne[8]),
		.ps(ps[8]),
		.theta(theta[8]),
		.alpha(alpha[8]),
		.beta(beta[8]),
		.weighted_sum_out(weighted_sum_8)
	);

	weighted_sum #(-41, -17, -132, 49, -6, -7) ws9
	(
		.ll(ll[9]),
		.ne(ne[9]),
		.ps(ps[9]),
		.theta(theta[9]),
		.alpha(alpha[9]),
		.beta(beta[9]),
		.weighted_sum_out(weighted_sum_9)

	);

	weighted_sum #(-15, 8, -36, -41, 102, 5) ws10
	(
		.ll(ll[10]),
		.ne(ne[10]),
		.ps(ps[10]),
		.theta(theta[10]),
		.alpha(alpha[10]),
		.beta(beta[10]),
		.weighted_sum_out(weighted_sum_10)
	);

	weighted_sum #(29, 26, 694, 69, -63, 9) ws11
	(
		.ll(ll[11]),
		.ne(ne[11]),
		.ps(ps[11]),
		.theta(theta[11]),
		.alpha(alpha[11]),
		.beta(beta[11]),
		.weighted_sum_out(weighted_sum_11)

	);

	weighted_sum #(56, 7, 121, 11, 79, -19) ws12
	(
		.ll(ll[12]),
		.ne(ne[12]),
		.ps(ps[12]),
		.theta(theta[12]),
		.alpha(alpha[12]),
		.beta(beta[12]),
		.weighted_sum_out(weighted_sum_12)
	);

	weighted_sum #(52, -10, 5, -118, -25, 92) ws13
	(
		.ll(ll[13]),
		.ne(ne[13]),
		.ps(ps[13]),
		.theta(theta[13]),
		.alpha(alpha[13]),
		.beta(beta[13]),
		.weighted_sum_out(weighted_sum_13)

	);

	weighted_sum #(-34, -1, -142, -5, 22, 30) ws14
	(
		.ll(ll[14]),
		.ne(ne[14]),
		.ps(ps[14]),
		.theta(theta[14]),
		.alpha(alpha[14]),
		.beta(beta[14]),
		.weighted_sum_out(weighted_sum_14)
	);

	weighted_sum #(-13, 37, 83, -115, 25, 4) ws15
	(
		.ll(ll[15]),
		.ne(ne[15]),
		.ps(ps[15]),
		.theta(theta[15]),
		.alpha(alpha[15]),
		.beta(beta[15]),
		.weighted_sum_out(weighted_sum_15)
	);

endmodule