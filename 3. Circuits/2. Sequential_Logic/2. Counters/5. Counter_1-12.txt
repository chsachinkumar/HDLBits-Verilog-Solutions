module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 
    
    count4 m0(clk, enable, c_load, c_d, Q);
    
    always@(*)
        begin
            if(reset)
                begin
                    c_load <= 1'b1;
                    c_d <= 4'd1;
                end
            else
                begin
                    c_load <= 1'b0;
                    c_d <= 4'd0;
                    if(enable && (Q == 4'd12))
                        begin
                            c_load <= 1'b1;
                    		c_d <= 4'd1;
                        end
                end
        end
    
    assign c_enable = enable;
    
endmodule