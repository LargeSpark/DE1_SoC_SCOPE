onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /LT24Top_tb/clock
add wave -noupdate -radix unsigned /LT24Top_tb/reset
add wave -noupdate -radix unsigned /LT24Top_tb/resetApp
add wave -noupdate -radix unsigned /LT24Top_tb/LT24Wr_n
add wave -noupdate -radix unsigned /LT24Top_tb/LT24Rd_n
add wave -noupdate -radix unsigned /LT24Top_tb/LT24CS_n
add wave -noupdate -radix unsigned /LT24Top_tb/LT24RS
add wave -noupdate -radix unsigned /LT24Top_tb/LT24Reset_n
add wave -noupdate -radix unsigned /LT24Top_tb/LT24Data
add wave -noupdate -radix unsigned /LT24Top_tb/LT24LCDOn
add wave -noupdate -radix unsigned /LT24Top_tb/HALF_CLOCK_PERIOD
add wave -noupdate -radix unsigned /LT24Top_tb/half_cycles
add wave -noupdate /LT24Top_tb/NUM_CYCLES
add wave -noupdate /LT24Top_tb/CLOCK_FREQ
add wave -noupdate /LT24Top_tb/clock
add wave -noupdate /LT24Top_tb/reset
add wave -noupdate /LT24Top_tb/HALF_CLOCK_PERIOD
add wave -noupdate /LT24Top_tb/half_cycles
add wave -noupdate /LT24Top_tb/lcd_scope_dut/xCount/clk
add wave -noupdate /LT24Top_tb/lcd_scope_dut/xCount/rst
add wave -noupdate /LT24Top_tb/lcd_scope_dut/xCount/enable
add wave -noupdate -expand /LT24Top_tb/lcd_scope_dut/Display/yAddr
add wave -noupdate {/LT24Top_tb/lcd_scope_dut/Display/yAddr[2]}
add wave -noupdate -expand /LT24Top_tb/lcd_scope_dut/Display/xAddr
add wave -noupdate /LT24Top_tb/lcd_scope_dut/xCount/cntOut
add wave -noupdate /LT24Top_tb/lcd_scope_dut/yCount/clk
add wave -noupdate /LT24Top_tb/lcd_scope_dut/yCount/rst
add wave -noupdate /LT24Top_tb/lcd_scope_dut/yCount/enable
add wave -noupdate /LT24Top_tb/lcd_scope_dut/yCount/cntOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1395168 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {9203946 ps}
