module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire w0,w1,w2;
    wire [15:0] w3,w4;
	
    add16 m0(a[15:0], b[15:0], 0, sum[15:0], w0);
    add16 m1(a[31:16], b[31:16], 0, w3, w1);
    add16 m2(a[31:16], b[31:16], 1, w4, w2);
	
    always @(w0, w3, w4) begin
        case(w0)
            1'b0 : sum[31:16] = w3;
            1'b1 : sum[31:16] = w4;
        endcase
    end
	
endmodule