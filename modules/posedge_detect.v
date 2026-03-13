module posedge_detect(
    input clk_i,
    input rst_ni,
    input key,
    output key_press
);



reg key_prev;
always @(posedge clk_i or negedge rst_ni)
if(~rst_ni) key_prev <= 1'b1; else
		      key_prev <= key;
				

assign key_press = ~key & key_prev;

endmodule