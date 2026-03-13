module hex_displays_animated(
    input clk_i,
    input rst_ni,

    input sens,

    output [7:0] hex0_o,
    output [7:0] hex1_o,
    output [7:0] hex2_o,
    output [7:0] hex3_o,
    output [7:0] hex4_o,
    output [7:0] hex5_o
);
//Combinatie biti cerc sus: dp g f e d c b a -> 8'b10011100
//Combinatie biti cerc jos: dp g f e d c b a -> 8'b10100011

localparam cerc_sus  = 8'b10011100;
localparam cerc_jos  = 8'b10100011;
localparam hex_empty = 8'b11111111;

reg[25:0] clocks;
reg en;
reg[3:0] counter;

always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                clocks <= 26'd0; else
if(clocks == 26'd50000000) clocks <= 26'd0; else
                           clocks <= clocks +1;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)                 en <= 1'b0; else
if(clocks == 26'd50000000)  en <= 1'b1; else
                            en <= 1'b0;

always @(posedge clk_i or negedge rst_ni)
if (~rst_ni)                       counter <=        4'd0; else
if (en && sens && counter == 4'd0) counter <=       4'd11; else
if (en && sens)                    counter <= counter - 1; else
if (en && ~sens && counter == 4'd11)        counter <=        4'd0; else
if (en && ~sens)                            counter <= counter + 1;


wire[5:0] selections;
wire sel_row;
selecter display_selecter(
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .in_i(counter),
    .select_col_o(selections),
    .sel_row_o(sel_row)
);

wire [7:0] hex_o [5:0];   

genvar i;
generate
    for (i = 0; i < 6; i = i + 1) begin : hex_gen
        hex hex_inst (
            .clk_i(clk_i),
            .rst_ni(rst_ni),
            .en_i(selections[i]),
            .up_i(sel_row),
            .display_o(hex_o[i])
        );
    end
endgenerate

assign hex0_o = hex_o[0];
assign hex1_o = hex_o[1];
assign hex2_o = hex_o[2];
assign hex3_o = hex_o[3];
assign hex4_o = hex_o[4];
assign hex5_o = hex_o[5];


endmodule