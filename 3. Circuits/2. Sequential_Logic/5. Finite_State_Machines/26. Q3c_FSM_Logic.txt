module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;
    
    assign z = (y == D) || (y == E);
    assign Y0 = (x && ((y == A) || (y == C))) || (~x && ((y == B) || (y == D) || (y == E)));

endmodule