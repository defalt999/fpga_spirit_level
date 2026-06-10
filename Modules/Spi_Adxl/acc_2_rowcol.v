module acc_2_rowcol(
    input clk_i,
    input rst_ni,
    input signed [9:0] accx_i,
    input signed [9:0] accy_i,
    output reg       row_o,
    output reg [2:0] col_o
);
parameter MIN_ACC=-200;
parameter MAX_ACC=200;
parameter NUM_COLS=6;
localparam RANGE=MAX_ACC-MIN_ACC;

wire signed [11:0] col_raw = ((accx_i - MIN_ACC) * NUM_COLS) / RANGE;

always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)             col_o <= 		  3'd2; else
if(col_raw >= NUM_COLS) col_o <=   NUM_COLS-1; else
if(col_raw <= 0)        col_o <= 		  3'd0; else
                        col_o <= col_raw[2:0];
								
always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)          row_o <= 1'b0; else
if(accy_i >= 10'sd0) row_o <= 1'b1; else
							row_o <= 1'b0;
endmodule