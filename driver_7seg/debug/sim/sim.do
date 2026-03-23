vlib work
vmap work work

vlog  ../../hdl/driver_7seg.v
vlog  ../../hdl/move_in_circle.v
vlog  ../../hdl/ck_div.v
vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/driver_7seg_tb.v

vsim -gui work.driver_7seg_tb

do wave.do

run -all

