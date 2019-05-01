module clockcounter(
input clock,
output [25:0] counterout
);

reg [25:0] counter = 0;

assign counterout = counter;

always @(posedge clock) begin
	counter <= counter + 1;
end

endmodule
