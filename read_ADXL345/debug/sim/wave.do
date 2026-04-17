onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /driver_7seg_tb/i_move_in_circle/clk
add wave -noupdate /driver_7seg_tb/i_move_in_circle/rst_n
add wave -noupdate /driver_7seg_tb/i_move_in_circle/move
add wave -noupdate /driver_7seg_tb/i_move_in_circle/sel_row
add wave -noupdate -radix unsigned /driver_7seg_tb/i_move_in_circle/sel_column
add wave -noupdate /driver_7seg_tb/HEX0
add wave -noupdate /driver_7seg_tb/HEX1
add wave -noupdate /driver_7seg_tb/HEX2
add wave -noupdate /driver_7seg_tb/HEX3
add wave -noupdate /driver_7seg_tb/HEX4
add wave -noupdate /driver_7seg_tb/HEX5
add wave -noupdate /driver_7seg_tb/i_driver_7seg/segments_o
add wave -noupdate /driver_7seg_tb/i_driver_7seg/segments
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24133821 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {24130676 ps} {24138068 ps}
