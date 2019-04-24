module sevenseg(
input clock,
input [3:0] seg_En,
input [13:0] number,
input [5:0] decimalPoint_EN,
output [6:0] seg0,
output [6:0] seg1,
output [6:0] seg2,
output [6:0] seg3
);
//Split Numbers
reg start = 0;
wire done;
wire [3:0] ones;
wire [3:0] tens;
wire [3:0] hundreds;
wire [3:0] thousands;

reg [13:0] prevNumber = 0;

reg [3:0] onescomplete;
reg [3:0] tenscomplete;
reg [3:0] hundredscomplete;
reg [3:0] thousandscomplete;

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

always @(posedge clock) begin
	if(prevNumber != number) begin
		start <= 1;
	end else if(start) begin
		start <= 0;
	end else if(done) begin
		onescomplete <= ones;
		tenscomplete <= tens;
		hundredscomplete <= hundreds;
		thousandscomplete <= thousands;
	end
end

endmodule


//https://stackoverflow.com/questions/22882882/split-up-a-four-digit-number-in-verilog
module numbersplit(
	input clock,
	input [13:0] mynumber,
	input        start,
	output       doneOut,
	output [3:0] onesOut,
	output [3:0] tensOut,
	output [3:0] hundredsOut,
	output [3:0] thousandsOut
);
	reg   [13:0] counter;
	reg   [3:0]  ones;
	reg   [3:0]  tens;
	reg   [3:0]  hundreds;
	reg   [3:0]  thousands;
	reg done;
	assign doneOut = done;
	assign onesOut = ones;
	assign tensOut = tens;
	assign hundredsOut = hundreds;
	assign thousandsOut = thousands;
	always @(posedge clock) begin
		 if(start) begin
			  counter <= 0;
			  done <= 0;
		 end else if(counter == mynumber) begin
			  done <= 1;
		 end else begin
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
		seg <= 7'h3F;
	end else if(number == 1) begin
		seg <= 7'h06;
	end else if(number == 2) begin
		seg <= 7'h5B;
	end else if(number == 3) begin
		seg <= 7'h4F;
	end else if(number == 4) begin
		seg <= 7'h66;
	end else if(number == 5) begin
		seg <= 7'h6D;
	end else if(number == 6) begin
		seg <= 7'h7D;
	end else if(number == 7) begin
		seg <= 7'h07;
	end else if(number == 8) begin
		seg <= 7'h7F;
	end else if(number == 9) begin
		seg <= 7'h67;
	end
end

endmodule
