module req_gen(
	input clk  			 		 ,
	input rst_n			 		 ,	
	input ack_i 		 		 ,
	input req_button 		 ,
	input [7:0] data 		 ,
	output reg req_o 		 ,
	output reg [7:0] LEDS
);
reg req_button_d;
wire req_button_pos_clk;


always @(posedge clk or negedge rst_n)begin
		if(!rst_n) req_button_d <= 1'b0; else
							 req_button_d <= req_button;
end 

assign req_button_pos_clk = (~req_button) & req_button_d;
 
always @(posedge clk or negedge rst_n)begin
		if(~rst_n) 						 req_o <= 1'b0; else
		if(ack_i)	 						 req_o <= 1'b0; else
		if(req_button_pos_clk) req_o <= 1'b1; 
end

always @(posedge clk or negedge rst_n)begin
		if(~rst_n) 				 LEDS <= 8'b0; else
		if(ack_i & req_o ) LEDS <= data; 
end

endmodule