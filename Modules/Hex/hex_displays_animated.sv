module hex_displays_animated(
    input clk_i,
    input rst_ni,

    input row_i,
	 input [3:0]col_i,

    output[5:0][7:0]hex_o
);

hexes hex_dut(
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .row_i(row_i),
    .col_i(col_i),
    .hex_o(hex_o)
);

endmodule

