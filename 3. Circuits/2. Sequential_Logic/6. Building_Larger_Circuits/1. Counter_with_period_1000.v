module top_module (
    input clk,
    input reset,
    output [9:0] q
);

    always@(posedge clk)
        begin
            if(reset | q == 10'd999)
                q <= 10'b0;
            else
                q <= q+10'b1;
        end
		
endmodule