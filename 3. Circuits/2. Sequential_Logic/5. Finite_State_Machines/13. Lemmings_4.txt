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
    output digging 
); 
    
    parameter LEFT = 3'd0, RIGHT = 3'd1, LEFT_FALL = 3'd2, RIGHT_FALL = 3'd3, LEFT_DIG = 3'd4, RIGHT_DIG = 3'd5, SPLATTER = 3'd6;
    reg [2:0] state, next_state;
    reg [7:0] count_20_clk;
    
    //reset & state_logic
    always@(posedge clk or posedge areset) 
        begin
            state <= areset ? LEFT : next_state;
        end
    
    //next_state logic
    always@(state,ground,dig,bump_left,bump_right,count_20_clk) 
        begin
            case (state)
                LEFT: next_state = ground ? (dig ? LEFT_DIG : (bump_left ? RIGHT : LEFT)) : LEFT_FALL;
                RIGHT: next_state = ground ? (dig ? RIGHT_DIG : (bump_right ? LEFT : RIGHT)) : RIGHT_FALL;
                LEFT_FALL: next_state = (~ground) ? LEFT_FALL : ((count_20_clk > 'd20) ? SPLATTER : LEFT);
                RIGHT_FALL: next_state = (~ground) ? RIGHT_FALL : ((count_20_clk > 'd20) ? SPLATTER : RIGHT); 
                LEFT_DIG: next_state = ground ? LEFT_DIG : LEFT_FALL;
    			RIGHT_DIG: next_state = ground ? RIGHT_DIG : RIGHT_FALL;
                SPLATTER: next_state = SPLATTER;
                default: next_state = LEFT;
			endcase
		end
    
    //20 clk counter to check grounds hit
    always@(posedge clk) 
        begin 
            if(areset)
				count_20_clk <= 'd0;
    		else 
                count_20_clk <= (~ground) ? count_20_clk + 'd1 : 'd0;
        end
                    
    //output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == LEFT_FALL) || (state == RIGHT_FALL);
    assign digging = (state == LEFT_DIG) || (state == RIGHT_DIG);

endmodule