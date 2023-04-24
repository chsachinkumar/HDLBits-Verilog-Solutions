module FA(
    input a,b,
    input cin,
    output cout,sum
);
	
    assign sum  = a ^ b ^ cin;
    assign cout = (a&b) | (b&cin) | (cin&a);
    
endmodule

//main_module
module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);
    
	genvar i;
    FA FA0(a[0],b[0],cin,cout[0],sum[0]);
	
    generate
        for (i=1; i<100; i=i+1) 
			begin : Full_adder_block
				FA FA1(a[i],b[i],cout[i-1],cout[i],sum[i]);
			end
    endgenerate
	
endmodule