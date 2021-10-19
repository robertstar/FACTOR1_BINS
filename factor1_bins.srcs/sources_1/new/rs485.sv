`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.01.2020 07:57:39
// Design Name: 
// Module Name: rs485
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


module rs485_dfs
(
	input  wire        clk_50Mhz,
	
	input  wire        serial_in,
	output wire        serial_out,
	output wire        serial_rse,
	
	//RX
	input  wire        fifo_rx_rd_clk,
	input  wire        fifo_rx_rd_en,
	output wire [7:0]  fifo_rx_dout,
	output wire [9:0]  fifo_rx_rd_data_count,
	output wire        fifo_rx_eop,
	
	//TX
	input  wire        fifo_tx_wr_clk,
	input  wire [7:0]  fifo_tx_din,
	input  wire        fifo_tx_wr_en
);

parameter speed = 9600;

wire rxclk_en;
wire txclk_en;
wire rdy;
wire rdy_clr;
wire serial_rx_st;
wire [7:0] rx_byte;
reg [7:0] tx_byte=0;
reg tx_en;
wire tx_busy;
wire serial_rdy;

reg         fifo_tx_rd_en=0;
wire        fifo_tx_full;
wire        fifo_tx_empty;
wire [7:0]  fifo_tx_dout;
wire [9:0]  fifo_tx_rd_data_count;
wire [9:0]  fifo_tx_wr_data_count;

wire        fifo_rx_wr_clk;
wire [7:0]  fifo_rx_din;
wire        fifo_rx_wr_en;
wire        fifo_rx_full;
wire        fifo_rx_empty;
wire [9:0]  fifo_rx_wr_data_count;

reg [3:0]  fifo_tx_state;
reg [7:0]  tx_count;
reg [31:0] ser1_delay;
reg [7:0]  tx_data [9:0]; 
reg [31:0] rcv_time;
reg        eop;

reg [15:0] timer_sw=0;
reg        drv=0;

initial begin
    fifo_tx_state   <=0;
    tx_count        <=0;
    tx_en           <=0;
    tx_byte         <=0;
    ser1_delay      <=0;
    rcv_time        <=0;
    eop             <=0;
end

assign fifo_rx_eop      = eop;
assign fifo_rx_wr_clk   = clk_50Mhz;
assign fifo_rx_wr_en    = serial_rdy & !tx_busy & drv;
assign fifo_rx_din      = rx_byte;

//assign rdy_clr          = (serial_rdy)?(1'b1):(1'b0);
assign serial_rse       = (tx_busy)?(1'b1):(1'b0);


/*    
baud_rate_gen #( .speed(speed)) baud_rate_gen_inst
(
    .clk_50Mhz  (clk_50Mhz),
    .rxclk_en   (rxclk_en),
    .txclk_en   (txclk_en)
);*/
    
//RXMajority3Filter rx_filter
//(
//    .clk        (clk_50Mhz),
//    .in         (serial_in),
//    .out        (serial_rx_st)
//);

/*serial_rx rx
(
    .clk_50Mhz  (clk_50Mhz),
    .clken      (rxclk_en),
    .rx         (serial_in),
    .rx_en      (!tx_busy),
    .rdy        (serial_rdy),
    .rdy_clr    (rdy_clr),
    .data       (rx_byte)
);*/


uart_rx_dfs uart_rx_dfs
(
    .i_Clock        (clk_50Mhz),
    .i_RX_Serial    (serial_in),
    .o_RX_DV        (serial_rdy),
    .o_RX_Byte      (rx_byte)
);

wire tx_done;

uart_tx_dfs uart_tx_dfs
(
    .i_Clock        (clk_50Mhz),
    .i_TX_DV        (tx_en),
    .i_TX_Byte      (tx_byte), 
    .o_TX_Active    (tx_busy),   //busy - active high 1
    .o_TX_Serial    (serial_out),
    .o_TX_Done      (tx_done)
);

/*
serial_tx tx
(
    .clk_50Mhz  (clk_50Mhz),
    .clken      (txclk_en),
    .din        (tx_byte),
    .wr_en      (tx_en),
    .tx         (serial_out),
    .tx_busy    (tx_busy)
);   
*/




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
    .rd_data_count  (fifo_rx_rd_data_count),            //: OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    .wr_data_count  (fifo_rx_wr_data_count)             //: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
);    

//1k fifo     
fifo_ser fifo_tx
(
    .wr_clk         (fifo_tx_wr_clk),                   //: IN STD_LOGIC;
    .rd_clk         (clk_50Mhz),                        //: IN STD_LOGIC;
    .din            (fifo_tx_din),                      //: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    .wr_en          (fifo_tx_wr_en & !fifo_tx_full),    //: IN STD_LOGIC;
    .rd_en          (fifo_tx_rd_en & !fifo_tx_empty),   //: IN STD_LOGIC;
    .dout           (fifo_tx_dout),                     //: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    .full           (fifo_tx_full),                     //: OUT STD_LOGIC;
    .empty          (fifo_tx_empty),                    //: OUT STD_LOGIC;
    .rd_data_count  (fifo_tx_rd_data_count),            //: OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    .wr_data_count  (fifo_tx_wr_data_count)             //: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
);  



//timer for reconect driver rs485
always@(posedge clk_50Mhz) begin 
    if(!tx_busy) begin
        if(timer_sw<62500) begin     //500 us
            timer_sw<=timer_sw+1;
        end
        else begin
            drv<=1;
        end  
    end
    else begin
        timer_sw<=0;
        drv<=0;
    end
end

//Timer
always@(posedge clk_50Mhz) begin 
    //if( serial_rdy & !tx_busy ) begin //Receive byte from RS485
    if(serial_rdy) begin //Receive byte from RS485
        rcv_time<=0;
        eop<=0;
    end
    else begin
        //if(rcv_time<32'd12500000) begin   //250 ms
        if(rcv_time<32'd260500) begin   //0.00520 s or 5 bytes time
            rcv_time<=rcv_time+1'b1;
            eop<=0;
        end
        else
            eop<=1;
    end
end




//***************************************************************************************//
// READ FROM TX FIFO & send to UART                                                     *//
//***************************************************************************************//
always@(posedge clk_50Mhz) begin 
    case(fifo_tx_state)
        0: begin    //IDLE
            tx_en           <=0;
            fifo_tx_rd_en   <=0;
            if( (fifo_tx_rd_data_count>0) && !tx_busy ) begin
                fifo_tx_rd_en<=1;
                fifo_tx_state<=1;
            end
        end
        
        1: begin    //Latency 1 clk for read from FIFO
            fifo_tx_state<=2;
        end

        2: begin
            tx_en        <=1;
            tx_byte      <=fifo_tx_dout;
            fifo_tx_rd_en<=0;
            fifo_tx_state<=3;
        end
        
        3: begin
            tx_en<=0;
            if(tx_busy)
                //fifo_tx_state<=0;
                fifo_tx_state<=4;
        end
        
        4: begin
            if(fifo_tx_rd_data_count>0) begin
                if(!tx_busy) begin
                    fifo_tx_rd_en<=1;
                    fifo_tx_state<=2;
                end
            end
            else
               fifo_tx_state<=5; 
        end
        
        5: begin //end bytes
            if(!tx_busy) begin
                tx_en        <=1;
                tx_byte      <=fifo_tx_dout;
                fifo_tx_state<=6; 
            end
        end
        
        6: begin
            tx_en<=0;
            if(tx_busy)
                fifo_tx_state<=0;
        end
        
        default: fifo_tx_state<=0;
    endcase  
end

/*
ila_dfs ila_dfs_dbg
(
   .clk        (clk_50Mhz),
   .probe0     (serial_rdy),         //1
   .probe1     (rx_byte),            //8
   .probe2     (),                   //12
);*/




//ila_1 ila_dbg
//(
//    .clk        (clk_125Mhz),
//    .probe0     (fifo_rx_wr_en),            //1
//    .probe1     (fifo_rx_din),              //8
//    .probe2     (fifo_rx_wr_data_count),    //12
    
//    .probe3     (fifo_tx_state),            //4
    
//    .probe4     (fifo_rx_rd_en),            //1
//    .probe5     (fifo_rx_dout),             //8
//    .probe6     (fifo_rx_rd_data_count),    //12
    
//    .probe7     (tx_en),                    //1
//    .probe8     (tx_busy)                   //1
//);

//ila_1 ila_dbg
//(
//    .clk        (clk_125Mhz),
//    .probe0     (fifo_tx_wr_en),            //1
//    .probe1     (fifo_tx_din),              //8
//    .probe2     (fifo_tx_wr_data_count),    //12
    
//    .probe3     (fifo_tx_state),            //4
    
//    .probe4     (fifo_tx_rd_en),            //1
//    .probe5     (fifo_tx_dout),             //8
//    .probe6     (fifo_tx_rd_data_count),    //12
    
//    .probe7     (tx_en),                    //1
//    .probe8     (tx_busy)                   //1
//);


endmodule








//    case(fifo_tx_state)
//        0:begin
//           serial_rse       <=0;
//           tx_count         <=0;
//           tx_en            <=0;
//           //tx_data          <= {"H","E","L","L","O","!","\r","\n"};
//           fifo_tx_state    <=1;
           
           
////           tx_data[79:72] <= 8'hA1;
////           tx_data[71:64] <= 8'hB2;
////           tx_data[63:56] <= 8'hC3;
////           tx_data[55:48] <= 8'hD4;
////           tx_data[47:40] <= 8'hE5;
////           tx_data[39:32] <= 8'hF6;
////           tx_data[31:24] <= 8'h01;
////           tx_data[23:16] <= 8'h23;
////           tx_data[15:8]  <= 8'h45;
////           tx_data[7:0]   <= 8'h67;

//           tx_data[0] <= "H";
//           tx_data[1] <= "E";
//           tx_data[2] <= "L";
//           tx_data[3] <= "L";
//           tx_data[4] <= "O";
//           tx_data[5] <= "!";
//           tx_data[6] <= "\r";
//           tx_data[7] <= "\n";
           
//           //tx_data[8] <= 8'h38;
//           //tx_data[9] <= 8'h39;
//        end
        
//        1:begin
//           if(tx_busy)
//               tx_en    <=1'b0;
//           else begin
//               serial_rse   <=1;
//               tx_en        <=1'b1;
//               tx_byte      <=tx_data[tx_count];//80
//               if(tx_count<=8'd7)
//                   fifo_tx_state<=4'd2;
//               else 
//                   fifo_tx_state<=4'd3; 
//           end        
//        end
        
//        2:begin
//           tx_count      <=tx_count+1;
//           //tx_data       <={tx_data[71:0],8'h00};
//           fifo_tx_state <=4'd1; 
//        end
        
//        3: begin
//            serial_rse  <=0;
//            tx_en       <=1'b0;
//            if(ser1_delay<125000000) begin
//                ser1_delay<=ser1_delay+1;
//            end
//            else begin
//                ser1_delay<=0;
//                fifo_tx_state<=4'd0;
//            end 
//        end
        
//        default:fifo_tx_state<=4'd0;	
//	endcase
	
//end

//endmodule
