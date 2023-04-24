module d_ff (input enable,clk,din, output reg q);

    always@(posedge clk)
        if(enable)
            q<=din;
    	else
            q<=q;
			
endmodule

module shift_reg #(parameter n=8) (input clk,in,enable, output [0:n-1] q);

    d_ff m0 (enable,clk,in,q[0]);
    generate
        begin: generate_block
            genvar i;
            for(i=1;i<=n-1;i=i+1)
                begin: generate_for_loop
                    d_ff m1 (enable,clk,q[i-1],q[i]);
                end
        end
    endgenerate
	
endmodule

//main_module
module top_module(
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z 
);
    
    reg [0:7]q;
    
    shift_reg s0(clk,S,enable,q);
    
    always@(*)
        begin
            case({A,B,C})
                3'd0: Z = q[0];
                3'd1: Z = q[1];
                3'd2: Z = q[2];
                3'd3: Z = q[3];
                3'd4: Z = q[4];
                3'd5: Z = q[5];
                3'd6: Z = q[6];
                3'd7: Z = q[7];
            endcase
        end
    
endmodule