//counter module
module counter (
    input clk,
    input reset,
    input start,  
    input [3:0] stop, 
    output count_stop,       
    output [3:0] count
);
 
    wire check_count;				// usefull for restarting of upper counter like ss[7:4], mm[7:4] or hh[7:4]
    assign check_count = start;
    
    always @(posedge clk)
        begin
        	if(reset)
            	begin
           			count <= 4'd0; 
        		end
            else if(check_count)
                begin
                    if(count_stop)
                		count <= 4'd0;
            		else
                		count <= count + 4'd1;
        		end
    	end
    
    assign count_stop = check_count && (count == stop); 
endmodule

//top-module
module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);
    
    //second-counter
    wire ss_low_stop, ss_upper_stop;   //low->lower BCD count & upper-> upper BCD Count
    counter count_ss_lbcd(clk, reset, ena, 4'd9, ss_low_stop, ss[3:0]);
    counter count_ss_ubcd(clk, reset, ss_low_stop, 4'd5, ss_upper_stop, ss[7:4]);
   
    //minute-counter
    wire mm_low_stop, mm_upper_stop;
    counter cnt_mml(clk, reset, ss_upper_stop, 4'd9, mm_low_stop, mm[3:0]);
    counter cnt_mmh( clk, reset, mm_low_stop, 4'd5, mm_upper_stop, mm[7:4]);
    
    reg am_to_pm;        //0->AM & 1->PM
    always @(posedge clk)
        begin
        	if(reset)
                begin
            		am_to_pm <= 0;
            		hh <= 8'h12;
        		end
        	else if(mm_upper_stop)
                begin
            		if(hh == 8'h12)
                		hh <= 8'h01;
            else
                begin
                	hh <= hh + 1'b1;
                	if(hh == 8'h09)
                    	hh <= 8'h10;
                	if(hh == 8'h11)
                    	am_to_pm <= ~am_to_pm;
            	end
        end
    end
    assign pm = am_to_pm;
endmodule