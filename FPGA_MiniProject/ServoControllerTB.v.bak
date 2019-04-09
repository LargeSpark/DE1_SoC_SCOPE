/*Testbench*/


`timescale 1 ns / 100 ps

module ServoController_tb;

	reg		 CLOCK = 0;
	reg [7:0] duty = 8'h00;
	reg       load = 0;
	wire		 PWMOUT;
	
ServoController dut (

	.clock		(CLOCK),
	.duty			(duty),
	.load			(load),
	.PWMOut		(PWMOUT)
);

localparam freq = 10;
always #freq CLOCK = ~CLOCK;

initial begin
	CLOCK = 1'b0;
	load = 0;
	
	#30_000_000;
	duty = 8'hFF;
	load = 1;
	@(posedge CLOCK);
	load = 0;
	
	#60_000_000;
	duty = 8'h80;
	load = 1;
	@(posedge CLOCK);
	load = 0;
	
	
end

endmodule
