module top_module(
    input clk,
    input in,
    input reset,
    output out);
	
    parameter A=2'd0, B=2'd1, C=2'd2, D=2'd3;
    reg [1:0] state,next_state;
    
    // State transition logic
	always@(state,in)
        begin
            case(state)
                A: next_state = in ? B:A;
               	B: next_state = in ? B:C;
                C: next_state = in ? D:A;
                D: next_state = in ? B:C;
            endcase
        end
    
    // State flip-flops with synchronous reset
	always@(posedge clk)
        begin
            if(reset)
                begin
                	state = A;
                end
            else
                state <= next_state;
        end
    
    // Output logic
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