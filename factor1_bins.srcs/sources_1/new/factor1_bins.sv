`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2019 08:47:34
// Design Name: 
// Module Name: factor
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


module factor1_bins
(
    input               sys_clk,
    input               sys_rst_n,
    output              led_1,
    
    input               envelope,
    
    //Ethernet PHY RTL8211
    inout               PHY_MDIO,             
    output              PHY_MDC,
    input               PHY_RXC,    
    input               PHY_RXDV,    
    input               PHY_RXER,
    input  [7:0]        PHY_RXD,
    input               PHY_TXC,           
    output              PHY_GTXC,   
    output              PHY_TXEN, 
    output              PHY_TXER,                     
    output [7:0]        PHY_TXD,
    output              PHY_RESET_N,
    
    output reg rk_o,
    output reg ru_o,
    
    //************************************************************
    //ADC
    output reg rst_adc_o,
    output reg conv_o,
    output reg clk_adc_o,
    output reg [7:0] cs_o,
    input [15:0] adc_data_1_i,
    input [15:0] adc_data_2_i,
    
    //************************************************************
    //RS485-1
    input   ser1_rx, 
    output  ser1_tx, 
    output  ser1_rse,
    
    //************************************************************
    //RS485-2
    input   ser2_rx, 
    output  ser2_tx, 
    output  ser2_rse,
    
    //************************************************************
    //DDS
    output dds_rst,
    output dds_sclk, 
    output dds_upd, 
    output dds_data,
    
    //************************************************************
    //DAC
    output bclk,
    output lrck,
    output ddata
    
    //output trigger_out
       
);

reg r_led;
reg [31:0] count;

reg  clk_1024Hz;
reg  clk_1Mhz;
reg  clk_5Mhz;
//reg  dac_clk;

//reg  [31:0] dac_cnt;
reg  [31:0] pause_cnt;
reg  [31:0] byte_cnt;
reg  [7:0]  test_byte;

reg			adc_ok;
reg [3:0]	adc_state;
reg [31:0]	adc_timer;
reg [7:0] 	adc_data;
reg 	    ad_done;
reg [3:0]	fd_st;

reg         conv_start_o;

//APO
reg 		    apo_rd;
wire [7:0] 	    apo_dout;
wire 		    apo_empty;
wire [7:0]	    apo_cnt;

//VARU
reg 		    varu_rd;
wire [7:0] 	    varu_dout;
wire 		    varu_empty;
wire [9:0]	    varu_rd_cnt;

reg  [11:0]	adc_wr_addr;
reg			adc_wr_en;


wire            clk_10Mhz;
wire            clk_50Mhz;
wire            clk_125Mhz;
wire            clk_160Mhz;
wire            adc_clk;

reg [31:0]    test_cnt;
reg [31:0]    fd_tim;

reg           fd;	
reg [15:0]    test_signal;

//(* keep = "true", max_fanout = 50 *) 

reg [15:0]    adc_ch_cnt;
reg [15:0]    samples;

//assign adc_clk = clk_125Mhz; //fd

reg [7:0] adc_temp;

//reg [15:0] packet_cnt_1;
//reg [15:0] packet_cnt_2;

reg [31:0] packet_cnt;

reg [3:0] apo_alg;

reg [31:0] timer_rst=0;

//(* dont_touch = "true" *) 


initial begin
	test_cnt<=0;
	fd_tim<=0;
	fd<=0;	
	test_signal<=16'h4000;
	adc_ch_cnt<=0;
	samples<=0;
	adc_temp <= 0;
	
	packet_cnt<=0;
	
//	packet_cnt_1 <= 1;
//	packet_cnt_2 <= 0;
	
	adc_wr_en<=0;
    adc_wr_addr<=0;
    apo_alg<=0;
    
    adc_state<=0;
end

initial begin
    r_led       <=1'b1;
    count       <=32'd0;
    //dac_clk     <=1'b0;
    //dac_cnt     <=32'd0;
    pause_cnt   <=32'd0;
    byte_cnt    <=32'd0;
    test_byte   <=8'd0;
    
    apo_rd      <=1'b0;
    varu_rd     <=1'b0;
    fd_st       <=4'd0;
    ad_done     <=1'b0;
    adc_ok      <=1'b0;
    adc_state   <=4'd0;
end

localparam IDLE       = 3'd0;
localparam WRITE      = 3'd1;
localparam READ       = 3'd2;
localparam PAUSE      = 3'd3;
reg [2:0] state       = IDLE;
reg [2:0] dac_state   = IDLE;

//32 chanells
//reg [31:0] angle_500Hz=0;
//reg [31:0] angle_1kHz=0;
//reg [31:0] angle_5kHz=0;
//reg [31:0] angle_var=0;

reg [31:0] word_var=0;
//reg [15:0] volume=0;

//reg phase_tvalid;
//reg [31:0] phase_tdata;
//wire dout_tvalid;
//wire [31:0] dout_sin_cos_var; 
//wire [31:0] dout_sin_cos_2k;

//reg [31:0] dout_sin_cos_var_int; 
//reg [31:0] dout_sin_cos_2k_int; 
//wire [31:0] dds_out;

//reg  [23:0] angle_var2;
//wire [23:0] dout_sin;
//wire [23:0] dout_cos;

//reg [23:0] angle_500Hz=0;
//reg [23:0] angle_1kHz=0;
//reg [23:0] angle_5kHz=0;
//reg [23:0] angle_10kHz=0;


reg [23:0] angle_var=0;
reg [23:0] angle_70kHz=0;
reg [23:0] angle_71kHz=0;
reg [23:0] angle_75kHz=0;


reg [7:0] apo_comm [17:0];
reg [7:0] b_cnt;
//reg [7:0] byte_cnt;

reg signed [15:0] dout_I=0;
reg signed [15:0] dout_Q=0;

reg signed [15:0] dout_I_vol=0;
reg signed [15:0] dout_Q_vol=0;


//reg [15:0] mem_ch2 [0:8192];
reg [12:0] addr;
reg [3:0]  alg_st;
//reg [31:0] adc_cnt;
//reg        mem_ok;
reg [3:0] alg_rst_phy=0;

//wire [15:0] ram;
//assign ram = mem_ch2[addr];

reg r_rst=1;
reg r_rst2=0;
reg cordic_en=0;

initial begin
    b_cnt<=0;
    byte_cnt<=0;
    
    addr<=13'd0;
    alg_st<=4'd0;
    //adc_cnt<=32'd0;
    //mem_ok<=1'b0;
end

//initial begin
//    phase_tvalid<=0;
//    phase_tdata<=0;
//end


assign led_1            = r_led;
assign PHY_RESET_N      = r_rst; 
assign PHY_MDC          = 1'b1;
assign PHY_MDIO         = 1'b1;
assign PHY_GTXC         = ~clk_125Mhz;
//assign DAC_CLK          = fd;
//assign ADC_CLK          = fd;//200kHz



assign conv_o = fd;     //====03.12




reg 	   freq_load;
reg [31:0] freq;
reg [3:0]  dds_alg;
reg [31:0] dds_alg_cnt;

wire        dfs_rx_rd_clk;
wire        dfs_rx_rd_en;
wire [7:0]  dfs_rx_dout;
wire [9:0]  dfs_rx_cnt; 
wire        dfs_rx_eop;

wire        dfs_tx_wr_clk;
wire [7:0]  dfs_tx_din;
wire        dfs_tx_wr_en;


initial begin
	 freq_load<=0;
	 freq<=0;
	 dds_alg<=0;
     dds_alg_cnt<=0;
end


wire clk_24_576Mhz;

pll pll_inst
(   
    .clk_in1                (sys_clk),      //50Mhz
    .reset                  (~sys_rst_n),   //Active high
    .clk_out1               (clk_160Mhz),
    .clk_out2               (clk_125Mhz),
    .clk_out3               (clk_50Mhz),
    .clk_out4               (clk_10Mhz)
);

pll_dac pll_dac1
(
    .clk_in1                (clk_50Mhz),      //50Mhz
    .clk_out1               (clk_24_576Mhz)
);
    


wire clk2_50Mhz;

//pll_dac pll_dac_inst
//(   
//    .clk_in1                (clk_50Mhz),    //50Mhz
//    .resetn                 (sys_rst_n),    //Active low
//    .clk_out1               (clk2_50Mhz),   //50Mhz
//    .clk_out2               (pll_24_576Mhz) //24_576Mhz
//);

//wire dac_clk;
//oddr_0 oddr_clk1
//(
//    .clk_in     (pll_24_576Mhz),
//    .clk_out    (bclk)
//);




wire [7:0] ram_varu_din;
wire [9:0] ram_varu_wr_addr;
wire       ram_varu_wr_en;
wire       ram_varu_wr_clk;

wire       eth_bins_tx_wr_clk;
wire [7:0] eth_bins_tx_din;
wire       eth_bins_tx_wr_en;

wire	   event_26100_bins_rd_clk;
reg	       event_26100_bins_rd=0;
wire	   event_26100_bins_ok;

assign 	   event_26100_bins_rd_clk = clk_125Mhz;

wire 	   ram_bins_26100_rd_en;
wire [5:0] ram_bins_26100_rd_addr;
wire [7:0] ram_bins_26100_dout;
wire 	   ram_bins_26100_valid;


wire        bins_rx_rd_clk;
reg         bins_rx_rd_en=0;
wire [7:0]  bins_rx_dout;
wire [9:0]  bins_rx_rd_data_count;

wire bins_26100_wr_en;


reg [7:0]   sync_rxd;
always@(posedge PHY_RXC) begin
    sync_rxd<=PHY_RXD;
end




mac mac_inst
(
    .reset_n		 		(1'b1),
    
    //***********************************************************************************// 
    //MAC module                                        
    .eth_rx_clk 			(PHY_RXC),
    .eth_rxd    			(sync_rxd),
    .eth_rxdv    			(PHY_RXDV),
    .eth_rxer    			(PHY_RXER),
    .eth_tx_clk 			(clk_125Mhz),
    .eth_txd				(PHY_TXD),
    .eth_txen				(PHY_TXEN),
    .eth_txer				(PHY_TXER),
    
    .eth_local_ip			({8'd192, 8'd168, 8'd4, 8'd2}),//FACTOR
    .eth_local_mac			(48'h1ACFFC1DFE02),
    .eth_local_port         (16'd25700),

    //***********************************************************************************//
    //ADC
    .adc_ok					(adc_ok),		//====17.10
    .adc_byte				(adc_data),		//====17.10
    
    //***********************************************************************************//
    //APO
    .fifo_eth_apo_rd_clk    (clk_125Mhz),
    .fifo_eth_apo_rd		(apo_rd),
    .fifo_eth_apo_dout	    (apo_dout),
    .fifo_eth_apo_empty     (apo_empty),
    .fifo_eth_apo_rd_cnt	(apo_cnt),
    
    //***********************************************************************************//
    //VARU
//    .fifo_eth_varu_rd_clk   (clk_125Mhz),
//    .fifo_eth_varu_rd       (varu_rd),
//    .fifo_eth_varu_dout     (varu_dout),
//    .fifo_eth_varu_empty    (varu_empty),
//    .fifo_eth_varu_rd_cnt   (varu_rd_cnt),


    //***********************************************************************************//
    //VARU
    .ram_varu_din           (ram_varu_din),
    .ram_varu_wr_addr       (ram_varu_wr_addr),
    .ram_varu_wr_en         (ram_varu_wr_en),
    .ram_varu_wr_clk        (ram_varu_wr_clk),

    
    //***********************************************************************************//
    //ADC
    .adc_wr_addr			(adc_wr_addr),
    .adc_wr_en				(adc_wr_en),
    .adc_clk                (clk_125Mhz),
    
    //***********************************************************************************//
    //DFS
    .dfs_rx_rd_clk          (dfs_rx_rd_clk),
    .dfs_rx_rd_en           (dfs_rx_rd_en),  
    .dfs_rx_dout            (dfs_rx_dout),
    .dfs_rx_cnt             (dfs_rx_cnt), 
    .dfs_rx_eop             (dfs_rx_eop), //If timer >= 250 ms and rx bytes not available -> then EOP
    
    .dfs_tx_wr_clk          (dfs_tx_wr_clk),
    .dfs_tx_din             (dfs_tx_din),
    .dfs_tx_wr_en           (dfs_tx_wr_en),
    
    //***********************************************************************************//
    //BINS
    .bins_tx_wr_clk         (eth_bins_tx_wr_clk),
    .bins_tx_din            (eth_bins_tx_din),
    .bins_tx_wr_en          (eth_bins_tx_wr_en),
    
    //for debug
    /*.bins_rx_rd_clk         (bins_rx_rd_clk),
    .bins_rx_rd_en          (bins_rx_rd_en),
    .bins_rx_din            (bins_rx_dout),
    .bins_rx_cnt            (bins_rx_rd_data_count),*/
    
    
    //events
    .event_26100_bins_rd_clk(event_26100_bins_rd_clk),
    .event_26100_bins_rd    (event_26100_bins_rd),
    .event_26100_bins_ok    (event_26100_bins_ok),
    
    //READ from RAM 26100
    .ram_bins_26100_lock    (bins_26100_wr_en), // 1 - write; 0 - read
    .ram_bins_26100_rd_en   (ram_bins_26100_rd_en),    
    .ram_bins_26100_rd_addr (ram_bins_26100_rd_addr),   
    .ram_bins_26100_dout    (ram_bins_26100_dout),
    .ram_bins_26100_valid   (ram_bins_26100_valid)               
);

ad9850 ad9850_inst 
( 
    .clk				    (clk_125Mhz),  
    .rst				    (1'b0),
    .load                   (freq_load),//pulse
    .freq				    (word_var),
    .sclk				    (dds_sclk),
    .update                 (dds_upd),
    .sdata                  (dds_data),
    .reset                  (dds_rst)
);

rs485_dfs #( .speed(9600)) rs485_dfs_inst
(
    .clk_50Mhz              (clk_50Mhz),

    .serial_in              (ser1_rx),
    .serial_out             (ser1_tx),
    .serial_rse             (ser1_rse),
    
    
    //FIFO 1024 bytes
    .fifo_rx_rd_clk         (dfs_rx_rd_clk), 
    .fifo_rx_rd_en          (dfs_rx_rd_en),  
    .fifo_rx_dout           (dfs_rx_dout),
    .fifo_rx_rd_data_count  (dfs_rx_cnt), 
    .fifo_rx_eop            (dfs_rx_eop), //If timer >= 250 ms and rx bytes not available -> then EOP
    
    //FIFO 1024 bytes
    .fifo_tx_wr_clk         (dfs_tx_wr_clk),
    .fifo_tx_din            (dfs_tx_din), 
    .fifo_tx_wr_en          (dfs_tx_wr_en) 
);


//reg         ser2_rd_en=0;
//wire [7:0]  ser2_rx_dout;
//wire [9:0]  ser2_rx_cnt; 
//wire 	    skp_rx_eop;      //If timer >= 250 ms and rx bytes not available -> then EOP

//rs485_skp #( .speed(57600)) rs485_skp_inst //57600
//(
//    .clk_50Mhz              (clk_50Mhz),
//    //.clk_125Mhz             (clk_125Mhz),

//    .serial_in              (ser2_rx),
//    .serial_out             (ser2_tx),
//    .serial_rse             (ser2_rse),
    
//    //FIFO 1024 bytes
//    .fifo_rx_rd_clk         (clk_125Mhz),
//    .fifo_rx_rd_en          (ser2_rd_en),
//    .fifo_rx_dout           (ser2_rx_dout),
//    .fifo_rx_rd_data_count  (ser2_rx_cnt),
//    .fifo_rx_eop            (skp_rx_eop)
//);

//reg [3:0]  skp_state=0;
//reg [31:0] ser2_delay=0;



//reg         bins_rx_rd_en = 0;
//wire [7:0]  bins_rx_dout;
//wire [9:0]  bins_rx_rd_data_count;

reg [3:0]   bins_st=0;
reg [7:0]   bins_cnt=0;
reg [31:0]  bins_timeout=0;
reg [7:0]   bins_i=0;
reg         bins_data_lock=0;

//reg         bins_rd_en=0;
//wire [7:0]  bins_rx_dout;
//wire [9:0]  bins_rx_cnt; 
//wire 	    skp_rx_eop;      //If timer >= 250 ms and rx bytes not available -> then EOP

reg [3:0]  bins_state=0;
reg [31:0] ser2_delay=0;


logic fifo_rx_wr_en_test;           //====17.08
logic [3:0] write_st_test;          //====17.08
logic serial_rdy_test;              //====18.08
logic [1:0] rdy_st_test;            //====18.08
logic rx_done_test;                 //====18.08

// assign ser1_tx  = ser2_rx;
// assign ser1_rse = 1'b1;
/*
wire        bins_rx_rd_clk;
wire        bins_rx_rd_en;
wire [7:0]  bins_rx_dout;
wire [9:0]  bins_rx_rd_data_count;
*/

wire [7:0] dbg_rx_byte;
wire       dbg_serial_rdy;

rs485_bins rs485_bins_inst //115200
(
    .clk_125Mhz             (clk_125Mhz),
        
    .serial_in              (ser2_rx),
    .serial_out             (ser2_tx),
    .serial_rse             (ser2_rse),
    
        //RX
    .fifo_rx_rd_clk         (clk_125Mhz),//(bins_rx_rd_clk),   //
    .fifo_rx_rd_en          (bins_rx_rd_en),
    .fifo_rx_dout           (bins_rx_dout),
    .fifo_rx_rd_data_count  (bins_rx_rd_data_count),
        
        //TX
    .fifo_tx_wr_clk         (eth_bins_tx_wr_clk),
    .fifo_tx_din            (eth_bins_tx_din),
    .fifo_tx_wr_en          (eth_bins_tx_wr_en),
    
    .dbg_rx_byte            (dbg_rx_byte),
	.dbg_serial_rdy         (dbg_serial_rdy)
    
    /*.fifo_rx_wr_en_test(fifo_rx_wr_en_test),             //====17.08
    .write_st_test(write_st_test),                       //====17.08
    .serial_rdy_test(serial_rdy_test),                   //====18.08
    .rdy_st_test(rdy_st_test),                           //====18.08
    .rx_done_test(rx_done_test)                          //====18.08*/
    
);




//***************************************************************************************//
// RAM for BINS_25700
reg  [7:0]  ram_bins_din=0;
reg			ram_bins_rd_en=1;         //====15.08
//reg			ram_bins_rd_en=0;             //====15.08
reg  [5:0]	ram_bins_rd_addr=0;
reg 			ram_bins_wr_en=0;
reg  [5:0]	ram_bins_wr_addr=0;
wire [7:0]	ram_bins_dout;

reg [7:0]	bins_clear_st=0;
reg [7:0]   clear_26100_bins_st=0;

ram_dual2 # (64,6) ram_bins //50 bytes
(
    //Write to RAM
    .clk        (clk_125Mhz),
    .din        (ram_bins_din), 
    .wr         (ram_bins_wr_en), 
    .wr_addr    (ram_bins_wr_addr),  
    
    //Read from RAM
    .rd         (ram_bins_rd_en),	
    .rd_addr	(ram_bins_rd_addr),   
    .dout		(ram_bins_dout)         
);
//***************************************************************************************//


//***************************************************************************************//
// RAM for BINS_26100
reg  [7:0]  ram_bins_26100_din=0;
reg 		ram_bins_26100_wr_en=0;
reg  [5:0]	ram_bins_26100_wr_addr=0;

ram_dual_v # (64,6,49) ram_bins_26100 //50 bytes
(
    //Write to RAM
    .clk        (clk_125Mhz), //event_26100_bins_rd_clk
    .din        (ram_bins_26100_din), 
    .wr         (ram_bins_26100_wr_en), 
    .wr_addr	(ram_bins_26100_wr_addr),  
    
    //Read from RAM
    .rd         (ram_bins_26100_rd_en),	
    .rd_addr	(ram_bins_26100_rd_addr),   
    .dout		(ram_bins_26100_dout),
    .valid	    (ram_bins_26100_valid)
);
//***************************************************************************************//


assign bins_26100_wr_en = ram_bins_26100_wr_en;


//ila_1 ila_eth_rx
//(
//    .clk        (PHY_RXC),
//    .probe0     (PHY_RXC),          //1
//    .probe1     (PHY_RXDV),         //1
//    .probe2     (PHY_RXER),         //1
//    .probe3     (PHY_RXD),          //8
//    .probe4     (PHY_RESET_N)       //1
//);

//ila_2 ila_eth_tx
//(
//    .clk        (PHY_GTXC),
//    .probe0     (PHY_TXEN),         //1
//    .probe1     (PHY_TXER),         //1
//    .probe2     (PHY_TXD),          //8
    
//    .probe3     (event_eth_skp_ok), //1        
//    .probe4     (event_eth_skp_rd)  //1
//);



//test dds module	
//always@(posedge clk_10Mhz) begin
//	case(dds_alg)
	
//		0: begin
//			freq		<=32'h00008638;	//1kHz
//			freq_load	<=1;
//			dds_alg		<=dds_alg+1;
//		end
		
//		1: begin
//			freq_load<=0;
//			if(dds_alg_cnt<100000000) begin
//				dds_alg_cnt<=dds_alg_cnt+1;
//			end
//			else begin
//				dds_alg<=dds_alg+1;
//				dds_alg_cnt<=0;
//			end
//		end
		
//		2: begin
//			freq		<=32'h00029F17;	//5kHz
//			freq_load	<=1;
//			dds_alg		<=dds_alg+1;
//		end
		
//		3: begin
//			freq_load<=0;
//			if(dds_alg_cnt<100000000) begin
//				dds_alg_cnt<=dds_alg_cnt+1;
//			end
//			else begin
//				dds_alg<=dds_alg+1;
//				dds_alg_cnt<=0;
//			end
//		end
		
//		4: begin
//			freq		<=32'h000A7C5A;	//20kHz
//			freq_load	<=1;
//			dds_alg		<=dds_alg+1;
//		end
		
//		5: begin
//			freq_load<=0;
//			if(dds_alg_cnt<100000000) begin
//				dds_alg_cnt<=dds_alg_cnt+1;
//			end
//			else begin
//				dds_alg<=0;
//				dds_alg_cnt<=0;
//			end
//		end
		
//		default: dds_alg<=0;
//	endcase
//end


//***************************************************************************************//
// RESET PHY                                                                            *//
//***************************************************************************************//

reg adc_rst=0;
assign rst_adc_o = adc_rst;
always@(posedge clk_125Mhz) begin
    case(alg_rst_phy)
        0: begin
            //timer_rst<=timer_rst+1;
            case(timer_rst)
                32'd62500000: begin
                    r_rst<=0;   //reset PHY
                    timer_rst<=0;
                    alg_rst_phy<=alg_rst_phy+1;
                    adc_rst<=1; //reset adc
                end
                default: timer_rst<=timer_rst+1;
            endcase
        end
        
        1: begin
            //timer_rst<=timer_rst+1;
            case(timer_rst)
                32'd62500000: begin
                    r_rst<=1;   
                    timer_rst<=0;
                    alg_rst_phy<=alg_rst_phy+1;
                    adc_rst<=0;
                end
                default: timer_rst<=timer_rst+1;
            endcase
        end
        
        2: begin
            //WORK this state!!!
            r_rst2<=1;
        end  
        
        default: alg_rst_phy<=0;
    endcase


    
    case(r_rst2)
        0: begin //RESET
            rk_o <= 0;
            ru_o <= 0;
        end
        
        1: begin //WORK
            case(apo_comm[0])           
                8'h31: rk_o <= 1;
                8'h32: rk_o <= 0; 
            endcase
            
            case(apo_comm[1])           
                8'h00: cordic_en <= 0;
                8'h01: cordic_en <= 1;
            endcase
                        
            case(apo_comm[5][7])      //case(apo_comm[5][6])  !!!!!
                0: ru_o <= 0;
                1: ru_o <= 1;
            endcase
        end
        
        default: begin
        
        end
    endcase
    
end

//for test fd adc
always@(posedge clk_160Mhz) begin
//always@(posedge clk_125Mhz) begin 
    case(r_rst2)
        
        0:begin //RESET
            fd_tim<=0;
        end
        
        1:begin //WORK
            fd_tim<=fd_tim+1;
            case(fd_tim)
                0: begin
                    fd<=1;
                end
                
                399: begin
                    fd<=0;
                end
                
                799: begin
                    fd_tim<=0;
                end
            endcase   
        end
        
        default: begin
        
        end
        
    endcase
end


//==================================================================================================        //====03.12
parameter adc_read_ofset = 270;


reg signed [15:0] data_adc[0:84];
//reg signed [15:0] data_adc2[0:84];
reg data_adc_ok=0;

initial begin
    clk_adc_o = 1;
    cs_o = '1; 
end

//wire signed [23:0] out_var_sin;
//wire signed [23:0] out_71k_sin;
//wire signed [23:0] out_75k_sin;


//==============================================================================        //==== 21.07
//wire signed [23:0] test_51Hz;
//wire signed [15:0] test_51Hz;



//parameter angle_test = 32'd700000;
/*logic [31:0] angle_test;


always @(posedge clk_125Mhz) begin
    angle_test <= angle_test + 32'd344597;
end

cordic32    cordic_i ( 
               //      .clk(fd),
                     .clk(clk_125Mhz),
               //      .x_start(32000/1.647),
                     .x_start(18000),
                     .y_start(0),
                     .angle(angle_test),
                     .sin(test_51Hz),
                     .cos() );*/
                     
                     
/*  ila_cordic_1    ila_cordic_1_i (                            //==== 14.08                  
                                  .clk(clk_125Mhz),
                                  .probe0(test_51Hz)
                                 );     */              
                     
                     
                     
//==============================================================================



//***************************************************************************************//
// ADC samples                                                                          *//
//***************************************************************************************//
always@(posedge clk_160Mhz) begin
//always@(posedge clk_125Mhz) begin
    case(fd_tim)
    
        adc_read_ofset:       clk_adc_o <= 0; 
        adc_read_ofset+10:    clk_adc_o <= 1;// ch1  - ch7
        adc_read_ofset+12:    clk_adc_o <= 0;
        adc_read_ofset+22:    clk_adc_o <= 1;// ch2  - ch8
        adc_read_ofset+24:    clk_adc_o <= 0; 
        adc_read_ofset+34:    clk_adc_o <= 1;// ch3  - ch9
        adc_read_ofset+36:    clk_adc_o <= 0;
        adc_read_ofset+46:    clk_adc_o <= 1;// ch4  - ch10
        adc_read_ofset+48:    clk_adc_o <= 0; 
        adc_read_ofset+58:    clk_adc_o <= 1;// ch5  - ch11
        adc_read_ofset+60:    clk_adc_o <= 0;
        adc_read_ofset+70:    clk_adc_o <= 1;// ch6  - ch12
        adc_read_ofset+72:    clk_adc_o <= 0;
        
        adc_read_ofset+82:    clk_adc_o <= 1;// ch13 - ch19
        adc_read_ofset+84:    clk_adc_o <= 0;  
        adc_read_ofset+94:    clk_adc_o <= 1;// ch14 - ch20
        adc_read_ofset+96:    clk_adc_o <= 0;
        adc_read_ofset+106:   clk_adc_o <= 1;// ch15 - ch21
        adc_read_ofset+108:   clk_adc_o <= 0; 
        adc_read_ofset+118:   clk_adc_o <= 1;// ch16 - ch22
        adc_read_ofset+120:   clk_adc_o <= 0;
        adc_read_ofset+130:   clk_adc_o <= 1;// ch17 - ch23
        adc_read_ofset+132:   clk_adc_o <= 0; 
        adc_read_ofset+142:   clk_adc_o <= 1;// ch18 - ch24
        adc_read_ofset+144:   clk_adc_o <= 0;
        
        adc_read_ofset+154:   clk_adc_o <= 1;// ch25 - ch31
        adc_read_ofset+156:   clk_adc_o <= 0; 
        adc_read_ofset+166:   clk_adc_o <= 1;// ch26 - ch32
        adc_read_ofset+168:   clk_adc_o <= 0;
        adc_read_ofset+178:   clk_adc_o <= 1;// ch27 - ch33
        adc_read_ofset+180:   clk_adc_o <= 0;
        adc_read_ofset+190:   clk_adc_o <= 1;// ch28 - ch34
        adc_read_ofset+192:   clk_adc_o <= 0; 
        adc_read_ofset+202:   clk_adc_o <= 1;// ch29 - ch35
        adc_read_ofset+204:   clk_adc_o <= 0;
        adc_read_ofset+214:   clk_adc_o <= 1;// ch30 - ch36
        adc_read_ofset+216:   clk_adc_o <= 0; 
        
        adc_read_ofset+226:   clk_adc_o <= 1;// ch37 - ch43
        adc_read_ofset+228:   clk_adc_o <= 0;
        adc_read_ofset+238:   clk_adc_o <= 1;// ch38 - ch44
        adc_read_ofset+240:   clk_adc_o <= 0;
        adc_read_ofset+250:   clk_adc_o <= 1;// ch39 - ch45
        adc_read_ofset+252:   clk_adc_o <= 0;
        adc_read_ofset+262:   clk_adc_o <= 1;// ch40 - ch46
        adc_read_ofset+264:   clk_adc_o <= 0; 
        adc_read_ofset+274:   clk_adc_o <= 1;// ch41 - ch47
        adc_read_ofset+276:   clk_adc_o <= 0;
        adc_read_ofset+286:   clk_adc_o <= 1;// ch42 - ch48
        adc_read_ofset+288:   clk_adc_o <= 0; 
        
        adc_read_ofset+298:   clk_adc_o <= 1;// ch49 - ch55
        adc_read_ofset+300:   clk_adc_o <= 0;
        adc_read_ofset+310:   clk_adc_o <= 1;// ch50 - ch56
        adc_read_ofset+312:   clk_adc_o <= 0;
        adc_read_ofset+322:   clk_adc_o <= 1;// ch51 - ch57
        adc_read_ofset+324:   clk_adc_o <= 0; 
        adc_read_ofset+334:   clk_adc_o <= 1;// ch52 - ch58
        adc_read_ofset+336:   clk_adc_o <= 0;
        adc_read_ofset+346:   clk_adc_o <= 1;// ch53 - ch59
        adc_read_ofset+348:   clk_adc_o <= 0;
        adc_read_ofset+358:   clk_adc_o <= 1;// ch54 - ch60
        adc_read_ofset+360:   clk_adc_o <= 0;
        
        adc_read_ofset+370:   clk_adc_o <= 1;// ch61 - ch67
        adc_read_ofset+372:   clk_adc_o <= 0;  
        adc_read_ofset+382:   clk_adc_o <= 1;// ch62 - ch68
        adc_read_ofset+384:   clk_adc_o <= 0;
        adc_read_ofset+394:   clk_adc_o <= 1;// ch63 - ch69
        adc_read_ofset+396:   clk_adc_o <= 0; 
        adc_read_ofset+406:   clk_adc_o <= 1;// ch64 - ch70
        adc_read_ofset+408:   clk_adc_o <= 0;
        adc_read_ofset+418:   clk_adc_o <= 1;// ch65 - ch71
        adc_read_ofset+420:   clk_adc_o <= 0;
        adc_read_ofset+430:   clk_adc_o <= 1;// ch66 - ch72
        adc_read_ofset+432:   clk_adc_o <= 0; 
        
        adc_read_ofset+442:   clk_adc_o <= 1;// ch73 - ch79
        adc_read_ofset+444:   clk_adc_o <= 0;
        adc_read_ofset+454:   clk_adc_o <= 1;// ch74 - ch80
        adc_read_ofset+456:   clk_adc_o <= 0;
        adc_read_ofset+466:   clk_adc_o <= 1;// ch75 - ch81
        adc_read_ofset+468:   clk_adc_o <= 0;
        adc_read_ofset+478:   clk_adc_o <= 1;// ch76 - ch82
        adc_read_ofset+480:   clk_adc_o <= 0; 
        adc_read_ofset+490:   clk_adc_o <= 1;// ch77 - ch83
        adc_read_ofset+492:   clk_adc_o <= 0;
        adc_read_ofset+502:   clk_adc_o <= 1;// ch78 - ch84
        adc_read_ofset+504:   clk_adc_o <= 0; 
        
        adc_read_ofset+514:   clk_adc_o <= 1;// ch85 - chXX 
    endcase

    case(fd_tim)
        adc_read_ofset:       cs_o <= 8'b1111_1110;
        adc_read_ofset+72:    cs_o <= 8'b1111_1101;
        adc_read_ofset+84:    cs_o <= 8'b1111_1011;
        adc_read_ofset+156:   cs_o <= 8'b1111_0111;
        adc_read_ofset+228:   cs_o <= 8'b1110_1111;
        adc_read_ofset+300:   cs_o <= 8'b1101_1111;
        adc_read_ofset+372:   cs_o <= 8'b1011_1111;
        adc_read_ofset+444:   cs_o <= 8'b0111_1111;
        adc_read_ofset+516:   cs_o <= 8'b1111_1111;
        //adc_read_ofset+518:   cs_o <= 8'b1111_1111;
    endcase
    
    case(fd_tim)
        //***********************************************************************//
        // ADC-1                                                                 //
        //***********************************************************************//
        adc_read_ofset+10: begin 
//            data_adc[0]  <= adc_data_1_i;           
//            data_adc[6]  <= adc_data_2_i;
        
            case(cordic_en)
                0: begin
//                    data_adc[0]  <= adc_data_1_i;           
//                    data_adc[6]  <= adc_data_2_i;

                    data_adc[73]   <= adc_data_1_i;           
                    data_adc[73+6] <= adc_data_2_i;
                end
                
                1: begin
                    data_adc[73]  <= adc_data_1_i; 
                    data_adc[73+6]  <= test_signal;       //==== 13.08.20
       //             data_adc[73+6]  <= adc_data_2_i;        //==== 13.08.20
                end
            endcase
        end
        
        adc_read_ofset+22: begin 
            data_adc[73+1]  <= adc_data_1_i;           
            data_adc[73+7]  <= adc_data_2_i;   
        end
        
        adc_read_ofset+34: begin 
            data_adc[73+2]  <= adc_data_1_i;     
            data_adc[73+8]  <= adc_data_2_i;      //====21.07
  //          data_adc[73+8]  <= test_51Hz[23:8];       //==== 13.08.20          
        end
        
        adc_read_ofset+46: begin 
            data_adc[73+3]  <= adc_data_1_i;     
            data_adc[73+9]  <= adc_data_2_i;   
        end
        
        adc_read_ofset+58: begin 
            data_adc[73+4]  <= adc_data_1_i;           
            data_adc[73+10] <= adc_data_2_i;   
        end
        
        adc_read_ofset+70: begin 
            data_adc[73+5]  <= adc_data_1_i;           
            data_adc[73+11] <= adc_data_2_i;   
        end
        
        
         //***********************************************************************//
         // ADC-2                                                                 //
         //***********************************************************************//
        adc_read_ofset+82: begin  // ch13
            //data_adc[12] <= adc_data_1_i; 
            data_adc[72] <= adc_data_1_i;
        end
        
        
        //***********************************************************************//
        // ADC-3                                                                 //
        //***********************************************************************//
        adc_read_ofset+94: begin //13 & 19
            data_adc[35+13] <= adc_data_1_i; 
            data_adc[35+19] <= adc_data_2_i; 
        end
        
        adc_read_ofset+106: begin 
            data_adc[35+14] <= adc_data_1_i; 
            data_adc[35+20] <= adc_data_2_i;
        end
        
        adc_read_ofset+118: begin 
            data_adc[35+15] <= adc_data_1_i; 
            data_adc[35+21] <= adc_data_2_i;
        end
        
        adc_read_ofset+130: begin
            data_adc[35+16] <= adc_data_1_i; 
            data_adc[35+22] <= adc_data_2_i;
        end

        adc_read_ofset+142: begin
            data_adc[35+17] <= adc_data_1_i; 
            data_adc[35+23] <= adc_data_2_i;
        end   
   
        adc_read_ofset+154: begin
            data_adc[35+18] <= adc_data_1_i; 
            data_adc[35+24] <= adc_data_2_i;
        end   
        
        
        //***********************************************************************//
        // ADC-4                                                                 //
        //***********************************************************************//
        adc_read_ofset+166: begin
            data_adc[35+25] <= adc_data_1_i; 
            data_adc[35+31] <= adc_data_2_i;
        end 
        
        adc_read_ofset+178: begin
            data_adc[35+26] <= adc_data_1_i; 
            data_adc[35+32] <= adc_data_2_i;
        end 
        
        adc_read_ofset+190: begin
            data_adc[35+27] <= adc_data_1_i; 
            data_adc[35+33] <= adc_data_2_i;
        end 
        
        adc_read_ofset+202: begin
            data_adc[35+28] <= adc_data_1_i; 
            data_adc[35+34] <= adc_data_2_i;
        end 
        
        adc_read_ofset+214: begin
            data_adc[35+29] <= adc_data_1_i; 
            data_adc[35+35] <= adc_data_2_i;
        end 
        
        adc_read_ofset+226: begin
            data_adc[35+30] <= adc_data_1_i; 
            data_adc[35+36] <= adc_data_2_i;
        end 
        
         //***********************************************************************//
         // ADC-5                                                                 //
         //***********************************************************************//
        adc_read_ofset+238: begin
            data_adc[37-37] <= adc_data_1_i; 
            data_adc[43-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+250: begin
            data_adc[38-37] <= adc_data_1_i; 
            data_adc[44-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+262: begin
            data_adc[39-37] <= adc_data_1_i; 
            data_adc[45-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+274: begin
            data_adc[40-37] <= adc_data_1_i; 
            data_adc[46-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+286: begin
            data_adc[41-37] <= adc_data_1_i; 
            data_adc[47-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+298: begin
            data_adc[42-37] <= adc_data_1_i; 
            data_adc[48-37] <= adc_data_2_i;
        end 
        
        //***********************************************************************//
        // ADC-6                                                                 //
        //***********************************************************************//
        adc_read_ofset+310: begin
            data_adc[49-37] <= adc_data_1_i; 
            data_adc[55-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+322: begin
            data_adc[50-37] <= adc_data_1_i; 
            data_adc[56-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+334: begin
            data_adc[51-37] <= adc_data_1_i; 
            data_adc[57-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+346: begin
            data_adc[52-37] <= adc_data_1_i; 
            data_adc[58-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+358: begin
            data_adc[53-37] <= adc_data_1_i; 
            data_adc[59-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+370: begin
            data_adc[54-37] <= adc_data_1_i; 
            data_adc[60-37] <= adc_data_2_i;
        end 
        
        //***********************************************************************//
        // ADC-7                                                                 //
        //***********************************************************************//
        adc_read_ofset+382: begin
            data_adc[61-37] <= adc_data_1_i; 
            data_adc[67-37] <= adc_data_2_i;          
        end 
        
        adc_read_ofset+394: begin
            data_adc[62-37] <= adc_data_1_i; 
            data_adc[68-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+406: begin
            data_adc[63-37] <= adc_data_1_i; 
            data_adc[69-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+418: begin
            data_adc[64-37] <= adc_data_1_i; 
            data_adc[70-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+430: begin
            data_adc[65-37] <= adc_data_1_i; 
            data_adc[71-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+442: begin
            data_adc[66-37] <= adc_data_1_i; 
            data_adc[72-37] <= adc_data_2_i;
        end 
        
        //***********************************************************************//
        // ADC-8                                                                 //
        //***********************************************************************//
        adc_read_ofset+454: begin
            data_adc[73-37] <= adc_data_1_i; 
            data_adc[79-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+466: begin
            data_adc[74-37] <= adc_data_1_i; 
            data_adc[80-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+478: begin
            data_adc[75-37] <= adc_data_1_i; 
            data_adc[81-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+490: begin
            data_adc[76-37] <= adc_data_1_i; 
            data_adc[82-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+502: begin
            data_adc[77-37] <= adc_data_1_i; 
            data_adc[83-37] <= adc_data_2_i;
        end 
        
        adc_read_ofset+514: begin
            //data_adc[78] <= adc_data_1_i; 
            //data_adc[84] <= adc_data_2_i;
            
            
            case(cordic_en)
                0: begin
                    data_adc[78-37]  <= adc_data_1_i;           
                    data_adc[84-37]  <= adc_data_2_i;
                end
                
                1: begin
                    data_adc[78-37]  <= adc_data_1_i; 
         //           data_adc[84-37]  <= test_signal;      //====13.08.20
                    data_adc[84-37]  <= adc_data_2_i;       //====13.08.20
                end
            endcase
            
        end 


        //***********************************************************************//
        // END                                                                   //
        //***********************************************************************//
        adc_read_ofset+515: begin 
            data_adc_ok <= 1; 
        end
        
        adc_read_ofset+517: begin 
            data_adc_ok <= 0; 
        end   
        
    endcase
    
end
//==================================================================================================


reg [31:0] time_t=0;
reg [31:0] get_time_t=0;

always@(posedge fd) begin	

    time_t<=time_t+1; //timer 
				
	test_cnt<=test_cnt+1'b1;
	if(test_cnt==8'd19)begin
		test_signal[15]<=~test_signal[15];//invert sign
		test_cnt<=8'd0;
	end
	
	
	//test dac
	//ldac_dat <= test_signal;
	//rdac_dat <= rdac_dat + 16'd2; 
end

//***************************************************************************************//
// LED                                                                                  *//
//***************************************************************************************//	
						
//always@(posedge clk_10Mhz) begin
//    case(r_rst2)
//        0: begin //RESET
//            count<=0;
//            r_led<=1;
//        end
        
//        1: begin //WORK
//            case (count)
//                32'd2000000: begin 
//                    r_led<=~r_led; //Indicate process
//                    count<=0; 
//                end
                
//                default: begin
//                    count<=count+1;
//                end
//            endcase  
//        end
//    endcase      
//end

//reg        envelope=1;
reg [3:0]  copy_st=0;
reg [7:0]  alg_work=0;

//Comment 17.04.2020_0746!!!
//reg [15:0] cic_Idout[0:84];
//reg [15:0] cic_Qdout[0:84];

reg [15:0] cnt_up=0;
reg [31:0] cnt_get_pkt=0;
reg [2:0]  work_state=0;

reg dac_rr=0;


//ila_apo ila_apodbg
//(
//    .clk        (clk_125Mhz),
//    .probe0     (apo_alg),          //4
//    .probe1     (apo_cnt),          //8
//    .probe2     (apo_rd),           //1
//    .probe3     (apo_dout),         //8
//    .probe4     (apo_comm[b_cnt]),  //8
//    .probe5     (b_cnt)             //8
//);

//reg [63:0] time_t=0;
//reg [63:0] get_time_t=0;





//reg [7:0] test_val1=8'hA1;
//reg [7:0] test_val2=8'hB1;
//reg [7:0] test_val3=8'hC1;
//reg [7:0] test_val4=8'hD1;



//wire        fifo_skp_wr_clk;
//reg [7:0]   fifo_skp_din=8'd0;
//reg         fifo_skp_wr_en=0;
//wire        fifo_skp_full;
//wire        fifo_skp_empty;
//wire [11:0] fifo_skp_wr_data_count;

//assign fifo_skp_wr_clk = clk_125Mhz;

////1k fifo   
//fifo_ser fifo_skp_26100
//(
//    .wr_clk         (fifo_skp_wr_clk),                   //: IN STD_LOGIC;
//    .rd_clk         (fifo_skp_rd_clk),                   //: IN STD_LOGIC;
//    .din            (fifo_skp_din),                      //: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
//    .wr_en          (fifo_skp_wr_en & !fifo_skp_full),   //: IN STD_LOGIC;
//    .rd_en          (fifo_skp_rd_en & !fifo_skp_empty),  //: IN STD_LOGIC;
//    .dout           (fifo_skp_dout),                     //: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
//    .full           (fifo_skp_full),                     //: OUT STD_LOGIC;
//    .empty          (fifo_skp_empty),                    //: OUT STD_LOGIC;
//    .rd_data_count  (fifo_skp_rd_data_count),            //: OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
//    .wr_data_count  (fifo_skp_wr_data_count)             //: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
//);


reg [1:0]   lock_st=0;
//reg [31:0]  skp_timeout=0;

reg         event_env_rd=0;
reg         event_env_wr=0;
wire        event_env_ok;
wire        envelope_out;
reg [1:0]   env_st=0;

//RXMajority3Filter env_filter
//(
//    .clk        (clk_10Mhz),//clk_125Mhz
//    .in         (envelope),
//    .out        (envelope_out)
//);

events event_envelope
(
	.wr_clk	(clk_125Mhz),
	.rd_clk	(clk_125Mhz),
	.rst	(1'b0),
	.rd		(event_env_rd),
	.wr		(event_env_wr),
	.out	(event_env_ok)
);


reg [3:0]  alg_mult=0;
reg [15:0] adc_cnt=0;
reg [15:0] adc_ch=0;
reg [3:0]  adc_i=0;


reg [31:0] dac_dat=0;
reg        lr_dat=0;
reg        clk_en=0;
reg [3:0]  dac_wr_st=0;
reg [7:0]  bit_cnt=0;
reg [7:0]  ldac_dat=0;
reg [31:0] dac_cnt=0;
reg [31:0] period_varu=0;
reg [3:0]  varu_alg=0;
reg        dac_fd=0;
reg [7:0]  dac_bit=0;

//wire [7:0] ram_varu_din;
// wire [9:0] ram_varu_wr_addr;
// wire       ram_varu_wr_en;
// wire       ram_varu_wr_clk;

reg  [9:0] ram_varu_rd_addr=0;
reg        ram_varu_rd_en=0;
wire [7:0] ram_varu_dout;
//wire       ram_varu_rd_clk;
wire       ram_varu_valid;

//assign     ram_varu_rd_clk = dac_fd;


//********************************************************//
//*Put VARU data in DUAL PORT RAM                        *//
//********************************************************//
ram_dual_v # (1050,10,1024) ram_varu //1024 bytes
(
    //Write to RAM
    .clk        (ram_varu_wr_clk), 
    .din        (ram_varu_din), 
    .wr         (ram_varu_wr_en), 
    .wr_addr    (ram_varu_wr_addr),  

    //Read from RAM
    .rd         (ram_varu_rd_en),
    .rd_addr    (ram_varu_rd_addr),   
    .dout       (ram_varu_dout),
    .valid      (ram_varu_valid)
);


reg        trigger=0;
reg        trigger2=0;
reg [3:0]  trigger_st=0;
reg [31:0] trigger_cnt=0;
reg [1:0]  envelope_t=2'b00;
reg [31:0] env_timer=0;
reg        dac_r=0;

//assign bclk  = dac_clk;     // clk 24_576 Mhz      trigger;
assign lrck  = lr_dat;      // envelope;
assign ddata = dac_r;
assign bclk  = clk_24_576Mhz;    



//oddr_0 oddr_trg
//(
//    .clk_in     (trigger),
//    .clk_out    (trigger_out)
//);

//assign trigger_out = 0;
//trigger;rxIdleOUT


//**************************************************************************************************************************//
//DAC
always@(posedge clk_24_576Mhz) begin
   case(dac_bit)
       31: begin
           lr_dat<=1;
           dac_bit<=dac_bit+1;
           dac_r<=dac_dat[31-dac_bit];
           //dac_r<=dac_dat[dac_bit];
       end
        
       63: begin
           lr_dat<=0;
           dac_bit<=0;
           dac_r<=0;
       end
        
       default: begin
           dac_bit<=dac_bit+1;
           if(dac_bit<=31)
               dac_r<=dac_dat[31-dac_bit];
               //dac_r<=dac_dat[dac_bit];
           else
               dac_r<=0;
       end
   endcase
end

always@(posedge lr_dat) begin
   dac_fd<=~dac_fd;
end

reg [2:0]  dac_st=0;
reg [2:0]  dac_alg_st=0;
reg [31:0] dac_div_cnt=0;
reg [10:0] dac_byte_cnt=0;

//always@(posedge clk_125Mhz) begin

always@(posedge dac_fd) begin


    case(dac_st)
    
        0: begin
            if(dac_rr && trigger) begin
                dac_st<=dac_st+1'b1; 
                dac_byte_cnt<=0;
            end
            else begin
                dac_dat <= {8'h80,24'd0}; 
            end
        end
        
        1: begin
            if(dac_div_cnt < period_varu) begin
                dac_div_cnt<=dac_div_cnt+1'b1;
            end
            else begin
                case(dac_byte_cnt)
                    0: begin
                        ram_varu_rd_addr<=0;
                        ram_varu_rd_en  <=1;
                            
                        if(ram_varu_dout>8'h80)
                            dac_dat <= {8'h80,24'd0};
                        else
                            dac_dat <= {ram_varu_dout,24'd0};
                                
                        dac_byte_cnt<=dac_byte_cnt+1;
                    end
                        
                    1023: begin
                        //dac_dat <= {ram_varu_dout,24'd0};
                            
                        if(ram_varu_dout>8'h80)
                            dac_dat <= {8'h80,24'd0};
                        else
                            dac_dat <= {ram_varu_dout,24'd0};
                                
                        ram_varu_rd_addr<=ram_varu_rd_addr+1;
                        dac_st<=dac_st+1'b1;  
                    end

                    default: begin
                        //dac_dat <= {ram_varu_dout,24'd0};
                            
                        if(ram_varu_dout>8'h80)
                            dac_dat <= {8'h80,24'd0};
                        else
                            dac_dat <= {ram_varu_dout,24'd0};
                                
                        ram_varu_rd_addr<=ram_varu_rd_addr+1;
                        dac_byte_cnt<=dac_byte_cnt+1;
                    end
                endcase
                dac_div_cnt<=0;
            end
        end
        
        2: begin
            dac_div_cnt     <=0;
            dac_byte_cnt    <=0;
            ram_varu_rd_addr<=0;
            ram_varu_rd_en  <=0;
            if(~trigger) begin
                dac_st<=0; 
            end 
        end
        
        default: dac_st<=0;
    
    endcase





/*
    case(dac_st)
        0: begin
            if(dac_fd) begin //wait posedge fd
                case(dac_alg_st)
                
                    0: begin
                        if(dac_rr && trigger) begin
                            dac_alg_st<=1; 
                            dac_byte_cnt<=0;
                        end
                        else begin
                            dac_dat <= {8'h80,24'd0}; 
                        end
                    end   
                    
                    1: begin
                        if(dac_div_cnt < period_varu) begin
                            dac_div_cnt<=dac_div_cnt+1'b1;
                        end
                        else begin
                            case(dac_byte_cnt)
                                0: begin
                                    ram_varu_rd_addr<=0;
                                    ram_varu_rd_en  <=1;
                                        
                                    if(ram_varu_dout>8'h80)
                                        dac_dat <= {8'h80,24'd0};
                                    else
                                        dac_dat <= {ram_varu_dout,24'd0};
                                            
                                    dac_byte_cnt<=dac_byte_cnt+1;
                                end
                                    
                                1023: begin
                                    //dac_dat <= {ram_varu_dout,24'd0};
                                        
                                    if(ram_varu_dout>8'h80)
                                        dac_dat <= {8'h80,24'd0};
                                    else
                                        dac_dat <= {ram_varu_dout,24'd0};
                                            
                                    ram_varu_rd_addr<=ram_varu_rd_addr+1;
                                    dac_alg_st<=2; 
                                end

                                default: begin
                                    //dac_dat <= {ram_varu_dout,24'd0};
                                        
                                    if(ram_varu_dout>8'h80)
                                        dac_dat <= {8'h80,24'd0};
                                    else
                                        dac_dat <= {ram_varu_dout,24'd0};
                                            
                                    ram_varu_rd_addr<=ram_varu_rd_addr+1;
                                    dac_byte_cnt<=dac_byte_cnt+1;
                                end
                            endcase
                            dac_div_cnt<=0;
                        end
                    end
                    
                    2: begin
                        dac_div_cnt     <=0;
                        dac_byte_cnt    <=0;
                        ram_varu_rd_addr<=0;
                        ram_varu_rd_en  <=0;
                        if(~trigger) begin
                            dac_alg_st<=0; 
                        end 
                    end
                    
                    default: dac_alg_st<=0;
                endcase
                dac_st<=dac_st+1'b1;
            end
        end
       
        1: begin
            if(~dac_fd) begin //wait negedge fd
                dac_st<=0;
            end
        end
    endcase*/
       

end
//**************************************************************************************************************************//

/*
ila_dac ila_dac1
(
   .clk        (clk_125Mhz),
   .probe0     (dac_rr),            //1
   .probe1     (dac_st),            //3
   .probe2     (dac_alg_st),        //3
   .probe3     (trigger),           //1
   .probe4     (ram_varu_rd_en),    //1
   .probe5     (ram_varu_rd_addr),  //10
   .probe6     (ram_varu_dout)      //8
);*/




reg [1:0]  ram_st=0;

//ila_2   ila_dbg2
//(
//    .clk        (clk_125Mhz),
    
//    .probe0     (fd),               //1
//    .probe1     (data_adc_ok),      //1
//    .probe2     (adc_cnt),          //8
//    .probe3     (cic_I_tready),     //1
//    .probe4     (adc_data_tvalid),  //1
//    .probe5     (adc_data_tlast),   //1
//    .probe6     (cic_I_tvalid),     //1
//    .probe7     (cic_I_tlast),      //1
//    .probe8     (cic_Ich[3:0]),     //7 cic_Ich[6:0]
//    .probe9     (fir_I_tready),     //1
//    .probe10    (fir_I_tvalid),     //1
//    .probe11    (fir_I_tlast),      //1
//    .probe12    (fir_Ich),          //7 [3:0]
//    .probe13    (adc_state),        //4 
//    .probe14    (adc_ch_cnt[10:0]), //11
//    .probe15    (adc_wr_en),        //1
//    .probe16    (adc_wr_addr),      //12
//    .probe17    (adc_data)          //8
    
////    .probe15    (adc_data),         //8 
////    .probe16    (byte_cnt[7:0]),    //8
////    .probe17    (adc_ch_cnt[10:0]), //11
////    .probe18    (adc_ok),           //1
////    .probe19    (adc_state),        //4 
////    .probe20    (adc_wr_en),        //1
////    .probe21    (adc_wr_addr),      //12
////    .probe22    (copy_st)           //4
//);


reg [7:0] bins_data_timeout=0;

//**********************************************************************************//
// for DEBUG !!!
// reg [7:0]   bins_tx_din=0;
// reg         bins_tx_en=0; 
// wire        bins_tx_busy;
// wire        bins_tx_ready;
// wire        bins_tx_dout;
// 
// uart_tx_bins uart_tx_inst
// (
// 	.clockIN		(clk_125Mhz),//(clk_50Mhz),
// 	.nTxResetIN		(1'b1),
// 	.txDataIN		(dbg_rx_byte),//(bins_tx_din),
// 	.txLoadIN		(dbg_serial_rdy),//(bins_tx_en),
// 	.txIdleOUT		(bins_tx_busy), //active tx -> tx_busy -> low; idle -> high
// 	.txReadyOUT		(bins_tx_ready),
// 	.txOUT			(bins_tx_dout)
// );


//assign ser1_tx  = bins_tx_dout;
//assign ser1_rse = (~bins_tx_busy)?(1'b1):(1'b0);
//assign ser1_rse = 1'b1;//(~bins_tx_ready)?(1'b1):(1'b0);



reg [3:0] bins_tx_st=0;
reg [7:0] send_cnt=0;
/*
always@(posedge clk_50Mhz) begin 
    case(bins_tx_st)
        0: begin    //IDLE
            bins_tx_en      <=0;
            bins_rx_rd_en   <=0;
            if( bins_rx_rd_data_count>=50) begin //active tx -> tx_busy -> low; idle -> high
                bins_tx_st      <=1;
                bins_rx_rd_en   <=1; //FIFO read enable
                send_cnt        <=0;
            end
        end
        
        1: begin
            bins_tx_st<=2; //Latency 1 clk for read from FIFO
        end
        
        2: begin    
            bins_tx_en      <=1;
            bins_tx_din     <=bins_rx_dout;
            bins_rx_rd_en   <=0;
            bins_tx_st      <=3;
        end
        
        3: begin
            bins_tx_en      <=0;
            if(!bins_tx_busy) begin
                send_cnt<=send_cnt+1'b1;
                bins_tx_st<=4;
            end
        end
        
        4: begin
            if(send_cnt<8'd49) begin
                if(bins_tx_busy) begin
                    bins_rx_rd_en<=1;
                    bins_tx_st<=2;
                end
            end
            else begin
                send_cnt<=0;
                bins_tx_st<=5; 
            end
        end
        
        5: begin //end bytes
            if(bins_tx_busy) begin
                bins_tx_en  <=1;
                bins_tx_din <=bins_rx_dout;
                bins_tx_st  <=6; 
            end
        end
        
        6: begin
            bins_tx_en<=0;
            if(!bins_tx_busy)
                bins_tx_st<=0;
        end
        
        default: bins_tx_st<=0;
    endcase  
end*/


/*
    .fifo_rx_rd_en          (bins_rx_rd_en),
    .fifo_rx_dout           (bins_rx_dout),
    .fifo_rx_rd_data_count  (bins_rx_rd_data_count),
*/

/*
always@(posedge clk_50Mhz) begin 
    case(bins_tx_st)
        0: begin    //IDLE
            bins_tx_en      <=0;
            bins_rx_rd_en   <=0;
            send_cnt        <=0;
            if( bins_rx_rd_data_count>=50) begin 
                bins_tx_st      <=1;
                bins_rx_rd_en   <=1; //FIFO read enable
            end
        end
        
        1: begin
            bins_tx_st<=2; //Latency 1 clk for read from FIFO
        end
        
        2: begin    
            bins_tx_en      <=1;
            bins_tx_din     <=bins_rx_dout;
            send_cnt        <=send_cnt+1'b1;
            if( bins_rx_rd_data_count==1) begin 
                bins_tx_st      <=0;
            end
        end
        default: bins_tx_st<=0;
    endcase  
end*/

/*
ila_bins ila_bins_rx
( 
    .clk        (clk_50Mhz), 
    .probe0     (bins_tx_st),               //4  
    .probe1     (bins_tx_en),               //1
    .probe2     (bins_rx_rd_en),            //1
    .probe3     (bins_rx_rd_data_count),    //10
    .probe4     (bins_rx_dout),             //8
    .probe5     (send_cnt),                 //8
    .probe6     (bins_tx_din),              //8
    .probe7     (bins_tx_ready)             //1
);*/



//**********************************************************************************//











always@(posedge clk_125Mhz) begin
//    ram_bins_rd_en <= !ram_bins_rd_en; 



    case(r_rst2)
        0: begin //RESET
            //skp_timeout<=0;
            bins_data_timeout<=0;
        end
        
        1: begin //WORK
        

            
            //***************************************************************************************//
            // BINS                                                                                 *//
            //***************************************************************************************//
            case(bins_st)
                0: begin
                    bins_rx_rd_en<=1'b0;
                    case(bins_timeout)		//0.1s timeout
                        32'd12499999: begin
                            case(bins_clear_st)
                                0: begin
                                    //for packet ADC
                                    ram_bins_wr_en		<=1'b1;
                                    ram_bins_wr_addr	<=1'b0;
                                    ram_bins_din		<=1'b0;
                                    
                                    //for packet 26100
                                    if(ram_bins_26100_rd_en==0) begin
                                        ram_bins_26100_wr_en	<=1'b1;
                                        ram_bins_26100_wr_addr	<=1'b0;
                                        ram_bins_26100_din		<=1'b0;
                                    end    
                                    bins_clear_st		<=bins_clear_st+1'b1;
                                end
                                50: begin
                                    //for packet ADC
                                    ram_bins_wr_en          <=1'b0;
                                    ram_bins_wr_addr        <=1'b0;
                                    bins_clear_st		    <=1'b0;
                                    bins_timeout            <=bins_timeout+1'b1;
                                    
                                    //for packet 26100
                                    ram_bins_26100_wr_en    <=1'b0;
                                    ram_bins_26100_wr_addr  <=1'b0;
                                end
                                default: begin
                                    //for packet ADC
                                    ram_bins_din            <=1'b0;
                                    ram_bins_wr_addr        <=ram_bins_wr_addr+1'b1;
                                    bins_clear_st           <=bins_clear_st+1'b1;
                                    
                                    //for packet 26100
                                    ram_bins_26100_din      <=1'b0;
                                    ram_bins_26100_wr_addr  <=ram_bins_26100_wr_addr+1'b1;
                                end
                            endcase
                        end
                        32'd12500000: begin //TIMEOUT
                            //Idle
                            /*case(clear_26100_bins_st)
                                0: begin						
                                    if(event_26100_bins_ok) begin
                                        event_26100_bins_rd		<=1'b1;
                                        ram_bins_26100_din		<=1'b0;
                                        ram_bins_26100_wr_en	<=1'b1;
                                        ram_bins_26100_wr_addr	<=1'b0;
                                        clear_26100_bins_st		<=clear_26100_bins_st+1'b1;
                                    end
                                end
                                1: begin
                                    event_26100_bins_rd			<=1'b0;
                                    ram_bins_26100_din			<=1'b0;
                                    ram_bins_26100_wr_addr		<=ram_bins_26100_wr_addr+1'b1;
                                    clear_26100_bins_st			<=clear_26100_bins_st+1'b1;
                                end
                                50: begin								
                                    ram_bins_26100_wr_en		<=1'b0;
                                    ram_bins_26100_wr_addr		<=1'b0;
                                    clear_26100_bins_st			<=1'b0;
                                end
                                default: begin
                                    ram_bins_26100_din			<=1'b0;
                                    ram_bins_26100_wr_addr		<=ram_bins_26100_wr_addr+1'b1;
                                    clear_26100_bins_st			<=clear_26100_bins_st+1'b1;
                                end
                            endcase*/
                        end
                        default: bins_timeout<=bins_timeout+1'b1;
                    endcase
                    
                    if( bins_rx_rd_data_count>=50 && !bins_data_lock ) begin
                        bins_timeout    <=0;
                        bins_rx_rd_en   <=1; //FIFO read enable
                        bins_st         <=bins_st+1;
                        
                        bins_data_lock  <=1;
                        ram_bins_wr_en  <=1;
                        ram_bins_wr_addr<=0;
                        
                        if(event_26100_bins_ok && ram_bins_26100_rd_en==0) begin
                            event_26100_bins_rd		<=1;
                            ram_bins_26100_wr_en	<=1;
                            ram_bins_26100_wr_addr	<=0;
                        end
                    end
                end
     
                1: begin //Latency 1 clk for read from FIFO
                    bins_st<=bins_st+1;
                    event_26100_bins_rd<=0;
                    /*if(!bins_data_lock) begin
                        bins_data_lock		<=1;
                        ram_bins_wr_en		<=1;
                        ram_bins_wr_addr	<=0;
                    end
                    
                    if(event_26100_bins_ok) begin
                        event_26100_bins_rd		<=1;
                        ram_bins_26100_wr_en	<=1;
                        ram_bins_26100_wr_addr	<=0;
                    end*/
                end

                2: begin	//WRITE to RAM
                    //if( bins_rx_rd_data_count>1 || ram_bins_wr_addr<=48 ) begin //24.08.2020
                    if( bins_rx_rd_data_count>1) begin //25.08.2020
                        case(ram_st)
                            0: begin
                                //if( (ram_bins_wr_addr == 0) && (bins_rx_dout==8'hC1) ) begin //24.08.2020
                                    ram_bins_din		<=bins_rx_dout;
                                    ram_bins_wr_addr	<=0;
                                    ram_st              <=ram_st+1;
                                    
                                    //Write to RAM 26100
                                    if(ram_bins_26100_wr_en) begin
                                        ram_bins_26100_din		<=bins_rx_dout;
                                        ram_bins_26100_wr_addr	<=0;
                                    end
                            end
                            
                            1: begin
                                ram_bins_din		<=bins_rx_dout;
                                ram_bins_wr_addr	<=ram_bins_wr_addr+1;
                                
                                //Write to RAM 26100
                                if(ram_bins_26100_wr_en) begin
                                    ram_bins_26100_din		<=bins_rx_dout;
                                    ram_bins_26100_wr_addr	<=ram_bins_26100_wr_addr+1;
                                end
                            end
                        endcase
                    end
                    else begin
                        ram_bins_din		<=bins_rx_dout;
                        ram_bins_wr_addr	<=ram_bins_wr_addr+1;
                        bins_st				<=bins_st+1;
                        bins_rx_rd_en  		<=0;
                        bins_data_lock 		<=0;
                        ram_st				<=0;	
                        //event_26100_bins_rd	<=0;	
                        
                        //Write to RAM 26100
                        if(ram_bins_26100_wr_en) begin
                            ram_bins_26100_din		<=bins_rx_dout;
                            ram_bins_26100_wr_addr	<=ram_bins_26100_wr_addr+1;
                        end
                    end
                end
                
                3: begin
                    bins_st				<=0;
                    ram_bins_wr_en		<=0;
                    ram_bins_wr_addr	<=0;

                    ram_bins_26100_wr_en	<=0;
                    ram_bins_26100_wr_addr	<=0;
                end

                default: bins_st<=0;
            endcase
            
            
            
            //***************************************************************************************//



            //***************************************************************************************//
            // APO                                                                                  *//
            //***************************************************************************************//
            case(apo_alg)
                0: begin
                    freq_load<=0;
                    if(apo_cnt>=18) begin
                        apo_alg<=apo_alg+1; 
                        apo_rd<=1;   
                    end
                end
                
                1: begin
                    apo_alg<=apo_alg+1; 
                end
                
                2: begin
                    if(apo_cnt>0) begin
                        apo_comm[b_cnt]<=apo_dout;
                        b_cnt<=b_cnt+1;
                    end
                    else begin
                        apo_comm[b_cnt]<=apo_dout;
                        apo_rd<=0;
                        apo_alg<=apo_alg+1; 
                    end
                end
                
                3: begin
                    apo_alg     <=0;
                    b_cnt       <=0;
                    byte_cnt    <=0;
                    word_var    <={apo_comm[13],apo_comm[12],apo_comm[11],apo_comm[10]};
                    period_varu <={apo_comm[17],apo_comm[16],apo_comm[15],apo_comm[14]};
                    freq_load	<=1;
                    
                    case(apo_comm[0])
                        8'h31:   begin work_state <=1; dac_rr <= 1; end //dac_st<=1; 
                        8'h32:   begin work_state <=2; dac_rr <= 0; end
                        8'h33:   begin work_state <=3; dac_rr <= 0; end
                        8'h34:   begin work_state <=4; dac_rr <= 0; end
                        default: begin work_state <=0; dac_rr <= 0; end
                    endcase
                    
                    cnt_get_pkt <={apo_comm[9],apo_comm[8],apo_comm[7],apo_comm[6]};
                    packet_cnt<=0;
                    
                    apo_comm[0]<=0;
                    apo_comm[6]<=0;
                    apo_comm[7]<=0;
                    apo_comm[8]<=0;
                    apo_comm[9]<=0;
                end
            endcase
            

            //***************************************************************************************//
            // ALG WORK                                                                             *//
            //***************************************************************************************//
            case(alg_work)
                
                8'h0: begin //Wait
                    adc_state <=0; 
                    if(work_state !=0)
                        alg_work<=1;
                end
                
                8'h1: begin 
                    case(work_state)           
                        
                        0: begin
                        
                        end

                        1: begin
                            case(env_st) 
                                0: begin
                                    envelope_t<= { envelope_t[0], envelope};
                                    if(envelope_t == 2'b10) begin
                                        envelope_t<=2'b11;  
                                        //trigger<=1; //to oscilloscope
                                        //work_state <=2;
                                        env_st<=1;
                                    end
                                end
                                
                                1: begin
                                    if(env_timer<32'd62500) begin //500us
                                        env_timer<=env_timer+1;
                                    end
                                    else begin
                                        env_timer<=0;
                                        env_st<=2;
                                    end
                                
                                end
                            
                                2: begin
                                    envelope_t<= { envelope_t[0], envelope};
                                    if(envelope_t == 2'b01) begin
                                        envelope_t<=2'b00;  
                                        trigger<=1; //to oscilloscope
                                        work_state <=2;
                                        env_st<=0;
                                        //trigger2<=1;
                                    end
                                end
                                
                            endcase
                        end
  
                        2: begin
                            //rst_fl<=0;
                            event_env_rd<=0;
                            if(cnt_get_pkt!=0) begin
                                //***************************************************************************************//
                                // AD DONE & ANGLE CORDIC                                                                //
                                //***************************************************************************************//
                                case(adc_state)
                                
                                 4'd0: begin
                                     adc_data    <=8'h00;
                                     byte_cnt    <=0;
                                     adc_ch_cnt  <=0;
                                     adc_ok      <=0;
                                     
                                     //WAIT valid
                                     //if( (fir_Ich==4'd0) && (fir_I_tvalid==1'b1) ) begin
                                     if(data_adc_ok) begin
                                         packet_cnt <= packet_cnt + 1;
                                         get_time_t <=time_t; 
                                         adc_state  <=adc_state+1;   
                                         lock_st    <=2'd0;
                                     end
                                 end
                                
                                 4'd1: begin //Get data from SKP
//                                    if(!skp_lock) begin
//                                        skp_data[0]  <= skp_data_t[0];
//                                        skp_data[1]  <= skp_data_t[1];
//                                        skp_data[2]  <= skp_data_t[2];
//                                        skp_data[3]  <= skp_data_t[3];
//                                        skp_data[4]  <= skp_data_t[4];
//                                        skp_data[5]  <= skp_data_t[5];
//                                        skp_data[6]  <= skp_data_t[6];
//                                        skp_data[7]  <= skp_data_t[7];
//                                        skp_data[8]  <= skp_data_t[8];
//                                        skp_data[9]  <= skp_data_t[9];
//                                        skp_data[10] <= skp_data_t[10];
//                                        skp_data[11] <= skp_data_t[11];
//                                        skp_data[12] <= skp_data_t[12];
//                                        skp_data[13] <= skp_data_t[13];
//                                        skp_data[14] <= skp_data_t[14];
//                                        skp_data[15] <= skp_data_t[15];
//                                        skp_data[16] <= skp_data_t[16];
//                                        skp_data[17] <= skp_data_t[17];
//                                        skp_data[18] <= skp_data_t[18];
//                                        skp_data[19] <= skp_data_t[19];
//                                        skp_data[20] <= skp_data_t[20];
//                                        skp_data[21] <= skp_data_t[21]; //22 bytes
//                                    end
                                    adc_state  <=adc_state+1; 
                                 end
                                
                                 4'd2: begin

                                     case(byte_cnt)
                                     
                                        0: begin
                                            adc_wr_en<=1;
                                            adc_data <=get_time_t[7:0];
                                            byte_cnt <=byte_cnt+1'b1;  
                                            adc_wr_addr<=adc_wr_addr+1;
                                        end
                                     
                                        1: begin
                                            adc_data <=get_time_t[15:8];
                                            byte_cnt <=byte_cnt+1'b1;  
                                            adc_wr_addr<=adc_wr_addr+1;
                                        end
                                        
                                        2: begin
                                            adc_data <=get_time_t[23:16];
                                            byte_cnt <=byte_cnt+1'b1;  
                                            adc_wr_addr<=adc_wr_addr+1;
                                        end
                                        
                                        3: begin
                                            adc_data <=get_time_t[31:24];
                                            byte_cnt <=byte_cnt+1'b1; 
                                            adc_wr_addr<=adc_wr_addr+1;
                                        end
                                
                                        4: begin // packet cnt
                                            adc_data <=packet_cnt[7:0];
                                            byte_cnt <=byte_cnt+1'b1; 
                                            adc_wr_addr<=adc_wr_addr+1;
                                        end
                                        
                                        5: begin
                                            adc_data <=packet_cnt[15:8];
                                            byte_cnt <=byte_cnt+1'b1;  
                                            adc_wr_addr<=adc_wr_addr+1;
                                        end
                                        
                                        6: begin
                                            adc_data <=packet_cnt[23:16];
                                            byte_cnt <=byte_cnt+1'b1; 
                                            adc_wr_addr<=adc_wr_addr+1;
                                            bins_data_timeout<=0;
                                        end
                                        
                                        7: begin
//                                            adc_data <=packet_cnt[31:24];
//                                            byte_cnt <=byte_cnt+1'b1; 

                                            adc_data 	<=packet_cnt[31:24];
                                            
                                            if(!bins_data_lock) begin
                                                byte_cnt 			<=byte_cnt+1;  
                                                bins_data_lock		<=1;
                                                ram_bins_rd_addr	<=0;
                                                adc_wr_addr         <=adc_wr_addr+1;
                                            end
                                            else begin
                                                if(bins_data_timeout<=100) begin //wait data from BINS
                                                    bins_data_timeout<=bins_data_timeout+1'b1;
                                                end
                                                else begin
                                                    byte_cnt 			<=0;
                                                    copy_st  			<=0;
                                                    adc_state			<=adc_state+1; 
                                                    adc_wr_addr			<=adc_wr_addr+51;
                                                end
                                            end
                                            
                                     //       ram_bins_rd_en <= 1;        //====15.08
                                               
                                        end //end packet cnt
                                        //*************************************************************************************************//
                                
                                        //*************************************************************************************************//
                                        //SKP
//                                        8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28: begin
//                                            byte_cnt <=byte_cnt+1'b1;    
//                                            adc_data <= skp_data[byte_cnt-8];
//                                        end
                                         
//                                        29: begin
//                                            adc_data <= skp_data[21];
//                                            byte_cnt <=0;
//                                            copy_st  <=0;//copy_st  <=1; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//                                            adc_state<=adc_state+1;  
//                                            adc_ch<=0;
//                                        end
                                        //*************************************************************************************************//



                                        //*************************************************************************************************//
                                        //BINS - 50bytes
                                        8: begin
                                            bins_data_timeout   <=0;
                                            adc_data 			<=ram_bins_dout;
                                            ram_bins_rd_addr	<=1;
                                            adc_wr_addr			<=adc_wr_addr+1; 
                                            byte_cnt 			<=byte_cnt+1;  
                                        end

                                        9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57: begin
                                            adc_data 			<=ram_bins_dout;
                              //              adc_data 			<=8'h67; 
                                            ram_bins_rd_addr	<=ram_bins_rd_addr+1;
                                            adc_wr_addr			<=adc_wr_addr+1; 
                                            byte_cnt 			<=byte_cnt+1;  
                                        end
                                
                                        58: begin
                                            bins_data_lock		<=0;
                                            ram_bins_rd_addr	<=0;
                                            adc_data 			<=0; //pressure meter
                                            adc_wr_addr			<=adc_wr_addr+1; 
                                            byte_cnt 			<=byte_cnt+1;  
                                            
                                    //        ram_bins_rd_en <= 0;        //====15.08 
                                    //        ram_bins_rd_en <= !ram_bins_rd_en;        //====15.08 
                                        end
                                
                                        59: begin
                                            adc_data 			<=0; //pressure meter
                                            adc_wr_addr			<=adc_wr_addr+1; 
                                            byte_cnt 			<=byte_cnt+1;  
                                        end

                                        60: begin
                                            adc_data 			<=0; //pressure meter
                                            adc_wr_addr			<=adc_wr_addr+1; 
                                            byte_cnt 			<=byte_cnt+1;  
                                        end

                                        61: begin
                                            adc_data 			<=0; //pressure meter   //bins_data[49]; 
                                            adc_wr_addr			<=adc_wr_addr+1; 
                                            adc_state			<=adc_state+1; 
                                            byte_cnt 			<=0;
                                            copy_st  			<=0;
                                            adc_cnt     		<=0;
                                            adc_ch				<=0;
                                        end
                                         
                                        default: begin 
                                            byte_cnt<=0;
                                            adc_data<=8'h00;
                                            adc_ch<=0;
                                        end
                                     endcase
                                 end

                                 4'd3: begin //copy 85 ch/samples 
                                    case(copy_st)
                                    
                                        0: begin
                                            adc_wr_en   <=1; 
                                            adc_wr_addr <=adc_wr_addr+1;

                                            case(adc_cnt)
                                /*               0:   begin                                        //==== 23.07
                                                       adc_data <= test_51Hz[7:0];              
                                                       adc_cnt  <= adc_cnt + 1;
                                               end
                                            
                                               1:   begin                                        //==== 23.07
                                                        adc_data <= test_51Hz[15:8];              
                                                        adc_cnt  <= adc_cnt + 1;
                                               end          */
                                               
                                 /*              2, 4, 6, 8, 10, 
                                               12:   begin                   //==== 10.08
                                                       adc_data <= test_51Hz[7:0];              
                                                       adc_cnt  <= adc_cnt + 1;
                                               end
                                            
                                               3, 5, 7, 9, 11, 
                                               13:   begin            //==== 10.08
                                                        adc_data <= test_51Hz[15:8];              
                                                        adc_cnt  <= adc_cnt + 1;
                                               end          */
                                               
                                               /*0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80,
                                               82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122, 124, 126, 128, 130, 132, 134, 136, 138, 140, 142, 144, 146,
                                               148, 150, 152, 154, 156, 158, 160, 162, 164, 166:   begin                   //==== 10.08
                                   //                    adc_data <= test_51Hz[7:0];                     //==== 13.08
                                                       adc_data <= data_adc[adc_ch][7:0];                //==== 13.08
                                                       adc_cnt  <= adc_cnt + 1;
                                               end*/
                                            
                                               /*1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67, 69, 71, 73, 75, 77, 79, 81,
                                               83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103, 105, 107, 109, 111, 113, 115, 117, 119, 121, 123, 125, 127, 129, 131, 133, 135, 137, 139, 141, 143, 145, 147,
                                               149, 151, 153, 155, 157, 159, 161, 163, 165, 167:   begin            //==== 10.08
                                   //                     adc_data <= test_51Hz[15:8];                  //==== 13.08
                                                        adc_data <= data_adc[adc_ch][15:8];             //==== 13.08    
                                                        adc_cnt  <= adc_cnt + 1;
                                               end  */        
                                            
    
                                                168: begin
                                                    //adc_data <= 8'hA7;
                                                    adc_data <= data_adc[adc_ch][7:0];        //==== 22.07               
                                     //               adc_data <= test_51Hz[7:0];               //==== 22.07
                                                    
                                                    
                                                    //adc_temp <= data_adc[adc_ch][15:8];
                                                    adc_cnt  <= adc_cnt+1;
                                                end
                                                
                                                169: begin
                                                    //adc_data <= 8'hB8;
                                                    adc_data <= data_adc[adc_ch][15:8];       //==== 22.07
                                     //               adc_data <= test_51Hz[15:8];                //==== 22.07
                                                    
                                                    
                                                    //adc_data    <= adc_temp;
                                                    adc_cnt     <= 0;
                                                    adc_ch      <= 0;
                                                    //adc_wr_en   <= 0;  
                                                    copy_st     <= copy_st+1;                                        
                                                end

                                                default: begin
                                                    case(adc_i)
                                                        0: begin //Write MSB
                                                            adc_data <= data_adc[adc_ch][7:0];            
                                                            //adc_temp <= data_adc[adc_ch][15:8];
                                                            
                                                            adc_cnt  <= adc_cnt+1;
                                                            adc_i<=1;
                                                        end
                                                        
                                                        1: begin //Write LSB
                                                            adc_data <= data_adc[adc_ch][15:8];           
                                                            //adc_data <= adc_temp;
                                                                                                                    
                                                            adc_cnt  <= adc_cnt+1;
                                                            adc_ch   <= adc_ch+1; 
                                                            adc_i<=0;
                                                        end
                                                        
                                                        default: adc_i<=0;
                                                    endcase  
                                                end
                                            endcase
                                        end
                                         
                                        1: begin //Wait next adc samples 85 ch
                                            adc_wr_en   <= 0;  
                                            //if(adc_wr_addr<1390) begin    // SKP version
                                            if(adc_wr_addr<1422) begin      // BINS version
                                                if(data_adc_ok) begin
                                                    //copy 85 samples from ADC
//                                                    for(int adc_i2=0; adc_i2 < 85; adc_i2=adc_i2+1) begin
//                                                        data_adc2[adc_i2]<=data_adc[adc_i2];
//                                                    end
                                                    copy_st<=0;
                                                end
                                            end
                                            else begin
                                                adc_state<=adc_state+1; 
                                            end   
                                        end
                                    endcase
                                end

                                 4'd4: begin
                                    adc_ok      <=1'b1;//Pulse
                                    adc_wr_en   <=0;
                                    adc_wr_addr <=0;
                                    adc_state   <=4'd0;
                                    
                                    
                                    //trigger<=0; //to oscilloscope
                                    
                                                                             
                                    if(cnt_get_pkt>0)
                                       cnt_get_pkt<=cnt_get_pkt-1'b1;
                                 end
                                 
                                 //default: adc_state <=0;
                                  
                                endcase
                                //***************************************************************************************//
                                // END                                                                                   //
                                //***************************************************************************************//
                            end
                            else begin
                                alg_work    <=0;
                                work_state  <=0;      //==== 27.07 
                                packet_cnt  <=0;
                                adc_state   <=0;
                                trigger     <=0; //to oscilloscope
                                //trigger2    <=0;
                            end 
                        end
                        
                        3: begin
                            alg_work    <=0;
                            work_state  <=0; 
                            packet_cnt  <=0; 
                            //trigger<=0;  
                            //adc_state   <=0;                    
                        end
                        
                        4: begin
                            alg_work    <=0;
                            work_state  <=0; 
                            packet_cnt  <=0;   
                            //trigger<=0;
                            //adc_state   <=0;                   
                        end
                        
                        default: begin
                            alg_work    <=0;
                            work_state  <=0; 
                            packet_cnt  <=0;
                            //trigger<=0;
                            //adc_state   <=0;
                        end
                        
                    endcase
                end

            endcase
            //***************************************************************************************//
            // END                                                                                   //
            //***************************************************************************************//

        end
    endcase  		
end

// ila_test    ila_test_i ( .clk(clk_125Mhz),
// 
//                          .probe0(ser2_rx),
//                          .probe1(ser2_tx),
//                          .probe2(ser2_rse),
//                          
//                          .probe3(bins_rx_rd_en),
//                          .probe4(bins_rx_dout),
//                          .probe5(bins_rx_rd_data_count),
//                          
//                          .probe6(ram_bins_din),
//                          .probe7(ram_bins_wr_en),
//                          .probe8(ram_bins_wr_addr),
//                          
//                         /*.probe9(ram_bins_rd_en),*/
//                          .probe9(1'b1),
//                          .probe10(ram_bins_rd_addr),
//                          .probe11(ram_bins_dout),
//                          
//                          .probe12(byte_cnt),
//                          .probe13(adc_state),
//                          .probe14(work_state),
//                          
//                          .probe15(copy_st),
//                          .probe16(bins_st),
//                          .probe17(r_rst2),
//                          
//                          .probe18(fifo_rx_wr_en_test),
//                          .probe19(write_st_test),
//                          .probe20(serial_rdy_test),
//                          .probe21(rdy_st_test),
//                          .probe22(rx_done_test)
//                                  
//                                                 
//                         );



endmodule
