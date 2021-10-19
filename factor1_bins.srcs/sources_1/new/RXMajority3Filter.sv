`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2020 07:57:02
// Design Name: 
// Module Name: RXMajority3Filter
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


module RXMajority3Filter
(
	input clk,
	input in,
	output wire out
);

reg [2:0] rxLock = 3'b111;

assign out = (rxLock[0] & rxLock[1]) | (rxLock[0] & rxLock[2]) | (rxLock[1] & rxLock[2]);

always @(posedge clk) begin
	rxLock <= {in, rxLock[2:1]};
end

endmodule
