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
input  [10:0] waveSel, //wave select to measure
input  [5:0]  measurement, //0 - no measurement, 1 is cursor x, 2 is cursor y
output [13:0] num

);

reg [25:0] Diff; //Delta 

//Math

always @ (posedge buttonClock)
begin 


end 

endmodule 