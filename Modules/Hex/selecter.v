module selecter(
    input clk_i,
    input rst_ni,
    input[3:0] col_i,

    output reg[5:0] select_col_o

);

always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)     select_col_o <= 'd0; else
case (col_i)
    4'd0: select_col_o <= 6'b100000;
    4'd1: select_col_o <= 6'b010000;
    4'd2: select_col_o <= 6'b001000;
    4'd3: select_col_o <= 6'b000100;
    4'd4: select_col_o <= 6'b000010;
    4'd5: select_col_o <= 6'b000001;
    default: select_col_o <= 6'b0;
endcase




endmodule