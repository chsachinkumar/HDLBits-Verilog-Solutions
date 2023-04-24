module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

	wire w1, w2;
	
    add16 adder_1(a[15:0], b[15:0], 0, sum[15:0], w1);
    add16 adder_2(a[31:16], b[31:16], w1, sum[31:16], w2);
	
endmodule

module add1(input a, input b, input cin, output sum, output cout);

    wire w0=a^b;
	
    assign sum  =  w0^cin;
    assign cout = (w0&cin) | (a&b);
	
endmodule