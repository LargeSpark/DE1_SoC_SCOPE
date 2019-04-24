/*Testbench*/
//

`timescale 1 ns / 100 ps

module VGATest_tb;

	reg		 CLOCK = 0;
	reg 		switch0 = 0; //Cursor X En
	reg		switch1 = 0;	//Cursor Y En
	reg		switch2 = 0; //Signal 1 En
	reg		switch3 = 0;	//Signal 2 En
	wire		vga_hsync;
	wire		vga_vsync;
	wire  [7:0]		G;
	wire	[7:0]		B;
	wire				VClock;
	
FPGA_MiniProject dut (

.clock (CLOCK),
.vga_hsync (vga_hsync),
.vga_vsync (vga_vsync),
.switch0 (switch0),
.switch1 (switch1),
.switch2 (switch2),
.switch3 (switch3),
.R (R),
.G (G),
.B (B),
.VClock(VClock)
);

localparam freq = 10; //   1/Freq =
always #freq CLOCK = ~CLOCK;

initial begin
	CLOCK = 1'b0;
	switch0 = 1'b0;
	switch1 = 1'b0;
	switch2 = 1'b1;
	switch3 = 1'b0;
	
end

endmodule
