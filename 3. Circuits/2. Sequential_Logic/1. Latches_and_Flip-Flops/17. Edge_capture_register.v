module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    
    reg [31:0]temp;
	integer i;
    
	always @(posedge clk)
        begin
			temp<=in;
		end

	always @(posedge clk)
        begin
    		if (reset)
        		begin
            		out<=32'd0;
				end
			else
        		begin
    				for (i=0;i<32;i=i+1)
                      	if({temp[i], in[i]}==2'b10)
                            out[i]<=1'b1;
				end
		end
    
endmodule