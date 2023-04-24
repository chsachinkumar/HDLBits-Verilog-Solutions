module top_module (input a, input b, input c, output out);
	
    wire w;
    supply1 vdd;
    andgate inst1 (w, a, b, c, vdd, vdd);
    assign out = ~w;

endmodule