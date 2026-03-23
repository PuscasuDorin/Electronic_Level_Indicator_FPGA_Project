module ck_div	#(parameter TIMER_LIMIT = 100_000_000)
(
	input  clk				,
	input  rst_n			,
	output move
);
reg [31:0] counter;

always @(posedge clk or negedge rst_n)
if (~rst_n) counter <= 32'd0				 ; else
if (move) 	counter <= 32'd0				 ; else
						counter <= counter + 1'b1;

assign move = (counter == (TIMER_LIMIT - 1));

endmodule