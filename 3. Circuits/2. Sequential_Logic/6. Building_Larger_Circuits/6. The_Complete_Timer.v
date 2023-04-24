module top_module (
	input clk,
	input reset,		// Synchronous reset
	input data,
	output [3:0] count,
	output counting,
	output done,
	input ack
);
    
	parameter RST = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, B0 = 4'd4, B1 = 4'd5, B2 = 4'd6, B3 = 4'd7, COUNT = 4'd8, WAIT = 4'd9;
    reg [3:0] delay, state, next_state;
    reg [13:0] count_delay;
	reg done_counting = 1'b0;
    
    //reset & state_logic
    always @(posedge clk) 
        begin 
            if(reset) 
                state<=RST; 
            else 
                state<=next_state;
		end
    
    //next_state logic
    always@(state, data, done_counting, ack) 
        begin
            case(state)
                RST: next_state = data ? S1 : RST;
                S1:	next_state = data ? S2 : RST;
                S2: next_state = data ? S2 : S3;
                S3: next_state = data ? B0 : RST;
                B0: next_state = B1; 
                B1: next_state = B2; 
                B2: next_state = B3; 
                B3: next_state = COUNT;
                COUNT: next_state = done_counting ? WAIT : COUNT;
                WAIT: next_state = ack ? RST : WAIT;
                default: next_state = RST;
            endcase
        end
	
    //data_input_logic & shift_enable logic
    always@(posedge clk) 
        begin 
            if(reset) 
                delay <= 'd0; 
            else 
                begin 
                    case(state) 
                        B0: delay[3] <= data; 
                        B1: delay[2] <= data;
                        B2: delay[1] <= data;
                        B3: delay[0] <= data;
                        default: delay <= delay;
                    endcase
                end
        end
    
    //logic for counting delay
    always @(posedge clk) 
        begin
            if (reset)
                count_delay<='d0;
            else 
                case(state)
					COUNT: count_delay <= count_delay + 14'd1;
                    default: count_delay <= 'd0; 
                endcase 
        end 
    
    //output_logic
    assign done_counting = (count_delay == ((delay + 1) * 1000 - 1));
    assign count = delay - count_delay/1000; 
    assign counting = (state == COUNT); 
    assign done= (state == WAIT); 
    
endmodule