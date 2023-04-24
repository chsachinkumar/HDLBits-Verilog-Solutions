module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
	
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;
    reg [2:0] state, next_state;
    
    //Synchronous Reset and state_logic
    always@(posedge clk)
        begin
            if(reset)
                state <= A;
            else
                state <= next_state;
        end
    
    //next_state logic
    always@(state,x)
        begin
            case(state)
                A: next_state = x ? B : A;
                B: next_state = x ? E : B;
                C: next_state = x ? B : C;
                D: next_state = x ? C : B;
                E: next_state = x ? E : D;
                default: next_state = A;
            endcase
        end
    
    //output_logic
    assign z = (state==D) | (state==E) ? 1'b1 : 1'b0;
    
endmodule