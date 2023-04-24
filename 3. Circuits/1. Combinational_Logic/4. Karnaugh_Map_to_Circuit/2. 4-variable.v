module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  
); 
	
    assign out= (~c)&(~b) | c&d&(a|b) | (~d)&(~a);
	
endmodule