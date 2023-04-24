module top_module( 
    input a, b, cin,
    output cout, sum 
);

    wire w=a^b;
	
	assign sum = w ^ cin;
    assign cout = (w & cin) | (a & b);
	
endmodule