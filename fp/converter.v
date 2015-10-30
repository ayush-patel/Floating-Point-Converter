`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer 1: Jonathan Hurwitz 804258351 
// Engineer 2: Ram Sivasundaram 704261325
// 
// Create Date:    12:33:24 10/19/2015 
// Design Name: 
// Module Name:    converter 
//////////////////////////////////////////////////////////////////////////////////
module FPCVT (
	  //inputs
     input [11:0] D,
	  //outputs
     output reg S, 
	  output reg[3:0] F,
	  output reg[2:0] E );
	 
	 reg [11:0] sign_mag;

	 integer num_leading = 0;
	 integer i = 11;

	 integer pos_five, shift_amt, bit_five;
	 
	 /*Convert 2's comp to sign magnitude
	 sign = 0 -> nothing changes
	 sign = 1 -> flip bits and add 1
	 */
	 always@(D[11:0]) //when one thing changes, everything runs and changes
	 begin
	 if(D[10:0] == 0 && D[11] == 1)
		 begin
			S = 1;
			E[2:0] = 3'b111;
			F[3:0] = 4'b1111;
		 end
	 else if(D[11:0] == 0)
		 begin
			S = 0;
			E[2:0] = 0;
			F[3:0] = 0;
		 end
	 else
		 begin
			 if(D[11])
				 begin
					//$display("Flipping bits. \n");
					//$display("D: %11b", D);
					 sign_mag[11:0]= ~D[11:0]+1;
					 
					//$display("sign mag: %11b", sign_mag[12:0]);
				 end
			 else
			 begin
				sign_mag = D;
			 end
			 
			 /*
			 Count number of leading zeroes
			 */
				 num_leading = 0;
				 i = 11;
				 if(sign_mag[11] == 0)
					 begin
						while((sign_mag[i] != 1) && (i >= 0))
							begin	
								num_leading = num_leading+1;
								i=i-1;
							end
					 end
					 
				 case(num_leading)
					0: $display("Zero leading bits. \n");
					1: E = 3'b111; 
					2: E = 3'b110; 
					3: E = 3'b101; 
					4: E = 3'b100; 
					5: E = 3'b011; 
					6: E = 3'b010; 
					7: E = 3'b001; 
					default: E = 3'b000;
				 endcase
			 //$display("Leading: %d \n", num_leading);
			 //$display("E: %03b \n", E);
			 //$display("SM: %12b", sign_mag);		 
			
			/*
			Figure out m = mantissa/significand.
			
			Store the 5th bit from the left leading 0.
			Figure out where the 5th bit is and then store this value.
			*/
			pos_five = (12 - num_leading)-5;
			shift_amt = 12 - (num_leading+4);
			S = D[11];

				
			//Obtain 5th bit
			bit_five = sign_mag[pos_five];
			
			//Shift sign_mag to the right by amount = shift_amt
				case(num_leading)
					0: F[3:0] = sign_mag[11:8];
					1: F[3:0] = sign_mag[10:7]; 
					2: F[3:0] = sign_mag[9:6];
					3: F[3:0] = sign_mag[8:5];
					4: F[3:0] = sign_mag[7:4];
					5: F[3:0] = sign_mag[6:3];
					6: F[3:0] = sign_mag[5:2];
					7: F[3:0] = sign_mag[4:1];
					default: F[3:0] = sign_mag[3:0];
				 endcase	
				
				
				if(bit_five)
				begin
					//Check to see if there will be overflow
					if(F[3:0] == 4'b1111)
						begin
							//shift sig right 1 bit
							//add 1 to exponent
							if(E[2:0] == 3'b111)
								begin
									//do nothing
								end
							else
								begin
					
								F[3:0] = {1'b0, F[2:0]};
								F=F+1;
								//m[3:0] = 4'b1000;
								E = E+1;
								end
						end
					else
						begin
							//add 1 to mantissa
							F = F+1;
						end
				end
				//$display("M: %03b \n", m);
				//$display("D: %11b \n", D);
				//$display("S: %01b \n", sign);
				 
			end
		 end
endmodule
