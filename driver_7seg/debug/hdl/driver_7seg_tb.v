module driver_7seg_tb( 
input					 clk					,
input 				 rst_n				,
output		     [7:0]		HEX0,
output		     [7:0]		HEX1,
output		     [7:0]		HEX2,
output		     [7:0]		HEX3,
output		     [7:0]		HEX4,
output		     [7:0]		HEX5
);

parameter BITS_PER_DISPLAY = 8;
parameter COLUMNS = 6;
parameter TIMER_LIMIT = 500;

wire [$clog2(COLUMNS+1)-1:0] sel_column;
wire sel_row;
wire move;

ck_rst_tb i_ck_rst_tb ( 
.clk         (clk  ),
.rst_n       (rst_n)
);  

driver_7seg #(
.BITS_PER_DISPLAY (BITS_PER_DISPLAY),
.COLUMNS 					(COLUMNS)
) i_driver_7seg (  
.clk      	(clk			 )					 									,
.rst_n    	(rst_n		 )			 											,
.sel_row  	(sel_row	 )		 												,
.sel_column (sel_column)														,
.segments_o ({HEX5, HEX4, HEX3, HEX2, HEX1, HEX0})
); 

ck_div #(
.TIMER_LIMIT (TIMER_LIMIT)
) i_ck_div (  
.clk      	 (clk	 ),
.rst_n    	 (rst_n),
.move				 (move )
); 

move_in_circle #(
.COLUMNS  (COLUMNS)
) i_move_in_circle(
.clk  			(clk			 ),
.rst_n			(rst_n		 ),
.move				(move			 ),
.sel_row		(sel_row	 ),
.sel_column	(sel_column) 		
);

endmodule 
