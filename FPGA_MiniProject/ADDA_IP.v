//8192 Levels per side (+ve,-ve)
//2Vpk-pk max in

module ADDA(
input 			clock,				//clock
input [13:0] 	ADC,					//ADDA GPIO
input 			OutOfRange,			//OUT OF RANGE INDICATOR
input 			EN,					//CHANNEL ENABLE PIN
input				clockEN,				//CLOCK ENABLE
input				invertEN,			//INVERT OUTPUT
output [13:0] 	ADCOut,				
output 			OutOfRangeOut,
output			clockOut
);

localparam signd = false;
wire signalOut[13:0];
Assign clockOut = (clockEN == 1) ? clock : 0;
Assign signalOut = (invertEN == 1) ? ~ADC : ADC;
Assign ADCOut = (EN == 1) ? signalOut : 0;
Assign OutOfRangeOut = OutOfRangep;

endmodule 