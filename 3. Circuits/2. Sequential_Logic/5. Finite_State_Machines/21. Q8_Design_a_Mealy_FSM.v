module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter IDLE = 2'd0, A = 2'd1, B = 2'd2;
    reg [1:0] state, next_state;

    //asynchronous active-low reset and state_logic
    always@(posedge clk or negedge aresetn)
        begin
            if(!aresetn)
                state <= IDLE;
            else
                state <= next_state;
        end
    
    //next_state logic
    always@(state,x)
        begin
            case(state)
                IDLE: next_state = x ? A : IDLE;
                A: next_state = x ? A :B;
                B: next_state = x ? A : IDLE;
                default next_state = IDLE;
            endcase
        end
    
    //output
    always@(state,x)
        begin
            case(state)
                IDLE: z = 1'b0;
                A: z = 1'b0;
                B: z = x;
                default z = 1'b0;
            endcase
        end
    
endmodule