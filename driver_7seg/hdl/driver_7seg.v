module driver_7seg #(parameter COLUMNS = 6
										,parameter BITS_PER_DISPLAY = 8
										)
(
	input 																				 clk  		 ,
	input 																				 rst_n		 ,	
  input 																				 sel_row	 ,
  input [$clog2(COLUMNS+1)-1:0] 								 sel_column,
	output reg [COLUMNS-1:0][BITS_PER_DISPLAY-1:0] segments_o				
);
//8 *(sel_column+1)-1:8*sel_column 	
localparam UP_PATTERN = 8'b10011100	 							 ;
localparam DOWN_PATTERN = 8'b10100011							 ;
localparam NO_SEGMENTS = COLUMNS * BITS_PER_DISPLAY;

reg [COLUMNS-1:0][BITS_PER_DISPLAY-1:0] segments;

always_comb
begin
segments = {NO_SEGMENTS{1'b1}};

if(~sel_row) segments[sel_column] = UP_PATTERN  ; else
						 segments[sel_column] = DOWN_PATTERN;		
						 
end

always @(posedge clk or negedge rst_n)
if(~rst_n) segments_o <= {NO_SEGMENTS{1'b1}}; else
					 segments_o <= segments						;
					 
endmodule