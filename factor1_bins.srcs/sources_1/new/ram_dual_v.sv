`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2020 13:36:02
// Design Name: 
// Module Name: ram_dual_v
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram_dual_v # (parameter words = 4096, addr_w = 12, addr_end = 49)
(
	input  [7:0] 			din,
	input  [addr_w-1:0] 	rd_addr, wr_addr,
	input 					wr, rd, clk, //wr_clk, rd_clk,
	output [7:0] 			dout,
	output 					valid
);


reg valid_r=0;
reg [7:0] ram[words-1:0];
	
always @ (posedge clk) begin
	// Write
	
	if (wr) begin
		ram[wr_addr] <= din;
		if(wr_addr>=addr_end)
			valid_r<=1'b1;
	end
	
	else if(rd) begin
		if(rd_addr>=addr_end)
			valid_r<=1'b0;
	end
	
end
	
assign dout  = (rd)?ram[rd_addr]:8'h00;
assign valid = valid_r;

endmodule
