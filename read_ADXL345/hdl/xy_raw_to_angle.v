module xy_raw_to_angle (
input clk,
input rst_n,

input [15:0] x_data_i,
input [15:0] y_data_i,
input 			 data_valid_i,

output reg signed [7:0] x_data_angle_o,
output reg signed [7:0] y_data_angle_o,
output reg 			 			  angle_valid_o
);