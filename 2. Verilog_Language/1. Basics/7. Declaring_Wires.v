`default_nettype none

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   
); 

	wire w0,w1;
    assign w0 = a & b;
    assign w1 = c & d;
    assign out = w0 | w1;
    assign out_n = ~out;
	
endmodule
