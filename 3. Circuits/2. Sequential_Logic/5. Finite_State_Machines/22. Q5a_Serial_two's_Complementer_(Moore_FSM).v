module top_module (
    input clk,
    input areset,
    input x,
    output z
); 

    parameter IDLE = 2'd0, FIRST_1 = 2'd1, COMP = 2'd2;
    reg [1:0] state, next_state;
    
    //asynchronous reset, state_logic and output_logic
    always@(posedge clk or posedge areset)
        begin
            if(areset)
                begin
                	state <= IDLE;
                    z <= 1'b0;
                end
            else
                begin
                	state <= next_state;
                    if(next_state == COMP)
                        z <= ~x;
                    else
                        z <= x;
                end
        end
    
    //next_state logic
    always@(state,x)
        begin
            case(state)
                IDLE: next_state = x ? FIRST_1 : IDLE;
                FIRST_1: next_state = COMP;
                COMP: next_state = COMP;
                default: next_state = IDLE;
            endcase
        end
    
endmodule