module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);
    
    parameter IDLE = 3'd0, DATA = 3'd1, CHECK = 3'd2, STOP = 3'd3, ERROR = 3'd4;
    reg [2:0] state, next_state;
    reg[7:0] out;  //data_received
    reg[3:0] count;
    wire odd, start;
    reg check;

    // Modify FSM and datapath from Fsm_serialdata
    //Synchronous Reset & state_logic
    always @(posedge clk)
        begin
        	if(reset)
                begin
            		state <= IDLE;
        		end
        	else
                begin
           			state <= next_state; 
        		end
    	end
    
    //next_state logic
    always@(*)
        begin        
			start = 0;        
			case(state)            
				IDLE: begin               
					next_state = in ? IDLE : DATA;               
					start=1;             
				end
            	DATA: next_state = (count == 8) ? CHECK : DATA;            
				CHECK: next_state = in ? STOP : ERROR;            
				STOP: begin
                	next_state = in ? IDLE : DATA;
                	start=1;
            	end
				ERROR: next_state = in ? IDLE : ERROR;
            	endcase
        end
    
    //count for 8-bit data
    always@(posedge clk)
        begin        
			if(reset)            
				count <= 0;        
			else            
				case(state)                
					DATA: count <= count + 4'd1;                
					default: count <= 0;            
				endcase    
        end
    
    //output_logic
    assign done = check && (state == STOP);
    
    //data_storing logic
    always@(posedge clk)
        begin        
			if(reset)            
                out<=0;        
			else            
				case(next_state)                
					DATA: out <= {in,out[7:1]};            
				endcase    
		end

    // New: Datapath to latch input bits.
    assign out_byte = out;

    // New: Add parity checking
    parity m0 (clk, reset | start, in, odd);
    
    //checking_logic
    always@(posedge clk)
        begin        
			if(reset)            
				check <= 0;        
			else            
				check <= odd;    
		end

endmodule