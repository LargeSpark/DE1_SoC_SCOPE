/*Testbench*/


`timescale 1 ns / 100 ps

module VGATest_tb;

	reg		 CLOCK = 0;
	reg		 VGACLOCK = 0;
	wire		 vga_hsync;
	wire		 vga_vsync;
	wire [7:0]		   R;
	wire [7:0]		   G;
	wire [7:0]		   B;
	
FPGA_MiniProject dut (

.clock (CLOCK),
.VGAclock (VGACLOCK),
.vga_hsync (vga_hsync),
.vga_vsync (vga_vsync),
.R (R),
.G (G),
.B (B)
);

localparam freq = 10; //   1/Freq =
localparam vgafreq = 20;
always #freq CLOCK = ~CLOCK;
always #vgafreq VGACLOCK = ~VGACLOCK;

initial begin
	CLOCK = 1'b0;
	
	
end

endmodule
