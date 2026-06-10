module req_ack_phy(
    input  clk_i,
    input  rst_ni,

    output logic       req_o    ,
    output logic       rw_o     ,
    output logic [5:0] address_o,
    output logic [7:0] wr_data_o,
    input              ack_i    ,
    input  logic [7:0] rd_data_i,

    output signed[9:0] accx_o,
    output signed[9:0] accy_o
);

typedef enum logic[1:0] {
    READ  = 2'b00,
    WRITE = 2'b01,
    JUMP  = 2'b10
} opcode_t;

typedef struct packed {
    opcode_t     opcode;   
    logic [5:0] operand1;   
    logic [7:0]  operand2;    
} instr_t;

localparam PROGRAM_SIZE = 8;
localparam INSTR_SIZE   = 16;

localparam DATA_FORMAT_ADDR = 6'h31;
localparam POWER_CTL_ADDR   = 6'h2D;
localparam INT_ENABLE_ADDR  = 6'h2E;
localparam DATAX0           = 6'h32;
localparam DATAX1           = 6'h33;
localparam DATAY0           = 6'h34;
localparam DATAY1           = 6'h35;

localparam instr_t [0:PROGRAM_SIZE-1] PROGRAM = '{
    '{WRITE, DATA_FORMAT_ADDR, 8'h40},
    '{WRITE, POWER_CTL_ADDR  , 8'h08},
    '{WRITE, INT_ENABLE_ADDR , 8'h00},
    '{READ , DATAX0          , 8'd0 },
    '{READ , DATAX1          , 8'd1 },
    '{READ , DATAY0          , 8'd2 },
    '{READ , DATAY1          , 8'd3 },
    '{JUMP , 6'd3            , 8'd0 }
};

instr_t                         crt_instr;
logic[$clog2(PROGRAM_SIZE)-1:0] program_counter;
reg[0:3][7:0]                   data;

assign crt_instr = PROGRAM[program_counter];


always@(posedge clk_i or negedge rst_ni)
if(~rst_ni)  req_o <= 1'b0; else
if(ack_i)    req_o <= 1'b0; else
             req_o <= 1'b1;  

				 
always@(posedge clk_i or negedge rst_ni)
if(~rst_ni)                      program_counter <= 'b0; else
if(ack_i) begin
    if(crt_instr.opcode == JUMP) program_counter <=    crt_instr.operand1; else
                                 program_counter <= program_counter + 'd1;
end

always@(posedge clk_i or negedge rst_ni)
if(~rst_ni)                   rw_o <= 1'b1; else
if(crt_instr.opcode == WRITE) rw_o <= 1'b0; else
                              rw_o <= 1'b1;

always@(posedge clk_i or negedge rst_ni)
if(~rst_ni)                                               address_o <=                'd0; else
if(crt_instr.opcode == WRITE || crt_instr.opcode == READ) address_o <= crt_instr.operand1; else
                                                          address_o <=                'd0;

always@(posedge clk_i or negedge rst_ni)
if(~rst_ni)                   wr_data_o <=                'd0; else
if(crt_instr.opcode == WRITE) wr_data_o <= crt_instr.operand2; else
                              wr_data_o <=                'd0;

always@(posedge clk_i or negedge rst_ni)
if(~rst_ni) data <= '{default:'0}; else
if(ack_i && crt_instr.opcode == READ) data[crt_instr.operand2[1:0]] <= rd_data_i;

assign accx_o = {data[1], data[0]};
assign accy_o = {data[3], data[2]};


endmodule