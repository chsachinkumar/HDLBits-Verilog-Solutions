module top_module ( input clk, input d, output q );

    wire w0,w1;
	
    my_dff m0(.clk(clk), .d(d), .q(w0));
    my_dff m1(.clk(clk), .d(w0), .q(w1));
    my_dff m2(.clk(clk), .d(w1), .q(q));
	
endmodule