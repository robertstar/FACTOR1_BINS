`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2020 13:46:19
// Design Name: 
// Module Name: ram_dual2
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


module ram_dual2 # (parameter words = 4096, addr_w = 12)
(
	input  [7:0] 			din,
	input  [addr_w-1:0] 	rd_addr, wr_addr,
	input 					wr, rd, clk, //wr_clk, rd_clk,
	output [7:0] 			dout          //====15.08
//	output reg [7:0] 	 dout             //====15.08
	//output [15:0] 	cnt
);


//reg [15:0] count;

//initial begin
//	count<=0;
//end

//assign cnt = count;


// Declare the RAM variable
reg [7:0] ram[words-1:0];
	
	always @ (posedge clk)
	begin
		// Write
		if (wr)
			ram[wr_addr] <= din;
	end
	
/*	always @(posedge clk) begin               //====15.08
        if (rd)   dout <= ram[rd_addr];
        else      dout <= 8'h00;
    end     */
        
	
	
//	always @ (posedge rd_clk)
//	begin
//		// Read 
//		if (rd)
//			dout <= ram[rd_addr];
//		else
//			dout <= 8'h00;
//	end
	
	
	assign dout = (rd)?ram[rd_addr]:8'h00;       //====15.08

endmodule
