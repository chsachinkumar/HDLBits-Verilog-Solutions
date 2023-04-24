module top_module #(parameter n=512) (
    input clk,
    input load,
    input [n-1:0] data,
    output [n-1:0] q
); 

    wire [n-1:0] q_left,q_right; 	//declaration of centere's left and right part
    assign q_left=q>>1; 			//centre's left part => right shift of q by 1-bit
    assign q_right=q<<1; 			//centre's right part => left shift of q by 1-bit	
	
    always@(posedge clk)
        begin
            if(load)
                q<=data;
            else
                q <= (~q & q_right) | (q & ~q_right) | (~q_left & q_right); //Functional Equation of Rule-110
        end
		
endmodule