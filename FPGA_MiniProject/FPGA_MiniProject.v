/* Top level modile for FPGA_MiniProject
Alexander Bolton - 200938078
Haider Shafiq - 201207577
N-Channel Oscilloscope */

// Top Level Module
module FPGA_MiniProject #(
			// Number of Channels -> Start with 1 
			parameter Channels = 1
)(
			// Following code is quick test to remind me of how verilog works 
			input  a,
			input  b,
			output c
);

			// Should see an & gate in the RTL viewer
			assign c = a & b;

endmodule 