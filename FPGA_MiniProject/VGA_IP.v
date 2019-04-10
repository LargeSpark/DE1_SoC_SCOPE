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
localparam h_a=3800; 	//nanoseconds - Sync
localparam h_b=1900; 	//nanoseconds - Backporch
localparam h_c=25400; 	//nanoseconds - Display Interval
localparam h_d=600; 		//nanoseconds - Front Porch
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
//localparam integer v_a_endcount = clockspeed * (v_a * 0.000000001);
//localparam integer v_b_endcount = clockspeed * (v_b * 0.000000001);
//localparam integer v_c_endcount = clockspeed * (v_c * 0.000000001);
//localparam integer v_d_endcount = clockspeed * (v_d * 0.000000001);

//calculate highest reg size required
localparam Hregsize_a = $clog2(h_a_endcount);
localparam Hregsize_b = $clog2(h_b_endcount);
localparam Hregsize_c = $clog2(h_c_endcount);
localparam Hregsize_d = $clog2(h_d_endcount);
localparam Vregsize_a = $clog2(v_a);
localparam Vregsize_b = $clog2(v_b);
localparam Vregsize_c = $clog2(v_c);
localparam Vregsize_d = $clog2(v_d);
localparam Hozregsize = $clog2(Horizontal_Size);
localparam Verregsize = $clog2(Vertical_Size);

//counter initilisations
reg [Hregsize_a:0] h_a_counter  = 0;
reg [Hregsize_b:0] h_b_counter  = 0;
reg [Hregsize_c:0] h_c_counter  = 0;
reg [Hregsize_d:0] h_d_counter  = 0;
reg [Vregsize_a:0] v_a_counter  = 0;
reg [Vregsize_b:0] v_b_counter  = 0;
reg [Vregsize_c:0] v_c_counter  = 0;
reg [Vregsize_d:0] v_d_counter  = 0;

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

//assign hsync
assign vga_hsync = (HozsigIndicator == 0) ? 0 : 1;		
assign R = (HozsigIndicator == 2 && VerSigOn == 0)? colour_R : 0;
assign G = (HozsigIndicator == 2 && VerSigOn == 0)? colour_G : 0;
assign B = (HozsigIndicator == 2 && VerSigOn == 0)? colour_B : 0;
//assign vsync
assign vga_vsync = (VerSigIndicator == 0 && VerSigOn == 1 && rstV == 0) ? 0 : 1;

//counters
always @(posedge clock) begin
	//If sync
	if(HozsigIndicator == 0) begin
		if(h_a_counter == h_a_endcount) begin
			h_a_counter <= 0;
			HozsigIndicator <= 1;
		end else begin
		h_a_counter <= h_a_counter + 1;
		end
	end
	
	//if backporch
	if(HozsigIndicator == 1) begin
		if(h_b_counter == h_b_endcount) begin
			h_b_counter <= 0;
			HozsigIndicator <= 2;
		end else begin
		h_b_counter <= h_b_counter + 1;
		end
	end
	
	//if data
	if(HozsigIndicator == 2) begin
		if(h_c_counter == h_c_endcount) begin
			h_c_counter <= 0;
			HozsigIndicator <= 3;
		end else begin
		h_c_counter <= h_c_counter + 1;
		end
	end
	
	//if frontporch
	if(HozsigIndicator == 3) begin
		if(h_d_counter == h_d_endcount) begin
			h_d_counter <= 0;
			HozsigIndicator <= 0;
		end else begin
		h_d_counter <= h_d_counter + 1;
		end
	end	
	
end

//Pixel Counter & V Sync
always @(posedge clock) begin
	//##Counter
	
	if(VerSigOn == 0) begin
		if(HozPixel < Horizontal_Size) begin
				HozPixel <= HozPixel + 1; //add one to position
		end else begin
			HozPixel <= 0;
			VerPixel <= VerPixel+1;
			
			if(VerPixel >= Vertical_Size) begin
				VerSigOn <= 1;
			end
		end
	end
	
	if(rstV == 1) begin
		HozPixel <= 0;
		VerPixel <= 0;
		VerSigOn <= 0;
		rstV <= 0;
	end
	//end
	
	//###### V SYNC ######
	
	
end

//VerPixel == 0;
reg [0:0] rstcounter = 1;
//Vsync
always @(posedge vga_hsync) begin

	if(VerSigOn == 1 && rstV == 0) begin
		//if sync
		if(VerSigIndicator == 0) begin
				if(v_a_counter == v_a) begin
					v_a_counter <= 0;
					VerSigIndicator <= 1;
				end else begin
				v_a_counter <= v_a_counter + 1;
				end
			end
			
		//if backporch
		else if(VerSigIndicator == 1) begin
			if(v_b_counter == v_b) begin
				v_b_counter <= 0;
				VerSigIndicator <= 2;
			end else begin
			v_b_counter <= v_b_counter + 1;
			end
		end
		
		//if data
		else if(VerSigIndicator == 2) begin
			if(v_c_counter == v_c) begin
				v_c_counter <= 0;
				VerSigIndicator <= 3;
			end else begin
			v_c_counter <= v_c_counter + 1;
			end
		end
		
		//if frontporch
		else if(VerSigIndicator == 3) begin
			if(v_d_counter == v_d) begin
				v_d_counter <= 0;
				VerSigIndicator <= 0;
				rstV <= 1;
			end else begin
			v_d_counter <= v_d_counter + 1;
			end
		end	
		
		if(rstV == 1) begin
			rstcounter <= rstcounter + 1;
			if(rstcounter == 1) begin
			rstcounter <= 0;
			end
		end
	end

end

endmodule
