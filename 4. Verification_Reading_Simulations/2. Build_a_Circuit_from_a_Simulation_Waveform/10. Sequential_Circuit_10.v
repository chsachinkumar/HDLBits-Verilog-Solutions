module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state  );
	
    assign q = a ^ b ^ state;
    
    always@(posedge clk)
        begin
            if(a==b)
                state <= a;
            else
                state <= state;
        end
    
endmodule