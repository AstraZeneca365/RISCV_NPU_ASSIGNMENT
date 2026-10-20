module optimized_multiplier(
	input clk,reset,start,
	input [3:0] m,
	input [3:0] q,
	output reg [7:0] product
);
	
	reg [3:0] M;       // stores the multiplicand
   reg [3:0] Q;       // stores the multiplier
   reg [3:0] A;       // accumulator register
   reg C;             // carry bit
   reg [2:0] count;   // counts the 4 multiplication cycles
   reg [4:0] sum;     // stores the addition result (5 bits)
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// initialise all registers during reset
			A <= 4'b0000;
			C <= 0;
			Q <= 4'b0000;
			M <= 4'b0000;
			count <= 2'b00;
			product <= 8'b00000000;
		end
		else if(start) begin
			// if start is high, then load inputs and initialise registers
			A <= 4'b0000;
			C <= 0;
			Q <= q;
			M <= m;
			count <= 3'b000;
			product <= 8'b00000000;
		end
		else begin	
			if (count < 4) begin //performs 4 (add & shift) operations so 4 clock cycles
				
				sum = {C,A}; // if Q[0] = 0 then retain current C and A register
				
				if(Q[0]) begin //if Q[0] = 1 then add M(multiplicand) to A(accumulator)
					sum = {1'b0,A} + {1'b0,M}; //here sum is 5 bits, so an extra 0 is put in front of A and M
				end
			{C,A,Q} <= {sum,Q}>>1; //shift right operation
			
			count <= count + 1; //cycle increases by 1
			end 
			
			else begin
				product <= {A,Q}; // store A and Q in product register (8 bits) which the final result
			end
			
		end
		
	end
		

endmodule