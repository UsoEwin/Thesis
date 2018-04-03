`include "util.vh"

module async_fifo #(
    parameter data_width = 8,
    parameter fifo_depth = 32,
    parameter addr_width = `log2(fifo_depth)
) (
    input wr_clk,
    input rd_clk,

    input wr_en,
    input rd_en,
    input [data_width-1:0] din,

    output full,
    output empty,
    output reg [data_width-1:0] dout = 0
);

    reg [data_width-1 : 0] mem [fifo_depth-1 : 0];
    reg [addr_width : 0] wr_ptr = 1'b0; // MSB for comparison
    reg [addr_width : 0] rd_ptr = 1'b0;

    wire [addr_width : 0] sync_wr_binary_ptr;
    wire [addr_width : 0] sync_rd_binary_ptr;

    wrptr_converter #(addr_width + 1'b1) my_write_converter (.wrptr(wr_ptr), .rd_clk(rd_clk), .sync_wr_binary_ptr(sync_wr_binary_ptr));
    rdptr_converter #(addr_width + 1'b1) my_read_converter (.rdptr(rd_ptr), .wr_clk(wr_clk), .sync_rd_binary_ptr(sync_rd_binary_ptr));

    // WRITE PORT
    always @ (posedge wr_clk) begin
        if (wr_en && !full) begin
            mem[wr_ptr[addr_width-1 : 0]] <= din;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    // READ PORT
    always @ (posedge rd_clk) begin
        if (rd_en && !empty) 
            rd_ptr <= rd_ptr + 1'b1;
    end

    always @ (posedge rd_clk) begin
        if (rd_en && !empty)
            dout <= mem[rd_ptr[addr_width-1 : 0]];
    end

    assign full = ({~wr_ptr[addr_width], wr_ptr[addr_width - 1 : 0]} == sync_rd_binary_ptr);
    assign empty = (sync_wr_binary_ptr == rd_ptr);
    //assign dout = mem[rd_ptr[addr_width-1 : 0]];
/*
    assign full = 1'b0;
    assign empty = 1'b0;
    assign dout = 1'b0;
*/

endmodule

module wrptr_converter #(parameter width = 16)
(
    input [width-1 : 0] wrptr,
    input rd_clk,
    output [width-1 : 0] sync_wr_binary_ptr
);
    wire [width-1 : 0] wr_gray_ptr;
    wire [width-1 : 0] sync_wr_gray_ptr;
    reg [width-1 : 0] ff1 = 0, ff2 = 0;

    bianry2gray #(width) wptrB2G (.num(wrptr), .out(wr_gray_ptr));

    always @ (posedge rd_clk) begin
        ff1 <= wr_gray_ptr;
        ff2 <= ff1;
    end
    
    assign sync_wr_gray_ptr = ff2;

    gray2binary #(width) wptrG2B (.num(sync_wr_gray_ptr), .out(sync_wr_binary_ptr));

endmodule

module rdptr_converter #(parameter width = 16)
(
    input [width-1 : 0] rdptr,
    input wr_clk,
    output [width-1 : 0] sync_rd_binary_ptr
);
    wire [width-1 : 0] rd_gray_ptr;
    wire [width-1 : 0] sync_rd_gray_ptr;
    reg [width-1 : 0] ff1 = 0, ff2 = 0;

    bianry2gray #(width) rptrB2G (.num(rdptr), .out(rd_gray_ptr));

    always @ (posedge wr_clk) begin
        ff1 <= rd_gray_ptr;
        ff2 <= ff1;
    end
    
    assign sync_rd_gray_ptr = ff2;

    gray2binary #(width) rptrG2B (.num(sync_rd_gray_ptr), .out(sync_rd_binary_ptr));

endmodule

module bianry2gray #(parameter width = 16)
(
    input [width-1 : 0] num,
    output [width-1 : 0] out
);
    assign out = num ^ (num >> 1);

endmodule

module gray2binary #(parameter width = 16)
(
    input [width-1 : 0] num,
    output [width-1 : 0] out
);
    wire [width-1 : 0] w1, w2, w3;
    assign w1 = num ^ (num >> 8);
    assign w2 = w1 ^ (w1 >> 4);
    assign w3 = w2 ^ (w2 >> 2);
    assign out = w3 ^ (w3 >> 1);

endmodule
