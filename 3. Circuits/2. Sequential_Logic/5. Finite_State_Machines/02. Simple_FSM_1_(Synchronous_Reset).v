// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
	parameter A=1'd0,B=1'd1;
    
    reg present_state, next_state;

    always @(posedge clk) 
        begin
        	if (reset) 
            	begin  
            		// Fill in reset logic
            		present_state <= B;
            		out <= 1'b1;
        		end 
        	else 
            	begin
            		case (present_state)
                		// Fill in state transition logic
                		A: next_state = in ? A:B;
                		B: next_state = in ? B:A;
                		default: next_state = next_state;
            		endcase

            		// State flip-flops
            		present_state = next_state;   

            		case (present_state)
                		// Fill in output logic
                		default: out <= present_state;
            		endcase
        		end
    	end
endmodule