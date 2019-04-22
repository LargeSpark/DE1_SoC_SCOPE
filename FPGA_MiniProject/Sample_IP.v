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
reg [10:0] samplecounter = 0;
reg [10:0] outputcounter = 0;
reg [13:0] outputData = 0;
assign screenData = outputData;
//output data
always @(posedge clock) begin
	/*if(outputcounter < 480) begin
	outputData <= sampleData[outputcounter];
	outputcounter <= outputcounter + 1;
	end else begin
	outputcounter <= 0;
	end*/
	outputData <= sampleData[screenX];
end

//Trigger Set
always @(posedge clock) begin
	if(data > triggerHighPoint) begin
	triggerHighPoint <= data;
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
	end
end

//Trigger Reset

always @(posedge clock) begin
end

endmodule
