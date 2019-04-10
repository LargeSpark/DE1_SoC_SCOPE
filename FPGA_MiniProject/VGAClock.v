module VGA_clock(
	input T50MHZClock,
	output reg T25MHZClock
	);
	
	reg [1:0] count = 0;
	
	always @(posedge T50MHZClock) begin
	count <= count + 1;
	T25MHZClock <= count[0];
	end
	
endmodule
