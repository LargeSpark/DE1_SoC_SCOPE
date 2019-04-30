module ADA (
	CLOCK,
	RESET,
	ADC_CS_N,
	ADC_SCLK,
	ADC_DIN,
	ADC_DOUT, 
	CH0, 
	CH1, 
	CH2, 
	CH3, 
	CH4, 
	CH5, 
	CH6, 
	CH7
);

parameter tsclk = 8'd16;
parameter numch = 4'd7;
parameter board = "DE10-Standard";
parameter board_rev = "Autodetect";
parameter max10pllmultby = 1;
parameter max10plldivby = 10;

input CLOCK, RESET;
output reg [11:0] CH0, CH1, CH2, CH3, CH4, CH5, CH6, CH7;

input ADC_DOUT;
output ADC_SCLK, ADC_CS_N, ADC_DIN;

reg go;
wire done;
wire [11:0] outs [7:0];
wire [8:0] T_SCLK;

defparam ADC_CTRL.T_SCLK = tsclk, ADC_CTRL.NUM_CH = numch, ADC_CTRL.BOARD = board, ADC_CTRL.BOARD_REV = board_rev, ADC_CTRL.MAX10_PLL_MULTIPLY_BY = max10pllmultby, ADC_CTRL.MAX10_PLL_MULTIPLY_BY = max10plldivby;
altera_up_avalon_adv_adc ADC_CTRL (CLOCK, RESET, go, ADC_SCLK, ADC_CS_N, ADC_DIN, ADC_DOUT, done, outs[0], outs[1], outs[2], outs[3], outs[4], outs [5], outs[6], outs[7]);

always @ (posedge CLOCK)
begin
	if (RESET) begin
		go<=1'b0;
		CH0<=0;
		CH1<=0;
		CH2<=0;
		CH3<=0;
		CH4<=0;
		CH5<=0;
		CH6<=0;
		CH7<=0;
	end
	else if (done) begin
		go<=1'b0;
		CH0<=outs[0];
		CH1<=outs[1];
		CH2<=outs[2];
		CH3<=outs[3];
		CH4<=outs[4];
		CH5<=outs[5];
		CH6<=outs[6];
		CH7<=outs[7];
	end	
	else 
		go<=1'b1;
end

endmodule
