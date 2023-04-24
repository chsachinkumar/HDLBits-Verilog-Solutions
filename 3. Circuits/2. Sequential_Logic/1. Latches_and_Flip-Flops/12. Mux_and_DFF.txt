module top_module(
    input clk,
    input w, R, E, L,
    output Q
);
    
	always @ (posedge clk) 
        begin
            case ({E,L})
                2'b00 : Q <= Q;
                2'b01 : Q <= R;
                2'b10 : Q <= w;
               	2'b11 : Q <= R;        
            endcase    
    	end
    
endmodule