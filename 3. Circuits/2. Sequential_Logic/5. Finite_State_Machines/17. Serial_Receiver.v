module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter [3:0] IDLE  = 4'd0, START = 4'd1, BIT0  = 4'd2, BIT1  = 4'd3, BIT2  = 4'd4, BIT3  = 4'd5, BIT4 = 4'd6, BIT5  = 4'd7, BIT6  = 4'd8, BIT7  = 4'd9, STOP  = 4'd10, ERROR  = 4'd11;
    reg [3:0] state, next_state;
    
    //Synchronous Reset & state_logic
    always @(posedge clk)begin
        if(reset)begin
            state <= IDLE;
        end
        else begin
           state <= next_state; 
        end
    end
    
    //next_state logic
    always @(*)begin
       next_state = IDLE;
        case(state)
            IDLE: next_state = in ? IDLE : START;
            START: next_state = BIT0;
            BIT0: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;
            BIT7: next_state = in ? STOP : ERROR;
            STOP: next_state = in ? IDLE : START;
            ERROR: next_state = in ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end
    
    //output_logic
    assign done = (state == STOP);
    
endmodule