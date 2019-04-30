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
reg [10:0] cursorY1 = defaultY1; 	//TESTCODE
reg [10:0] cursorY2 = defaultY2;	//TESTCODE
reg [10:0] cursorX1 = defaultX1;  //TESTCODE
reg [10:0] cursorX2 = defaultX2; //TESTCODE
reg [10:0] offset1 = 30;
reg [10:0] offset2 = 200;
//Default codes 
localparam defaultY1 = 25;
localparam defaultY2 = 100;
localparam defaultX1 = 32;
localparam defaultX2 = 90;
//TEST REG's
reg testWave1;
reg testWave2;
reg testCx;
reg testCy;
reg buttPush = 0;
reg buttPush1 = 0;
//Wave wires
wire [11:0] waveSigIn1;
wire [11:0] waveSigIn2;
wire [11:0] sampledwave1;
wire [11:0] sampledwave2;
//Clocks
reg [19:0] slowerClock = 0;
//VGA IP Wires 
wire [10:0] sX;
wire [10:0] sY;
//To programatically change down shifts
reg [3:0] shiftDown1 = 0;
reg [3:0] shiftDown2 = 3;
assign waveSigIn1 = (sampledwave1 >> shiftDown1); // Squish 
assign waveSigIn2 = (sampledwave2 >> shiftDown2); //needs to change to wave sample 2 sampledwave1
//wire slClock = slowerClock[clockTest];
//assign ADDAClock = slClock;
wire [11:0] adda1;
//Parameters for Cursors
localparam moveSize = 1;	
//Code to move cursors on Measre screen
always @ (posedge slowerClock[19])
begin
	//State 1
	if (!switch9 && !switch8)
	begin	
	//Switch on Cursors
	testCx <= switch0;
	testCy <= switch1;
		//Code for yCursors 
		if (switch3 && !butt3)
		begin 
				cursorY1 <= cursorY1 + moveSize;
		end 
		else if (switch3 && !butt2)
		begin 
				cursorY1 <= cursorY1 - moveSize;
		end 
		else if (switch3 && !butt1)
		begin 
				cursorY2 <= cursorY2 + moveSize;
		end 
		else if (switch3 && !butt0)
		begin 
				cursorY2 <= cursorY2 - moveSize;
		end 
		//Codr for xCursors
		if (switch2 && !butt3)
		begin 
				cursorX1 <= cursorX1 + moveSize;
		end 
		else if (switch2 && !butt2)
		begin 
				cursorX1 <= cursorX1 - moveSize;
		end 
		else if (switch2 && !butt1)
		begin 
				cursorX2 <= cursorX2 + moveSize;
		end 
		else if (switch2 && !butt0)
		begin 
				cursorX2 <= cursorX2 - moveSize;
		end
		//Code to move both Y Cursors @ same time
		if (switch3 && switch2 && !butt3)
		begin
				cursorY1 <= cursorY1 + moveSize;
				cursorY2 <= cursorY2 + moveSize;
				cursorX1 <= defaultX1;
		end
		if (switch3 && switch2 && !butt2)
		begin
				cursorY1 <= cursorY1 - moveSize;
				cursorY2 <= cursorY2 - moveSize;
				cursorX1 <= defaultX1;
		end
		//Code to move both X Cursors @ same time
		if (switch3 && switch2 && !butt1)
		begin
				cursorX1 <= cursorX1 + moveSize;
				cursorX2 <= cursorX2 + moveSize;
				cursorY2 <= defaultY2;
		end
		if (switch3 && switch2	&& !butt0)
		begin
				cursorX1 <= cursorX1 - moveSize;
				cursorX2 <= cursorX2 - moveSize;
				cursorY2 <= defaultY2;
		end
	end
end 
//Code for Waves 
always @ (posedge slowerClock[19])
begin
	//State 2
	if (!switch9 && switch8)
	begin 
	//Code to see Waves 	
	testWave1 <= switch0;
	testWave2 <= switch1;
		//Move Wave 1 up and down 
		if (switch2 && !butt3)
		begin
				offset1 <= offset1 + moveSize;		
		end	
		else if (switch2 && !butt2)
		begin
				offset1 <= offset1 - moveSize;		
		end	
		//Move Wave 2 up and down 
		else if (switch2 && !butt1)
		begin
				offset2 <= offset2 + moveSize;		
		end	
		else if (switch2 && !butt0)
		begin
				offset2 <= offset2 - moveSize;		
		end		
	end
end

//Code for Squish
always @ (posedge slowerClock[19])
begin
	if (!switch9 && switch8)
	begin 
		if (switch3 && !butt3 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown1 = shiftDown1 + 1;			
		end
		else if (switch3 && !butt2 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown1 = shiftDown1 - 1;			
		end
		else if (switch3 && !butt1 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown2 = shiftDown2 + 1;			
		end
		else if (switch3 && !butt0 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown2 = shiftDown2 - 1;			
		end
		else if ((butt0 && butt1 && butt2 && butt3) && buttPush) begin
			buttPush <= 0;
		end
	end
end  
  
wire [11:0] CH0;
wire [11:0] CH1;
wire [11:0] CH2;
wire [11:0] CH3;
wire [11:0] CH4;
wire [11:0] CH5;
wire [11:0] CH6;
wire [11:0] CH7;
sine_wave_gen testWave(
	.Clk (slowerClock[6]),
	.data_out (testwave)
	);

VGA_IP_Top VGA(
	.clk50 		(clock),
	.cursorX_EN (testCx),
	.cursorY_EN (testCy),
	.cursorY1 	(cursorY1),
	.cursorY2 	(cursorY2),
	.cursorX1 	(cursorX1),
	.cursorX2 	(cursorX2),
	.waveSigIn1 (waveSigIn1),
	.waveSigIn2 (waveSigIn2),
	.waveSigIn1_En (testWave1),
	.waveSigIn2_En (testWave2),
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
	.writeClock (slowerClock[3]),
	.hold ( ),
	.data (testwave),
	.screenX (sX),
	.reset (0),
	.screenData (sampledwave1)
);

//test adc
Sample sample2(
	.readClock (clock),
	.writeClock (slowerClock[3]),
	.hold ( ),
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
	.clockOut	( )
);*/

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



/*ADA ada(
	.CLOCK(slowerClock[3]),
	.RESET(0),
	.ADC_CS_N(ADC_CS_N),
	.ADC_SCLK(ADC_SCLK),
	.ADC_DIN(ADC_DIN),
	.ADC_DOUT(ADC_DOUT),
	.CH0 (CH0), 
	.CH1 (CH1), 
	.CH2 (CH2), 
	.CH3 (CH3), 
	.CH4 (CH4), 
	.CH5 (CH5), 
	.CH6 (CH6), 
	.CH7 (CH7)
);*/

	ADCV2_adc_mega_0 #(
		.board          ("DE1-SoC"),
		.board_rev      ("Autodetect"),
		.tsclk          (13),
		.numch          (7),
		.max10pllmultby (1),
		.max10plldivby  (1)
	) adc_mega_0 (
		.CLOCK    (slowerClock[2]),    //                clk.clk
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

always @(posedge clock) begin
	slowerClock <= slowerClock + 1;

end

endmodule 