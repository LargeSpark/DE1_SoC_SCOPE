module Measure(
input	 		  buttonClock, 	
input  [10:0] cursory1,
input  [10:0] cursory2,
input  [10:0] cursorx1,
input  [10:0] cursorx2,
input  [5:0]  sampleadjust1, //sample rate
input  [5:0]  sampleadjust2,
input  [3:0]  shiftDown1, //shrink
input  [3:0]  shiftDown2,
input  [1:0] waveSel, //wave select to measure
input  [2:0]  measurement, //0 - no measurement, 1 is cursor x, 2 is cursor y
output [13:0] num

);

reg [13:0] deltay1 = 0;
reg [13:0] deltay2 = 0;
reg [13:0] deltax1 = 0;
reg [13:0] deltax2 = 0;

reg [13:0] result = 6;
reg [13:0] vx1 = 0;
assign num = result;

wire [13:0] Diffx; //Delta x
//Find Delta x - makes sure we get no -ve values 
assign Diffx = (deltay1 < 0) ? deltay2 : deltay1;
wire [13:0] Diffy; //Delta y
//Find Delta y 
assign Diffy = (deltax1 < 0) ? deltax2 : deltax1;

always @(posedge buttonClock) begin 
	deltay1 <= cursory1 - cursory2;
	deltay2 <= cursory2 - cursory1;
	deltax1 <= cursorx1 - cursorx2;
	deltax2 <= cursorx2 - cursorx1;
	vx1 <= (shiftDown1 + 1) * Diffx;
	
	result <= vx1;
end

endmodule 