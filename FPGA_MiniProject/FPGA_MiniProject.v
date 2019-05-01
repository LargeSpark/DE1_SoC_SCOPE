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
//ADC Onboard
output				ADC_CS_N,
output 				ADC_SCLK, //clock
output 				ADC_DIN,
input					ADC_DOUT,
//VGA
output 				vga_hsync,
output				vga_vsync,
output	[7:0]		R,
output	[7:0]		G,
output	[7:0]		B,
output				VClock,
output				ADDAClock,
output				ResampleLED,
//seven seg
output 	[6:0]		seg0,
output 	[6:0]		seg1,
output 	[6:0]		seg2,
output 	[6:0]		seg3
);

assign VClock = clock;
wire [11:0] testwave; //test wave output
//test code

//Default codes 

//TEST REG's

wire Wave1_EN;
wire Wave2_EN;
wire cursorX_EN;
wire cursorY_EN;
wire [25:0] slClock;
wire [10:0] offset1;
wire [10:0] offset2;
wire hold1;
wire hold2;
wire [10:0] cursorY1;
wire [10:0] cursorY2;
wire [10:0] cursorX1;
wire [10:0] cursorX2;
wire [3:0] shiftDown1;
wire [3:0] shiftDown2;
wire [5:0] sampleAdjust1;
wire [5:0] sampleAdjust2;
wire sampleWriteClock1; //stay
wire sampleWriteClock2; //stay
assign sampleWriteClock1 = slClock[sampleAdjust1]; //stay
assign sampleWriteClock2 = slClock[sampleAdjust2]; //stay

//Wave wires
wire [11:0] waveSigIn1;
wire [11:0] waveSigIn2;
wire [11:0] sampledwave1;
wire [11:0] sampledwave2;
//VGA IP Wires 
wire [10:0] sX;
wire [10:0] sY;
//To programatically change down shifts
assign waveSigIn1 = (sampledwave1 >> shiftDown1); // Squish 
assign waveSigIn2 = (sampledwave2 >> shiftDown2); //needs to change to wave sample 2 sampledwave1
//wire slClock = slowerClock[clockTest];
//assign ADDAClock = slClock;
//wire [11:0] adda1;
//Code to move cursors on Measre screen

 
wire [11:0] CH0;
wire [11:0] CH1;
wire [11:0] CH2;
wire [11:0] CH3;
wire [11:0] CH4;
wire [11:0] CH5;
wire [11:0] CH6;
wire [11:0] CH7;
sine_wave_gen testWave(
	.Clk (slClock[6]),
	.data_out (testwave)
	);

VGA_IP_Top VGA(
	.clk50 		(clock),
	.cursorX_EN (cursorX_EN),
	.cursorY_EN (cursorY_EN),
	.cursorY1 	(cursorY1),
	.cursorY2 	(cursorY2),
	.cursorX1 	(cursorX1),
	.cursorX2 	(cursorX2),
	.waveSigIn1 (waveSigIn1),
	.waveSigIn2 (waveSigIn2),
	.waveSigIn1_En (Wave1_EN),
	.waveSigIn2_En (Wave2_EN),
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
	.readClock (clock),
	.writeClock (sampleWriteClock1),
	.hold (hold1),
	.data (testwave),
	.screenX (sX),
	.reset (0),
	.screenData (sampledwave1),
	.triggerthreshold(0)
);

//test adc
Sample sample2(
	.readClock (clock),
	.writeClock (sampleWriteClock2),
	.hold (hold2),
	.data (CH0),
	.screenX (sX),
	.reset (0),
	.screenData (sampledwave2),
	.resample(ResampleLED),
	.triggerthreshold(100)
);

sevenseg sevSeg(
	.clock (clock),
	.seg_En (4'b1111),
	.number (4567),
	.decimalPoint_EN (0),
	.seg0 (seg0),
	.seg1 (seg1),
	.seg2 (seg2),
	.seg3 (seg3)
);


clockcounter slclock(
	.clock (clock),
	.counterout (slClock)
);

controls Ctrl(
	.switch0 (switch0), //Cursor X En
	.switch1 (switch1),	//Cursor Y En
	.switch2 (switch2), //Signal 1 En
	.switch3 (switch3),	//Signal 2 En
	.switch4 (switch4), //Cursor Y set
	.switch5 (switch5), //Cursor X Set 
	.switch6 (switch6), //Wave 1 Shift /Squish
	.switch7 (switch7), //Wave 2 Shift/Squish
	.switch8 (switch8), //Wave 1 Clock 
	.switch9 (switch9), //Wave 2 Clock 
	.butt0 (butt0),	//x1/y1 left/up
	.butt1 (butt1),  	//x1/y1 right/down
	.butt2 (butt2),	//x2/y2 left/up
	.butt3 (butt3),	//x2/y2 right/down
	.buttonClock (slClock[19]),
	.hold1Out (hold1),
	.hold2Out (hold2),
	.cursorY1Out (cursorY1),
	.cursorY2Out (cursorY2),
	.cursorX1Out (cursorX1),
	.cursorX2Out (cursorX2),
	.shiftDown1Out (shiftDown1),
	.shiftDown2Out (shiftDown2),
	.sampleAdjust1Out (sampleAdjust1),
	.sampleAdjust2Out (sampleAdjust2),
	.cursorX_ENOut (cursorX_EN),
	.cursorY_ENOut (cursorY_EN),
	.Wave1_ENOut (Wave1_EN),
	.Wave2_ENOut (Wave2_EN),
	.offset1Out (offset1),
	.offset2Out (offset2)
);




	ADCV2_adc_mega_0 #(
		.board          ("DE1-SoC"),
		.board_rev      ("Autodetect"),
		.tsclk          (13),
		.numch          (7),
		.max10pllmultby (1),
		.max10plldivby  (1)
	) adc_mega_0 (
		.CLOCK    (slClock[2]),    //                clk.clk
		.RESET    (0),    //              reset.reset
		.CH0      (CH0),      //           readings.export
		.CH1      (CH1),      //                   .export
		.CH2      (CH2),      //                   .export
		.CH3      (CH3),      //                   .export
		.CH4      (CH4),      //                   .export
		.CH5      (CH5),      //                   .export
		.CH6      (CH6),      //                   .export
		.CH7      (CH7),      //                   .export
		.ADC_SCLK (ADC_SCLK), // external_interface.export
		.ADC_CS_N (ADC_CS_N), //                   .export
		.ADC_DOUT (ADC_DOUT), //                   .export
		.ADC_DIN  (ADC_DIN)   //                   .export
	);

endmodule 