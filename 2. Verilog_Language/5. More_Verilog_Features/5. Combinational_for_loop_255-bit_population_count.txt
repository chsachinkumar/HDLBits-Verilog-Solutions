module top_module( 
    input [254:0] in,
    output [7:0] out
);

	integer i;
    reg [7:0] count;
	
    always@(in)
		begin
			count = 0;
			for(i=0; i<255; i=i+1)
				begin
					if(in[i]==1'b1) 
						count = count+1'b1;
				end
			out = count;
		end
		
endmodule