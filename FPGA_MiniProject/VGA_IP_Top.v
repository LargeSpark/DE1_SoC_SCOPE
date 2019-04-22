//Based on https://github.com/mstump/verilog-vga-controller/blob/master/src   - 800x600 //
module VGA_IP_Top(
input clk50,
input cursorX_EN,
input cursorY_EN,
input [10:0] cursorY1,
input [10:0] cursorY2,
input [10:0] cursorX1,
input [10:0] cursorX2,
input [13:0] waveSigIn1,
input [13:0] waveSigIn2,
input waveSigIn1_En,
input waveSigIn2_En,
output hsync_out,
output vsync_out,
output [7:0] red_out,
output [7:0] blue_out,
output [7:0] green_out,
output [10:0] sX,
output [10:0] sY
);
	wire line_clk, blank, hblank, vblank;
	assign blank = hblank || vblank;
	
	hsync hs(
	.clk50 (clk50), 
	.hsync_out (hsync_out), 
	.blank_out (hblank), 
	.newline_out (line_clk)
	);

	vsync vs(
	.line_clk (line_clk), 
	.vsync_out (vsync_out), 
	.blank_out (vblank)
	);   
	
	gridandwave gaw(
	.clk (clk50), 
	.blank (blank), 
	.red_out (red_out), 
	.green_out (green_out), 
	.blue_out (blue_out),
	.hsync (hblank),
	.vsync (vblank),
	.waveSigIn1 (waveSigIn1),
	.waveSigIn2 (waveSigIn2),
	.waveSigIn1_En (waveSigIn1_En),
	.waveSigIn2_En (waveSigIn2_En),
	.cursorX_EN (cursorX_EN),
	.cursorY_EN (cursorY_EN),
	.cursorY1 (cursorY1),
	.cursorY2 (cursorY2),
	.cursorX1 (cursorX1),
	.cursorX2 (cursorX2),
	.sX (sX),
	.sY (sY)
	);
	


endmodule



