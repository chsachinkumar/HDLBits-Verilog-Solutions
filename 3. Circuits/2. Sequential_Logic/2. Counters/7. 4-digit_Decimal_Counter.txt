module BCD_Counter(input clk,rst,ena, output [3:0] q);
    always@(posedge clk)
        begin
            if(rst)
                q<=0;
            else
                begin
                    if(ena)
                        if(q==4'd9)
                            q<=0;
                    	else
                            q<=q+4'd1;
                end
        end
endmodule

module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    BCD_Counter m0 (clk,reset,1'd1,q[3:0]);
    genvar i;
    generate
        for(i=1;i<=3;i=i+1)
            begin: gen_for_loop
                BCD_Counter m1 (clk,reset,ena[i],q[i*4+3:i*4]);
            end
    endgenerate

    assign ena[1] = (q[3:0] == 9);
    assign ena[2] = ((q[7:4] == 9)&(q[3:0] == 9));
    assign ena[3] = ((q[11:8] == 9)&(q[7:4] == 9)&(q[3:0] == 9));

endmodule