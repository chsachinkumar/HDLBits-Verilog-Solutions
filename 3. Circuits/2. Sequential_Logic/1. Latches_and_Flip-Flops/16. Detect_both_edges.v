module top_module(
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    reg [7:0] w;
	
    always@(posedge clk)
        begin
            w<=in;
            anyedge<=in^w;
        end
    
endmodule