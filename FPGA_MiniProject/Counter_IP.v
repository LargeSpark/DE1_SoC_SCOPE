/* Slower clock for FPGA_MiniProject
This module takes the defaullt 50MHz clock & slows it to ~93Hz 
N-Channel Oscilloscope */

module clockcounter(
input clock,
output [25:0] counterout
);
//Store output of the register 
reg [25:0] counter = 0;
assign counterout = counter;
//Every clock cycle increase the counter by 1 
always @(posedge clock) begin
	counter <= counter + 1;
end
endmodule
