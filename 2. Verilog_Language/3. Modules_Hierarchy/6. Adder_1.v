module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

	wire c0,c1;
	wire [15:0] w0,w1;
	
	add16 m0(.a(a[15:0]), .b(b[15:0]), .cin(0), .sum(w0), .cout(c0));
	add16 m1(.a(a[31:16]), .b(b[31:16]), .cin(c0), .sum(w1), .cout(c1));
	
	assign sum={w1,w0};
	
endmodule