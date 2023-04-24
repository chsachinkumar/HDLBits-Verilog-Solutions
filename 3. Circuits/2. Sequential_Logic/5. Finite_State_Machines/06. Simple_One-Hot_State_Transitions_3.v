module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = state[0]&(~in) | state[2]&(~in);
    assign next_state[B] = state[0]&in | state[1]&in | state[3]&in;
    assign next_state[C] = state[1]&(~in) | state[3]&(~in);
    assign next_state[D] = state[2]&in;

    // Output logic: 
    assign out = state[D];

endmodule