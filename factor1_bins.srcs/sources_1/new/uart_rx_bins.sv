`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2020 13:05:22
// Design Name: 
// Module Name: uart_rx_bins
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


module uart_rx_bins #
(
	parameter CLOCK_FREQUENCY = 50_000_000,
	parameter BAUD_RATE       = 115200
)
(
	input  clockIN,
	input  nRxResetIN,
	input  rxIN, 
	output wire rxIdleOUT,
	output wire rxReadyOUT,
	output wire [7:0] rxDataOUT
);

localparam HALF_BAUD_CLK_REG_VALUE = (CLOCK_FREQUENCY / BAUD_RATE / 2 - 1);
localparam HALF_BAUD_CLK_REG_SIZE  = $clog2(HALF_BAUD_CLK_REG_VALUE);

reg [HALF_BAUD_CLK_REG_SIZE-1:0] rxClkCounter = 0;
reg rxBaudClk = 1'b0;
//reg [9:0] rxReg = 10'h000;
reg [3:0] rx_st=0;

//for parity odd
reg [10:0] rxReg = 11'h000;

wire rx = rxIN;

//reg clk_12_5Mhz = 1'b0;
//reg [3:0] cnt_12_5Mhz=0;

assign rxIdleOUT      = ~rxReg[0];
//assign rxReadyOUT     = rxReg[9] & rxIdleOUT;
assign rxDataOUT[7:0] = rxReg[8:1];
//assign rxReadyOUT     = rxReg[10] & rxIdleOUT;
assign rxReadyOUT     = (rx_st==10)?1'b1:1'b0;

//initial begin
//	rxDataOUT<=0;
//end

/*
RXMajority3Filter rxFilter
(
	.clk(clockIN),
	.in(rxIN),
	.out(rx)
);*/

always @(posedge clockIN) begin : rx_clock_generate
//	if(rx & rxIdleOUT) begin
//		rxClkCounter <= HALF_BAUD_CLK_REG_VALUE;
//		rxBaudClk    <= 0;
//	end
	if(rxClkCounter == 0) begin
		rxClkCounter <= HALF_BAUD_CLK_REG_VALUE;
		rxBaudClk    <= ~rxBaudClk;
	end
	else begin
		rxClkCounter <= rxClkCounter - 1'b1;
	end
	
	
// 	case(cnt_12_5Mhz)
//         
//         1: begin
//             cnt_12_5Mhz<=0;
//             clk_12_5Mhz<=~clk_12_5Mhz;
//         end
//         
//         default: cnt_12_5Mhz<=cnt_12_5Mhz+1;
// 	
// 	endcase
	
end

always @(posedge rxBaudClk or negedge nRxResetIN) begin : rx_receive
	if(~nRxResetIN) begin
		//rxReg <= 10'h000;
		rxReg <=11'h000;
		rx_st <=0;
	end
	else begin
		case(rx_st)
			0: begin
				if(~rx) begin	//START
					//rxDataOUT<=rxReg[8:1];
					rxReg <={rx,10'h000};
					//rxReg[0]<=rx;
					rx_st<=rx_st+1;
					//rxReg <= 11'h000;
				end
			end
			
			1: begin
				rxReg[1]<=rx;
				rx_st<=rx_st+1;
			end
			
			2: begin
				rxReg[2]<=rx;
				rx_st<=rx_st+1;
			end
			
			3: begin
				rxReg[3]<=rx;
				rx_st<=rx_st+1;
			end
			
			4: begin
				rxReg[4]<=rx;
				rx_st<=rx_st+1;
			end
			
			5: begin
				rxReg[5]<=rx;
				rx_st<=rx_st+1;
			end
			
			6: begin
				rxReg[6]<=rx;
				rx_st<=rx_st+1;
			end
			
			7: begin
				rxReg[7]<=rx;
				rx_st<=rx_st+1;
			end
			
			8: begin
				rxReg[8]<=rx;
				rx_st<=rx_st+1;
			end
			
			9: begin
				rxReg[9]<=rx; //PARITY
				rx_st<=rx_st+1;
			end
			
			10: begin
				rxReg[10]<=rx; //STOP
				rx_st<=0;
			end
			
			default: rx_st<=0;
		endcase
	end
	
	
//	else if(~rx) begin
//		//rxReg <= 10'h1FF;
//		rxReg <= 11'h3FF;
//	end
//	else if(~rxIdleOUT) begin
//		//rxReg <= {rx, rxReg[9:1]};
//		rxReg <= {rx, rxReg[10:1]};
//	end
//	else if(~rx) begin
//		//rxReg <= 10'h1FF;
//		rxReg <= 10'h3FF;
//	end
end



/*
ila_bins ila_bins_rx
( 
    .clk        (clk_12_5Mhz),     
    .probe0     (rxBaudClk),    //clk uart
    .probe1     (rx),           //majority filter out
    .probe2     (rxIdleOUT),    //1bit
    .probe3     (rxReadyOUT),   //1bit
    .probe4     (rxDataOUT),    //data 8bit
    .probe5     (rx_st)         //rx state 4bit
);*/


endmodule

