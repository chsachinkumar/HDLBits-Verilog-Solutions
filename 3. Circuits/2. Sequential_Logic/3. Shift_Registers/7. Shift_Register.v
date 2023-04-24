module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);

    reg [3:0] q;
	
    always@(posedge clk)
        begin
            if(~resetn)
                q<=0;
            else
                begin
                    q[2:0]<=q[3:1];
                    q[3]<=in;
                end
        end
		
    assign out=q[0];
	
endmodule