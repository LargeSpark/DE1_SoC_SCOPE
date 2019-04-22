/*Testbench*/
//

`timescale 1 ns / 100 ps

module VGATest_tb;

	reg		 CLOCK = 0;
	wire 		   switch0;
	wire 		   switch1;
	wire		 vga_hsync;
	wire		 vga_vsync;
	wire [7:0]		   R;
	wire [7:0]		   G;
	wire [7:0]		   B;
	wire		    VClock;
	
FPGA_MiniProject dut (

.clock (CLOCK),
.vga_hsync (vga_hsync),
.vga_vsync (vga_vsync),
.switch0 (switch0),
.switch1 (switch1),
.R (R),
.G (G),
.B (B),
.VClock(VClock)
);

localparam freq = 10; //   1/Freq =
always #freq CLOCK = ~CLOCK;

initial begin
	CLOCK = 1'b0;
	
end

endmodule
