module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	
    reg [9:0] counter;
    
    always@(posedge clk)
        begin
            if(load)
                counter <= data;
            else if(counter != 10'd0)
                counter <= counter - 10'd1;
            else
                counter <= counter;
        end
    
    assign tc = (counter==10'd0);
    
endmodule