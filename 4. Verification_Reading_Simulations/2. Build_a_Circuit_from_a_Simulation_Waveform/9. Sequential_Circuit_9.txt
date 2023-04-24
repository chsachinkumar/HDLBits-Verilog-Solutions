module top_module (
    input clk,
    input a,
    output [3:0] q 
);
    always@(posedge clk)
         begin
               if(a)
                   q <= 'd4;
             else if(q==6)
                 q <= 'd0;
             else
                   q <= q + 4'd1;
         end
    
endmodule 