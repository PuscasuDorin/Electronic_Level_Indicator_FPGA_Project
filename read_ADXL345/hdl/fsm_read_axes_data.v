module fsm_read_axes_data(
input	rst_n								,
input clk	 								,
		
input ack_i					  		,
input [7:0] rd_data_i 		,

output reg req_o					,
output reg rw_ni					,	 // 1=read, 0=write
output reg [5:0] addr_o		,
output reg [7:0] wr_data_o,

output reg signed [15:0] x_data_o,  
output reg signed [15:0] y_data_o
);

localparam STATE_RESET		 					= 4'd0;
localparam STATE_CONFIG_RESOLUTION	= 4'd1;
localparam STATE_CONFIG_POWER				= 4'd2;
localparam STATE_WAIT_100HZ					= 4'd3;
localparam STATE_READ_X_LOW					= 4'd4;
localparam STATE_READ_X_HIGH				= 4'd5;
localparam STATE_READ_Y_LOW					= 4'd6;
localparam STATE_READ_Y_HIGH				= 4'd7;
localparam MAX_TICK_100HZ						= 32'h7_A120; //500_000

reg [3:0]  current_state;
reg [3:0]  next_state;
reg [31:0] timer_cnt;
wire tick;

always @(posedge clk or negedge rst_n)begin
	if(~rst_n) current_state <= STATE_RESET; else
						 current_state <= next_state;
end

always_comb begin
	
	case(current_state)
		STATE_RESET: begin
			next_state = STATE_CONFIG_RESOLUTION;
		end
		
		STATE_CONFIG_RESOLUTION: begin
			if(ack_i) next_state = STATE_CONFIG_POWER; else
								next_state = STATE_CONFIG_RESOLUTION;
		end
		
		STATE_CONFIG_POWER: begin
			if(ack_i) next_state = STATE_WAIT_100HZ; else
								next_state = STATE_CONFIG_POWER;
		end
		
		STATE_WAIT_100HZ: begin
			if(tick) next_state = STATE_READ_X_LOW; else
							 next_state = STATE_WAIT_100HZ;
		end
		
		STATE_READ_X_LOW: begin
			if(ack_i) next_state = STATE_READ_X_HIGH; else
								next_state = STATE_READ_X_LOW;
		end
		
		STATE_READ_X_HIGH: begin
			if(ack_i) next_state = STATE_READ_Y_LOW; else
								next_state = STATE_READ_X_HIGH;
		end
		
		STATE_READ_Y_LOW: begin
			if(ack_i) next_state = STATE_READ_Y_HIGH; else
								next_state = STATE_READ_Y_LOW;
		end
		
		STATE_READ_Y_HIGH: begin
			if(ack_i) next_state = STATE_WAIT_100HZ; else
								next_state = STATE_READ_Y_HIGH;
		end
		
	endcase	
end	

	
always @(posedge clk or negedge rst_n)begin
	if (~rst_n)begin
		req_o 		<= 1'b0;
		rw_ni 		<= 1'b1;
		addr_o 		<= 6'h00;
		wr_data_o <= 8'h00;
	end else begin
		
		case (current_state)
			STATE_RESET: begin
				req_o 			 <= 1'b0;
				rw_ni 			 <= 1'b0;
			end
			
			STATE_CONFIG_RESOLUTION: begin
				req_o 			 <= 1'b1;
				rw_ni 			 <= 1'b0;
				addr_o 			 <= 6'h31;
				wr_data_o 	 <= 8'b0100_1000;
				
				if(ack_i) req_o <= 1'b0;
			end
			
			STATE_CONFIG_POWER: begin
				req_o 		<= 1'b1;
				rw_ni 		<= 1'b0;
				addr_o 		<= 6'h2D;
				wr_data_o <= 8'b0000_1000;
				
				if(ack_i) req_o <= 1'b0;
			end
			
			STATE_READ_X_LOW: begin
				rw_ni <= 1'b1;
				addr_o <= 6'h32;
				if(ack_i)begin
					x_data_o[7:0] <= rd_data_i;
					req_o <= 1'b0;
				end else
				req_o <= 1'b1;
			end
			
			STATE_READ_X_HIGH: begin
				rw_ni <= 1'b1;
				addr_o <= 6'h33;
				if(ack_i)begin
					x_data_o[15:8] <= rd_data_i;
					req_o <= 1'b0;
				end	else
				req_o <= 1'b1;
			end
			
			STATE_READ_Y_LOW: begin
				rw_ni <= 1'b1;
				addr_o <= 6'h34;
				if(ack_i)begin
					y_data_o[7:0] <= rd_data_i;
					req_o <= 1'b0;
				end else
				req_o <= 1'b1;
			end
			
			STATE_READ_Y_HIGH: begin
				rw_ni <= 1'b1;
				addr_o <= 6'h35;
				if(ack_i)begin 
					y_data_o[15:8] <= rd_data_i;
					req_o <= 1'b0;
				end else
				req_o <= 1'b1;
			end
			
		endcase
	end
end


assign tick = (timer_cnt >= MAX_TICK_100HZ);

always @(posedge clk or negedge rst_n) begin

	if(~rst_n) timer_cnt <= 32'd0; else
	
	if(current_state ==  STATE_WAIT_100HZ) begin
		if(tick) timer_cnt <= 32'd0; else
						 timer_cnt <= timer_cnt + 1;		
	end else
	timer_cnt <= 32'd0;
	
end

endmodule



