`timescale 1ns/1ps

module optimized_multiplier_tb;

reg [3:0] m = 0;
reg [3:0] q = 0;
reg clk = 0;
reg start = 0;
reg reset = 0;
wire [7:0] product;


optimized_multiplier uut(.m(m), .q(q), .start(start), .clk(clk), .reset(reset), .product(product));

// clock of period 10 ns
always #5 clk = ~clk;

initial begin
    // reset multiplier 
    reset = 1;
    #10;
    reset = 0;
	 
	 // test 1 (11*7 = 77)
    m = 4'b1011;
	 q = 4'b0111;
    #10;
	 
	 start = 1;
	 #10;
	 start = 0;
	 #40;
	 
    // test 2 (6*9 = 54)
    m = 4'b0110;
    q = 4'b1001;
    #10;
		
	 start = 1;
	 #10;
	 start = 0;
	 #50;
    $finish;
end

endmodule