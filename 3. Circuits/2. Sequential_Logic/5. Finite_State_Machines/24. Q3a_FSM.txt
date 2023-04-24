module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
	
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;
    reg [1:0] count_1, count_3clk;
    
    //synchronous reset and state_logic
    always@(posedge clk)
        begin
            if(reset)
                state <= A;
            else
                state <= next_state;
        end
    
    //next_state logic
    always@(state,s)
        begin
            case(state)
                A: next_state = s ? B : A;
                B: next_state = B;
                default: next_state = B;
            endcase
        end
    
    //next 3 clock logic for state B
    always@(posedge clk)
        begin
            if(reset)
                begin
                    count_3clk <= 2'd0;
                    count_1 <= 2'd0;
                end
            else if(state == A)
                begin
                    count_3clk <= 2'd0;
                    count_1 <= 2'd0;
                end
           	else if(count_3clk == 2'd3)
                begin
                    count_3clk <= 2'd1;
                    count_1 <= w;
                end
            else
                begin
                    count_3clk <= count_3clk + 2'd1;
                    count_1 <= count_1 + w;
                end
        end
        
    //output_logic
    assign z = (count_1 == 2'd2) && (count_3clk == 2'd3);
    
endmodule