module top_module (
    input clock,
    input a,
    output p,
    output q );
	
    always@(*)
        begin
            if(clock == 1'b1)
            	p = a;
            else
                p = p;
        end
		
    always@(negedge clock)
        begin
            q = a;
        end
		
endmodule