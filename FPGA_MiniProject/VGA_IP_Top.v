//800x600 VGA IP - Alexander Bolton
module VGA_IP_Top(
input clk50, //60 MHz Clock
input cursorX_EN, //Cursor X Enable
input cursorY_EN, //Cursor Y Enable
input [10:0] cursorY1, //Cursor Y1 Position
input [10:0] cursorY2, //Cursor Y2 Position
input [10:0] cursorX1, //Cursor X1 Position
input [10:0] cursorX2, //Cursor X2 Position
input [10:0] waveSigIn1_Offset, //Wave signal 0 offset
input [10:0] waveSigIn2_Offset, //Wave signal 1 offset
input [13:0] waveSigIn1, //Wave signal in for channel 0
input [13:0] waveSigIn2, //Wave signal in for channel 1
input waveSigIn1_En, //Wave signal enable for channel 0
input waveSigIn2_En, //Wave signal enable for channel 1
output hsync_out, //HSync out to monitor 
output vsync_out, //VSync out to monitor 
output [7:0] red_out, //RGB Out (Red)
output [7:0] blue_out, //RGB Out (Blue)
output [7:0] green_out, //RGB Out (Green)
output [10:0] sX, //Counter X Out
output [10:0] sY //Counter Y Out
);
	wire line_clk, blank, hblank, vblank;
	assign blank = hblank || vblank;
	//Instantiate HSync 
	hsync hs(
	.clk50 (clk50), //50MHz clock
	.hsync_out (hsync_out), //HSync output
	.blank_out (hblank), //Blanking period out
	.newline_out (line_clk) //new line out
	);
	//Instantiate HSync 
	vsync vs(
	.line_clk (line_clk), //Line clock in (goes to new line out)
	.vsync_out (vsync_out), //vsync output
	.blank_out (vblank) //Blanking period out
	);   
	
	gridandwave gaw(
	.clk (clk50), //50 MHz Clock
	.blank (blank), //Blanking Period
	.red_out (red_out), //Red Out
	.green_out (green_out), //Green Out
	.blue_out (blue_out), //Blue Out
	.hsync (hblank), //HSync in
	.vsync (vblank), //VSync in
	.waveSigIn1 (waveSigIn1), //Wave signal in for channel 0
	.waveSigIn2 (waveSigIn2), //Wave signal in for channel 1
	.waveSigIn1_En (waveSigIn1_En), //Wave signal enable for channel 0
	.waveSigIn2_En (waveSigIn2_En), //Wave signal enable for channel 1
	.cursorX_EN (cursorX_EN), //Cursor X Enable
	.cursorY_EN (cursorY_EN), //Cursor Y Enable
	.cursorY1 (cursorY1), //Cursor Y1 Position
	.cursorY2 (cursorY2), //Cursor Y2 Position
	.cursorX1 (cursorX1), //Cursor X1 Position
	.cursorX2 (cursorX2), //Cursor X2 Position
	.wave1YOffset (waveSigIn1_Offset), //Wave signal 1 offset
	.wave2YOffset (waveSigIn2_Offset), //Wave Signal 2 offset
	.sX (sX), //Output of x counter
	.sY (sY) //output of y counter
	);
	


endmodule



