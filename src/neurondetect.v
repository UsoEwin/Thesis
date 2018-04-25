module neurondetect #(parameter INPUT_WIDTH = 32)
( 
  input signed [INPUT_WIDTH-1:0] din0,
  input signed [INPUT_WIDTH-1:0] din1,
  input signed [INPUT_WIDTH-1:0] din2,
  input signed [INPUT_WIDTH-1:0] din3,
  input signed [INPUT_WIDTH-1:0] din4,
  input signed [INPUT_WIDTH-1:0] din5,
  input signed [INPUT_WIDTH-1:0] din6,
  input signed [INPUT_WIDTH-1:0] din7,
  input signed [INPUT_WIDTH-1:0] din8,
  input signed [INPUT_WIDTH-1:0] din9,
  input signed [INPUT_WIDTH-1:0] din10,
  input signed [INPUT_WIDTH-1:0] din11,
  input signed [INPUT_WIDTH-1:0] din12,
  input signed [INPUT_WIDTH-1:0] din13,
  input signed [INPUT_WIDTH-1:0] din14,
  input signed [INPUT_WIDTH-1:0] din15,

  input en, rst, clk, //rst active high, en active low
  output seizure
);

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

  assign total_sum = weighted_sum_0 + weighted_sum_1 + weighted_sum_2 + weighted_sum_3 + 
             weighted_sum_4 + weighted_sum_5 + weighted_sum_6 + weighted_sum_7 + 
             weighted_sum_8 + weighted_sum_9 + weighted_sum_10 + weighted_sum_11 + 
             weighted_sum_12 + weighted_sum_13 + weighted_sum_14 + weighted_sum_15;

  assign seizure = (total_sum >= 422);

    datapath #(32, 40, 25, 4, 12, 5, 8, 12, 20, 18, 39, -7, 382, 64, 68) channel_0 
    (
      .din(din0),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_0)
    );

    datapath #(32, 40, 25, 8, 52, 100, 100, 100, 99, 4, -9, -1, 2, 11, 2) channel_1 
    (
      .din(din1),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_1)
    );

    datapath #(32, 40, 25, 4, 18, 13, 15, 19, 33, 62, -89, 55, 43, 81, 130) channel_2 
    (
      .din(din2),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_2)
    );

    datapath #(32, 40, 25, 3, 8, 18, 13, 13, 9, 53, -5, -67, 105, -17, 1) channel_3 
    (
      .din(din3),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_3)
    );

    datapath #(32, 40, 25, 3, 10, 24, 10, 20, 7, -55, -13, -26, 65, -23, -34) channel_4 
    (
      .din(din4),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_4)
    );

    datapath #(32, 40, 25, 3, 6, 25, 9, 15, 6, -14, 10, -15, 22, -14, -36) channel_5 
    (
      .din(din5),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_5)
    );

    datapath #(32, 40, 25, 2, 4, 20, 9, 15, 5, -54, 2, -65, -77, -21, 1) channel_6 
    (
      .din(din6),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_6)
    );

    datapath #(32, 40, 25, 2, 5, 18, 15, 12, 9, 14, -19, 9, -112, 80, -177) channel_7 
    (
      .din(din7),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_7)
    );

    datapath #(32, 40, 25, 5, 24, 15, 24, 27, 38,43, -19, 40, -25, 2, -10) channel_8 
    (
      .din(din8),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_8)
    );

    datapath #(32, 40, 25, 3, 11, 17, 12, 9, 15, -41, -17, -132, 49, -6, -7) channel_9 
    (
      .din(din9),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_9)
    );

    datapath #(32, 40, 25, 4, 25, 19, 15, 29, 39, -15, 8, -36, -41, 102, 5) channel_10 
    (
      .din(din10),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_10)
    );

    datapath #(32, 40, 25, 4, 29, 37, 22, 31, 53, 29, 26, 694, 69, -63, 9) channel_11 
    (
      .din(din11),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_11)
    );

    datapath #(32, 40, 25, 3, 6, 12, 10, 12, 8, 56, 7, 121, 11, 79, -19) channel_12 
    (
      .din(din12),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_12)
    );

    datapath #(32, 40, 25, 3, 8, 16, 16, 26, 10, 52, -10, 5, -118, -25, 92) channel_13 
    (
      .din(din13),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_13)
    );

    datapath #(32, 40, 25, 4, 12, 27, 16, 25, 11, -34, -1, -142, -5, 22, 30) channel_14 
    (
      .din(din14),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_14)
    );

    datapath #(32, 40, 25, 4, 9, 14, 13, 24, 9, -13, 37, 83, -115, 25, 4) channel_15 
    (
      .din(din15),
      .en(en),
      .rst(rst),
      .clk(clk),
      .weight_sum(weighted_sum_15)
    );
    
endmodule