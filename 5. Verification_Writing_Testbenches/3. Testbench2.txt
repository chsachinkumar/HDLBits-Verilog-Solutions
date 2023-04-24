module top_module();
    
	reg clk;
    reg in;
    reg [2:0] s;
    wire out;
    
    initial
        begin
            clk=0;
            in=0;
            s=3'd2;
            #10 s=3'd6;
            #10 s=3'd2;
            in=1;
            #10 s=3'd7;
            in=0;
            #10 s=3'd0;
            in=1;
            #30 in=0;
        end
    
    q7 dut(clk,in,s,out);
    
    always #5 clk=~clk;
    
endmodule