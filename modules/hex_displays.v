module hex_displays(
    input clk_i,
    input rst_ni,

    input row_i,
    input[2:0] col_i,

    input mode,



    output reg[7:0] hex0_o,
    output reg[7:0] hex1_o,
    output reg[7:0] hex2_o,
    output reg[7:0] hex3_o,
    output reg[7:0] hex4_o,
    output reg[7:0] hex5_o
);
//Combinatie biti cerc sus: dp g f e d c b a -> 8'b10011100
//Combinatie biti cerc jos: dp g f e d c b a -> 8'b10100011

localparam cerc_sus  = 8'b10011100;
localparam cerc_jos  = 8'b10100011;
localparam hex_empty = 8'b11111111;



always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                 hex0_o <= hex_empty; else
if( row_i && col_i == 3'd5) hex0_o <=  cerc_sus; else
if(~row_i && col_i == 3'd5) hex0_o <=  cerc_jos; else
                            hex0_o <= hex_empty;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                 hex1_o <= hex_empty; else
if( row_i && col_i == 3'd4) hex1_o <=  cerc_sus; else
if(~row_i && col_i == 3'd4) hex1_o <=  cerc_jos; else
                            hex1_o <= hex_empty;
  

always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                 hex2_o <= hex_empty; else
if( row_i && col_i == 3'd3) hex2_o <=  cerc_sus; else
if(~row_i && col_i == 3'd3) hex2_o <=  cerc_jos; else
                            hex2_o <= hex_empty;

always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                 hex3_o <= hex_empty; else
if( row_i && col_i == 3'd2) hex3_o <=  cerc_sus; else
if(~row_i && col_i == 3'd2) hex3_o <=  cerc_jos; else
                            hex3_o <= hex_empty;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                 hex4_o <= hex_empty; else
if( row_i && col_i == 3'd1) hex4_o <=  cerc_sus; else
if(~row_i && col_i == 3'd1) hex4_o <=  cerc_jos; else
                            hex4_o <= hex_empty;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                 hex5_o <= hex_empty; else
if( row_i && col_i == 3'd0) hex5_o <=  cerc_sus; else
if(~row_i && col_i == 3'd0) hex5_o <=  cerc_jos; else
                            hex5_o <= hex_empty;






endmodule