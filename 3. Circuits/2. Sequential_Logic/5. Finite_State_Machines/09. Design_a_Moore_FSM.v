module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    //u -> upper_sensors && l -> lower_sensors
    parameter S0 = 3'd1, S1_u = 3'd2, S1_l = 3'd3, S2_u = 3'd4, S2_l = 3'd5, S3 = 3'd6;
    reg [2:0]state, next_state;
    
    //reset & state_logic
	always@(posedge clk)
        begin
			if(reset) 
                state <= S0;
			else 
                state <= next_state;
        end
    
    //next_state logic
    always @(state,s)
        begin
			case(state)
                S0: if(s == 3'b001) 
                    	next_state <= S1_u;
                	else if(s == 3'b000) 
                        next_state <= S0;
                
                S1_u: if(s == 3'b000)
                    	next_state <= S0;
                	else if(s == 3'b011)
                    	next_state <= S2_u;
                	else if(s == 3'b001)
                    	next_state <= S1_u;
                
                S2_u: if(s == 3'b001)
                    next_state <= S1_l;
                	else if(s == 3'b011)
                    	next_state <= S2_u;
                	else if(s == 3'b111)
                    	next_state <= S3;
                
                S1_l: if(s == 3'b000)
                    	next_state <= S0; 
                	else if(s == 3'b011)
                        next_state <= S2_u;  
                	else if(s == 3'b001)
                    	next_state <= S1_l;
                
                S2_l: if(s == 3'b001)
                    	next_state <= S1_l;
                	else if(s == 3'b111)
                    	next_state <= S3;
                	else if(s == 3'b011)
                    	next_state <= S2_l;
                
                S3: if(s == 3'b011)
                    	next_state <= S2_l;
                	else if(s == 3'b111)
                    	next_state <= S3;
                
                default: next_state <= S0;
           endcase
        end
    
    //output_logic
    always@(state)
        begin
            case(state)
                S0: {dfr, fr3, fr2,fr1} = 4'b1111;
                S1_u: {dfr, fr3, fr2, fr1} = 4'b0011;
                S2_u: {dfr, fr3, fr2, fr1} = 4'b0001;
                S1_l: {dfr, fr3, fr2, fr1} = 4'b1011;
                S2_l: {dfr, fr3, fr2,fr1} = 4'b1001;
                S3: {dfr, fr3, fr2, fr1} = 4'b0000;
            endcase
        end
    
endmodule