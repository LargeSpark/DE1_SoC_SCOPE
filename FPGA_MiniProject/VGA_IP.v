module VGA_drawPixel(
input 				clock,
input reg			x_pos,
input reg			y_pos,
input reg [7:0]	colour_R,
input reg [7:0]	colour_G,
input reg [7:0]	colour_B,
output 				vga_hsync,
output				vga_vsync,
output	[7:0]		colour_R,
output	[7:0]		colour_G,
output	[7:0]		colour_B

);
//parameters for 1024x1028
localparam clockspeed = 108000000;
localparam h_a=1000 	//nanoseconds - Sync
localparam h_b=2300 	//nanoseconds - Backporch
localparam h_c=11900 //nanoseconds - Display Interval
localparam h_d=400 	//nanoseconds - Front Porch

reg [9:0] screenPosition = 0;
reg [9:0] linePosition = 0;

//What the counters must count up to to switch at the correct time.
localparam integer h_a_endcount = clockspeed * (h_a * 0.000000001);
localparam integer h_b_endcount = clockspeed * (h_b * 0.000000001);
localparam integer h_c_endcount = clockspeed * (h_c * 0.000000001);
localparam integer h_d_endcount = clockspeed * (h_d * 0.000000001);

//calculate highest reg size required
localparam regsize = $clog2(h_c_endcount);

//counter initilisations
reg h_a_counter [regsize:0] = 0;
reg h_b_counter [regsize:0] = 0;
reg h_c_counter [regsize:0] = 0;
reg h_d_counter [regsize:0] = 0;

//Indicator for section of signal
reg [2:0] sigIndicator = 0;
/*
0 - sync
1 - backporch
2 - data
3 - frontporch
*/

assign vga_hsync = (sigIndicator == 0) ? 1 : 0;		//assign hsync



endmodule
