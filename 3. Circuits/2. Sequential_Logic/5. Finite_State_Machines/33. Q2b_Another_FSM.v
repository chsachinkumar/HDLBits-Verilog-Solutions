module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    
    //RST-> F=1 -> {S1,S2,S3}={1,0,1} -> {1,1}or{1,0}or{0,1}={G=1} till reset -> {if not previous condition}={G=0} till reset
    
    parameter RST = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3, S4 = 4'd4, G= 4'd5, G1 = 4'd6, G0 = 4'd7, F = 4'd8;
    reg [3:0] state, next_state;
    
    //reset & state_logic
    always@(posedge clk)
        begin
            if(!resetn)
            	state <= RST;
        	else 
            	state <= next_state;
    	end
    
    //next_state logic
    always@(*)
        begin
        	case(state)
            	RST: next_state = F;
            	F: next_state = S1;
            	S1: next_state = x ? S2 : S1;
            	S2: next_state = x ? S2 : S3;
            	S3: next_state = x ? G: S1; 
            	G: next_state = y ? G1 : S4;
            	S4: next_state = y ? G1 : G0;
            	G1: next_state = G1;
            	G0: next_state = G0;
            	default: next_state = RST;
        	endcase
    	end
    
    //output logic
    assign f = (state == F);
    assign g = (state == S4 || state == G || state == G1);
                
endmodule