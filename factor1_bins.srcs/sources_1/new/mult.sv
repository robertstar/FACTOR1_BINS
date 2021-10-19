`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2019 09:47:30
// Design Name: 
// Module Name: mult
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


module mult(clk, x, y, out);
	
	// Inputs
  	input clk;
	input signed       [15:0] x;   //signal 32bit
	input signed       [15:0] y;   //cordic 32bit
 	
 	// Outputs
	output reg signed  [31:0] out;
	//output reg signed  [63:0] temp;
	
	initial begin
		//temp<=64'd0;
		out<=32'd0;
	end
	
	//assign out = temp[31:0];
	
	always @(posedge clk) begin
		//temp <= x * y;
		out  <= x * y;
	end
	
endmodule
