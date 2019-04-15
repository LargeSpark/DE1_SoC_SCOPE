module VGA_drawPixel(
input 				clock,
input					x_pos,
input					y_pos,
input 		[7:0]	colour_R,
input 		[7:0]	colour_G,
input 		[7:0]	colour_B,
output 				vga_hsync,
output				vga_vsync,
output	[7:0]		R,
output	[7:0]		G,
output	[7:0]		B

);
//parameters for 640x480
localparam clockspeed = 25000000;
localparam h_a=3800; 	//nanoseconds - Sync //3800
localparam h_b=1900; 	//nanoseconds - Backporch //1900
localparam h_c=25400; 	//nanoseconds - Display Interval //25400
localparam h_d=600; 		//nanoseconds - Front Porch //600
localparam v_a=2;			//lines - Sync
localparam v_b=33;		//lines - Backporch
localparam v_c=480;		//lines - Display Interval
localparam v_d=10;		//lines - Front Porch
localparam Horizontal_Size = 640;
localparam Vertical_Size = 480;


reg [9:0] screenPosition = 0;
reg [9:0] linePosition = 0;

//What the counters must count up to to switch at the correct time.
localparam integer h_a_endcount = clockspeed * (h_a * 0.000000001);
localparam integer h_b_endcount = clockspeed * (h_b * 0.000000001);
localparam integer h_c_endcount = clockspeed * (h_c * 0.000000001);
localparam integer h_d_endcount = clockspeed * (h_d * 0.000000001);
localparam integer total_Hendcount = h_a_endcount + h_b_endcount + h_c_endcount + h_d_endcount;
localparam integer total_Vendcount = v_a + v_b + v_c + v_d;
//calculate highest reg size required
localparam Vregsize_a = $clog2(v_a);
localparam Vregsize_b = $clog2(v_b);
localparam Vregsize_c = $clog2(v_c);
localparam Vregsize_d = $clog2(v_d);
localparam Hozregsize = $clog2(Horizontal_Size);
localparam Verregsize = $clog2(Vertical_Size);
//other method
localparam Hregsize = $clog2(total_Hendcount);
localparam Vregsize = $clog2(total_Vendcount);

//counter initilisations
reg [Hregsize:0] Hcounter = 0;
reg [Vregsize:0] Vcounter = 0;
//Positions counter initilisations
reg [Hozregsize:0] HozPixel = 0;
reg [Verregsize:0] VerPixel = 0;
//Indicator for section of signal
reg [2:0] HozsigIndicator = 0;
/*
0 - sync
1 - backporch
2 - data
3 - frontporch
*/
reg [2:0] VerSigIndicator = 0; //Keep track of each counter.
reg VerSigOn = 0; //When 1 it will turn off colour signals
reg rstV = 0;
/*
0 - sync
1 - backporch
2 - data
3 - frontporch
*/

assign R = (Hcounter>=(h_a_endcount + h_b_endcount) && Hcounter<(h_a_endcount + h_b_endcount+h_c_endcount) && VerSigOn == 0)? colour_R : 0;
assign G = (Hcounter>=(h_a_endcount + h_b_endcount) && Hcounter<(h_a_endcount + h_b_endcount+h_c_endcount) && VerSigOn == 0)? colour_G : 0;
assign B = (Hcounter>=(h_a_endcount + h_b_endcount) && Hcounter<(h_a_endcount + h_b_endcount+h_c_endcount) && VerSigOn == 0)? colour_B : 0;
assign vga_hsync = (Hcounter<h_a_endcount) ? 0 : 1;
assign vga_vsync = (Vcounter<v_a) ? 0 : 1;
//assign vsync
//assign vga_hsync = (VerSigIndicator == 0 && VerSigOn == 1 && rstV == 0) ? 0 : 1;
//counters
always @(posedge clock) begin
	Hcounter = Hcounter + 1;
	if (Hcounter == total_Hendcount) begin
		Hcounter <= 0;
		if(VerSigOn == 0) begin
		VerPixel <= VerPixel + 1;
		end
	end
end

//Pixel Counter & V Sync
always @(posedge vga_hsync) begin
	if(VerPixel < Vertical_Size) begin
	VerSigOn <= 1;
	Vcounter = Vcounter + 1;
		if(Vcounter == total_Vendcount) begin
			VerSigOn <= 0;
			Vcounter <= 0;
		end
	end
end

endmodule
