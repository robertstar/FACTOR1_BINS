`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2020 16:03:19
// Design Name: 
// Module Name: skp_tx
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


module skp_tx
(
    input  wire         clk_50Mhz,
    input  wire         clken,
    input  wire         wr_en,
    output reg          tx,
    output wire         tx_busy,
    
    output wire [1:0]   tx_state,
    output wire [7:0]   tx_addr
);

initial begin
	 tx = 1'b1;
end

parameter  STATE_IDLE	= 2'b00;
parameter  STATE_SEND	= 2'b01;

reg [1:0]  state = STATE_IDLE;
reg [7:0]  uart_data_addr;	
reg [72:0] uart_shift;

//parameter  uart_data = 73'b1111_0_01001010_110_00100100_010_01100000_010_00000000_010_11001010_010_11101100_0_1111;  //ADDR - 0x52
parameter    uart_data = 73'b1111_0_10001010_110_00100100_010_01100000_010_00000000_010_11001010_010_11001110_0_1111;  //ADDR - 0x51

assign tx_state = state;
assign tx_addr  = uart_data_addr;

always @(posedge clk_50Mhz) begin
	case (state)
        
        STATE_IDLE: begin
            if (wr_en) begin
                state           <= STATE_SEND;
                uart_shift      <= uart_data;
                uart_data_addr  <= 0;
            end
        end
        
        STATE_SEND: begin
            if (clken) begin
                if(uart_data_addr != 73) begin
                    uart_data_addr <= uart_data_addr + 1;
                    tx <= uart_shift[72];
                    uart_shift <= uart_shift << 1;
                end
                else begin
                    uart_data_addr <= 0;
                    tx <= 1;
                    uart_shift <= uart_data;
                    state <= STATE_IDLE;
                end
            end
        end
        
        default: begin
            tx <= 1'b1;
            state <= STATE_IDLE;
        end
	endcase
end

assign tx_busy = (state != STATE_IDLE);


endmodule
