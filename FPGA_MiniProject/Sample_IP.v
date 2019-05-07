//SampleandTrigger

module Sample(
	input readClock,	//Clock to read values to VGA
	input writeClock,	//Clock to write
	input [11:0] data,//Data in
	input [11:0] screenX, //Screen counter in
	input reset, //reset 
	input hold, //hold
	input [11:0] triggerthreshold, //trigger threshold in
	output [11:0] screenData, //Screendata out to VGA IP
	output resample //Resample LED
);

reg [11:0] sampleData[800:0]; //BRAM block of sampled data
reg [11:0] triggerHighPoint = 0; //Trigger threshold highpoint
reg [11:0] samplecounter = 0; //sample counter
reg [11:0] triggercounter = 0; //trigger counter
reg [11:0] outputcounter = 0; //output counter
reg [11:0] outputData = 0; //output data
reg resamplereg = 0; //for LED
assign resample = resamplereg; //for LED
assign screenData = outputData; //screen data out to VGA IP
//Read data to VGA IP out of BRAM
always @(posedge readClock) begin
	outputData <= sampleData[screenX];
end

//Trigger Sample Data
always @(posedge writeClock) begin
//find highest point after 
	if(data >= 0 && data <= triggerthreshold && samplecounter > 800) begin
		samplecounter <= 0;
		triggercounter <= 0;
		resamplereg = ~resamplereg;
	//If hold then do nothing
	end else if(samplecounter < 800 && hold) begin
	
	//if samplecounter is below 480 then sample
	end else if(samplecounter < 800) begin
		sampleData[samplecounter] <= data;
		samplecounter <= samplecounter + 1;
		triggercounter <= triggercounter+1;
	//if trigger counter is over 2000 then set to 0
	end else if (triggercounter > 2000) begin
		triggercounter <= 0;
	//else count up
	end else begin
		samplecounter <= samplecounter + 1;
		triggercounter <= triggercounter+1;
	end
end

endmodule
