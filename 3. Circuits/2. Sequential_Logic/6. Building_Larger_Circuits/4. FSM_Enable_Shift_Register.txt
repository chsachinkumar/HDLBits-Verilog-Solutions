module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);
    
    reg [2:0] q = 3'd0;
    always@(posedge clk)
        begin
            if(reset)
                begin
                   shift_ena <= 1'b1;
                   q <= 3'd0;
                end
            else
                begin
                    if(q == 3'd3)
                        begin
                            shift_ena <= 1'b0;
                        end
                    else if(q < 3'd4)
                        begin
                            shift_ena <= 1'b1;
                            q <= q + 3'd1;
                        end
                end
        end
    
endmodule