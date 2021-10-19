`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2019 16:36:30
// Design Name: 
// Module Name: ram_adc
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2019 09:00:56
// Design Name: 
// Module Name: ram_dual
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


module ram_adc # (parameter words = 4096, addr_w = 12)
(
	input  [7:0] 	din,
	input  [addr_w-1:0] 	rd_addr, wr_addr,
	input 			wr, rd, wr_clk, rd_clk,
	output [7:0] 	dout
	//output [15:0] 	cnt
);


reg [15:0] count;

initial begin
	count<=0;
end

//assign cnt = count;


// Declare the RAM variable
reg [7:0] ram[words-1:0];
	
	always @ (posedge wr_clk)
	begin
		// Write
		if (wr)
			ram[wr_addr] <= din;
	end
	
//	always @ (posedge rd_clk)
//	begin
//		// Read 
//		if (rd)
//			dout <= ram[rd_addr];
//		else
//			dout <= 8'h00;
//	end
	
	
	assign dout = (rd)?ram[rd_addr]:8'h00;
	//assign dout = ram[rd_addr];
	
//	always @(wr_clk) begin
//		case ({rd, wr})
//			2'b00: count <= count;
//			2'b01://Write
//					count <= wr_addr;
//			2'b10://Read
//					count <= rd_addr;
//			2'b11://Write & Read
//				count <= count;
//		endcase
//	end
	
	
endmodule


