module rgb_generator(
    input  [9:0] pixel_xi,
    input  [9:0] pixel_yi,
    input        video_oni,
    
    input signed [9:0] accx_i,
    input signed [9:0] accy_i,
    
    output [3:0] rgb_ro,
    output [3:0] rgb_go,
    output [3:0] rgb_bo
);

wire [9:0] ball_x = ((accx_i + 512) * 640) >> 10;
wire [9:0] ball_y = ((accy_i + 512) * 480) >> 10;

localparam R = 10;

wire in_ball = (pixel_xi >= ball_x - R) && (pixel_xi < ball_x + R) &&
               (pixel_yi >= ball_y - R) && (pixel_yi < ball_y + R);

reg [11:0] color;
always @(*)
if (~video_oni) color = 12'h000; else
if (in_ball)    color = 12'hFFF; else
                color = 12'h000;

assign rgb_ro = color[11:8];
assign rgb_go = color[7:4];
assign rgb_bo = color[3:0];

endmodule