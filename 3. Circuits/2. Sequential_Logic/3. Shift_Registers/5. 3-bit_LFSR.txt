module mux_dff(input clk,L,r_in,q_in, output reg q);

    always@(posedge clk)
        begin
            if(L)
                q<=r_in;
            else
                q<=q_in;
        end
		
endmodule

//main_module
module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR	 // Q
);  

    mux_dff m0(KEY[0],KEY[1],SW[0],LEDR[2],LEDR[0]);
    mux_dff m1(KEY[0],KEY[1],SW[1],LEDR[0],LEDR[1]);
    mux_dff m2(KEY[0],KEY[1],SW[2],LEDR[2]^LEDR[1],LEDR[2]);
    
endmodule