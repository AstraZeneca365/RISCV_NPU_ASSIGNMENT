`timescale 1ns/1ps

module rra_tb;

reg [3:0] req = 0;
reg clk = 0;
reg reset = 0;
wire [3:0] gnt;

rra uut(.req(req), .clk(clk), .reset(reset), .gnt(gnt));

// clock of period 10 ns
always #5 clk = ~clk;

initial begin
    // reset arbiter 
    reset = 1;
    #10;
    reset = 0;

    // test 1
    req[0] = 1;
    #10;

    // test 2
    req[0] = 0;
    req[1] = 1;
    #10;

    // test 3(check arbitration when multiple requests are there)
    req = 4'b1011;
    #10;

    reset = 1;
    #10;
    reset = 0;

    // test 4(to check round robin rotation)
    req = 4'b1111;
    #100;

    $finish;
end

endmodule