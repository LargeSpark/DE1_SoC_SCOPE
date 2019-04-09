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

localparam signd = 0;
wire [13:0] signalOut;
assign clockOut = (clockEN == 1) ? clock : 0;
assign signalOut = (invertEN == 1) ? ~ADC : ADC;
assign ADCOut = (EN == 1) ? signalOut : 0;
assign OutOfRangeOut = OutOfRange;

endmodule 