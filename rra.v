module rra(
    input [3:0] req,
    input clk,
    input reset,
    output reg [3:0] gnt
);

    reg [1:0] priority; // stores which requester gets priority next

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            priority <= 2'b00; // start priority from r0(default state)
            gnt <= 4'b0000;
        end

        else begin
            gnt <= 4'b0000; // clear previous grant

            // priority starts from r0
            if(priority == 2'b00) begin
                if(req[0] == 1) begin
                    gnt[0] <= 1;
                    priority <= 2'b01;
                    end
                else if(req[1] == 1) begin
                    gnt[1] <= 1;
                    priority <= 2'b10;
                    end
                else if(req[2] == 1) begin
                    gnt[2] <= 1;
                    priority <= 2'b11;
                    end
                else if(req[3] == 1) begin
                    gnt[3] <= 1;
                    priority <= 2'b00;
                    end
            end

            // priority starts from r1
            else if(priority == 2'b01) begin
                if(req[1] == 1) begin
                    gnt[1] <= 1;
                    priority <= 2'b10;
                    end
                else if(req[2] == 1) begin
                    gnt[2] <= 1;
                    priority <= 2'b11;
                    end
                else if(req[3] == 1) begin
                    gnt[3] <= 1;
                    priority <= 2'b00;
                    end
                else if(req[0] == 1) begin
                    gnt[0] <= 1;
                    priority <= 2'b01;
                    end
            end

            // priority starts from r2
            else if(priority == 2'b10) begin
                if(req[2] == 1) begin
                    gnt[2] <= 1;
                    priority <= 2'b11;
                    end
                else if(req[3] == 1) begin
                    gnt[3] <= 1;
                    priority <= 2'b00;
                    end
                else if(req[0] == 1) begin
                    gnt[0] <= 1;
                    priority <= 2'b01;
                    end
                else if(req[1] == 1) begin
                    gnt[1] <= 1;
                    priority <= 2'b10;
                    end
            end

            // priority starts from r3
            else if(priority == 2'b11) begin
                if(req[3] == 1) begin
                    gnt[3] <= 1;
                    priority <= 2'b00;
                    end
                else if(req[0] == 1) begin
                    gnt[0] <= 1;
                    priority <= 2'b01;
                    end
                else if(req[1] == 1) begin
                    gnt[1] <= 1;
                    priority <= 2'b10;
                    end
                else if(req[2] == 1) begin
                    gnt[2] <= 1;
                    priority <= 2'b11;
                    end
            end
        end
    end
endmodule