module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    //Designing of HDLC (High-Level Data Link Control)    
    parameter IDLE = 4'd0, BIT1_1  = 4'd1, BIT2_1  = 4'd2, BIT3_1 = 4'd3, BIT4_1 = 4'd4, BIT5_1 = 4'd5, BIT6_1  = 4'd6, ERR  = 4'd7, DISC = 4'd8, FLAG = 4'd9;
    reg [3:0] state, next_state;
    
    always @(posedge clk)begin
        if(reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    always @(*)begin
       next_state = IDLE;
        case(state)
            IDLE: next_state = in ? BIT1_1 : IDLE;
            BIT1_1:  next_state = in ? BIT2_1 : IDLE;
            BIT2_1:  next_state = in ? BIT3_1 : IDLE;
            BIT3_1: next_state = in ? BIT4_1 : IDLE;
            BIT4_1: next_state = in ? BIT5_1 : IDLE;
            BIT5_1: next_state = in ? BIT6_1 : DISC;
            BIT6_1:  next_state = in ? ERR : FLAG;
            ERR:  next_state = in ? ERR : IDLE;
            DISC: next_state = in ? BIT1_1 : IDLE;
            FLAG: next_state = in ? BIT1_1 : IDLE;
            default: next_state = IDLE;
        endcase
    end
    
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err  = (state == ERR);
    
endmodule