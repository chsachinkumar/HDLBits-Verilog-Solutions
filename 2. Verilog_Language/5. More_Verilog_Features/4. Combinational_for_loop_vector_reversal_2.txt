module top_module( 
    input [99:0] in,
    output [99:0] out
);

    always@(in)
        begin: always_block     //always_block is named due to declaration i inside always_block
            integer i;
            for(i=0;i<100;i=i+1)
                out[99-i]=in[i];
        end
		
endmodule