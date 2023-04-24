module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  
);

    wire w0,w1;
	
    assign w0 = a^b;
    assign w1 = c^d;
    assign out = w0&(~w1) | (~w0)&w1;
	
endmodule