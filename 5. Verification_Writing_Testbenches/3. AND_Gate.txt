module top_module();
    
    reg [1:0] in;
    wire out;
    
    initial
        begin
            in=2'd0;
            #10 in=2'd1;
            #10 in=2'd2;
            #10 in=2'd3;
        end
    
    andgate dut(in,out);
    
endmodule