/* Top level modile for FPGA_MiniProject
Alexander Bolton - 200938078
Haider Shafiq - 201207577 s
N-Channel Oscilloscope */

// Top Level Module
module FPGA_MiniProject(
input 				clock,
input					switch0, //Cursor X En
input					switch1,	//Cursor Y En
input					switch2, //Signal 1 En
input					switch3,	//Signal 2 En
output 				vga_hsync,
output				vga_vsync,
output	[7:0]		R,
output	[7:0]		G,
output	[7:0]		B,
output				VClock
);

assign VClock = clock;
wire [13:0] testwave;
reg [10:0] cursorY1 = 25; 	//TESTCODE
reg [10:0] cursorY2 = 100;	//TESTCODE
reg [10:0] cursorX1 = 32;  //TESTCODE
reg [10:0] cursorX2 = 90; //TESTCODE
wire [13:0] waveSigIn1;
reg [2:0] slowerClock = 0;
wire [10:0] sX;
wire [10:0] sY;

sine_wave_gen testWave(
	.Clk (slowerClock[1]),
	.data_out (testwave)
	);

VGA_IP_Top VGA(
	.clk50 		(clock),
	.cursorX_EN (switch0),
	.cursorY_EN (switch1),
	.cursorY1 	(cursorY1),
	.cursorY2 	(cursorY2),
	.cursorX1 	(cursorX1),
	.cursorX2 	(cursorX2),
	.waveSigIn1 (waveSigIn1),
	.waveSigIn2 (waveSigIn2),
	.waveSigIn1_En (switch2),
	.waveSigIn2_En (switch3),
	.hsync_out 	(vga_hsync),
	.vsync_out 	(vga_vsync),
	.red_out 	(R),
	.blue_out 	(G),
	.green_out 	(B),
	.sX (sX),
	.sY (sY)
);

Sample sample(
	.clock (slowerClock[1]),
	.data (testwave),
	.screenX (sX),
	.reset (0),
	.screenData (waveSigIn1)
);

always @(posedge clock) begin
	slowerClock <= slowerClock + 1;
end

endmodule 