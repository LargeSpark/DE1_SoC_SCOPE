/* Nbit Counter module
 * For DE1-SoC Scope 
 */
 
// Lab 5 up counter used as basis
module NbitCounter #(
    parameter N     = 10,       // N bits wide
    parameter Up	  = 1,        // Increase counter by 1
    parameter Max   = (2**N)-1  // Max value default is 2^N - 1
)(   
    input                    clk,
    input                    rst,
    input                    enable, // Increase by Up when enable is high
    output reg [(N-1):0]     cntOut  // Output is declared as "N" bits wide
);

always @ (posedge clk) 
begin
    if (rst) 
	 begin
        //When rst is high, set output back to 0
        cntOut <= {(N){1'b0}};
    end
	 // Else if enable is high run the following:	
	 else if (enable) 
	 begin
		  // If counter output exceeds max val allowed	
        if (cntOut >= Max[N-1:0])
		  begin
		      //Reset back to 0
            cntOut <= {(N){1'b0}};   
        end 
		  // Else increase by up
		  else 
		  begin
            cntOut <= cntOut + Up[N-1:0];
        end
    end
end

endmodule


