/* Measurements for FPGA_MiniProject
This module measures the voltage of the waves and dispalys it on the seven seg display
N-Channel Oscilloscope */

//All the inputs & outputs
module Measure(
input	 		  buttonClock, 
input 		  switch9,
input 		  switch8,
input 		  switch7,	
input  [10:0] cursory1,
input  [10:0] cursory2,
input  [10:0] cursorx1,
input  [10:0] cursorx2,
input  [5:0]  sampleadjust1, //sample rate
input  [5:0]  sampleadjust2,
input  [3:0]  shiftDown1, //shrink
input  [3:0]  shiftDown2,
input  [1:0]  waveSel, //wave select to measure
input  [2:0]  measurement, //0 - no measurement, 1 is cursor x, 2 is cursor y
//Number to be dispalyed on the 7 seg
output [13:0] num
);
//Differance in cursor values, initialy 0
reg [13:0] deltay1 = 0;
reg [13:0] deltay2 = 0;
reg [13:0] deltax1 = 0;
reg [13:0] deltax2 = 0;
//Result 6, if nothing happens should see 6 on 7 seg display
reg [13:0] result = 6;
//Reg's to store result of wave in
reg [13:0] vx1 = 0;
reg [13:0] vx2 = 0;
reg [13:0] fy1 = 0;
//Num = Result
assign num = result;
//Delta x
wire [13:0] Diffx; 
//Find Delta x - makes sure we get no -ve values 
assign Diffx = (deltay1 < 0) ? deltay2 : deltay1;
//Delta y
wire [13:0] Diffy; 
//Find Delta y 
assign Diffy = (deltax1 < 0) ? deltax2 : deltax1;

always @(posedge buttonClock) 
begin 
	//Get values of Delta's
	deltay1 <= cursory1 - cursory2;
	deltay2 <= cursory2 - cursory1;
	deltax1 <= cursorx1 - cursorx2;
	deltax2 <= cursorx2 - cursorx1;
	//Caluclate voltage
	vx1 <= ((((shiftDown1 + 1) * Diffx)) * 2); 
	//Store value in result
	result <= vx1;
end
endmodule 