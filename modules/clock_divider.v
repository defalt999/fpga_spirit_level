module clock_divider #(
    parameter DIVIDER = 10,
    parameter COUNTER_WIDTH=4
)(
    input clk_i,
    input rst_ni,
    output reg clk_div_out_o
);

reg[COUNTER_WIDTH-1:0] counter;
localparam limit = (DIVIDER>> 1) - 1;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)          counter <= 'd0; else
if(counter == limit) counter <= 'd0; else
                     counter <= counter + 1;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)          clk_div_out_o <= 'd0; else
if(counter == limit) clk_div_out_o <= ~clk_div_out_o;






endmodule