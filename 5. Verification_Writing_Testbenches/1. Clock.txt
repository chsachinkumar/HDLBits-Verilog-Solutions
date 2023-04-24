module top_module();

	reg clk;
    initial clk=0;
	
    dut m0(clk);
    always #5 clk = ~clk;
	
endmodule