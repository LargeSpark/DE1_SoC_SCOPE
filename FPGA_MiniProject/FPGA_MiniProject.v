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
input 				switch4, //Cursor Y set
input					switch5, //Cursor X Set 
input 				switch6, //Wave 1 Shift /Squish
input 				switch7, //Wave 2 Shift/Squish
input 				switch8, //Wave 1 Clock 
input 				switch9, //Wave 2 Clock 
input					butt0,	//x1/y1 left/up
input					butt1,  	//x1/y1 right/down
input					butt2,	//x2/y2 left/up
input					butt3,	//x2/y2 right/down
//input [2:0]			clockTest,
input [13:0] 	ADCin,
input 			OutOfRange,
output 				vga_hsync,
output				vga_vsync,
output	[7:0]		R,
output	[7:0]		G,
output	[7:0]		B,
output				VClock,
output				ADDAClock,
output				ResampleLED
);

assign VClock = clock;
wire [11:0] testwave; //test wave output
//test code
reg [10:0] cursorY1 = 25; 	//TESTCODE
reg [10:0] cursorY2 = 100;	//TESTCODE
reg [10:0] cursorX1 = 32;  //TESTCODE
reg [10:0] cursorX2 = 90; //TESTCODE
reg [10:0] offset1 = 30;
reg [10:0] offset2 = 200;
//Wave wires
wire [11:0] waveSigIn1;
wire [11:0] waveSigIn2;
wire [11:0] sampledwave1;
wire [11:0] sampledwave2;
//Clocks
reg [15:0] slowerClock = 0;
//VGA IP Wires
wire [10:0] sX;
wire [10:0] sY;
//To programatically change down shifts
reg [3:0] shiftDown1 = 0;
reg [3:0] shiftDown2 = 3;
assign waveSigIn1 = (sampledwave1 >> shiftDown1);
assign waveSigIn2 = (sampledwave2 >> shiftDown2); //needs to change to wave sample 2 sampledwave1
//wire slClock = slowerClock[clockTest];
assign ADDAClock = slClock;
wire [11:0] adda1;
localparam downSize = 1;
//Code to move cursors 
always @ (posedge slowerClock[14])
begin
		if (switch4 && !butt3)
		begin 
				cursorY1 <= cursorY1 + downSize;
		end 
end 

sine_wave_gen testWave(
	.Clk (slClock),
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
	.waveSigIn1_Offset (offset1),
	.waveSigIn2_Offset (offset2),
	.sX (sX),
	.sY (sY)
);

Sample sample(
	.clock (clock),
	.data (testwave),
	.screenX (sX),
	.reset (0),
	.screenData (sampledwave1)
);

//test adc
Sample sample2(
	.clock (clock),
	.data (CH0),
	.screenX (sX),
	.reset (0),
	.screenData (sampledwave2),
	.resample(ResampleLED)
);
/*
ADDA adda(
	.clock (clock),				//clock
	.ADC (ADCin),					//ADDA GPIO
	.OutOfRange (OutOfRange),			//OUT OF RANGE INDICATOR
	.EN (1),					//CHANNEL ENABLE PIN
	.clockEN (1),				//CLOCK ENABLE
	.invertEN (0),			//INVERT OUTPUT
	.ADCOut (adda1),				
	.OutOfRangeOut ( ),
	.clockOut ( )
);*/

always @(posedge clock) begin
	slowerClock <= slowerClock + 1;
end

endmodule 