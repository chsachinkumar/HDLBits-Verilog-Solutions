module top_module ();
	
    reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff dut(clk,reset,t,q);
    
    initial
        begin
            clk=0;
            reset=1;
            t=1;
            #10 reset=0;
        end
    
    always #5 clk=~clk;
    
endmodule