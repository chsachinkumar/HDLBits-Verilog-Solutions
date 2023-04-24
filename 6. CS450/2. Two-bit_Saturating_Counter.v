module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    
    always@(posedge clk, posedge areset)
        begin
            if(areset)
                state <= 2'b01;
            else
                begin
                    casex({train_valid, train_taken})
                           2'b11: begin
                               		state <= (state == 2'd3)? 2'd3:state + 2'd1;
                           		  end
                           2'b10: begin
                               		state <= (state == 2'd0)? 2'd0:state - 2'd1;
                           		  end
                           2'b0?: begin
                               		state <= state;
                           		  end
                           default: state <= 2'd1;
                    endcase
              	end
       	end
endmodule