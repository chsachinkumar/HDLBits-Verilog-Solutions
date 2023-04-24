module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
    
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;
    reg [2:0] state, next_state;
    
    //synchronous reset and state_logic
    always@(posedge clk)
        begin
            if(reset)
                state <= A;
            else
                state <= next_state;
        end
    
    //next_state logic
    always@(state,w)
        begin
            case(state)
                A: next_state = w ? B : A;
               	B: next_state = w ? C : D;
                C: next_state = w ? E : D;
                D: next_state = w ? F : A;
                E: next_state = w ? E : D;
                F: next_state = w ? C : D;
                default: next_state = A;
            endcase
        end
    
    //output_logic
    always@(state)
        begin
            case(state)
                A: z = 1'b0;
               	B: z = 1'b0;
                C: z = 1'b0;
                D: z = 1'b0;
                E: z = 1'b1;
                F: z = 1'b1;
                default: z = 1'b0;
            endcase
        end

endmodule