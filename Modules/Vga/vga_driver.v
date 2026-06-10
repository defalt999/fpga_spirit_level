module vga_driver(
    input clk_i,
    input rst_ni,

    input[3:0] rgb_ri,
    input[3:0] rgb_gi,
    input[3:0] rgb_bi,
    
    output[3:0] VGA_Ro,
    output[3:0] VGA_Go,
    output[3:0] VGA_Bo,

    output VGA_HSo,
    output VGA_VSo,

    output [9:0] pixel_xo,
    output [9:0] pixel_yo,
    output       video_ono
);

localparam HSIZE = 640;
localparam HSYNC = 96;
localparam HBACK = 48;
localparam HFRONT = 16;
localparam HTOTAL= 800;

localparam VSIZE = 480;
localparam VSYNC = 2;
localparam VBACK = 33;
localparam VFRONT = 10;
localparam VTOTAL = 525;

reg [9:0] h_count;
reg [9:0] v_count;


always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)             h_count <= 'd0; else
if(h_count == HTOTAL-1) h_count <= 'd0; else
                        h_count <= h_count +1;

always @(posedge clk_i or negedge rst_ni)
if(~rst_ni)             v_count <= 'd0; else
if(v_count == VTOTAL-1) v_count <= 'd0; else
if(h_count == HTOTAL-1) v_count <= v_count +1;

assign VGA_HSo = ~(h_count < HSYNC);
assign VGA_VSo = ~(v_count < VSYNC);

wire h_synced;
assign h_synced = (h_count >= HSYNC + HBACK) && (h_count < HSYNC + HBACK + HSIZE);

wire v_synced;
assign v_synced = (v_count >= VSYNC + VBACK) && (v_count < VSYNC + VBACK + VSIZE);


assign video_ono = h_synced && v_synced;
assign pixel_xo = video_ono ? (h_count - (HSYNC + HBACK)) : 10'd0;
assign pixel_yo = video_ono ? (v_count - (VSYNC + VBACK)) : 10'd0;

assign VGA_Ro = video_ono ? rgb_ri : 4'd0;
assign VGA_Go = video_ono ? rgb_gi : 4'd0;
assign VGA_Bo = video_ono ? rgb_bi : 4'd0;

endmodule