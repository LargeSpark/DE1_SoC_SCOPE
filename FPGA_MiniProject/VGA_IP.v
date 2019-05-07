//VSync Clock written by https://github.com/mstump/verilog-vga-controller/  - Mike Stump
//This module controls the VSync signal
module vsync(
	input line_clk, //Line Clock in 
	output vsync_out, //VSync out to monitor
	output blank_out //Blank period out
	);
   
   reg [10:0] count = 10'b0000000000; //counter set to 0
   reg vsync  = 0; //vsync reg to 0
   reg blank  = 0; //blanking period reg to 0

	//at posedge line clock count up
   always @(posedge line_clk)
	 if (count < 666)
	   count <= count + 1;
	 else
	   count <= 0;
   //at posedge line clock if count is above 600 blanking period on
   always @(posedge line_clk)
	 if (count < 600)
	   blank 		<= 0;
	 else
	   blank 		<= 1;
   //at posedge line clock if count is between values then vsync is on
   always @(posedge line_clk)
	 begin
		if (count < 637)
		  vsync 	<= 1;
		else if (count >= 637 && count < 643)
		  vsync 	<= 0;
		else if (count >= 643)
		  vsync 	<= 1;
	 end
	//assign to outputs
   assign vsync_out  = vsync;
   assign blank_out  = blank;
   
endmodule // hsync   
//HSync Clock written by https://github.com/mstump/verilog-vga-controller/  - Mike Stump
//This module controls the HSync signal
module hsync(
	input clk50, //50MHz clock in 
	output hsync_out, //HSync out to monitor
	output blank_out, //blanking period out
	output newline_out //newline clock out
	);
   //counter set to 0
   reg [10:0] count = 10'b0000000000;
	//hSync, blank, and new line regs to 0
   reg hsync 	= 0;
   reg blank 	= 0;
   reg newline 	= 0;
	//at posedge 50MHz clock count up when below 1040 else reset.
   always @(posedge clk50)
	 begin
		if (count < 1040)
		  count  <= count + 1;
		else
		  count  <= 0;
	 end
   //at posedge 50MHz clock if count is at 0 then newline clock to 1
   always @(posedge clk50)
	 begin
		if (count == 0)
		  newline <= 1;
		else
		  newline <= 0;
	 end
	//at posedge 50MHz clock if count is above or equal to 800 then blanking period on
   always @(posedge clk50)
	 begin
		if (count >= 800)
		  blank  <= 1;
		else
		  blank  <= 0;
	 end
	//Control hsync clock
   always @(posedge clk50)
	 begin
		if (count < 856) // pixel data plus front porch
		  hsync <= 1;
		else if (count >= 856 && count < 976)
		  hsync <= 0;
		else if (count >= 976)
		  hsync <= 1;
	 end // always @ (posedge clk50)
				 
	//Assign outputs
   assign hsync_out    = hsync;
   assign blank_out    = blank;
   assign newline_out  = newline;
   
endmodule
//This module controls the pixels of the measurement grid and waves
module gridandwave(
	input clk, //50MHz clock
	input blank, //Blanking period in
	input hsync, //HSync in
	input vsync, //VSync in
	input cursorX_EN, //Cursor Enables
	input cursorY_EN, //Cursor Enables
	input [10:0] cursorY1, //CursorY1 Position
	input [10:0] cursorY2, //CursorY2 Position
	input [10:0] cursorX1, //CursorX1 Position
	input [10:0] cursorX2, //CursorX2 Position
	input [13:0] waveSigIn1, //Channel 0 in
	input [13:0] waveSigIn2, //Channel 1 in
	input [10:0] wave1YOffset, //Channel 0 offset in
	input [10:0] wave2YOffset,	//Channel 1 offset in
	input waveSigIn1_En, //Channel 0 enable
	input waveSigIn2_En, //Channel 1 enable
	output [7:0] red_out,  //red colour output to monitor
	output [7:0] green_out, //green colour output to monitor
	output [7:0] blue_out, //blue colour output to monito
	output [10:0] sX, //Counter x Out
	output [10:0] sY //Counter y Out
	);
	localparam gridoffset = 20; //Offset for grid on x axis
	reg [19:0] x; //Register for x counter
	reg [19:0] y; //Register for y counter
   reg [7:0] pixel_R = 0; //Register for red pixel colour
	reg [7:0] pixel_G = 0; //Register for green pixel colour
	reg [7:0] pixel_B = 0; //Register for blue pixel colour
	
	//Assigns for counter outputs
	assign sX = x; 
	assign sY = y;
   always @(posedge clk)
	 begin
		if (blank) begin //if blanking period
			if(hsync) begin //if hsync then reset counter
			x <= 0; //reset
			end else if (vsync) begin //if vsync then reset counter
			x <= 0; //reset
			end
		end else begin
			x <= x+1; //count up
			//wave code - if wave enabled and y is equal to the wave signal plus offset
			if (waveSigIn1_En && y == (waveSigIn1 + wave1YOffset)) begin
			pixel_R <= 8'b00000000; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if (waveSigIn2_En && (y == waveSigIn2 + wave2YOffset)) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b00000000; //set colours
			pixel_B <= 8'b11111111; //set colours
			//cursor code - If cursor enabled and the x or y value is equal to the specific cursor value
			end else if(cursorX_EN && x == cursorX1) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b00000000; //set colours
			end else if (cursorX_EN && x == cursorX2) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b00000000; //set colours
			end else if (cursorY_EN && y == cursorY1) begin
			pixel_R <= 8'b00000000; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b00000000; //set colours
			end else if (cursorY_EN && y == cursorY2) begin
			pixel_R <= 8'b00000000; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b00000000; //set colours
			//Y grid code - This is a very inefficient peice of code which draws the grid.
			end else if(y == 60 * 1) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 2) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 3) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 4) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 5) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 6) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 7) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 8) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(y == 60 * 9) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			//X grid code - This is a very inefficient peice of code which draws the grid.
			end else if(x == (60 * 1) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 2) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 3) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 4) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 5) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 6) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 7) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 8) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 9) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 10) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 11) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 12) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 13) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else if(x == (60 * 14) - gridoffset) begin
			pixel_R <= 8'b11111111; //set colours
			pixel_G <= 8'b11111111; //set colours
			pixel_B <= 8'b11111111; //set colours
			end else begin //else set the background to black
			pixel_R <= 8'b0; //set colours to black
			pixel_G <= 8'b0; //set colours to black
			pixel_B <= 8'b0; //set colours to black
			end
		end
	 end
	//HSync counter for y counter
	always @(posedge hsync) begin
		if(vsync) begin
			y <= 0;
		end else begin
			y <= y + 1;
		end
	end
	//Assigns for red green and blue colours out. It also checks if it is in a blanking period.
   assign red_out	 = (blank) ? 0 : pixel_R;
	assign green_out = (blank) ? 0 : pixel_G;
	assign blue_out  = (blank) ? 0 : pixel_B;
   
endmodule // color