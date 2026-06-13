module ck_div	#(parameter STEP_DELAY_S = 1)
(
	input  clk				,
	input  rst_n			,
	output move
);
localparam F_CLK_HZ = 50_000_000;
localparam TIMER_LIMIT = F_CLK_HZ * STEP_DELAY_S;

reg [31:0] counter;

always @(posedge clk or negedge rst_n)
if (~rst_n) counter <= 32'd0				 ; else
if (move) 	counter <= 32'd0				 ; else
						counter <= counter + 1'b1;

assign move = (counter == (TIMER_LIMIT - 1));

endmodule