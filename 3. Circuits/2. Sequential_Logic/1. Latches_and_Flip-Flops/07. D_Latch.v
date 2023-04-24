module top_module(
    input d, 
    input ena,
    output q
);

    always@(*)
        if(ena)
        	q<=d;
			
endmodule