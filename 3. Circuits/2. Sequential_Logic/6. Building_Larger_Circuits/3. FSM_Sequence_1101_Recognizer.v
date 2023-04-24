module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
);
	
    parameter A=3'd0, B=3'd1, C=3'd2, D=3'd3, E=3'd4;
    reg [2:0] state, next_state;
    
    //Synchronous Reset
    always@(posedge clk)
        begin
            if(reset)
                begin
                    state <= A;
                end
            else
                state <= next_state;
        end
    
    //next_state logic
    always@(*)
        begin
            case(state)
                A: next_state = data ? B:A;
                B: next_state = data ? C:A;
                C: next_state = data ? C:D;
                D: next_state = data ? E:A;
                E: next_state = reset ? A:E;
                default: next_state = A;
            endcase
        end
    
    //output logic
    always@(state)
        begin
            case(state)
                A: start_shifting <= 1'b0;
                B: start_shifting <= 1'b0;
                C: start_shifting <= 1'b0;
                D: start_shifting <= 1'b0;
                E: start_shifting <= 1'b1;
                default: start_shifting <= 1'b0;
            endcase
        end
                
endmodule