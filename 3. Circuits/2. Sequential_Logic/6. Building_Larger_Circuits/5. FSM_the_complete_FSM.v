module top_module (
	input clk,
	input reset,		// Synchronous reset
	input data,
	output shift_ena,
	output counting,
	input done_counting,
	output done,
	input ack 
);
    
    parameter A = 4'd0, B = 4'd1, C = 4'd2, D = 4'd3, E = 4'd4, F = 4'd5 , G = 4'd6, H = 4'd7, I = 4'd8, J = 4'd9;
    reg [3:0] state, next_state;
    
    //reset and state_logic
    always@(posedge clk) 
        begin
            if(reset)
                state <= A;
            else
				state <= next_state;
		end
    
    //next_state logic
    always@(state, data, done_counting, ack) 
        begin
			case(state)
				A: next_state = data ? B : A;
				B: next_state = data ? C :A ;
                C: next_state = data ? C : D;
                D: next_state = data ? E : A;
                E: next_state = F;
                F: next_state = G;
                G: next_state = H;
                H: next_state = I;
                I: next_state = done_counting ? J : I;
                J: next_state = ack ? A : J;
			endcase
		end
    
    //output_logic
    assign shift_ena = (state==E) || (state==F) || (state==G) || (state==H);
    assign counting = (state==I);
    assign done = (state==J);
    
endmodule