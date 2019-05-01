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
output 	[10:0]	offset2Out
);
localparam defaultY1 = 25;
localparam defaultY2 = 100;
localparam defaultX1 = 32;
localparam defaultX2 = 90;
//Parameters for Cursors
localparam moveSize = 1;	
reg [10:0] cursorY1 = defaultY1; 	//TESTCODE
reg [10:0] cursorY2 = defaultY2;	//TESTCODE
reg [10:0] cursorX1 = defaultX1;  //TESTCODE
reg [10:0] cursorX2 = defaultX2; //TESTCODE
reg [10:0] offset1 = 30;
reg [10:0] offset2 = 200;
reg [5:0] sampleAdjust1 = 0;
reg [5:0] sampleAdjust2 = 0;
reg hold1 = 0;
reg hold2 = 0;
reg buttPush = 0;
reg buttPush1 = 0;
reg hol;
reg [3:0] shiftDown1 = 0;
reg [3:0] shiftDown2 = 3;
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

always @ (posedge buttonClock)
begin
	//State 1
	if (!switch9 && !switch8)
	begin	
	//Switch on Cursors
	cursorX_EN <= switch0;
	cursorY_EN <= switch1;
		//Code for yCursors 
		if (switch3 && !butt3)
		begin 
				cursorY1 <= cursorY1 + moveSize;
		end 
		else if (switch3 && !butt2)
		begin 
				cursorY1 <= cursorY1 - moveSize;
		end 
		else if (switch3 && !butt1)
		begin 
				cursorY2 <= cursorY2 + moveSize;
		end 
		else if (switch3 && !butt0)
		begin 
				cursorY2 <= cursorY2 - moveSize;
		end 
		//Codr for xCursors
		if (switch2 && !butt3)
		begin 
				cursorX1 <= cursorX1 + moveSize;
		end 
		else if (switch2 && !butt2)
		begin 
				cursorX1 <= cursorX1 - moveSize;
		end 
		else if (switch2 && !butt1)
		begin 
				cursorX2 <= cursorX2 + moveSize;
		end 
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
//Code for Waves 
always @ (posedge buttonClock)
begin
	//State 2
	if (!switch9 && switch8)
	begin 
	//Code to see Waves 	
	Wave1_EN <= switch0;
	Wave2_EN <= switch1;
		//Move Wave 1 up and down 
		if (switch2 && !butt3 && !switch5)
		begin
				offset1 <= offset1 + moveSize;		
		end	
		else if (switch2 && !butt2 && !switch5)
		begin
				offset1 <= offset1 - moveSize;		
		end	
		//Move Wave 2 up and down 
		else if (switch2 && !butt1 && !switch5)
		begin
				offset2 <= offset2 + moveSize;		
		end	
		else if (switch2 && !butt0 && !switch5)
		begin
				offset2 <= offset2 - moveSize;		
		end				
	end
end

//Code for Squish
always @ (posedge buttonClock)
begin
	if (!switch9 && switch8)
	begin
		if (switch3 && !butt3 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown1 = shiftDown1 + 1;			
		end
		else if (switch3 && !butt2 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown1 = shiftDown1 - 1;			
		end
		else if (switch3 && !butt1 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown2 = shiftDown2 + 1;			
		end
		else if (switch3 && !butt0 && !buttPush)
		begin
			buttPush <= 1;
			shiftDown2 = shiftDown2 - 1;			
		end
		else if ((butt0 && butt1 && butt2 && butt3) && buttPush) begin
			buttPush <= 0;
		end
	end
end  
// Code for hold
always @ (posedge buttonClock)
begin
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
// Code for sample adjust
always @ (posedge buttonClock)
begin
	if (!switch9 && switch8)
	begin 
		if (switch5 && !butt3 && !buttPush1)
		begin
			buttPush1 <= 1; 
			sampleAdjust1 <= sampleAdjust1 + 1;
		end 
		else if (switch5 &&  !butt2 && !buttPush1)
		begin
		   buttPush1 <= 1;
			sampleAdjust1 <= sampleAdjust1 - 1;
		end
		else if (switch5 &&  !butt1	&& !buttPush1)
		begin
			buttPush1 <= 1;
			sampleAdjust2 <= sampleAdjust2 + 1;
		end 
		else if (switch5 &&  !butt0 && !buttPush1)
		begin
			buttPush1 <= 1;
			sampleAdjust2 <= sampleAdjust2 - 1;
		end
		else if ((butt0 && butt1 && butt2 && butt3) && buttPush1) begin
			buttPush1 <= 0;
		end
	end
end
endmodule
