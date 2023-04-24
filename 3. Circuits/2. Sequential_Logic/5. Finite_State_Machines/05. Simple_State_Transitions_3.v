module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;

    // State transition logic: next_state = f(state, in)
    always@(*)
        begin
            case(state)
                A: next_state = in ? B:A;
                B: next_state = in ? B:C;
                C: next_state = in ? D:A;
                D: next_state = in ? B:C;
                default: next_state = next_state;
            endcase
        end

    // Output logic:  out = f(state) for a Moore state machine
    always@(state)
        begin
            case(state)
                A: out <= 1'b0;
                B: out <= 1'b0;
                C: out <= 1'b0;
                D: out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end

endmodule