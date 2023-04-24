module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire w0,w1;
    wire [31:0] w2;
	
    assign w2 = {32{sub}}^b; 
	
    add16 m0(a[15:0], w2[15:0], sub, sum[15:0], w0);
    add16 m1(a[31:16], w2[31:16], w0, sum[31:16],w1);
	
endmodule