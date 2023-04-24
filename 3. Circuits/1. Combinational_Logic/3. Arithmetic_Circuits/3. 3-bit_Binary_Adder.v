module FA( 
    input a, b, cin,
    output cout, sum 
);
    
    wire w=a^b;
	
    assign sum  = w ^ cin;
	assign cout = (w & cin) | (a & b);
	
endmodule

//main_module
module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum 
);
	
    FA FA0(a[0],b[0],cin,cout[0],sum[0]);
    FA FA1(a[1],b[1],cout[0],cout[1],sum[1]);
    FA FA2(a[2],b[2],cout[1],cout[2],sum[2]);
    
endmodule