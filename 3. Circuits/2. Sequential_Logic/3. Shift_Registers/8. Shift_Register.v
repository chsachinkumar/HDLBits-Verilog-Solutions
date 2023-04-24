module top_module #(parameter n=4)(
    input [n-1:0] SW,
    input [3:0] KEY,
    output [n-1:0] LEDR
);

    MUXDFF m0(KEY[0],KEY[1],KEY[2],KEY[3],SW[n-1],LEDR[n-1]);
    genvar i;
    generate
        begin: generate_block
        for(i=n-2;i>=0;i=i-1)
            begin: module_instantiation
                MUXDFF m0(KEY[0],KEY[1],KEY[2],LEDR[i+1],SW[i],LEDR[i]);
            end
        end
    endgenerate
	
endmodule

module MUXDFF (input clk,E,L,W,r_in, output q);

    always@(posedge clk)
        begin
            case({E,L})
                2'b00: q<=q;
                2'b01: q<=r_in;
                2'b10: q<=W;
                2'b11: q<=r_in;
                default: q<=1'bx;
            endcase
        end
		
endmodule