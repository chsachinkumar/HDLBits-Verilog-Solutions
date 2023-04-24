module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
	
    parameter S0=4'd0, S1=4'd1, S2=4'd2, S3=4'd3, S4=4'd4, S5=4'd5, S6=4'd6, S7=4'd7, S8=4'd8, S9=4'd9;
    
    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[S0] = (~in) & (state[0] | state[1] | state[2] | state[3] | state[4] | state[7] | state[8] | state[9]);
    assign next_state[S1] = in & (state[0] | state[8] | state[9]);
    assign next_state[S2] = state[1] & in;
    assign next_state[S3] = state[2] & in;
    assign next_state[S4] = state[3] & in;
    assign next_state[S5] = state[4] & in;
    assign next_state[S6] = state[5] & in;
    assign next_state[S7] = (state[6] | state[7]) & in;
    assign next_state[S8] = state[5] & (~in);
    assign next_state[S9] = state[6] & (~in);

    // Output logic: 
    assign out1 = (state[S8] | state[S9]);
    assign out2 = (state[S7] | state[S9]);
    
endmodule