//SampleandTrigger

module Sample(
	input readClock,
	input writeClock,
	input [11:0] data,
	input [11:0] screenX,
	input reset,
	output [11:0] screenData,
	output resample
);

reg [11:0] sampleData[800:0];
reg [11:0] triggerHighPoint = 0;
reg [11:0] samplecounter = 0;
reg [11:0] triggercounter = 0;
reg [11:0] outputcounter = 0;
reg [11:0] outputData = 0;
reg randomreg1 = 0;
reg randomreg2 = 0;
reg resamplereg = 0;
assign resample = resamplereg;
assign screenData = outputData;
//output data
always @(posedge readClock) begin
	outputData <= sampleData[screenX];
end

//Trigger Set
always @(posedge writeClock) begin
	//randomreg1 <= ~randomreg1;
	if(triggerHighPoint<data) begin
		triggerHighPoint <= data;
		//randomreg2 <= ~randomreg2;
	end else if (triggercounter > 1999) begin
		triggerHighPoint <= 0;
	end
end

//Trigger Sample Data
always @(posedge writeClock) begin
//find highest point after 
	if(data == /*triggerHighPoint*/0 && samplecounter > 800) begin
	samplecounter <= 0;
	triggercounter <= 0;
	resamplereg = ~resamplereg;
	//if samplecounter is below 480 then sample
	end else if(samplecounter < 800) begin
	sampleData[samplecounter] <= data;
	samplecounter <= samplecounter + 1;
	triggercounter <= triggercounter+1;
	end else if (triggercounter > 2000) begin
	triggercounter <= 0;
	end else begin
	samplecounter <= samplecounter + 1;
	triggercounter <= triggercounter+1;
	end
end

endmodule
