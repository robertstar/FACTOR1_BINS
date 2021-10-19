`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2020 16:18:15
// Design Name: 
// Module Name: rs485_skp
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


module rs485_skp
(
    input  wire        clk_50Mhz,
    //input  wire        clk_125Mhz,
    input  wire        serial_in,
    output wire        serial_out,
    output wire        serial_rse,
    
    //RX
    input  wire        fifo_rx_rd_clk,
    input  wire        fifo_rx_rd_en,
    output wire [7:0]  fifo_rx_dout,
    output wire [11:0] fifo_rx_rd_data_count,
    output wire        fifo_rx_eop
    
    //TX
//    input  wire        fifo_tx_wr_clk,
//    input  wire [7:0]  fifo_tx_din,
//    input  wire        fifo_tx_wr_en
);

parameter   speed = 57600;

wire        rxclk_en;
wire        txclk_en;
wire        rdy;
wire        rdy_clr;
wire        serial_rx_st;
wire [7:0]  rx_byte;
reg         tx_en;
wire        tx_busy;
//wire        serial_rdy;

reg         serial_rdy=0;


reg         fifo_tx_rd_en=0;
wire        fifo_tx_full;
wire        fifo_tx_empty;
wire [7:0]  fifo_tx_dout;
wire [11:0] fifo_tx_rd_data_count;
wire [11:0] fifo_tx_wr_data_count;

wire [1:0]   tx_state;
wire [7:0]   tx_addr;

reg [31:0] rcv_time;
reg        eop;

initial begin
    //fifo_tx_state   <=0;
    //tx_count        <=0;
    tx_en           <=0;
    //ser1_delay      <=0;
    rcv_time        <=0;
    eop             <=0;
end

assign rdy_clr     = (serial_rdy)?(1'b1):(1'b0);
assign serial_rse  = (tx_busy)?(1'b1):(1'b0);
assign fifo_rx_eop = eop;


//Timer
always@(posedge clk_50Mhz) begin 
    if( serial_rdy & !tx_busy ) begin //Receive byte from RS485
        rcv_time<=0;
        eop<=0;
    end
    else begin
        //if(rcv_time<32'd31250000) begin   //250 ms
        //if(rcv_time<32'd1250000) begin    //25 ms
        if(rcv_time<32'd500000) begin       //10 ms
            rcv_time<=rcv_time+1;
            eop<=0;
        end
        else
            eop<=1;
    end
end

    
baud_rate_gen #( .speed(speed)) baud_rate_gen_inst
(
    .clk_50Mhz  (clk_50Mhz),
    .rxclk_en   (rxclk_en),
    .txclk_en   (txclk_en)
);
    
//RXMajority3Filter rx_filter
//(
//    .clk        (clk_125Mhz),
//    .in         (serial_in),
//    .out        (serial_rx_st)
//);

//serial_rx rx
//(
//    .clk_125Mhz (clk_125Mhz),
//    .clken      (rxclk_en),
//    .rx         (serial_rx_st),
//    .rx_en      (!tx_busy),
//    .rdy        (serial_rdy),
//    .rdy_clr    (rdy_clr),
//    .data       (rx_byte)
//);

skp_tx tx
(
    .clk_50Mhz  (clk_50Mhz),
    .clken      (txclk_en),
    .wr_en      (tx_en),
    .tx         (serial_out),
    .tx_busy    (tx_busy),
    .tx_state   (tx_state),
    .tx_addr    (tx_addr)
);


wire        fifo_rx_wr_clk;
//wire [7:0]  fifo_rx_din;
//wire        fifo_rx_wr_en;
wire        fifo_rx_full;
wire        fifo_rx_empty;
wire [11:0] fifo_rx_wr_data_count;

reg [9:0] uart_period_rx=0;
reg [7:0] data_rx=0;
reg [2:0] bit_rx_nn=0;
reg [3:0] rx_state=0;

parameter rx_idle               = 0;
parameter rx_start_data_low     = 1;
parameter rx_start_data_high    = 2;
parameter rx_start_data_delay   = 3;
parameter rx_receive            = 4;


assign fifo_rx_wr_clk = clk_50Mhz;
//assign fifo_rx_wr_en  = serial_rdy & !tx_busy;
//assign fifo_rx_din    = data_rx;//rx_byte;

reg [7:0]  fifo_rx_din;
reg        fifo_rx_wr_en=0;

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

//************************************************************************************************//
//sync & write to fifo
reg [3:0] write_st=0;
reg [7:0] write_cnt=0;
reg [31:0] sync=0;

always@(posedge clk_50Mhz) begin
    case(write_st)
        0: begin
            fifo_rx_wr_en<=0;
            if(serial_rdy) begin
                sync <= {sync[23:0], data_rx};
                //if( {sync[23:0], data_rx} == 32'h52241300 ) begin
                if( {sync[23:0], data_rx} == 32'h51241300 ) begin
                    fifo_rx_wr_en<=1;
                    //fifo_rx_din  <=8'h52;
                    fifo_rx_din  <=8'h51;
                    sync         <=0;
                    write_cnt<=write_cnt+1;
                    write_st<=write_st+1;
                end
            end  
        end
        
        1: begin
            fifo_rx_din <=8'h24;        
            write_cnt   <=write_cnt+1;
            write_st    <=write_st+1;
        end
        
        2: begin
            fifo_rx_din <=8'h13;       
            write_cnt   <=write_cnt+1;
            write_st    <=write_st+1;
        end
        
        3: begin
            fifo_rx_din <=8'h00;       
            write_cnt   <=write_cnt+1;
            write_st    <=write_st+1;
        end
        
        4: begin
            fifo_rx_wr_en<=0;
            if(serial_rdy) begin
            
                case(write_cnt)

                    18: begin
                        fifo_rx_wr_en<=1;
                        fifo_rx_din<=data_rx;
                        //write_cnt<=write_cnt+1;
                        write_cnt<=0;
                        write_st<=0;
                    end
                    
                    default: begin
                        fifo_rx_wr_en<=1;
                        fifo_rx_din<=data_rx;
                        write_cnt<=write_cnt+1;
                    end
                    
                endcase  
            end    
        end
        
        default: write_st<=0;
 
    endcase
end



always@(posedge clk_50Mhz) begin 
    if(!tx_busy)begin
        case(rx_state)
    
            rx_idle: begin  
                serial_rdy<= 0;
                if(serial_in) begin
                   uart_period_rx <= uart_period_rx + 1; 
                   if(uart_period_rx == 800)   rx_state <= rx_start_data_low;
//                 if(uart_period_rx == 29)   rx_state <= rx_start_data_low;
                end
            end
                             
            rx_start_data_low: begin   
                if(uart_period_rx != 819)   uart_period_rx <= uart_period_rx + 1;
//              rx_start_data_low:   if(uart_period_rx != 39)   uart_period_rx <= uart_period_rx + 1;
                else begin
                    uart_period_rx <= 0;	 
                    rx_state <= rx_start_data_high;
                end
            end
                             
            rx_start_data_high: begin   
                if(!serial_in) begin
                    uart_period_rx <= uart_period_rx + 1;
                    if(uart_period_rx == 800)   rx_state <= rx_start_data_delay;
//                  if(uart_period_rx == 29)   rx_state <= rx_start_data_delay;
                end
            end
                                            
            rx_start_data_delay: begin   
                if(uart_period_rx != 819)   uart_period_rx <= uart_period_rx + 1;
//              rx_start_data_delay:   if(uart_period_rx != 39)   uart_period_rx <= uart_period_rx + 1;
                else begin
                    uart_period_rx <= 0;
                    rx_state <= rx_receive;
                end
            end
                                                
            rx_receive: begin   
                if(uart_period_rx != 819)   uart_period_rx <= uart_period_rx + 1;
//              rx_receive:   if(uart_period_rx != 39)   uart_period_rx <= uart_period_rx + 1;
                else begin
                    uart_period_rx <= 0;
                    if(bit_rx_nn != 7)   bit_rx_nn <= bit_rx_nn + 1;
                    else begin 
                        bit_rx_nn   <= 0;
                        rx_state    <= rx_idle;
                        serial_rdy  <=1;
                    end
                    data_rx[7]   <= serial_in;
                    data_rx[6:0] <= data_rx[7:1];  
                end
            end
              
            default: rx_state <= rx_idle;  
        endcase
    end
    
    else begin
        serial_rdy      <= 0;
        uart_period_rx  <= 0;
        bit_rx_nn       <= 0;
        rx_state        <= rx_idle;
        data_rx         <= 0;
    end

end



//ila_1 ila_dbg
//(
//    .clk        (clk_125Mhz),
    
//    .probe0     (serial_rdy), //1
//    .probe1     (rx_byte),    //8
//    .probe2     (tx_busy),    //1
//    .probe3     (tx_en),      //1
//    .probe4     (serial_out), //1
//    .probe5     (tx_state),   //2
//    .probe6     (tx_addr),    //8
    
//    .probe7     (fifo_rx_din),//8
//    .probe8     (fifo_rx_wr_en),//1
//    .probe9     (fifo_rx_rd_en),//1
//    .probe10    (fifo_rx_dout),//8
//    .probe11    (fifo_rx_rd_data_count),//12
//    .probe12    (fifo_rx_wr_data_count)//12
//);



reg [3:0]  skp_tx_state;
reg [31:0] delay;
reg [7:0]  tx_data [9:0]; 

initial begin
    skp_tx_state <=0;
    tx_en        <=0;
    delay        <=0;
end

//send to skp comm
always@(posedge clk_50Mhz) begin 

    case(skp_tx_state)
    
        0: begin
            tx_en<=1;
            skp_tx_state<=skp_tx_state+1;
        end
        
        1: begin
            tx_en<=0;
            skp_tx_state<=skp_tx_state+1;
        end
        
        2: begin
//            if(delay<50000000) begin  // 1  packet per second
            //if(delay<2500000) begin   // 20 packet per second
            if(delay<1000000) begin     // 50 packet per second
                delay<=delay+1;
            end
            else begin
                delay<=0;
                skp_tx_state<=0;
            end
        end
        
        default: begin
            skp_tx_state<=0;
        end
    
    endcase

end



endmodule
