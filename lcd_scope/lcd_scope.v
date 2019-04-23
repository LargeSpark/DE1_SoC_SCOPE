/* LCD module for DE1-SoC scope
 * Mini-project
 * Haider Shafiq & Alex Bolton 
 */
 
 // Top-level - Lab 5 FPGA for SoC code used as basis
 module lcd_scope 
 (
	// Setting input and outputs
	input		clock,
	input 	globalRst,
	output	rstApp,
	// LT24 interface
	output             LT24Wr_n,
   output             LT24Rd_n,
   output             LT24CS_n,
   output             LT24RS,
   output             LT24Reset_n,
   output [15:0] 		 LT24Data,
   output             LT24LCDOn
);
	
// Varaibles
wire [7:0]  x;
<<<<<<< Updated upstream
reg  [7:0]	xPos; 		// Screen width is 240, 240 is 8 bits
=======
reg  [7:0]	xPos = 0; 		// Screen width is 240, 240 is 8 bits
>>>>>>> Stashed changes
wire [8:0]  yPos;			// Screen width is 320, 320 is 9 bits
reg  [15:0] pixData;	   // 15->11 = red, 10->5 = green, 4->0 = blue
wire 			pixReady;
reg			pixWrite;
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
// LT24 Dimensions
localparam LCD_W = 240;
localparam LCD_H = 320;

// Instantiating LT24 Display Driver from Lab 5
// Code by Thomas Carpenter, slightly edited to fit this code
LT24Display #(
    .WIDTH       (LCD_W),
    .HEIGHT      (LCD_H),
    .CLOCK_FREQ  (50000000)
) Display (
    .clock       (clock),
    .globalReset (globalRst),
    .resetApp    (rstApp),
    .xAddr       (xPos),
    .yAddr       (yPos),
    .pixelData   (pixData),
    .pixelWrite  (pixWrite),
    .pixelReady  (pixReady),
    .pixelRawMode(1'b0),
    .cmdData     (8'b0),
    .cmdWrite    (1'b0),
    .cmdDone     (1'b0),
    .cmdReady    (    ),
    .LT24Wr_n    (LT24Wr_n),
    .LT24Rd_n    (LT24Rd_n),
    .LT24CS_n    (LT24CS_n),
    .LT24RS      (LT24RS),
    .LT24Reset_n (LT24Reset_n),
    .LT24Data    (LT24Data),
    .LT24LCDOn   (LT24LCDOn)
);

// Instantiaitng the x-position counter via the N-bit counter
NbitCounter #(
	.N 		(8),			// Width of x-postion is 8 bits
	.Max		(LCD_W - 1) // Max value for x-pos is 239, 0 -> 239 = 240
) xCount(
	.clk		(clock),
	.rst		(rstApp),
	.enable	(pixReady),
	.cntOut	(x)
);

// y Enable is ready when pixReady is high and when xPos = its max val
wire yCntEn = (pixReady && (xPos == LCD_W - 1));
// Instantiaitng the y-position counter via the N-bit counter
NbitCounter #(
	.N 		(9),			// Width of y-postion is 9 bits
	.Max		(LCD_H - 1) // Max value for x-pos is 319, 0 -> 319 = 320
) yCount(
	.clk		(clock),
	.rst		(rstApp),
	.enable	(yCntEn),
	.cntOut	(yPos)
);

// Following code is the code which makes the pixel write
// Runs on +ve egede of clock or +ve edge of application reset
always @ (posedge clock or posedge rstApp) 
begin
	if (rstApp)	// If application reset is high
	begin 
		pixWrite <= 1'b0;	// Don't write pixel
	end else 
		 begin
		pixWrite <= 1'b1; // Else write a pixel
		 end
end
<<<<<<< Updated upstream
always @ (posedge clock or posedge rstApp)
begin
xPos <= xPos + 1;
end
=======
/*always @ (posedge clock or posedge rstApp)
begin
xPos <= xPos + 1;
end*/
>>>>>>> Stashed changes
// Following code is to get some pixels on screen
// Runs on +ve egede of clock or +ve edge of application reset
always @ (posedge clock or posedge rstApp)
begin
	if (rstApp)
	begin
		pixData	<= 16'b0; // Set data to 0
	end else if (pixReady)
				 begin
				 //xPos <= xPos + 1; 
<<<<<<< Updated upstream
					if (xPos == 5)
					begin
						pixData[15:11] <= 5'b1;
						pixData[10:5] <= 6'b0; 
						pixData[4:0]	<= 5'b0;	
						pixData <= xPos[7:5];	
					end else 
					begin 
					//xPos <= xPos + 1; 
=======
					if (xPos > 0)
					begin
						/*pixData[15:11] <= 5'b1;
						pixData[10:5] <= 6'b0; 
						pixData[4:0]	<= 5'b0;	
						pixData <= xPos[7:5];*/	
						pixData[10:5] <= xPos[2:0];
					end else 
					begin 
					xPos <= xPos + 1; 
>>>>>>> Stashed changes
						pixData[15:11] <= xPos[7:3];
					end
					 // Set Red from pixData = to the xPos
					// pixData[10:5] <= xPos[7:6]; // xPos = 1111000 = 120
					 // Set blue from pixData = to the yPos 
					// pixData[15:11] <= 5'b0;
					// pixData[10:5] <= 6'b1; 
					// pixData[4:0]	<= 5'b0;
					// pixData[15:0] <= 15'b0000011111100000;
					 //pixData <= xPos[7:0];
					 // pixData[4:0] <= yPos[8:0];
				 end
end 

endmodule 