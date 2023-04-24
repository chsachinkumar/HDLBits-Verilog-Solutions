module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    
    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
    reg [1:0] state, next_state;
    
    //synchronous reset and state_logic
    always@(posedge clk)
        begin
        	if(~resetn)
                state <= A;
        	else
                state <= next_state;
    	end
    
    //next_state logic
    always@(state,r)
        begin
        	case(state)
            	A: 	if(r[1])
                    	next_state = B;
                	else if(r == 3'b000)
                    	next_state = A;
                	else if(r[2:1] == 2'b10)
                    	next_state = C;
                	else if(r == 3'b100)
                    	next_state = D;
                B: 	if(r[1] == 1'b0)
                    	next_state = A;
                	else if(r[1])
                    	next_state = B;
            	C: 	if(r[2])
                    	next_state = C;
                else if(r[2] == 1'b0)
                    	next_state = A;
            	D: 	if(r[3])
                    	next_state = D;
                	else if(~r[3])
                    	next_state = A;
            	default: next_state = A;
        	endcase
    	end
    
    //output logic
    always@(*)
        begin
        	case(state)
            	A: g = 3'b000;
            	B: g = 3'b001;
            	C: g = 3'b010;
            	D: g = 3'b100;
            	default: g = 0;
        	endcase
    	end
 
endmodule