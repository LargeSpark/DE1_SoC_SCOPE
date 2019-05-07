module sevenseg(
input clock, //50MHz Clock
input [3:0] seg_En, //7 Seg Enables
input [13:0] number, //Number of 4 digits
output [6:0] seg0, //Seven Segment Display 0 output
output [6:0] seg1, //Seven Segment Display 1 output
output [6:0] seg2, //Seven Segment Display 2 output
output [6:0] seg3 //Seven Segment Display 3 output
);
//Wires
wire done;
wire [3:0] ones; //Wires value in ones
wire [3:0] tens; //Wires value in tens
wire [3:0] hundreds; //Wires value in hundreds
wire [3:0] thousands; //Wire value in thousands
//Registers
reg start = 0; //if numbersplit starts
reg started = 0; //if numbersplit is currently ongoing
reg [13:0] prevNumber = 0; //previous number
reg numberCountto = 0; //number
reg [3:0] onescomplete; //ones register
reg [3:0] tenscomplete; //tens register
reg [3:0] hundredscomplete; //hundreds register
reg [3:0] thousandscomplete; //thousands register

//Number split module instantiation
numbersplit NS(
.clock (clock),
.mynumber (number),
.start (start),
.doneOut(done),
.onesOut (ones),
.tensOut (tens),
.hundredsOut (hundreds),
.thousandsOut (thousands)
);
//Seven Seg Display outputs
generateSevenSegOutput segoutput0(
.clock (clock),
.number (onescomplete),
.segOutput (seg0)
);

generateSevenSegOutput segoutput1(
.clock (clock),
.number (tenscomplete),
.segOutput (seg1)
);

generateSevenSegOutput segoutput2(
.clock (clock),
.number (hundredscomplete),
.segOutput (seg2)
);

generateSevenSegOutput segoutput3(
.clock (clock),
.number (thousandscomplete),
.segOutput (seg3)
);
//This always block keeps the number in the numbersplit module changing mid count.
always @(posedge clock) begin
	if(prevNumber != number && !start && !started) begin
		start <= 1;
		started <= 1;
	end else if(start) begin
		start <= 0;
	end else if(done) begin
		started <= 0;
		onescomplete <= ones;
		tenscomplete <= tens;
		hundredscomplete <= hundreds;
		thousandscomplete <= thousands;
		prevNumber <= number;
	end
end

endmodule


//Based on idea from https://stackoverflow.com/questions/22882882/split-up-a-four-digit-number-in-verilog
//This module splits numbers into ones, tens, hundreds, thousands by counting. This is less expensive than division.
module numbersplit(
	input clock, //50MHz Clock
	input [13:0] mynumber, //number to count to
	input        start, //start out
	output       doneOut, //complete out
	output [3:0] onesOut, //ones out
	output [3:0] tensOut, //tens out
	output [3:0] hundredsOut, //hundreds out
	output [3:0] thousandsOut //thousands out
);
	//registers
	reg   [13:0] counter = 0;
	reg   [3:0]  ones = 0;
	reg   [3:0]  tens = 0;
	reg   [3:0]  hundreds = 0;
	reg   [3:0]  thousands = 0;
	reg done = 0;
	//assigns
	assign doneOut = done;
	assign onesOut = ones;
	assign tensOut = tens;
	assign hundredsOut = hundreds;
	assign thousandsOut = thousands;
	
	always @(posedge clock) begin
		//if start then set all values to 0
		 if(start) begin
			  counter <= 0;
			  done <= 0;
			  ones <= 0;
			  tens <= 0;
			  hundreds <= 0;
			  thousands<= 0;
		//else then check if the counter is equal to number if so then set register done to signal completed
		 end else if(counter == mynumber) begin
			  done <= 1;
		//if not complete then count up to the number but keep a track of single digits
		 end else if (!done) begin
			  counter <= counter + 1;
			  ones <= ones == 9 ? 0 : ones + 1;
			  if(ones == 9) begin
					tens <= tens == 9 ? 0 : tens + 1;
					if(tens == 9) begin
						 hundreds <= hundreds == 9 ? 0 : hundreds + 1;
						 if(hundreds == 9) begin
								thousands <= thousands + 1; 
						 end
					end
			  end
		 end
	end
endmodule

module generateSevenSegOutput(
input clock,
input [3:0] number,
output [6:0] segOutput
);

reg [6:0] seg;

assign segOutput = seg;

always @(posedge clock) begin
	if(number == 0) begin
		seg <= ~(7'h3F);
	end else if(number == 1) begin
		seg <= ~(7'h06);
	end else if(number == 2) begin
		seg <= ~(7'h5B);
	end else if(number == 3) begin
		seg <= ~(7'h4F);
	end else if(number == 4) begin
		seg <= ~(7'h66);
	end else if(number == 5) begin
		seg <= ~(7'h6D);
	end else if(number == 6) begin
		seg <= ~(7'h7D);
	end else if(number == 7) begin
		seg <= ~(7'h07);
	end else if(number == 8) begin
		seg <= ~(7'h7F);
	end else if(number == 9) begin
		seg <= ~(7'h67);
	end
end

endmodule
