module move_in_circle #(parameter COLUMNS = 6
											 ,parameter NO_COL_BITS = $clog2(COLUMNS+1)-1 
											 )
(
	input 		 								 clk  			,
	input 		 								 rst_n			,
	input 		 								 move				,
  output reg 								 sel_row		,
  output reg [NO_COL_BITS:0] sel_column		
);
reg wait_turn;

always @(posedge clk or negedge rst_n)
if(~rst_n) sel_row <= 1'b0; else
if(move)
begin
if((sel_column == COLUMNS-1) & ~sel_row) sel_row <= 1'b1; else
if((sel_column == 0) & sel_row) 				 sel_row <= 1'b0;
end
					 
always @(posedge clk or negedge rst_n)
if(~rst_n) sel_column <= {NO_COL_BITS{1'b0}}; else
if(move & ~wait_turn)
begin
if(~sel_row & (sel_column != COLUMNS-1)) sel_column <= sel_column + 1'b1;else
if(sel_row & (sel_column != 0)) 				 sel_column <= sel_column - 1'b1;																									
end

always @(posedge clk or negedge rst_n)
if(~rst_n) wait_turn <= 1'b0; else
if(move & ((sel_column == COLUMNS-1) & ~sel_row) | ((sel_column == 0) & sel_row)) wait_turn <= 1'b1;else
																																									wait_turn <= 1'b0;

endmodule