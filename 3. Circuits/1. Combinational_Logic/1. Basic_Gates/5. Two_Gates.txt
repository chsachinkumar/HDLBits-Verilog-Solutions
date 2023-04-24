module top_module(
    input in1,
    input in2,
    input in3,
    output out
);

    wire w;
	
    assign w = ~(in1^in2);
    assign out = w^in3;
	
endmodule