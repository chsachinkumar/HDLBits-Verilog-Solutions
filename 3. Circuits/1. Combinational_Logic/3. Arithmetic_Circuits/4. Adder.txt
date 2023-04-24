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
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum
);
	
    wire w0,w1,w2;
	
    FA FA0(x[0],y[0],0,w0,sum[0]);
    FA FA1(x[1],y[1],w0,w1,sum[1]);
    FA FA2(x[2],y[2],w1,w2,sum[2]);
    FA FA3(x[3],y[3],w2,sum[4],sum[3]);
    
endmodule