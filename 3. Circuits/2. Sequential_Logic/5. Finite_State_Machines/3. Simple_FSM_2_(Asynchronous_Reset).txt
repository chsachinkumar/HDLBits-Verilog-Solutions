module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'd0, ON=1'd1; 
    reg state, next_state;

    always @(*) 
        begin
        	// State transition logic
        	case(state)
            	OFF: next_state = j ? ON:OFF;
            	ON: next_state = k ? OFF:ON;
            	default: next_state = next_state;
        	endcase
    	end

    always @(posedge clk, posedge areset) 
        begin
        	// State flip-flops with asynchronous reset
        	if(areset)
            	state = OFF;
        	else
            	state <= next_state;
    	end

    // Output logic
            assign out = (state == ON);
endmodule