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
input [2:0]			clockTest,
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
reg [12:0] slowerClock = 0;
//VGA IP Wires
wire [10:0] sX;
wire [10:0] sY;
//To programatically change down shifts
reg [3:0] shiftDown1 = 0;
reg [3:0] shiftDown2 = 1;
assign waveSigIn1 = (sampledwave1 >> shiftDown1);
assign waveSigIn2 = (sampledwave2 >> shiftDown2); //needs to change to wave sample 2 sampledwave1
wire slClock = slowerClock[9];
assign ADDAClock = slClock;
wire [11:0] adda1;

sine_wave_gen testWave(
	.Clk (slowerClock[2]),
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
	.clockOut	( )
);*/

wire [11:0] CH0;
wire [11:0] CH1;
wire [11:0] CH2;
wire [11:0] CH3;
wire [11:0] CH4;
wire [11:0] CH5;
wire [11:0] CH6;
wire [11:0] CH7;

ADA ada(
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
);

always @(posedge clock) begin
	slowerClock <= slowerClock + 1;
end

endmodule 