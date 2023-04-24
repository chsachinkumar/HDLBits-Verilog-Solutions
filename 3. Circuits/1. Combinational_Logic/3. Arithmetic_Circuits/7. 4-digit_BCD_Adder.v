module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum 
);
	
    wire [2:0]w;
	
    bcd_fadd m0(a[3:0],b[3:0],cin,w[0],sum[3:0]);
    bcd_fadd m1(a[7:4],b[7:4],w[0],w[1],sum[7:4]);
    bcd_fadd m2(a[11:8],b[11:8],w[1],w[2],sum[11:8]);
    bcd_fadd m3(a[15:12],b[15:12],w[2],cout,sum[15:12]);
    
endmodule