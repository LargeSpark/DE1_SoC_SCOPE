/* Top level modile for FPGA_MiniProject
Alexander Bolton - 200938078
Haider Shafiq - 201207577
N-Channel Oscilloscope */

// Top Level Module
module FPGA_MiniProject(
input 				clock,
output 				vga_hsync,
output				vga_vsync,
output	[7:0]		R,
output	[7:0]		G,
output	[7:0]		B
);
wire VGAclock;

VGA_clock VGAClk(
	.T50MHZClock (clock),
	.T25MHZClock (VGAclock)
);

VGA_drawPixel VGA(
	.clock(VGAclock),//FROM FREQ DIVIDER
	.x_pos (0),
	.y_pos (0),
	.colour_R (255),
	.colour_G (0),
	.colour_B (0),
	.vga_hsync (vga_hsync),
	.vga_vsync (vga_vsync),
	.R (R),
	.G (G),
	.B (B)
);

endmodule 