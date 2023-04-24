module top_module (
    input [3:1] y,
    input w,
    output Y2);
    
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;
    
    assign Y2 = (w && ((y == B) || (y == C) || (y == E) || (y == F))) || (~w && ((y == B) || (y == F)));

endmodule