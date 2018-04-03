`include "util.vh"

module fifo #(
    parameter data_width = 8,
    parameter fifo_depth = 32,
    parameter addr_width = `log2(fifo_depth)
) (
    input clk, rst,

    // Write side
    input wr_en,
    input [data_width-1:0] din,
    output full,

    // Read side
    input rd_en,
    output reg [data_width-1:0] dout,
    output empty
);

    reg [addr_width-1 : 0] wr_ptr;
    reg [addr_width-1 : 0] rd_ptr;
    reg [data_width-1 : 0] mem [fifo_depth-1 : 0];
    reg [addr_width : 0] counter;

    wire canread;
    wire canwrite;
    assign canread = rd_en && !empty;
    assign canwrite = wr_en && !full;
    
    always @ (posedge clk) begin // write operation
    	if (rst)
    		wr_ptr <= 1'b0;
    	else if (canwrite) begin
    		mem[wr_ptr] <= din;
            	wr_ptr <= wr_ptr + 1'b1;
        end
    end

    always @ (posedge clk) begin // read operation
    	if (rst)
    		rd_ptr <= 1'b0;
    	else if (canread)
        	rd_ptr <= rd_ptr + 1'b1;
    end
 
    always @ (posedge clk) begin // counter
    	if (rst)
    		counter <= 1'b0;
    	else if (canread && !canwrite)
    		counter <= counter - 1'b1;
    	else if (!canread && canwrite)
    		counter <= counter + 1'b1;
    end

    always @ (posedge clk) begin 
        if (rst)
            dout <= 1'b0;
        else if (canread)
            dout <= mem[rd_ptr];
    end


    assign full = (counter == fifo_depth);
    assign empty = (counter == 1'b0);

endmodule
