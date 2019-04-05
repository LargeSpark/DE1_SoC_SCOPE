//TAKEN FROM ASSIGNMENT 1 AND IMPROVED UPON - REF ALEXANDER BOLTON - 200938078

/*--Module to divide the clock into requested clock speed--*/
module clockDivider # (
	parameter baseclock = 50000000;										//Base clock inputted into module (default 50MHz)
	parameter clockspeed = 128000;										//Set the output clockspeed of the clock divider (default 128kHz)
) (
input 			clock,														//Input clock
output reg  	clockdivided												//Output clock
);

	reg [9:0]counter = 0;													//counter register which initial is set to 0
	localparam integer counterspeed = baseclock/clockspeed; 
	localparam integer halfcounterspeed = counterspeed / 2;		//half counter speed for clock divided signal
	
	always @(posedge clock)													//always block at positive edge of clock to count
	begin
		if(counter == counterspeed) begin								//compare counter and counterspeed and if it has met counterspeed then set counter to 0
		counter <= 0;
		end
		else begin
		counter <= counter + 1;												//if not equal to counter speed then counter++
		end
	end
	
	
	always @(posedge clock) begin											//assign block if counter is smaller than halfcounterspeed then clockdivided is 0, else 1
		if(counter < halfcounterspeed) begin
			clockdivided <= 1;
		end else begin
			clockdivided <= 0;
		end
	end

endmodule
