/* Controls for FPGA_MiniProject
This module contros which waves/cursor display on screen
the position of the waves/cursors. the volts/div aswell as the time/div 
N-Channel Oscilloscope */

//All the inputs & outputs
module controls(
input					switch0, //Cursor X En
input					switch1,	//Cursor Y En
input					switch2, //Signal 1 En
input					switch3,	//Signal 2 En
input 				switch4, //Cursor Y set
input					switch5, //Cursor X Set 
input 				switch6, //Wave 1 Shift /Squish
input 				switch7, //Wave 2 Shift/Squish
input 				switch8, //Wave 1 Clock 
input 				switch9, //Wave 2 Clock 
//IMPORTANT - BUTTONS ARE ACTIVE LOW
input					butt0,	//x1/y1 left/up
input					butt1,  	//x1/y1 right/down
input					butt2,	//x2/y2 left/up
input					butt3,	//x2/y2 right/down
input       		buttonClock, //Clock for button refresh
output				hold1Out,
output				hold2Out,
output	[10:0]	cursorY1Out,
output	[10:0]	cursorY2Out,
output	[10:0]	cursorX1Out,
output	[10:0]	cursorX2Out,
output 	[3:0]		shiftDown1Out,
output 	[3:0]		shiftDown2Out,
output	[5:0]		sampleAdjust1Out,
output	[5:0]		sampleAdjust2Out,
output 				cursorX_ENOut,
output 				cursorY_ENOut,
output 				Wave1_ENOut,
output				Wave2_ENOut,
output 	[10:0]	offset1Out,
output 	[10:0]	offset2Out,
output   			TWave_EnOut
);
//Default posiions of the cursors
localparam defaultY1 = 60; // 60 pixels = ~500mV
localparam defaultY2 = 120;
localparam defaultX1 = 32;
localparam defaultX2 = 90;
//Parameter for Cursor move Cursor by 1 every clock cycle
localparam moveSize = 1;	
//Set each cursor to the default position 
reg [10:0] cursorY1 = defaultY1; 	
reg [10:0] cursorY2 = defaultY2;	
reg [10:0] cursorX1 = defaultX1;  
reg [10:0] cursorX2 = defaultX2; 
//Offset sets the intial postion of the waves on the screen
reg [10:0] offset1 = 30;
reg [10:0] offset2 = 200;
//Initially showing the defualt samples on the screen
reg [5:0] sampleAdjust1 = 0;
reg [5:0] sampleAdjust2 = 0;
//The hold and buttpush reg's are to make sure the buttons work on push and not hold
//Useful for control the size of the time or volts/div
reg hold1 = 0;
reg hold2 = 0;
reg buttPush = 0;
reg buttPush1 = 0;
//Following is to get the test wave up and running, instead of wave 1
reg TWave_En = 0;
assign TWave_EnOut = TWave_En;
//Intial value of shiftdown, allows user to see decent size wave
reg [3:0] shiftDown1 = 3;
reg [3:0] shiftDown2 = 3;
//Enable cursors and Waves to 0
reg cursorX_EN = 0;
reg cursorY_EN = 0;
reg Wave1_EN = 0;
reg Wave2_EN = 0;
//assignments
assign hold1Out = hold1;
assign hold2Out = hold2;
assign cursorY1Out = cursorY1;
assign cursorY2Out = cursorY2;
assign cursorX1Out = cursorX1;
assign cursorX2Out = cursorX2;
assign shiftDown1Out = shiftDown1;
assign shiftDown2Out = shiftDown2;
assign sampleAdjust1Out = sampleAdjust1;
assign sampleAdjust2Out = sampleAdjust2;
assign cursorX_ENOut = cursorX_EN;
assign cursorY_ENOut = cursorY_EN;
assign Wave1_ENOut = Wave1_EN;
assign Wave2_ENOut = Wave2_EN;
assign offset1Out = offset1;
assign offset2Out = offset2;
//Following code is for state 1, when switch 8 & 9 are 0
//Contros whether the cursors are on the screen, and the position of them 
//buttonClock is atached to the slower clock, so every 93Hz 
always @ (posedge buttonClock)
begin
	//State 1
	if (!switch9 && !switch8)
	begin	
	//Switch on Cursors when switches 0 & 1 are on
	cursorX_EN <= switch0;
	cursorY_EN <= switch1;
		//Code for yCursors when switch 3 is 1, and key 3 is being pushed move cursor y1 down
		if (switch3 && !butt3)
		begin 
				cursorY1 <= cursorY1 + moveSize;
		end 
		//Code for yCursors, when switch 3 is 1, and key 2 is being pushed move cursor y1 up 
		else if (switch3 && !butt2)
		begin 
				cursorY1 <= cursorY1 - moveSize;
		end 
		//Code for yCursors, when switch 3 is 1, and key 1 is being pushed move cursor y2 down
		else if (switch3 && !butt1)
		begin 
				cursorY2 <= cursorY2 + moveSize;
		end 
		//Code for yCursors, when switch 3 is 1, and key 0 is being pushed move cursor y2 up
		else if (switch3 && !butt0)
		begin 
				cursorY2 <= cursorY2 - moveSize;
		end 
		//Code for xCursors
		//When switch 2 is 1, and key 3 is being pushed move cursor x1 right
		if (switch2 && !butt3)
		begin 
				cursorX1 <= cursorX1 + moveSize;
		end 
		//When switch 2 is 1, and key 2 is being pushed move cursor x1 left
		else if (switch2 && !butt2)
		begin 
				cursorX1 <= cursorX1 - moveSize;
		end 
		//When switch 2 is 1, and key 1 is being pushed move cursor x2 right
		else if (switch2 && !butt1)
		begin 
				cursorX2 <= cursorX2 + moveSize;
		end 
  	   //When switch 2 is 1, and key 0 is being pushed move cursor x2 left
		else if (switch2 && !butt0)
		begin 
				cursorX2 <= cursorX2 - moveSize;
		end
		//Code to move both Y Cursors @ same time
		if (switch3 && switch2 && !butt3)
		begin
				cursorY1 <= cursorY1 + moveSize;
				cursorY2 <= cursorY2 + moveSize;
				cursorX1 <= defaultX1;
		end
		if (switch3 && switch2 && !butt2)
		begin
				cursorY1 <= cursorY1 - moveSize;
				cursorY2 <= cursorY2 - moveSize;
				cursorX1 <= defaultX1;
		end
		//Code to move both X Cursors @ same time
		if (switch3 && switch2 && !butt1)
		begin
				cursorX1 <= cursorX1 + moveSize;
				cursorX2 <= cursorX2 + moveSize;
				cursorY2 <= defaultY2;
		end
		if (switch3 && switch2	&& !butt0)
		begin
				cursorX1 <= cursorX1 - moveSize;
				cursorX2 <= cursorX2 - moveSize;
				cursorY2 <= defaultY2;
		end
	end
