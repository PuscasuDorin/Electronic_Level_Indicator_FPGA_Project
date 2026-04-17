module req_gen(
	input clk  	,
	input rst_n	,	
	input ack_i ,
	input req_i	,
	input [7:0] data	,
	output reg req_o,
	output reg [7:0] LEDS
);
//reg [31:0] time_pressed;
//Leg req la 1 si fac citire de pe registrul 0 pe led-uri

always @(posedge clk or negedge rst_n)begin
		if(~rst_n) req_o <= 1'b0; else
		if(~req_i) req_o <= 1'b1; else
												 req_o <= 1'b0;
end
 
 
always @(posedge clk or negedge rst_n)begin
		if(~rst_n) LEDS <= 8'b0; else
		if(ack_i & req_o) LEDS <= data; 
end

//always @(posedge clk or negedge rst_n)
//if(~rst_n) time_pressed <= 0; else
//if(req_i) time_pressed <= time_pressed + 1; else
//					time_pressed <= 0;

endmodule