module fsm_read_axes_data(
input	rst_n,
input clk,

input ack_i,
input [7:0] rd_data_i,

output reg req_o,
output reg rw_ni,
output reg [7:0] addr_o,
output reg [7:0] wr_data_o

output reg [15:0] x_data_o,  
output reg [15:0] y_data_o,     
output reg        data_valid_o
);

localparam STATE_RESET
localparam STATE_CONFIG_RES;
localparam STATE_CONFIG_PWR;
localparam STATE_WAIT_100HZ;
localparam STATE_READ_X_LOW;
localparam STATE_READ_X_HIGH;
localparam STATE_READ_Y_LOW;
localparam STATE_READ_Y_HIGH;
localparam STATE_OUTPUT_VALID;