end 
//Following code is for state 2, when switch 8 is 1 & switch 9 is 0
//Contros whether the waves are on the screen, and the position of them 
always @ (posedge buttonClock)
begin
	//State 2
	if (!switch9 && switch8)
	begin 
	//Switch on waves when switches 0 & 1 are on
	Wave1_EN <= switch0;
	Wave2_EN <= switch1;
      //Code to move wave 1 down the screen, when switch 2 is 1, switch 5 is 0, and key 3 is being pushed
    	if (switch2 && !butt3 && !switch5)
		begin
				offset1 <= offset1 + moveSize;		
		end	
		//Code to move wave 1 up the screen, when switch 2 is 1, switch 5 is 0, and key 2 is being pushed
		else if (switch2 && !butt2 && !switch5)
		begin
				offset1 <= offset1 - moveSize;		
		end	
      //Code to move wave 2 down the screen, when switch 2 is 1, switch 5 is 0, and key 1 is being pushed
		else if (switch2 && !butt1 && !switch5)
		begin
				offset2 <= offset2 + moveSize;		
		end	
		//Code to move wave 2 up the screen, when switch 2 is 1, switch 5 is 0, and key 0 is being pushed
		else if (switch2 && !butt0 && !switch5)
		begin
				offset2 <= offset2 - moveSize;		
		end				
	end
