`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2020 13:07:54
// Design Name: 
// Module Name: rs485_bins
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


module rs485_bins
(
	input  wire        	clk_125Mhz,
	
	input  wire        	serial_in,
	output wire        	serial_out,
	output wire        	serial_rse,

	//RX
	input  wire        	fifo_rx_rd_clk,
	input  wire        	fifo_rx_rd_en,
	output wire [7:0]  	fifo_rx_dout,
	output wire [9:0]  	fifo_rx_rd_data_count,
	
	//TX
	input  wire        	fifo_tx_wr_clk,
	input  wire [7:0]  	fifo_tx_din,
	input  wire        	fifo_tx_wr_en,
	
	output wire [7:0]   dbg_rx_byte,
	output wire         dbg_serial_rdy
	
);


wire [7:0] 	rx_byte;
reg  [7:0] 	tx_byte=0;
reg 		tx_en;
wire 		tx_busy;

reg         fifo_tx_rd_en=0;
wire        fifo_tx_full;
wire        fifo_tx_empty;
wire [7:0]  fifo_tx_dout;
wire [9:0]  fifo_tx_rd_data_count;
wire [9:0]  fifo_tx_wr_data_count;

wire        fifo_rx_wr_clk;
reg  [7:0]  fifo_rx_din=0;
wire        fifo_rx_full;
wire        fifo_rx_empty;
wire [9:0]  fifo_rx_wr_data_count;
reg         fifo_rx_wr_en=0;
reg [3:0]  	fifo_tx_state;

initial begin
	fifo_tx_state  <=0;
	tx_en          <=0;
	tx_byte        <=0;
end

assign fifo_rx_wr_clk   = clk_125Mhz;
assign serial_rse		= (~tx_busy)?(1'b1):(1'b0);

wire rx_done;
wire rx_busy;
wire serial_rdy;

/*
uart_rx_bins uart_rx_inst
(
	.clockIN		(clk_50Mhz),
	.nRxResetIN		(1'b1),
	.rxIN			(serial_in), 
	.rxIdleOUT		(rx_busy),
	.rxReadyOUT		(rx_done),
	.rxDataOUT		(rx_byte)
);*/


UART_RX uart_rx_inst
(
    .i_Clock        (clk_125Mhz),
    .i_RX_Serial    (serial_in),
    .o_RX_DV        (serial_rdy),
    .o_RX_Byte      (rx_byte)
);

assign dbg_rx_byte      = rx_byte;
assign dbg_serial_rdy   = serial_rdy;

//************************************************************************************************//
//sync & write to fifo
reg [3:0] write_st=0;
reg [7:0] write_cnt=0;
reg [1:0] rdy_st=0;
//reg serial_rdy=0;
reg [7:0] sync=0;
reg [3:0] sync_st=0;

//READ from UART & WRITE to FIFO
always@(posedge clk_125Mhz) begin

	//25.08.2020_13:19
	case(write_st)
		0: begin
			case(serial_rdy)
                0: fifo_rx_wr_en<=0;
                1: begin
                    case(sync_st)
                    
                        0: begin
                            if(rx_byte!=8'hC1)
                                sync_st<=0;
                            else
                                sync_st<=sync_st+1; 
                        end
                        
                        1: begin
                            if(rx_byte!=8'hC1)
                                sync_st<=0; 
                            else begin
                                sync_st<=sync_st+1; 
                                fifo_rx_wr_en<=1;
                                fifo_rx_din  <=8'hC1;//rx_byte;
                                write_cnt<=write_cnt+1'b1;
                                write_st<=write_st+1'b1;
                            end
                        end
                        
                        //default: sync_st<=0;
                    endcase  
                end
			endcase	
		end
		
		1: begin
            sync_st     <=0;
			fifo_rx_din <=8'hC1;//rx_byte;         
			write_cnt   <=write_cnt+1'b1;
			write_st    <=write_st+1'b1;
		end
		
		2: begin
			case(serial_rdy)
                0: begin
                    fifo_rx_wr_en<=0;
                    case(write_cnt)
                        50: begin
                            write_cnt<=0;
                            write_st<=0;
                        end
                    endcase
                end
                1: begin
                    fifo_rx_wr_en<=1;
                    fifo_rx_din<=rx_byte;
                    write_cnt<=write_cnt+1'b1;
                end
			endcase
		end
		
		default: write_st<=0;
	endcase
	//************************************************************************************//
	
end


//fifo_ser fifo_rx
//(
//	.rdclk			(fifo_rx_rd_clk),
//	.rdreq			(fifo_rx_rd_en & !fifo_rx_empty),
//	.rdempty		(fifo_rx_empty),
//	.rdusedw		(fifo_rx_rd_data_count),

	
//	.wrclk			(fifo_rx_wr_clk),
//	.wrreq			(fifo_rx_wr_en & !fifo_rx_full),
//	.wrfull			(fifo_rx_full),
	
//	.data			(fifo_rx_din),
//	.q				(fifo_rx_dout)
//);





//1k fifo   
fifo_ser fifo_rx
(
    .wr_clk         (fifo_rx_wr_clk),                   //: IN STD_LOGIC;
    .rd_clk         (fifo_rx_rd_clk),                   //: IN STD_LOGIC;
    .din            (fifo_rx_din),                      //: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    .wr_en          (fifo_rx_wr_en & !fifo_rx_full),    //: IN STD_LOGIC;
    .rd_en          (fifo_rx_rd_en & !fifo_rx_empty),   //: IN STD_LOGIC;
    .dout           (fifo_rx_dout),                     //: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    .full           (fifo_rx_full),                     //: OUT STD_LOGIC;
    .empty          (fifo_rx_empty),                    //: OUT STD_LOGIC;
    .rd_data_count  (fifo_rx_rd_data_count),            //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    .wr_data_count  (fifo_rx_wr_data_count)             //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
); 


/*
ila_bins ila_bins_rx
( 
    .clk        (fifo_rx_wr_clk),     
    .probe0     (serial_rdy),               //1  
    .probe1     (rx_byte),                  //8
    .probe2     (fifo_rx_rd_en),            //1
    .probe3     (fifo_rx_dout),             //8
    .probe4     (fifo_rx_wr_data_count),    //10
    .probe5     (fifo_rx_rd_data_count)     //10
);*/

//     .probe6     (serial_rdy),               //1
//     .probe7     (write_st),                 //4
//     .probe8     (sync_st),                  //4
//     .probe9     (write_cnt)                 //8



wire tx_ready;


uart_tx_bins uart_tx_inst
(
	.clockIN		(clk_125Mhz),
	.nTxResetIN		(1'b1),
	.txDataIN		(tx_byte),
	.txLoadIN		(tx_en),
	.txIdleOUT		(tx_busy), //active tx -> tx_busy -> low; idle -> high
	.txReadyOUT		(tx_ready),
	.txOUT			(serial_out)
);

reg [3:0]  send_st=0;
reg [31:0] timer_10ms=0;
reg [31:0] timer_100ms=0;
reg [31:0] timer_1s=0;
reg [7:0]  send_cnt=8'd0;


//test send to uart
//always@(posedge clk_50Mhz) begin
//	case(send_st)
//		
//		0: begin
//			tx_byte<=tx_byte+1'b1;
//			//tx_byte<=8'hA7;
//			tx_en<=1'b1;
//			send_st<=send_st+1;
//		end
//		
//		1: begin
//			tx_en<=1'b0;
//			send_st<=send_st+1;
//		end
//		
//		2: begin
//			if(tx_ready)
//				send_st<=send_st+1;
//		end
//		
//		3: begin //delay 0.1 seconds
//			if(timer_100ms<32'd5000000)
//				 timer_100ms<=timer_100ms+1;
//			else begin
//				 timer_100ms<=0;
//				 send_st<=0;
//			end
//		end
//	
//	endcase
//end




//fifo_ser fifo_tx
//(
//	.rdclk			(clk_50Mhz),
//	.rdreq			(fifo_tx_rd_en & !fifo_tx_empty),
//	.data				(fifo_tx_din),
//	.rdempty			(fifo_tx_empty),
//	.rdusedw			(fifo_tx_rd_data_count),

//	.wrclk			(fifo_tx_wr_clk),
//	.wrreq			(fifo_tx_wr_en & !fifo_tx_full),
//	.wrfull			(fifo_tx_full),
//	.q					(fifo_tx_dout)
//);


//1k fifo     
fifo_ser fifo_tx
(
    .wr_clk         (fifo_tx_wr_clk),                   //: IN STD_LOGIC;
    .rd_clk         (clk_125Mhz),                       //: IN STD_LOGIC;
    .din            (fifo_tx_din),                      //: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    .wr_en          (fifo_tx_wr_en & !fifo_tx_full),    //: IN STD_LOGIC;
    .rd_en          (fifo_tx_rd_en & !fifo_tx_empty),   //: IN STD_LOGIC;
    .dout           (fifo_tx_dout),                     //: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    .full           (fifo_tx_full),                     //: OUT STD_LOGIC;
    .empty          (fifo_tx_empty),                    //: OUT STD_LOGIC;
    .rd_data_count  (fifo_tx_rd_data_count),            //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    .wr_data_count  (fifo_tx_wr_data_count)             //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
); 

//***************************************************************************************//
// READ FROM TX FIFO & send to UART                                                     *//
//***************************************************************************************//
always@(posedge clk_125Mhz) begin 
    case(fifo_tx_state)
        0: begin    //IDLE
            tx_en           <=0;
            fifo_tx_rd_en   <=0;
				if( (fifo_tx_rd_data_count>=42) && tx_busy ) begin //active tx -> tx_busy -> low; idle -> high
                fifo_tx_state<=1;
            end
        end
        
        1: begin
            send_cnt<=0;
            if(serial_rdy) begin
                fifo_tx_state<=2;
            end
            else begin //timeout 1s
                if(timer_1s<32'd50000000)
                        timer_1s<=timer_1s+1;
                else begin
                        timer_1s<=0;
                        fifo_tx_state<=2;
                end	 
            end
        end
        
        2: begin    //10ms delay
            if(timer_10ms<32'd500000)
                timer_10ms<=timer_10ms+1;
            else begin
                timer_10ms<=0;
                fifo_tx_state<=3;
                fifo_tx_rd_en<=1;
            end
        end
        
        3: begin    //Latency 1 clk for read from FIFO
            fifo_tx_state<=4;
        end

        4: begin
            tx_en        <=1;
            tx_byte      <=fifo_tx_dout;
            fifo_tx_rd_en<=0;
            fifo_tx_state<=5;
        end
        
        5: begin
            tx_en<=0;
            if(!tx_busy) begin
                send_cnt<=send_cnt+1'b1;
                fifo_tx_state<=6;
            end
        end
        
        6: begin
				if(send_cnt<8'd41) begin
					 if(tx_busy) begin
                    fifo_tx_rd_en<=1;
                    fifo_tx_state<=4;
                end
            end
            else begin
                send_cnt<=0;
                fifo_tx_state<=7; 
            end
        end
        
        7: begin //end bytes
				if(tx_busy) begin
                tx_en        <=1;
                tx_byte      <=fifo_tx_dout;
                fifo_tx_state<=8; 
            end
        end
        
        8: begin
            tx_en<=0;
				if(!tx_busy)
                fifo_tx_state<=0;
        end
        
        default: fifo_tx_state<=0;
    endcase  
end

endmodule




	//************************************************************************************//
	//Make Pulse
	/*case(rdy_st)
		0: begin
			if(rx_done) begin
				serial_rdy<=1'b1;
				rdy_st<=rdy_st+1'b1;
			end
		end
		1: begin
			serial_rdy<=1'b0;
			if(!rx_done)
				rdy_st<=0;
		end
		default: rdy_st<=0;
	endcase*/
	//************************************************************************************//
	
	
	//************************************************************************************//
	//SYNC 0xC1 0xC1
	/*case(write_st)
		0: begin
			fifo_rx_wr_en<=0;
			if(serial_rdy) begin
				sync <= rx_byte;
				if( {sync, rx_byte} == 16'hC1C1 ) begin
					fifo_rx_wr_en<=1;
					fifo_rx_din  <=8'hC1;//rx_byte;
					sync         <=0;
					write_cnt<=write_cnt+1'b1;
					write_st<=write_st+1'b1;
				end
			end  
		end
		1: begin
			fifo_rx_din <=8'hC1;//rx_byte;         
			write_cnt   <=write_cnt+1'b1;
			write_st    <=write_st+1'b1;
		end
		2: begin
			fifo_rx_wr_en<=0;
			if(serial_rdy) begin
				case(write_cnt)
					49: begin
						fifo_rx_wr_en<=1;
						fifo_rx_din<=rx_byte;
						write_cnt<=0;
						write_st<=0;
					end
					default: begin
						fifo_rx_wr_en<=1;
						fifo_rx_din<=rx_byte;
						write_cnt<=write_cnt+1'b1;
					end
				 endcase  
			end    
		end
		default: write_st<=0;
	endcase*/
