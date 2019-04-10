onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /VGATest_tb/CLOCK
add wave -noupdate -radix unsigned /VGATest_tb/VGACLOCK
add wave -noupdate -radix unsigned /VGATest_tb/vga_hsync
add wave -noupdate -radix unsigned /VGATest_tb/vga_vsync
add wave -noupdate -radix unsigned /VGATest_tb/R
add wave -noupdate -radix unsigned /VGATest_tb/G
add wave -noupdate -radix unsigned /VGATest_tb/B
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/h_a_counter
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/h_b_counter
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/h_c_counter
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/h_d_counter
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/v_a_counter
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/v_b_counter
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/v_c_counter
add wave -noupdate /VGATest_tb/dut/VGA/HozsigIndicator
add wave -noupdate /VGATest_tb/dut/VGA/VerSigIndicator
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/v_d_counter
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/HozPixel
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/VerPixel
add wave -noupdate /VGATest_tb/dut/VGA/VerSigOn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26300340000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 216
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {26041283645 ps} {26811258225 ps}