end
//Code for changing the volts/div
always @ (posedge buttonClock)
begin
	//Again on state 2 
	if (!switch9 && switch8)
	begin
	   //When switch 3 is 1, buttpush is 0, and key 3 is pressed 
		if (switch3 && !butt3 && !buttPush)
		begin
		   //Make buttpush 1, Increase volts/div for wave 1
			buttPush <= 1;
			shiftDown1 = shiftDown1 + 1;			
		end
	   //When switch 3 is 1, buttpush is 0, and key 2 is pressed 
		else if (switch3 && !butt2 && !buttPush)
		begin
		   //Make buttpush 1, Decrease volts/div for wave 1
			buttPush <= 1;
			shiftDown1 = shiftDown1 - 1;			
		end
	   //When switch 3 is 1, buttpush is 0, and key 1 is pressed 
		else if (switch3 && !butt1 && !buttPush)
		begin
		   //Make buttpush 1, Increase volts/div for wave 2
			buttPush <= 1;
			shiftDown2 = shiftDown2 + 1;			
		end
	   //When switch 3 is 1, buttpush is 0, and key 0 is pressed 
		else if (switch3 && !butt0 && !buttPush)
		begin
		   //Make buttpush 1, Decrease volts/div for wave 2
			buttPush <= 1;
			shiftDown2 = shiftDown2 - 1;			
		end
		//Immediately after button is pushed, reest buttpush so that button only works on press not push
		else if ((butt0 && butt1 && butt2 && butt3) && buttPush) begin
			buttPush <= 0;
		end
	end
end  
// Code for holding postion of waves on screen i.e. freezing the wave 
always @ (posedge buttonClock)
begin
	//Again on state 2
	if (!switch9 && switch8)
	begin 
		if (switch4 && !butt3 && !hold1)
		begin
			hold1 <= 1;
		end
		else if (switch4 && !butt2 && hold1)
		begin
			hold1 <= 0;
		end
		else if (switch4 && !butt1 && !hold2)
		begin
			hold2 <= 1;
		end
		else if (switch4 && !butt0 && hold2)
		begin
			hold2 <= 0;
		end	
	end
end
// Code for changing time/div
always @ (posedge buttonClock)
begin
	//Again on state 2 
	if (!switch9 && switch8)
	begin 
	   //When switch 5 is 1, buttpush is 0, and key 3 is pressed 
		if (switch5 && !butt3 && !buttPush1)
		begin
		   //Make buttpush 1, Increase time/div for wave 1
			buttPush1 <= 1; 
			sampleAdjust1 <= sampleAdjust1 + 1;
		end 
	   //When switch 5 is 1, buttpush is 0, and key 2 is pressed 
		else if (switch5 &&  !butt2 && !buttPush1)
		begin
		   //Make buttpush 1, Decrease time/div for wave 1
		   buttPush1 <= 1;
			sampleAdjust1 <= sampleAdjust1 - 1;
		end
	   //When switch 5 is 1, buttpush is 0, and key 1 is pressed 
		else if (switch5 &&  !butt1	&& !buttPush1)
		begin
		   //Make buttpush 1, Increase time/div for wave 2
			buttPush1 <= 1;
			sampleAdjust2 <= sampleAdjust2 + 1;
	   //When switch 5 is 1, buttpush is 0, and key 0 is pressed 
		end
		else if (switch5 &&  !butt0 && !buttPush1)
		begin
		   //Make buttpush 1, Decrease time/div for wave 2
			buttPush1 <= 1;
			sampleAdjust2 <= sampleAdjust2 - 1;
		end
		//Immediately after button is pushed, reest buttpush so that button only works on press not push
		else if ((butt0 && butt1 && butt2 && butt3) && buttPush1) begin
			buttPush1 <= 0;
		end
	end
end
// Code for testWave on screen
always @ (posedge buttonClock)
begin
	//State 3
	if (switch9 && switch8)
	begin 
		TWave_En <= switch0;
	end
end 
endmodule
