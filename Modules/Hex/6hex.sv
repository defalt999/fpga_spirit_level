module hexes(
    input clk_i,
    input rst_ni,
    input row_i,
    input[3:0] col_i,

    output[5:0][7:0]hex_o
);

wire[5:0] selections;
selecter display_selecter(
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .col_i(col_i),
    .select_col_o(selections)
);
   
genvar i;
generate
    for (i = 0; i < 6; i = i + 1) begin : hex_gen
        hex hex_inst (
            .clk_i(clk_i),
            .rst_ni(rst_ni),
            .en_i(selections[i]),
            .up_i(row_i),
            .display_o(hex_o[i])
        );
    end
endgenerate


endmodule