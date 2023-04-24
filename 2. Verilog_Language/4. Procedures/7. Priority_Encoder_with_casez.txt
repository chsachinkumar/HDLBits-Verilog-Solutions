//synthesis verilog_input_version verilog_2001
module top_module(
    input [7:0] in,
    output reg [2:0] pos
);

	always @(*)
		begin
			casez (in[7:0])
				8'bzzzzzzz1: pos = 'd0;
				8'bzzzzzz1z: pos = 'd1;
				8'bzzzzz1zz: pos = 'd2;
				8'bzzzz1zzz: pos = 'd3;
				8'bzzz1zzzz: pos = 'd4;
				8'bzz1zzzzz: pos = 'd5;
				8'bz1zzzzzz: pos = 'd6;
				8'b1zzzzzzz: pos = 'd7;
				default: 	 pos = 'd0;
			endcase
		end
		
endmodule
