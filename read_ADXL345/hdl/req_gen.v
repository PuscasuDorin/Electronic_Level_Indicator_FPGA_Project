module req_gen(
	input clk  	,
	input rst_n	,	
	input ack_i ,
	input req_i	,
	input [7:0] data	,
	output reg req_o,
	output reg [7:0] LEDS
);

always @(posedge clk or negedge rst_n)begin
		if(~rst_n) req_o <= 1'b0; else
		if(~req_i) req_o <= 1'b1; else
		if(ack_i)	 req_o <= 1'b0;
end
 
 
always @(posedge clk or negedge rst_n)begin
		if(~rst_n) LEDS <= 8'b0; else
		if(ack_i & req_o & (time_pressed < clk/2)) LEDS <= data; 
end



endmodule