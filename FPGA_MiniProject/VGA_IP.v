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
//parameters for 1024x1028
localparam clockspeed = 108000000;
localparam h_a=1000; 	//nanoseconds - Sync
localparam h_b=2300; 	//nanoseconds - Backporch
localparam h_c=11900; //nanoseconds - Display Interval
localparam h_d=400; 	//nanoseconds - Front Porch

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
reg [regsize:0] h_a_counter  = 0;
reg [regsize:0] h_b_counter  = 0;
reg [regsize:0] h_c_counter  = 0;
reg [regsize:0] h_d_counter  = 0;

//Indicator for section of signal
reg [2:0] sigIndicator = 0;
/*
0 - sync
1 - backporch
2 - data
3 - frontporch
*/

assign vga_hsync = (sigIndicator == 0) ? 0 : 1;		//assign hsync
assign R = (sigIndicator == 2)? colour_R : 0;
assign G = (sigIndicator == 2)? colour_G : 0;
assign B = (sigIndicator == 2)? colour_B : 0;

//counters
always @(posedge clock) begin

	//If sync
	if(sigIndicator == 0) begin
		if(h_a_counter == h_a_endcount) begin
			h_a_counter <= 0;
			sigIndicator <= 1;
		end else begin
		h_a_counter <= h_a_counter + 1;
		end
	end
	
	//if backporch
	if(sigIndicator == 1) begin
		if(h_b_counter == h_b_endcount) begin
			h_b_counter <= 0;
			sigIndicator <= 2;
		end else begin
		h_b_counter <= h_b_counter + 1;
		end
	end
	
	//if data
	if(sigIndicator == 2) begin
		if(h_c_counter == h_c_endcount) begin
			h_c_counter <= 0;
			sigIndicator <= 3;
		end else begin
		h_c_counter <= h_c_counter + 1;
		end
	end
	
	//if frontporch
	if(sigIndicator == 3) begin
		if(h_d_counter == h_d_endcount) begin
			h_d_counter <= 0;
			sigIndicator <= 0;
		end else begin
		h_d_counter <= h_d_counter + 1;
		end
	end	
	
end

endmodule
