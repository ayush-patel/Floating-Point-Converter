`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:48:04 10/25/2015
// Design Name:   converter
// Module Name:   C:/Users/Terminator/Documents/CS152A/fp/tb1.v
// Project Name:  fp
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: converter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb1;

	// Inputs
	reg [11:0] D;

	// Outputs
	wire S;
	wire [3:0]F;
	wire [2:0]E;

	// Instantiate the Unit Under Test (UUT)
	FPCVT uut (
		.D(D), 
		.S(S), 
		.F(F), 
		.E(E)
	);

	initial begin
		// Initialize Inputs
		//dec = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		D[11:0] = 12'b0000_0010_1100;
		#100;
		D[11:0] = 12'b0000_0010_1110;
		#100;
		D[11:0] = 12'b1010_1010_1010;
		#100;
		
		D[11:0] = 12'b0000_0111_1101;
		#100;
		
		D[11:0] = 12'b1110_0101_1010;
		#100;
		
		D[11:0] = 12'b1111_1111_1111;
		#100;
		
		D[11:0] = 12'b1000_0000_0000;
		#100;
		
		D[11:0] = 12'b0000_0000_0000;
		#100;
	end
      
endmodule

