module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    /*
    	X: don't care
        c_s: current_state (state)
        n_s: next_state
        r: reset
        x: input
        z: output
        
        +-----------------------+
        | r | x | c_s | n_s | z |
        |-----------------------|
        | 1 | X |  X  |  A  | 0 |
        | 0 | 1 |  A  |  B  | 1 |
        | 0 | 0 |  A  |  A  | 0 |
        | 0 | 1 |  B  |  B  | 0 |
        | 0 | 0 |  B  |  B  | 1 |
        +-----------------------+
    */
    
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;
    
    //asynchronous reset and state_logic
    always@(posedge clk or posedge areset)
        begin
            if(areset)
                state <= A;
            else
                state <= next_state;
        end
    
    //next_state logic
    always@(state, x)
        begin
            case(state)
                A: next_state = x ? B : A;
                B: next_state = B;
                default: next_state = A;
            endcase
        end
    
    //procedure of one-hot encoding output
    //assign z = ((state == A) && x) ? 1'b1 : ((state == A) && ~x) ? 1'b0 : ((state == B) && x) ? 1'b0 : ((state == B) && ~x) ? 1'b1 : 1'b0;
    // from table we can see when state=A output is x and when state is B ouput is ~x
    // so we can minimize the expression which will reduce the power of an circuit
    assign z = (state == A) ? x : (state == B) ? ~x : 1'b0;
    
endmodule