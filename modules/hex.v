module hex(
    input clk_i,
    input rst_ni,
    input en_i,
    input up_i,
    output reg[7:0] display_o

);

localparam cerc_sus  = 8'b10011100;
localparam cerc_jos  = 8'b10100011;
localparam hex_empty = 8'b11111111;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)       display_o <= hex_empty; else
if(en_i && up_i)  display_o <=  cerc_sus; else
if(en_i && ~up_i) display_o <=  cerc_jos; else
                  display_o <= hex_empty;


endmodule