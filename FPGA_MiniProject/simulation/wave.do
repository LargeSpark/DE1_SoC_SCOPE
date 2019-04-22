onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /VGATest_tb/CLOCK
add wave -noupdate -radix unsigned /VGATest_tb/switch0
add wave -noupdate -radix unsigned /VGATest_tb/switch1
add wave -noupdate -radix unsigned /VGATest_tb/switch2
add wave -noupdate -radix unsigned /VGATest_tb/switch3
add wave -noupdate -radix unsigned /VGATest_tb/vga_hsync
add wave -noupdate -radix unsigned /VGATest_tb/vga_vsync
add wave -noupdate -radix unsigned /VGATest_tb/G
add wave -noupdate -radix unsigned /VGATest_tb/B
add wave -noupdate -radix unsigned /VGATest_tb/VClock
add wave -noupdate -radix unsigned /VGATest_tb/R
add wave -noupdate /VGATest_tb/dut/sample/clock
add wave -noupdate /VGATest_tb/dut/sample/data
add wave -noupdate /VGATest_tb/dut/sample/reset
add wave -noupdate /VGATest_tb/dut/sample/screenData
add wave -noupdate /VGATest_tb/dut/sample/triggerHighPoint
add wave -noupdate /VGATest_tb/dut/sample/sampleData
add wave -noupdate -radix decimal -childformat {{{/VGATest_tb/dut/sample/samplecounter[9]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[8]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[7]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[6]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[5]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[4]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[3]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[2]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[1]} -radix decimal} {{/VGATest_tb/dut/sample/samplecounter[0]} -radix decimal}} -subitemconfig {{/VGATest_tb/dut/sample/samplecounter[9]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[8]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[7]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[6]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[5]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[4]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[3]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[2]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[1]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/samplecounter[0]} {-height 15 -radix decimal}} /VGATest_tb/dut/sample/samplecounter
add wave -noupdate -radix decimal -childformat {{{/VGATest_tb/dut/sample/outputcounter[9]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[8]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[7]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[6]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[5]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[4]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[3]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[2]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[1]} -radix decimal} {{/VGATest_tb/dut/sample/outputcounter[0]} -radix decimal}} -subitemconfig {{/VGATest_tb/dut/sample/outputcounter[9]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[8]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[7]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[6]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[5]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[4]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[3]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[2]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[1]} {-height 15 -radix decimal} {/VGATest_tb/dut/sample/outputcounter[0]} {-height 15 -radix decimal}} /VGATest_tb/dut/sample/outputcounter
add wave -noupdate /VGATest_tb/dut/sample/outputData
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/gaw/x
add wave -noupdate -radix decimal /VGATest_tb/dut/VGA/gaw/y
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60560570000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
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
WaveRestoreZoom {52372586950 ps} {102506705950 ps}
