/* Top level modile for FPGA_MiniProject
Alexander Bolton - 200938078
Haider Shafiq - 201207577 s
N-Channel Oscilloscope */

// Top Level Module
module FPGA_MiniProject(
input 				clock,
input					switch0, //Cursor X En
input					switch1,	//Cursor Y En
output 				vga_hsync,
output				vga_vsync,
output	[7:0]		R,
output	[7:0]		G,
output	[7:0]		B,
output				VClock
);

assign VClock = clock;
reg [10:0] cursorY1 = 25; 	//TESTCODE
reg [10:0] cursorY2 = 100;	//TESTCODE
reg [10:0] cursorX1 = 32;  //TESTCODE
reg [10:0] cursorX2 = 90; //TESTCODE

VGA_IP_Top VGA(
	.clk50 		(clock),
	.cursorX_EN (switch0),
	.cursorY_EN (switch1),
	.cursorY1 	(cursorY1),
	.cursorY2 	(cursorY2),
	.cursorX1 	(cursorX1),
	.cursorX2 	(cursorX2),
	.hsync_out 	(vga_hsync),
	.vsync_out 	(vga_vsync),
	.red_out 	(R),
	.blue_out 	(G),
	.green_out 	(B)
);

endmodule 