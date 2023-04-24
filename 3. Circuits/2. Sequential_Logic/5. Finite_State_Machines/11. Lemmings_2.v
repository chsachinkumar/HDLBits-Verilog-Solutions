module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
	
    parameter LEFT=2'd0, RIGHT=2'd1,GROUND=2'd2; 
    reg [1:0] state, next_state;
    wire [1:0] direction = {bump_left,bump_right};
    reg [1:0] temp=LEFT;

    always @(*) begin
        // State transition logic
        case(state)
            LEFT: begin
                next_state = (ground) ? ((direction == 2'b10) || (direction == 2'b11) ? RIGHT:LEFT) : GROUND;
            end
            RIGHT: begin
                next_state = (ground) ? ((direction == 2'b01) || (direction == 2'b11) ? LEFT:RIGHT) : GROUND;
            end
            GROUND: begin
                next_state = ground ? temp:GROUND;
            end
            default: begin
                		next_state = LEFT;
                		temp = LEFT;
            end
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset)
           state <= LEFT;
        else
            begin
           		state <= next_state;
                aaah <= !ground;
                if(state != GROUND)
                	temp = state;
                else
                    temp = temp;
            end
    end

    // Output logic
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    
endmodule