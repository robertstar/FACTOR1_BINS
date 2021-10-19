`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2020 13:06:41
// Design Name: 
// Module Name: uart_tx_bins
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


module uart_tx_bins #
(
	parameter CLOCK_FREQUENCY = 125_000_000, //50_000_000,
	parameter BAUD_RATE       = 115200,
	parameter PARITY 		  = 2'b01 		// OFF ->PARITY = 2'b00; ODD -> PARITY = 2'b01; EVEN -> PARITY = 2'b10; 
)
(
	input  clockIN,
	input  nTxResetIN,
	input  [7:0] txDataIN,
	input  txLoadIN,
	output wire txIdleOUT,
	output wire txReadyOUT,
	output reg txOUT
);

localparam HALF_BAUD_CLK_REG_VALUE = (CLOCK_FREQUENCY / BAUD_RATE / 2 - 1);
localparam HALF_BAUD_CLK_REG_SIZE  = $clog2(HALF_BAUD_CLK_REG_VALUE);

//localparam HALF_BAUD_CLK_REG_VALUE = (CLOCK_FREQUENCY / BAUD_RATE);
//localparam HALF_BAUD_CLK_REG_SIZE  = $clog2(HALF_BAUD_CLK_REG_VALUE);

reg [HALF_BAUD_CLK_REG_SIZE-1:0] txClkCounter = 0;
reg txBaudClk        = 1'b0;
//reg [9:0] txReg     = 10'h001;
reg [3:0]  txCounter = 4'h0; 
//reg [10:0] txReg     = 11'h001; //for parity
reg [7:0] tx_temp=8'h00;
//reg [2:0] bitpos = 3'h0;

reg parity=0;
initial begin
	txOUT <= 1'b1;
	case(PARITY)
		1:   parity<=1;//ODD
		0,2: parity<=0;//EVEN
	endcase
end

assign txReadyOUT = !txCounter[3:0];
assign txIdleOUT  = txReadyOUT & (~txCounter[0]);
//assign txOUT      = txReg[0];

always @(posedge clockIN) begin : tx_clock_generate
	if(txIdleOUT & (~txLoadIN)) begin
		txClkCounter <= 0;
		txBaudClk    <= 1'b0;
	end
	if(txClkCounter == 0) begin
		txClkCounter <= HALF_BAUD_CLK_REG_VALUE;
		txBaudClk    <= ~txBaudClk;
	end
	else begin
		txClkCounter <= txClkCounter - 1'b1;
	end
end

always @(posedge txBaudClk or negedge nTxResetIN or posedge txLoadIN) begin : tx_transmit
	if(~nTxResetIN) begin
		txCounter <=4'h0;
		tx_temp   <=8'd0;
		txOUT     <=1'b1;
        case(PARITY)
            1:   parity<=1;//ODD
            0,2: parity<=0;//EVEN
        endcase
	end
	else if(txLoadIN) begin
		tx_temp	<=txDataIN[7:0];
		txCounter<=4'hC;
	end
	else if(~txReadyOUT) begin
		//txReg     <= {1'b0, txReg[9:1]};
		case(txCounter)
			4'hC: txOUT<=1'b0;
			4'hB: begin txOUT<=tx_temp[0]; if(tx_temp[0]) parity <= !parity; end
			4'hA: begin txOUT<=tx_temp[1]; if(tx_temp[1]) parity <= !parity; end
			4'h9: begin txOUT<=tx_temp[2]; if(tx_temp[2]) parity <= !parity; end
			4'h8: begin txOUT<=tx_temp[3]; if(tx_temp[3]) parity <= !parity; end
			4'h7: begin txOUT<=tx_temp[4]; if(tx_temp[4]) parity <= !parity; end
			4'h6: begin txOUT<=tx_temp[5]; if(tx_temp[5]) parity <= !parity; end
			4'h5: begin txOUT<=tx_temp[6]; if(tx_temp[6]) parity <= !parity; end
			4'h4: begin txOUT<=tx_temp[7]; if(tx_temp[7]) parity <= !parity; end
			4'h3: begin txOUT<=parity; parity<=1; end
			default: txOUT<=1'b1; 
		endcase
		txCounter <= txCounter - 1'b1;
	end
	else begin
		txCounter<=4'h0;
		txOUT<=1'b1; 
	end
end

endmodule

