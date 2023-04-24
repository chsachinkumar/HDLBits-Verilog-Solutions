module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LEFT = 3'd0, RIGHT = 3'd1, LEFT_FALL = 3'd2, RIGHT_FALL = 3'd3, LEFT_DIG = 3'd4, RIGHT_DIG = 3'd5;
	reg [2:0] state, next_state;
    
    //reset & state_logic
    always @(posedge clk or posedge areset) 
        begin 
            if(areset) 
                state <= LEFT; 
            else 
                state <= next_state;
        end
	
    //next_state logic
    always @(state,ground,dig,bump_left,bump_right) 
        begin
			case (state)
				LEFT: next_state = ground ? (dig ? LEFT_DIG : bump_left ? RIGHT : LEFT) : LEFT_FALL;
                RIGHT: next_state = ground ? (dig ? RIGHT_DIG : bump_right ? LEFT : RIGHT) : RIGHT_FALL;
                LEFT_FALL: next_state = ground ? LEFT : LEFT_FALL;
                RIGHT_FALL: next_state = ground ? RIGHT : RIGHT_FALL;
                LEFT_DIG: next_state = ground ? LEFT_DIG : LEFT_FALL;
                RIGHT_DIG: next_state = ground ? RIGHT_DIG : RIGHT_FALL;
                default: next_state=LEFT;
			endcase
        end
    
    //output logic
    assign walk_right=(state==RIGHT);
    assign walk_left=(state==LEFT);
    assign digging=(state==RIGHT_DIG |state==LEFT_DIG);
    assign aaah=(state==LEFT_FALL | state==RIGHT_FALL);

endmodule