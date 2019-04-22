//SampleandTrigger

module Sample(
	input clock,
	input [13:0] data,
	input [10:0] screenX,
	input reset,
	output [13:0] screenData
);

reg [13:0] sampleData[800:0];
reg [13:0] triggerHighPoint = 0;
reg [13:0] samplecounter = 0;
reg [10:0] outputcounter = 0;
reg [13:0] outputData = 0;
reg randomreg1 = 0;
reg randomreg2 = 0;
assign screenData = outputData;
//output data
always @(posedge clock) begin
	outputData <= sampleData[screenX];
end

//Trigger Set
always @(posedge clock) begin
	//randomreg1 <= ~randomreg1;
	if(triggerHighPoint<data) begin
		triggerHighPoint <= data;
		//randomreg2 <= ~randomreg2;
	end
end

//Trigger Sample Data
always @(posedge clock) begin
//find highest point after 
	if(data == triggerHighPoint && samplecounter > 800) begin
	samplecounter <= 0;
	//if samplecounter is below 480 then sample
	end else if(samplecounter < 800) begin
	sampleData[samplecounter] <= data;
	samplecounter <= samplecounter + 1;
	end else begin
	samplecounter <= samplecounter + 1;
	end
end

//Trigger Reset

always @(posedge clock) begin
end

endmodule
