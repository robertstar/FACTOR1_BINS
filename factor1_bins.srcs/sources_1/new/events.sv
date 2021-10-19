`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2019 08:59:19
// Design Name: 
// Module Name: events
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


module events
(
	input 	wr_clk,
	input 	rd_clk,
	
	input 	rst,
	input		rd,
	input  	wr,

	output 	out
);

reg temp;
reg temp1; 
reg temp2; 
reg temp3; 
reg temp4; 


initial begin
	temp<=0;
	temp1<=0;
	temp2<=0;
	temp3<=0;
	temp4<=0;
end

assign out = temp;

always @ (posedge wr_clk)
begin
	// Write
	if (wr) begin
		temp1 <= 1'b1;
	end
	else
		temp1 <= 1'b0;
end


always @ (posedge rd_clk)
begin
	
	temp2 <= temp1;
	temp3 <= temp2;
	
	// Read 
	if (rd) begin
		temp <= 1'b0;
	end

	if(!temp3 && temp2)   temp <= 1'b1;
	
end

endmodule

