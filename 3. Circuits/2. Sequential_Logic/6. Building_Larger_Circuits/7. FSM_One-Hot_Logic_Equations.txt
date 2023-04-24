module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
); //

    // You may use these parameters to access state bits using e.g., state[B2] instead of state[6].
    parameter RST = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, B0 = 4'd4, B1 = 4'd5, B2 = 4'd6, B3 = 4'd7, COUNT = 4'd8, WAIT = 4'd9;
    
    assign B3_next = state[B2];
    assign S_next = (~d && state[RST]) || (~d && state[S1]) || (~d && state[S3]) || (ack && state[WAIT]);
    assign S1_next = (d && state[RST]);
    assign Count_next = state [B3] || (state[COUNT] && (~done_counting));
    assign Wait_next = (state[COUNT] && done_counting) || (~ack&&state[WAIT]);
    assign done = state[WAIT];
    assign counting = state[COUNT];
    assign shift_ena = state[B0] || state[B1] || state[B2] || state[B3];

endmodule