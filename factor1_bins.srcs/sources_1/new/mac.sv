`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2019 08:57:07
// Design Name: 
// Module Name: mac
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


module mac(
	input               	reset_n,
	
	//*****************************************************//
	//*Ethernet 														*//
	input               	eth_rx_clk,
	input               	eth_tx_clk,
	
	input       [7:0]   	eth_rxd,
	input               	eth_rxdv,
	input               	eth_rxer,
	
	output reg  [7:0]   	eth_txd,
	output reg          	eth_txen,           
	output reg         		eth_txer, 

	input  wire [31:0]  	eth_local_ip,
	input  wire [47:0]  	eth_local_mac,
	input  wire [15:0]  	eth_local_port,

	//*****************************************************//
	//*ADC Data 														*//
	input					adc_ok,
	input  		[7:0]   	adc_byte,
	
	//FOR DEBUG
	//output wire [7:0] 		eth_rx_state_dbg,
	
	/*output reg [7:0] 		crc1,
	output reg [7:0] 		crc2,
	output reg [7:0] 		crc3,
	output reg [7:0] 		crc4,
	output wire [31:0] 	    crc32,
	output wire [31:0] 	    crc32_next,*/
	
    //***********************************************************************************//
	//APO module
	input  wire             fifo_eth_apo_rd_clk,
	input  wire				fifo_eth_apo_rd,
	output wire	[7:0]		fifo_eth_apo_dout,
	output wire				fifo_eth_apo_empty,
	output wire	[7:0]	    fifo_eth_apo_rd_cnt,
	
	//***********************************************************************************//
    //VARU module
//    input  wire             fifo_eth_varu_rd_clk,
//    input  wire             fifo_eth_varu_rd,
//    output wire    [7:0]    fifo_eth_varu_dout,
//    output wire             fifo_eth_varu_empty,
//    output wire    [9:0]    fifo_eth_varu_rd_cnt,

    output wire [7:0]       ram_varu_din,
    output wire [9:0]       ram_varu_wr_addr,
    output wire             ram_varu_wr_en,
    output wire             ram_varu_wr_clk,
	
	//***********************************************************************************//
	//ADC module
	/*output wire 			fifo_eth_adc_rd_dbg,
	output wire [7:0]		fifo_eth_adc_dout_dbg,
	output wire 			fifo_eth_adc_empty_dbg,
	output wire 			fifo_eth_adc_full_dbg,
	output wire	[15:0]	    fifo_eth_adc_cnt_dbg,*/
	
	input  wire [11:0] 	    adc_wr_addr,
	input  wire 			adc_wr_en,
	input  wire             adc_clk,
	
	//***********************************************************************************//
	//DFS module
	//DFS -->> PC
    output wire             dfs_rx_rd_clk,
    output reg              dfs_rx_rd_en,  
    input  wire [7:0]		dfs_rx_dout,
    input  wire [9:0]		dfs_rx_cnt, 
    input  wire 			dfs_rx_eop,      //If timer >= 250 ms and rx bytes not available -> then EOP
    
    //PC -->> DFS
    output wire             dfs_tx_wr_clk,
    output reg [7:0]        dfs_tx_din,
    output reg              dfs_tx_wr_en,
    
    //PC -->> SKP
//    input  wire             event_eth_skp_clk,
//    input  wire 			event_eth_skp_rd,
//    output wire             event_eth_skp_ok,
    
//    output wire             fifo_skp_rd_clk,
//    output reg              fifo_skp_rd_en,
//    input  wire [7:0]       fifo_skp_dout,
//    input  wire [11:0]      fifo_skp_rd_data_count

    //input  wire 			skp_lock,
    //input  wire [7:0]		skp_data [25:0]
    
    
    
    
    output wire             bins_tx_wr_clk,
    output reg [7:0]        bins_tx_din,
    output reg              bins_tx_wr_en,
    
    //for debug
    /*output wire             bins_rx_rd_clk,
    output reg              bins_rx_rd_en,        
    input wire [7:0]        bins_rx_din,          
    input wire [9:0]        bins_rx_cnt,  */         
    
    
    

    input  wire				event_26100_bins_rd_clk,
    input  wire 			event_26100_bins_rd,
    output wire 			event_26100_bins_ok,
    
    output reg 				ram_bins_26100_rd_en,
    output reg  [5:0]		ram_bins_26100_rd_addr,
    input  wire [7:0]		ram_bins_26100_dout,
    input  wire 			ram_bins_26100_valid,
    input  wire 			ram_bins_26100_lock
    
);

assign bins_tx_wr_clk  = ~eth_rx_clk;
assign dfs_tx_wr_clk   = ~eth_rx_clk;
assign dfs_rx_rd_clk   = eth_tx_clk;



reg event_26100_bins_wr=0;

initial begin
    bins_tx_din=0;
    bins_tx_wr_en=0;
    ram_bins_26100_rd_en=0;
    ram_bins_26100_rd_addr=0;
    
    //bins_rx_rd_en<=0;
end



//Local variable
reg [15:0]  eth_rx_i, eth_rx_j;
reg [15:0]  eth_rx_m, eth_rx_n;

reg [15:0]  eth_icmp_cnt;
reg [31:0]  eth_chk_buf;

reg [3:0]  	eth_rx_state;
reg [15:0] 	eth_rx_byte_cnt;
reg [7:0]  	eth_rx_alg_state;

reg [3:0]  	eth_tx_state;  
reg [15:0] 	eth_tx_byte_cnt;
reg [7:0]  	eth_tx_alg_state;

//

//reg [7:0]   eth_tx_arp_data  [67:0]; 
//reg [7:0]  	eth_tx_icmp_data [109:0]; //8byte Preambule + 14byte Eth + 20byte IPv4 + 64byte ICMP (64 for Linux, 40 for Windows)
reg [7:0]   eth_tx_adc_data   [49:0];
reg [7:0]   eth_tx_26100_data [49:0];
reg [7:0]   eth_tx_26010_data [49:0];

reg [111:0] eth_layer;
reg [47:0]  eth_MAC_dst;
reg [47:0]  eth_MAC_src;
reg [15:0]  eth_type;

//(* dont_touch = "true" *) 


reg [47:0]  ICMP_MAC_src;
reg [31:0]	ICMP_IP_src;

reg [159:0] eth_IPv4_layer;
reg [7:0]   eth_IPv4_vh;
reg [7:0]   eth_IPv4_dscp;
reg [15:0]  eth_IPv4_tlen;
reg [15:0]  eth_IPv4_id;
reg [15:0]  eth_IPv4_flags;
reg [7:0]   eth_IPv4_ttl;
reg [7:0]	eth_IPv4_type;
reg [15:0]  eth_IPv4_crc;
reg [31:0]	eth_IPv4_IP_src;
reg [31:0]	eth_IPv4_IP_dst;						

reg [223:0] eth_ARP_layer;
reg [47:0]  eth_ARP_MAC_src;
reg [31:0]  eth_ARP_IP_src;
reg [31:0]  eth_ARP_IP_dst;
reg [31:0]  eth_ARP_FCS;

reg [511:0] eth_ICMP_layer;
reg [15:0]  eth_ICMP_tlen;
reg [31:0]  eth_ICMP_FCS;

reg [63:0]  eth_UDP_layer;	//8 bytes
reg [79:0]  eth_UDP_data;		//10 bytes
reg [31:0]  eth_UDP_fcs;		//4 bytes
reg [15:0]  eth_UDP_tlen;

reg [15:0]  eth_UDP_SP;
reg [15:0]  eth_UDP_DP;
reg [15:0]  eth_UDP_data_len;

reg [7:0]   eth_rx_cnt;
reg [7:0]   eth_tx_cnt;

//Events
reg 			event_eth_arp_rd;
reg 			event_eth_arp_wr;
wire			event_eth_arp_ok;

reg 			event_eth_icmp_rd;
reg 			event_eth_icmp_wr;
wire			event_eth_icmp_ok;


reg 			event_eth_control_rs485_wr;
reg 			event_eth_control_rs485_rd;
wire			event_eth_control_rs485_ok;


parameter	    rx_IDLE				=0,
				rx_PREAMBULE		=1,
                rx_ETH_layer		=2,
				rx_IPv4_layer  	    =3,
				rx_ARP_layer		=4,
				rx_ARP_TRL			=5,
				rx_ARP_FCS			=6,
				rx_ICMP_layer		=7,
				rx_ICMP_FCS			=8,
				rx_UDP_layer		=9,
				rx_APO 				=10,
				rx_DFS              =11,
				rx_RS485            =12,
				rx_VARU             =13,
				rx_BINS				=14,
				rx_DELAY			=15;
/*				
parameter 	    tx_IDLE				=0,
				tx_ADC		 		=1,	//Data from ADC
				tx_ARP		 		=2,	//Answer for request packet from eth
				tx_UDP		 		=3,
				tx_DFS              =4,
				tx_SKP              =5,
				tx_ICMP		 		=6,
				tx_ZERO             =7,
				tx_FCS	      	    =8,
				tx_IGP		   	    =9;*/
				
parameter 	    tx_IDLE				=0,
                tx_ADC		 		=1,	//Data from ADC
                tx_ARP		 		=2,	//Answer for request packet from eth
                tx_UDP		 		=3,
                tx_ICMP		 		=4,
                tx_26010            =5,
                tx_26100		 	=6,
                tx_FCS	      	    =7,
                tx_IGP		   	    =8;

reg	[31:0] fcs_t;
	
initial begin
	eth_rx_state<=rx_IDLE;
	eth_tx_state<=tx_IDLE;
	
	eth_icmp_cnt<=16'd0;
	
	eth_rx_byte_cnt<=16'd0;
	eth_rx_alg_state<=8'd0;
	
	eth_tx_byte_cnt<=16'd0;
	eth_tx_alg_state<=8'd0;
	
	eth_rx_cnt<=8'd0;
	eth_tx_cnt<=8'd0;
	
	event_eth_arp_rd	<=1'b0;
	event_eth_arp_wr	<=1'b0;
	
	//event_eth_icmp_rd<=1'b0;
	//event_eth_icmp_wr<=1'b0;
	
    event_eth_control_rs485_wr<=1'b0;
    event_eth_control_rs485_rd<=1'b0;
	
	eth_txer<=0;
	eth_txen<=0;
	
	fcs_t<=32'd0;
	
	//eth_MAC_src<=48'hFF_FF_FF_FF_FF_FF;
	eth_ARP_MAC_src<=48'hFF_FF_FF_FF_FF_FF;
end

//CRC32 Module
wire [31:0] crcnext;
wire [31:0] fcs;
reg	crcrst;
reg	crcen;

assign crc32      = {~fcs[24], ~fcs[25], ~fcs[26], ~fcs[27], ~fcs[28], ~fcs[29], ~fcs[30], ~fcs[31], ~fcs[16], ~fcs[17], ~fcs[18], ~fcs[19], ~fcs[20], ~fcs[21], ~fcs[22], ~fcs[23], ~fcs[8], ~fcs[9], ~fcs[10], ~fcs[11], ~fcs[12], ~fcs[13], ~fcs[14], ~fcs[15], ~fcs[0], ~fcs[1], ~fcs[2], ~fcs[3], ~fcs[4], ~fcs[5], ~fcs[6], ~fcs[7]};
assign crc32_next = {~crcnext[24], ~crcnext[25], ~crcnext[26], ~crcnext[27], ~crcnext[28], ~crcnext[29], ~crcnext[30], ~crcnext[31], 
					 ~crcnext[16], ~crcnext[17], ~crcnext[18], ~crcnext[19], ~crcnext[20], ~crcnext[21], ~crcnext[22], ~crcnext[23], 
					 ~crcnext[8],  ~crcnext[9],  ~crcnext[10], ~crcnext[11], ~crcnext[12], ~crcnext[13], ~crcnext[14], ~crcnext[15], 
					 ~crcnext[0],  ~crcnext[1],  ~crcnext[2],  ~crcnext[3],  ~crcnext[4],  ~crcnext[5],  ~crcnext[6],  ~crcnext[7]};


//input 8-bit data
crc crc_inst
(
	.clk		(eth_tx_clk),
	.rst		(crcrst),
	.en		    (crcen),
	.data_in	(eth_txd),
	.Crc		(fcs),
	.CrcNext	(crcnext)
);

//EVENTS
events event_arp
(
	.wr_clk	(eth_rx_clk),
	.rd_clk	(eth_tx_clk),
	.rst	(1'b0),
	.rd		(event_eth_arp_rd),
	.wr		(event_eth_arp_wr),
	.out	(event_eth_arp_ok)
);

events event_26100_bins
(
    .wr_clk	(eth_rx_clk),
    .rd_clk	(event_26100_bins_rd_clk),
    .rst	(1'b0),
    .rd		(event_26100_bins_rd),
    .wr		(event_26100_bins_wr),
    .out	(event_26100_bins_ok)
);

reg  event_26100_dfs_wr=0;
reg  event_26100_dfs_rd=0;
wire event_26100_dfs_ok;

events event_26100_dfs
(
    .wr_clk	(eth_rx_clk),
    .rd_clk	(eth_tx_clk),
    .rst	(1'b0),
    .rd		(event_26100_dfs_rd),
    .wr		(event_26100_dfs_wr),
    .out	(event_26100_dfs_ok)
);

reg  event_26010_dfs_wr=0;
reg  event_26010_dfs_rd=0;
wire event_26010_dfs_ok;

events event_26010_dfs
(
    .wr_clk	(eth_rx_clk),
    .rd_clk	(eth_tx_clk),
    .rst	(1'b0),
    .rd		(event_26010_dfs_rd),
    .wr		(event_26010_dfs_wr),
    .out	(event_26010_dfs_ok)
);





/*
events event_control_rs485
(
	.wr_clk	(eth_rx_clk),
	.rd_clk	(eth_tx_clk),
	.rst	(1'b0),
	.rd		(event_eth_control_rs485_rd),
	.wr		(event_eth_control_rs485_wr),
	.out	(event_eth_control_rs485_ok)
);*/

//events event_icmp
//(
//	.wr_clk	(eth_rx_clk),
//	.rd_clk	(eth_tx_clk),
//	.rst		(1'b0),
//	.rd		(event_eth_icmp_rd),
//	.wr		(event_eth_icmp_wr),
//	.out		(event_eth_icmp_ok)
//);
	

reg			fifo_eth_apo_wr;
reg	[7:0]	fifo_eth_apo_din;
wire	    fifo_eth_apo_full;

//reg			fifo_eth_varu_wr;
//reg	[7:0]	fifo_eth_varu_din;
//wire	    fifo_eth_varu_full;

initial begin
	fifo_eth_apo_wr  <=1'b0;
//	fifo_eth_varu_wr <=1'b0;
end
	
//********************************************************//
//*Put APO Packet in FIFO 								 *//
//********************************************************//	
wire [7:0] fifo_eth_apo_wr_cnt;
fifo_apo    fifo_apo_inst( 	
                .rst            (1'b0),
                .wr_clk         (~eth_rx_clk),
                .rd_clk         (fifo_eth_apo_rd_clk),
                .din            (fifo_eth_apo_din),
                .wr_en          (fifo_eth_apo_wr & !fifo_eth_apo_full),
                .rd_en          (fifo_eth_apo_rd & !fifo_eth_apo_empty),
                .dout           (fifo_eth_apo_dout),
                .full           (fifo_eth_apo_full),
                .empty          (fifo_eth_apo_empty),
                .rd_data_count  (fifo_eth_apo_rd_cnt),
                .wr_data_count  (fifo_eth_apo_wr_cnt)
            );
 
            
reg [7:0] varu_din=0;
reg [9:0] varu_wr_addr=0;
reg       varu_wr_en=0;

//VARU
assign ram_varu_din     = varu_din;
assign ram_varu_wr_addr = varu_wr_addr;
assign ram_varu_wr_en   = varu_wr_en;
assign ram_varu_wr_clk  = eth_rx_clk;


initial begin
    dfs_tx_din<=8'h00;
    dfs_tx_wr_en<=1'b0;
end

	
//***********************************************************************************************************************//
//*ETHERNET1: RECEIVE PACKET'S																														*//
//***********************************************************************************************************************//
always@(negedge eth_rx_clk) begin
	
	case(eth_rx_state)
		rx_IDLE:       begin
            /*event_eth_arp_wr            <=1'b0;
            event_eth_icmp_wr           <=1'b0;
            event_eth_control_rs485_wr  <=1'b0;
			
            fifo_eth_apo_wr     <=1'b0;
            //fifo_eth_varu_wr    <=1'b0;
            
            dfs_tx_din          <=0;
            dfs_tx_wr_en        <=0;

			eth_rx_alg_state	<=8'd0;
			eth_rx_byte_cnt	    <=16'd0;
			
			varu_wr_addr <=0;
            varu_wr_en   <=0;*/
            
            event_eth_arp_wr            <=1'b0;
            event_26100_bins_wr         <=0;
            event_26010_dfs_wr          <=0;
            event_26100_dfs_wr          <=0;
			
            fifo_eth_apo_wr     <=1'b0;
            //fifo_eth_varu_wr    <=1'b0;
            
            dfs_tx_din          <=0;
            dfs_tx_wr_en        <=0;
            bins_tx_wr_en		  <=0;

			eth_rx_alg_state	<=8'd0;
			eth_rx_byte_cnt	    <=16'd0;
			
			varu_wr_addr <=0;
            varu_wr_en   <=0;
			
			if(eth_rxdv)  begin
				if(eth_rxd==8'h55) //1
					eth_rx_state<=rx_PREAMBULE; 
                else
                    eth_rx_state<=rx_IDLE;
			end
		end
		
		rx_PREAMBULE:  begin
			if(eth_rxdv) begin				  
				case (eth_rx_alg_state)
				
				    8'd0: begin
                        if(eth_rxd!=8'h55) //2
                            eth_rx_state<=rx_IDLE;
                        else
                            eth_rx_alg_state<=eth_rx_alg_state+1'b1;    
				    end
				    
				    8'd1: begin
                        if(eth_rxd!=8'h55) //3
                            eth_rx_state<=rx_IDLE;
                        else
                            eth_rx_alg_state<=eth_rx_alg_state+1'b1;            
                    end
                                        
                    8'd2: begin
                        if(eth_rxd!=8'h55) //4
                            eth_rx_state<=rx_IDLE;
                        else
                            eth_rx_alg_state<=eth_rx_alg_state+1'b1;                                 
                    end
                    
                    8'd3: begin
                        if(eth_rxd!=8'h55) //5 
                            eth_rx_state<=rx_IDLE;
                        else
                            eth_rx_alg_state<=eth_rx_alg_state+1'b1;                                                       
                    end 
                    
                    8'd4: begin
                        if(eth_rxd!=8'h55) //6
                            eth_rx_state<=rx_IDLE;
                        else
                            eth_rx_alg_state<=eth_rx_alg_state+1'b1;                                                     
                    end
                    
                    8'd5: begin
                        if(eth_rxd!=8'h55) //7
                            eth_rx_state<=rx_IDLE;
                        else
                            eth_rx_alg_state<=eth_rx_alg_state+1'b1;                                                     
                    end
                    
                    8'd6: begin
                        if(eth_rxd!=8'hD5) //8
                            eth_rx_state<=rx_IDLE;
                        else begin
                            eth_rx_state    <=rx_ETH_layer;
                            eth_rx_alg_state<=8'd0;
                        end                                                          
                    end 
                   
                   default: eth_rx_alg_state<=0;

				endcase
			end
			else eth_rx_state<=rx_IDLE;
		end
		
		rx_ETH_layer:  begin
			if(eth_rxdv) begin
				
//				if(eth_rx_byte_cnt<16'd13) begin
//					eth_layer	     <={eth_layer[103:0],eth_rxd};
//					eth_rx_byte_cnt  <=eth_rx_byte_cnt+1'b1;
//				end
//				else begin	
//					eth_layer	<={eth_layer[103:0],eth_rxd};
//					eth_MAC_dst	<=eth_layer[103:56];
//					eth_MAC_src	<=eth_layer[55:8];
//					eth_type	<={eth_layer[7:0],eth_rxd};
					
//					case ({eth_layer[7:0],eth_rxd}) 						//Ethernet Type Protocol
//						16'h0800: begin eth_rx_state<=rx_IPv4_layer; end 	//Receive IPv4
//						16'h0806: begin eth_rx_state<=rx_ARP_layer;  end	//Receive ARP
//						default:  begin eth_rx_state<=rx_IDLE; 		 end
//					endcase
//					eth_rx_byte_cnt <=16'd0;
//				end

                case (eth_rx_alg_state)
                
                    0:  begin eth_MAC_dst[47:40] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    1:  begin eth_MAC_dst[39:32] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    2:  begin eth_MAC_dst[31:24] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    3:  begin eth_MAC_dst[23:16] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    4:  begin eth_MAC_dst[15:8]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    5:  begin eth_MAC_dst[7:0]   <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    6:  begin eth_MAC_src[47:40] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    7:  begin eth_MAC_src[39:32] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    8:  begin eth_MAC_src[31:24] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    9:  begin eth_MAC_src[23:16] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    10: begin eth_MAC_src[15:8]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    11: begin eth_MAC_src[7:0]   <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    12: begin eth_type[15:8]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    13: begin 
                        eth_type[7:0]<= eth_rxd; 
                        
                        case ({eth_type[15:8],eth_rxd}) 						//Ethernet Type Protocol
                            16'h0800: begin eth_rx_state<=rx_IPv4_layer; end    //Receive IPv4
                            16'h0806: begin eth_rx_state<=rx_ARP_layer;  end    //Receive ARP
                            default:  begin eth_rx_state<=rx_IDLE;       end
                        endcase
                        eth_rx_alg_state<=0; 
                    end
                    default: eth_rx_alg_state<=0;
                endcase
			end
			else eth_rx_state<=rx_IDLE;
		end
		
		rx_IPv4_layer: begin
			if(eth_rxdv) begin
				
//				if(eth_rx_byte_cnt<16'd19) begin
//					eth_IPv4_layer	 <={eth_IPv4_layer[151:0],eth_rxd[7:0]};
//					eth_rx_byte_cnt <=eth_rx_byte_cnt+1'b1;
//				end
//				else begin
//					eth_IPv4_layer		<={eth_IPv4_layer[151:0],eth_rxd[7:0]};
//					eth_IPv4_vh			<=eth_IPv4_layer[151:144];
//					eth_IPv4_dscp		<=eth_IPv4_layer[143:136];
//					eth_IPv4_tlen		<=eth_IPv4_layer[135:120];
//					eth_IPv4_id			<=eth_IPv4_layer[119:104];
//					eth_IPv4_flags  	<=eth_IPv4_layer[103:88];
//					eth_IPv4_ttl		<=eth_IPv4_layer[87:80];
//					eth_IPv4_type		<=eth_IPv4_layer[79:72];
//					eth_IPv4_crc		<=eth_IPv4_layer[71:56];
//					eth_IPv4_IP_src	<=eth_IPv4_layer[55:24];
//					eth_IPv4_IP_dst	<={eth_IPv4_layer[23:0],eth_rxd[7:0]};
					
//					case (eth_IPv4_layer[79:72])								//IPv4 Type Protocol
//						8'd01: begin 												//ICMP
//							eth_ICMP_tlen <=eth_IPv4_layer[135:120] - 16'd20; 
//							eth_rx_state  <=rx_ICMP_layer; end	
//						8'd17: begin 												//UDP
//							eth_UDP_tlen  <=eth_IPv4_layer[135:120] - 16'd20; 
//							eth_rx_state  <=rx_UDP_layer;  end
//						default: eth_rx_state<=rx_IDLE;
//					endcase
//					eth_rx_byte_cnt <=16'd0;
//				end

                case (eth_rx_alg_state)
                    
                    2:  begin eth_IPv4_tlen[15:8]    <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    3:  begin eth_IPv4_tlen[7:0]     <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    9:  begin eth_IPv4_type          <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end

                    12: begin eth_IPv4_IP_src[31:24] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    13: begin eth_IPv4_IP_src[23:16] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    14: begin eth_IPv4_IP_src[15:8]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    15: begin eth_IPv4_IP_src[7:0]   <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    16: begin eth_IPv4_IP_dst[31:24] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    17: begin eth_IPv4_IP_dst[23:16] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    18: begin eth_IPv4_IP_dst[15:8]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    19: begin 
                        eth_IPv4_IP_dst[7:0] <= eth_rxd;
                        case (eth_IPv4_type)								//IPv4 Type Protocol
//                            8'd01: begin                                                 //ICMP
//                                eth_ICMP_tlen <=eth_IPv4_layer[135:120] - 16'd20; 
//                                eth_rx_state  <=rx_ICMP_layer; end    
                            8'd17: begin                                                 //UDP
                                eth_UDP_tlen  <=eth_IPv4_tlen - 16'd20; 
                                eth_rx_state  <=rx_UDP_layer;  
                            end
                            default: eth_rx_state<=rx_IDLE;
                        endcase
                        //eth_rx_state <=rx_IDLE;
                        eth_rx_alg_state<=0; 
                    end
                    
                    default: eth_rx_alg_state<=eth_rx_alg_state+1;
                    
                endcase
				
			end
			else eth_rx_state<=rx_IDLE;
		end
		
		rx_ARP_layer:  begin
			if(eth_rxdv) begin
//				if(eth_rx_byte_cnt<16'd27) begin
//					eth_ARP_layer		<={eth_ARP_layer[215:0],eth_rxd};
//					eth_rx_byte_cnt	<=eth_rx_byte_cnt+1'b1;
//				end
//				else begin
//					//eth_ARP_layer	<={eth_ARP_layer[215:0],eth_rxd};
//					eth_ARP_MAC_src	<=eth_ARP_layer[151:104];
//					eth_ARP_IP_src	<=eth_ARP_layer[103:72];	
//					eth_ARP_IP_dst	<={eth_ARP_layer[23:0],eth_rxd};	
//					eth_rx_byte_cnt	<=16'd0;
//					if(eth_local_ip == {eth_ARP_layer[23:0],eth_rxd}) begin
//						event_eth_arp_wr	<=1'b1; 
//					end
//					eth_rx_state <=rx_IDLE;
//				end

                case (eth_rx_alg_state)
                                
                    //eth_ARP_HW_type[15:0]     2   0 1
                    //eth_ARP_PR_type[15:0]     2   2 3
                    //eth_ARP_HW_size[7:0]      1   4
                    //eth_ARP_PR_size[7:0]      1   5
                    //eth_ARP_Opcode[15:0]      2   6 7
                    //eth_ARP_MAC_src[47:0]     6   8 9 10 11 12 13
                    //eth_ARP_IP_src[31:0]      4   14 15 16 17
                    //eth_ARP_MAC_dst[47:0]     6   18 19 20 21 22 23 
                    //eth_ARP_IP_dst[31:0]      4   24 25 26 27
                    //28 bytes
                    
                    8:  begin eth_ARP_MAC_src[47:40] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    9:  begin eth_ARP_MAC_src[39:32] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    10: begin eth_ARP_MAC_src[31:24] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    11: begin eth_ARP_MAC_src[23:16] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    12: begin eth_ARP_MAC_src[15:8]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    13: begin eth_ARP_MAC_src[7:0]   <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    14: begin eth_ARP_IP_src[31:24]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    15: begin eth_ARP_IP_src[23:16]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    16: begin eth_ARP_IP_src[15:8]   <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    17: begin eth_ARP_IP_src[7:0]    <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    24: begin eth_ARP_IP_dst[31:24]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    25: begin eth_ARP_IP_dst[23:16]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    26: begin eth_ARP_IP_dst[15:8]   <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    27: begin 
                        eth_ARP_IP_dst[7:0] <= eth_rxd;
                        if(eth_local_ip == {eth_ARP_IP_dst[31:8],eth_rxd}) begin
                            event_eth_arp_wr    <=1'b1; 
                        end
                        eth_rx_state <=rx_IDLE;
                        eth_rx_alg_state<=0; 
                    end
                    
                    default: eth_rx_alg_state<=eth_rx_alg_state+1;
                    
                endcase

			end
			else eth_rx_state <=rx_IDLE;
		end
		
		rx_ICMP_layer: begin
//			if(eth_rxdv) begin
//				if(eth_rx_byte_cnt<(eth_ICMP_tlen-1'b1)) begin
//					eth_ICMP_layer	<={eth_ICMP_layer[503:0],eth_rxd};
//					eth_rx_byte_cnt	<=eth_rx_byte_cnt+1'b1;
//				end
//				else begin
//					eth_ICMP_layer	<={eth_ICMP_layer[503:0],eth_rxd};
//					eth_rx_byte_cnt	<=16'd0;
//					if(eth_local_ip == eth_IPv4_IP_dst) begin
//						event_eth_icmp_wr<=1'b1;
						
//						//save
//						ICMP_MAC_src <= eth_MAC_src;
//						ICMP_IP_src	 <= eth_IPv4_IP_src;
//					end
//					eth_rx_state	<=rx_IDLE;
//				end
//			end
//			else eth_rx_state<=rx_IDLE;
            eth_rx_state<=rx_IDLE;
		end

		rx_UDP_layer:  begin
			if(eth_rxdv) begin
				
//				if(eth_rx_byte_cnt < 16'd7) begin 							//8 byte UDP Layer
//					eth_UDP_layer		<={eth_UDP_layer[55:0],eth_rxd};
//					eth_rx_byte_cnt	<=eth_rx_byte_cnt+1'b1;
//				end
//				else begin
//					eth_UDP_layer	   <={eth_UDP_layer[55:0],eth_rxd};
//					eth_UDP_SP		   <=eth_UDP_layer[55:40];
//					eth_UDP_DP		   <=eth_UDP_layer[39:24];
//					eth_UDP_data_len   <=(eth_UDP_layer[23:8]-16'd8);	
//					eth_rx_byte_cnt	   <=16'd0;
					
//					if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_layer[39:24] == 16'd25900) && ((eth_UDP_layer[23:8]-16'd8) == 16'd18) )
//						eth_rx_state<=rx_APO;
						
//				    else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_layer[39:24] == 16'd26010) && ((eth_UDP_layer[23:8]-16'd8) > 16'd0) )
//                        eth_rx_state<=rx_DFS;  
                         
//                    else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_layer[39:24] == 16'd26100) && ((eth_UDP_layer[23:8]-16'd8) > 16'd0) )
//                        eth_rx_state<=rx_SKP;
                    
////                    else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_layer[39:24] == 16'd25800) && ((eth_UDP_layer[23:8]-16'd8) > 16'd0) )
////                        eth_rx_state<=rx_VARU;
                              
//					else
//						eth_rx_state<=rx_IDLE;
//				end

                case (eth_rx_alg_state)
                    0: begin eth_UDP_SP[15:8] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    1: begin eth_UDP_SP[7:0]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    2: begin eth_UDP_DP[15:8] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    3: begin eth_UDP_DP[7:0]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    4: begin eth_UDP_data_len[15:8] <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    5: begin eth_UDP_data_len[7:0]  <= eth_rxd; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    
                    6: begin eth_UDP_data_len <= eth_UDP_data_len - 16'd8; eth_rx_alg_state<=eth_rx_alg_state+1; end
                    7: begin
                        /*if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd25900) && (eth_UDP_data_len == 16'd18) )
                            eth_rx_state<=rx_APO;
                            
                        else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd26010) && (eth_UDP_data_len > 16'd0) )
                            eth_rx_state<=rx_DFS;  
                             
                        else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd26100) && (eth_UDP_data_len > 16'd0) )
                            eth_rx_state<=rx_SKP;
                        
                        //else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_layer[39:24] == 16'd25800) && ((eth_UDP_layer[23:8]-16'd8) > 16'd0) )
                        else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd25800) && (eth_UDP_data_len > 16'd0) )
                            eth_rx_state<=rx_VARU;
    
                        else eth_rx_state <=rx_IDLE;
                        eth_rx_alg_state<=0; */
                        
                        if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd25900) && (eth_UDP_data_len == 16'd18) )
                            eth_rx_state<=rx_APO;
                        
                        else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd26010) && (eth_UDP_data_len > 16'd0) ) begin
                            event_26010_dfs_wr  <=1;
                            eth_rx_state        <=rx_DFS;  
                        end
                        
                        else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd26100) && (eth_UDP_data_len > 16'd0) ) begin
                            event_26100_bins_wr	<=1;			//add bins
                            event_26100_dfs_wr	<=1;
                            eth_rx_state        <=rx_DFS; 
                            //eth_rx_state<=rx_RS485;
                        end
                
                        else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd26200) && (eth_UDP_data_len > 16'd0) )
                            eth_rx_state<=rx_BINS;
                
                        else if( (eth_local_ip == eth_IPv4_IP_dst) && (eth_UDP_DP == 16'd25800) && (eth_UDP_data_len > 16'd0) )
                            eth_rx_state<=rx_VARU;

                        else eth_rx_state <=rx_IDLE;
                        eth_rx_alg_state<=0; 
                    end
                    default: eth_rx_alg_state<=0;
                    
                endcase
			end
			else eth_rx_state<=rx_IDLE;
		end
		
		rx_APO:   begin   //Port = 25900
			if(eth_rxdv) begin
				if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
					fifo_eth_apo_wr    <=1'b1;
					fifo_eth_apo_din   <=eth_rxd;
					eth_rx_byte_cnt	   <=eth_rx_byte_cnt+1'b1;
				end
				else begin
					//fifo_eth_apo_wr  	<=1'b0;
					fifo_eth_apo_din   <=eth_rxd;
					eth_rx_state       <=rx_IDLE;
					eth_rx_byte_cnt	   <=16'd0;
				end	
			end
			else eth_rx_state<=rx_IDLE;
		end
		
		/*rx_DFS:   begin   //Port = 26010
		  if(eth_rxdv) begin
		      if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
                  dfs_tx_wr_en    <=1;
                  dfs_tx_din      <=eth_rxd;
                  eth_rx_byte_cnt <=eth_rx_byte_cnt+1'b1;
              end
              else begin
                  dfs_tx_din      <=eth_rxd;
                  eth_rx_state    <=rx_IDLE;
                  eth_rx_byte_cnt <=16'd0;
              end    
		  end
          else eth_rx_state<=rx_IDLE;
		end
		
		rx_SKP:   begin   //Port = 26100
		  if(eth_rxdv) begin
//		      if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
//                //skp_tx_wr_en    <=1;
//                //skp_tx_din      <=eth_rxd;
//                eth_rx_byte_cnt <=eth_rx_byte_cnt+1'b1;
//                case(eth_rx_byte_cnt)
//                    16'd0: begin
//                        if(eth_rxd == 8'h41)begin
//                            event_eth_skp_wr<=1'b1; 
//                        end
//                    end
//                endcase
//              end
//              else begin
//                //skp_tx_din      <=eth_rxd;
//                eth_rx_state    <=rx_IDLE;
//                eth_rx_byte_cnt <=16'd0;
//              end 

                if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
                  dfs_tx_wr_en    <=1;
                  dfs_tx_din      <=eth_rxd;
                  eth_rx_byte_cnt <=eth_rx_byte_cnt+1'b1;
                end
                else begin
                  dfs_tx_din      <=eth_rxd;
                  eth_rx_state    <=rx_IDLE;
                  eth_rx_byte_cnt <=16'd0;
                  event_eth_control_rs485_wr<=1'b1; //add skp or bins !!!
                end              
		  end
		  else eth_rx_state<=rx_IDLE;
		end
		
		rx_VARU:  begin   //Port = 25800
            if(eth_rxdv) begin
                if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
                    //fifo_eth_varu_wr   <=1'b1;
                    //fifo_eth_varu_din  <=eth_rxd;
                    case(eth_rx_byte_cnt)
                        0: begin
                            varu_din     <=eth_rxd;
                            varu_wr_addr <=0;
                            varu_wr_en   <=1;
                        end
                        
                        default: begin
                            varu_din     <=eth_rxd;
                            varu_wr_addr <=varu_wr_addr+1;
                        end
                    endcase

                    eth_rx_byte_cnt    <=eth_rx_byte_cnt+1'b1;
                end
                else begin
                    //fifo_eth_varu_din  <=eth_rx;
                    varu_din        <=eth_rxd;
                    //varu_wr_addr    <=varu_wr_addr+1;
                    eth_rx_byte_cnt <=16'd0; 
                    eth_rx_state    <=rx_IDLE;
                end    
            end
            else 
                eth_rx_state<=rx_IDLE;
        end
			
		rx_DELAY: begin
			if(eth_rx_byte_cnt < 16'd9) begin
				eth_rx_byte_cnt	<=eth_rx_byte_cnt+1'b1;
			end
			else begin
			   eth_rx_byte_cnt	<=16'd0;
				eth_rx_state<=rx_IDLE;
			end
		end*/
		
		
		rx_DFS:   		begin   	//Port = 26010
			if(eth_rxdv) begin
				if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
					dfs_tx_wr_en    		<=1;
					dfs_tx_din      		<=eth_rxd;
					eth_rx_byte_cnt 		<=eth_rx_byte_cnt+1'b1;
				end
				else begin
					dfs_tx_din      		<=eth_rxd;
					eth_rx_state    		<=rx_IDLE;
					eth_rx_byte_cnt 		<=16'd0;
					//event_26010_dfs_wr	    <=1;
				end    
			end
         else eth_rx_state<=rx_IDLE;
		end
		
		/*rx_RS485:   	begin   	//Port = 26100 //Control RS485
			if(eth_rxdv) begin
				if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
					dfs_tx_wr_en    		<=1;
					dfs_tx_din      		<=eth_rxd;
					eth_rx_byte_cnt 		<=eth_rx_byte_cnt+1'b1;
				end
				else begin
					dfs_tx_din      		<=eth_rxd;
					eth_rx_state    		<=rx_IDLE;
					eth_rx_byte_cnt 		<=16'd0;
					event_26100_bins_wr	    <=1;			//add bins
					event_26100_dfs_wr	    <=1;
				end              
			end
			else eth_rx_state<=rx_IDLE;
		end*/
		
		rx_BINS:			begin		//Port = 26200
			if(eth_rxdv) begin
				if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
					bins_tx_wr_en    	<=1;
					bins_tx_din      	<=eth_rxd;
					eth_rx_byte_cnt 	<=eth_rx_byte_cnt+1'b1;
				end
				else begin
					bins_tx_din			<=eth_rxd;
                    eth_rx_state    	<=rx_IDLE;
                    eth_rx_byte_cnt 	<=16'd0;
				end
			end
			else eth_rx_state<=rx_IDLE;
		end
		
		rx_VARU:  begin   //Port = 25800
            if(eth_rxdv) begin
                if(eth_rx_byte_cnt < (eth_UDP_data_len-1'b1)) begin
                    //fifo_eth_varu_wr   <=1'b1;
                    //fifo_eth_varu_din  <=eth_rxd;
                    case(eth_rx_byte_cnt)
                        0: begin
                            varu_din     <=eth_rxd;
                            varu_wr_addr <=0;
                            varu_wr_en   <=1;
                        end
                        
                        default: begin
                            varu_din     <=eth_rxd;
                            varu_wr_addr <=varu_wr_addr+1;
                        end
                    endcase

                    eth_rx_byte_cnt    <=eth_rx_byte_cnt+1'b1;
                end
                else begin
                    //fifo_eth_varu_din  <=eth_rx;
                    varu_din        <=eth_rxd;
                    //varu_wr_addr    <=varu_wr_addr+1;
                    eth_rx_byte_cnt <=16'd0; 
                    eth_rx_state    <=rx_IDLE;
                end    
            end
            else 
                eth_rx_state<=rx_IDLE;
        end
			
		rx_DELAY: begin
			if(eth_rx_byte_cnt < 16'd9) begin
				eth_rx_byte_cnt	<=eth_rx_byte_cnt+1'b1;
			end
			else begin
			   eth_rx_byte_cnt	<=16'd0;
				eth_rx_state<=rx_IDLE;
			end
		end
		
		default: eth_rx_state<=rx_IDLE;  
	endcase
end





//ila_3 ila_eth_rx
//(
//    .clk        (eth_rx_clk),
//    .probe0     (eth_rxdv),         //1
//    .probe1     (eth_rxer),         //1
//    .probe2     (eth_rxd),          //8
    
//    .probe3     (event_eth_arp_wr), //1
//    .probe4     (event_eth_arp_ok), //1
//    .probe5     (event_eth_arp_rd), //1
    
    
//    .probe6     (eth_rx_state),     //4
//    .probe7     (eth_MAC_dst),      //48
//    .probe8     (eth_MAC_src),      //48
//    .probe9     (eth_type),         //16  
    
//    .probe10    (eth_ARP_IP_dst),   //32
    
//    .probe11    (eth_IPv4_tlen),    //16
//    .probe12    (eth_IPv4_type),    //8
//    .probe13    (eth_IPv4_IP_src),  //32
//    .probe14    (eth_IPv4_IP_dst),  //32
    
//    .probe15    (eth_UDP_SP),       //16
//    .probe16    (eth_UDP_DP),       //16
//    .probe17    (eth_UDP_data_len)  //16
    
    
//);

//ila_5 ila_eth_rx
//(
//    .clk        (eth_rx_clk),
//    .probe0     (eth_rxdv),        //1
//    .probe1     (eth_rxer),        //1
//    .probe2     (eth_rxd)          //8
//);


//ila_5 ila_eth_tx
//(
//    .clk        (eth_tx_clk),
//    .probe0     (eth_txen),        //1
//    .probe1     (eth_txer),        //1
//    .probe2     (eth_txd)          //8
//);

//***********************************************************************************************************************
reg 	[15:0]eth_ADC_IPv4_ID;
reg 	[15:0]eth_tx_i;
reg 	[15:0]eth_tx_j;
reg 	[15:0]eth_tx_p;
reg 	[3:0] eth_tx_igp;
reg  	[7:0] eth_tx_temp;
reg 	[3:0] eth_tx_pre;

reg 	[15:0]eth_pre_arp_bcnt;
reg 	[15:0]eth_pre_udp_bcnt;
reg 	[15:0]eth_pre_icmp_bcnt;

reg 	[15:0]eth_icmp_i;
reg 	[15:0]eth_icmp_j;

reg 	[15:0]i1;
reg 	[15:0]j1;

reg 	[15:0]i3;
reg 	[15:0]j3;

reg	[3:0] eth_pre_arp=0;
//reg [3:0] eth_pre_udp;
//reg	[3:0] eth_pre_icmp;

reg 			fifo_eth_adc_rd;
reg 			fifo_eth_adc_wr;
wire 	[7:0] fifo_eth_adc_dout;
wire 			fifo_eth_adc_empty;
wire 			fifo_eth_adc_full;
wire 	[15:0]fifo_eth_adc_cnt;

reg			fifo_eth_arp_rd;
reg			fifo_eth_arp_wr;
reg	[7:0]	fifo_eth_arp_din;
wire	[7:0]	fifo_eth_arp_dout;
wire			fifo_eth_arp_empty;
wire			fifo_eth_arp_full;
wire	[15:0]fifo_eth_arp_cnt;

reg			fifo_eth_icmp_rd;
reg			fifo_eth_icmp_wr;
reg	[7:0]	fifo_eth_icmp_din;
wire	[7:0]	fifo_eth_icmp_dout;
wire			fifo_eth_icmp_empty;
wire			fifo_eth_icmp_full;
wire	[15:0]fifo_eth_icmp_cnt;

reg 			event_eth_adc_rd;
reg 			event_eth_adc_wr;
wire 			event_eth_adc_ok;

reg     [31:0]eth_adc_crc;
reg	    [15:0]eth_adc_i;
reg     [31:0]pkt_cnt;

reg     [17:0]eth_crc_t=0;

reg   [11:0]adc_rd_addr;
reg 			adc_rd_en;

//ARP
reg   [7:0] ram_arp_din;
reg   [8:0] ram_arp_rd_addr;
reg   [8:0] ram_arp_wr_addr;
reg			ram_arp_wr_en;
reg			ram_arp_rd_en;
wire	[7:0] ram_arp_dout;

reg 			event_arp_pre_rd;
reg 			event_arp_pre_wr;
wire 			event_arp_pre_ok;

//ICMP
reg   [7:0] ram_icmp_din;
reg   [8:0] ram_icmp_rd_addr;
reg   [8:0] ram_icmp_wr_addr;
reg			ram_icmp_wr_en;
reg			ram_icmp_rd_en;
wire	[7:0] ram_icmp_dout;

reg 			event_icmp_pre_rd;
reg 			event_icmp_pre_wr;
wire 			event_icmp_pre_ok;

reg [15:0]      dfs_pkt_cnt=0;
reg [15:0]      dfs_len=0;
reg [15:0]      dfs_ip4_len=0;
reg [15:0]      dfs_udp_len=0;
reg [15:0]      zero_cnt=0;

reg [15:0]      rs485_pkt_cnt=0;
reg [15:0]      rs485_ip4_len=0;
reg [15:0]      rs485_udp_len=0;
reg [15:0]      rs485_len=0;


initial begin
	fifo_eth_adc_rd  	<=1'b0;
	fifo_eth_adc_wr  	<=1'b0;
	fifo_eth_arp_wr  	<=1'b0;
	fifo_eth_icmp_wr 	<=1'b0;
	eth_ADC_IPv4_ID  	<=16'd0;
	eth_tx_i		    <=16'd0;
	eth_tx_j			<=16'd0;
	eth_tx_p			<=16'd0;
	eth_tx_igp			<=4'd0;
	eth_tx_temp			<=8'd0;
	eth_pre_arp_bcnt 	<=16'd0;
	eth_pre_udp_bcnt 	<=16'd0;
	eth_pre_icmp_bcnt	<=16'd0;
	//eth_pre_arp			<=4'd0;
	//eth_pre_udp			<=4'd0;
	//eth_pre_icmp		<=4'd0;
	eth_tx_pre			<=4'd0;
	eth_adc_i			<=16'd0;
	pkt_cnt				<=32'd0;
	
	//pkt_cnt				<=32'd1;
	
	adc_rd_addr			<=12'd0;
	event_eth_adc_rd	<=1'b0;
	
	//ARP
	ram_arp_din			<=0;
	ram_arp_rd_addr	<=0;
	ram_arp_wr_addr	<=0;
	ram_arp_wr_en		<=0;
	ram_arp_rd_en		<=0;

	event_arp_pre_rd	<=0;
	event_arp_pre_wr	<=0;
	
	//ICMP
	ram_icmp_din		<=0;
	ram_icmp_rd_addr	<=0;
	ram_icmp_wr_addr	<=0;
	ram_icmp_wr_en		<=0;
	ram_icmp_rd_en		<=0;

	event_icmp_pre_rd	<=0;
	event_icmp_pre_wr	<=0;
	
	dfs_rx_rd_en        <=0;

end		
	

//********************************************************//
//*Put ADC data in DUAL PORT RAM for transmission			*//
//********************************************************//
ram_adc # (4096,12) ram_adc
(
    .din		(adc_byte),			//input  [7:0] 	
    .rd_addr	(adc_rd_addr), 		//input  [11:0] 	
    .wr_addr	(adc_wr_addr),      //input  [11:0] 	
    .wr         (adc_wr_en),        //input 			
    .rd         (fifo_eth_adc_rd),	//input 			
//  .wr_clk	    (eth_tx_clk),		//input
    .wr_clk	    (adc_clk),
    .rd_clk	    (eth_tx_clk),		//input
    .dout		(fifo_eth_adc_dout)	//output [7:0] 
);

events event_adc
(
    .wr_clk     (eth_tx_clk),
    .rd_clk	    (eth_tx_clk),
    .rst		(1'b0),
    .rd         (event_eth_adc_rd),
    .wr         (adc_ok),
    .out		(event_eth_adc_ok)
);

/*
events event_26100_bins
(
    .wr_clk	    (eth_rx_clk),
    .rd_clk	    (event_26100_bins_rd_clk),
    .rst		(1'b0),
    .rd		    (event_26100_bins_rd),
    .wr		    (event_26100_bins_wr),
    .out		(event_26100_bins_ok)
);*/

//********************************************************//
//*Put ARP data in DUAL PORT RAM for transmission			*//
//********************************************************//
//ram_dual # (512,9) ram_arp
//(
//    .din		(ram_arp_din),          //input  [7:0] 	
//    .rd_addr	(ram_arp_rd_addr),      //input  [8:0] 	
//    .wr_addr	(ram_arp_wr_addr),      //input  [8:0] 	
//    .wr         (ram_arp_wr_en),        //input 			
//    .rd         (ram_arp_rd_en),		//input 			
//    .wr_clk     (eth_tx_clk),			//input
//    .rd_clk     (eth_tx_clk),           //input
//    .dout		(ram_arp_dout)          //output [7:0] 
//);

//events event_arp_pre
//(
//	.wr_clk	(eth_tx_clk),
//	.rd_clk	(eth_tx_clk),
//	.rst		(1'b0),
//	.rd		(event_arp_pre_rd),
//	.wr		(event_arp_pre_wr),
//	.out		(event_arp_pre_ok)
//);

//********************************************************//
//*Put ICMP data in DUAL PORT RAM for transmission			*//
//********************************************************//
//ram_dual # (512,9) ram_icmp
//(
//    .din        (ram_icmp_din),		//input  [7:0] 	
//    .rd_addr	(ram_icmp_rd_addr), 	//input  [8:0] 	
//    .wr_addr	(ram_icmp_wr_addr),	//input  [8:0] 	
//    .wr         (ram_icmp_wr_en), 	//input 			
//    .rd		    (ram_icmp_rd_en),		//input 			
//    .wr_clk	    (eth_tx_clk),			//input
//    .rd_clk	    (eth_tx_clk),			//input
//    .dout		(ram_icmp_dout)		//output [7:0] 
//);

//events event_icmp_pre
//(
//	.wr_clk	   (eth_tx_clk),
//	.rd_clk	   (eth_tx_clk),
//	.rst       (1'b0),
//	.rd        (event_icmp_pre_rd),
//	.wr		   (event_icmp_pre_wr),
//	.out       (event_icmp_pre_ok)
//);

//********************************************************//
//*Put ARP Packet in FIFO for transmission						*//
//********************************************************//
//fifo2 # (8,512) fifo_eth_arp
//(
//	.clk		(eth_tx_clk),
//	.rst		(1'b0),
//	.rd		(fifo_eth_arp_rd & !fifo_eth_arp_empty),
//	.wr		(fifo_eth_arp_wr & !fifo_eth_arp_full),
//	.din		(fifo_eth_arp_din),
//	.dout		(fifo_eth_arp_dout),
//	.empty	(fifo_eth_arp_empty),
//	.full		(fifo_eth_arp_full),
//	.cnt		(fifo_eth_arp_cnt)
//);
//
////********************************************************//
////*Put ICMP Packet in FIFO for transmission			*//
////********************************************************//
//fifo2 # (8,512) fifo_eth_icmp
//(
//	.clk		(eth_tx_clk),
//	.rst		(1'b0),
//	.rd		(fifo_eth_icmp_rd & !fifo_eth_icmp_empty),
//	.wr		(fifo_eth_icmp_wr & !fifo_eth_icmp_full),
//	.din		(fifo_eth_icmp_din),
//	.dout		(fifo_eth_icmp_dout),
//	.empty	(fifo_eth_icmp_empty),
//	.full		(fifo_eth_icmp_full),
//	.cnt		(fifo_eth_icmp_cnt)
//);




wire [9:0]  fifo_eth_arp_data_cnt;
fifo_arp    fifo_arp_inst
( 	
    .srst           (1'b0),
    .clk            (eth_tx_clk),
    .din            (fifo_eth_arp_din),
    .wr_en          (fifo_eth_arp_wr & !fifo_eth_arp_full),
    .rd_en          (fifo_eth_arp_rd & !fifo_eth_arp_empty),
    .dout           (fifo_eth_arp_dout),
    .full           (fifo_eth_arp_full),
    .empty          (fifo_eth_arp_empty),
    .data_count     (fifo_eth_arp_data_cnt)
);

//wire [9:0]  fifo_eth_icmp_data_cnt;
//fifo_arp    fifo_icmp_inst
//( 	
//    .srst           (1'b0),
//    .clk            (eth_tx_clk),
//    .din            (fifo_eth_icmp_din),
//    .wr_en          (fifo_eth_icmp_wr & !fifo_eth_icmp_full),
//    .rd_en          (fifo_eth_icmp_rd & !fifo_eth_icmp_empty),
//    .dout           (fifo_eth_icmp_dout),
//    .full           (fifo_eth_icmp_full),
//    .empty          (fifo_eth_icmp_empty),
//    .data_count     (fifo_eth_icmp_data_cnt)
//);


//***********************************************************************************************************************//
reg [3:0]   eth_pre_26100=0;
reg [15:0]  eth_26100_IPv4_ID=0;
reg [31:0]  eth_26100_crc=0;
reg [7:0]   fifo_26100_st=0;
reg [7:0]   addr_26100=0;


reg  [7:0]  fifo_26100_din=0;
reg         fifo_26100_wr_en=0;
reg         fifo_26100_rd_en=0;
wire [7:0]  fifo_26100_dout;
wire        fifo_26100_full;
wire        fifo_26100_empty;
wire [9:0]  fifo_26100_rd_data_count;
wire [9:0]  fifo_26100_wr_data_count;


//1k fifo   
fifo_ser fifo_26100
(
    .wr_clk         (eth_tx_clk),                           //: IN STD_LOGIC;
    .rd_clk         (eth_tx_clk),                           //: IN STD_LOGIC;
    .din            (fifo_26100_din),                       //: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    .wr_en          (fifo_26100_wr_en & !fifo_26100_full),  //: IN STD_LOGIC;
    .rd_en          (fifo_26100_rd_en & !fifo_26100_empty), //: IN STD_LOGIC;
    .dout           (fifo_26100_dout),                      //: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    .full           (fifo_26100_full),                      //: OUT STD_LOGIC;
    .empty          (fifo_26100_empty),                     //: OUT STD_LOGIC;
    .rd_data_count  (fifo_26100_rd_data_count),             //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    .wr_data_count  (fifo_26100_wr_data_count)              //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
); 
//***********************************************************************************************************************//


reg [3:0]   eth_pre_26010=0;
reg [15:0]  eth_26010_IPv4_ID=0;
reg [31:0]  eth_26010_crc=0;
reg [7:0]   fifo_26010_st=0;
reg [7:0]   addr_26010=0;


reg  [7:0]  fifo_26010_din=0;
reg         fifo_26010_wr_en=0;
reg         fifo_26010_rd_en=0;
wire [7:0]  fifo_26010_dout;
wire        fifo_26010_full;
wire        fifo_26010_empty;
wire [9:0]  fifo_26010_rd_data_count;
wire [9:0]  fifo_26010_wr_data_count;


//1k fifo   
fifo_ser fifo_26010
(
    .wr_clk         (eth_tx_clk),                           //: IN STD_LOGIC;
    .rd_clk         (eth_tx_clk),                           //: IN STD_LOGIC;
    .din            (fifo_26010_din),                       //: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    .wr_en          (fifo_26010_wr_en & !fifo_26010_full),  //: IN STD_LOGIC;
    .rd_en          (fifo_26010_rd_en & !fifo_26010_empty), //: IN STD_LOGIC;
    .dout           (fifo_26010_dout),                      //: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    .full           (fifo_26010_full),                      //: OUT STD_LOGIC;
    .empty          (fifo_26010_empty),                     //: OUT STD_LOGIC;
    .rd_data_count  (fifo_26010_rd_data_count),             //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    .wr_data_count  (fifo_26010_wr_data_count)              //: OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
); 


//*******************************************************************//
// RAM for DFS_26010
/*reg  [7:0]  ram_dfs_26010_din=0;
reg         ram_dfs_26010_wr_en=0;
reg  [6:0]  ram_dfs_26010_wr_addr=0;

reg         ram_dfs_26010_rd_en=0;
reg  [6:0]  ram_dfs_26010_rd_addr=0;
wire [7:0]  ram_dfs_26010_dout;
wire        ram_dfs_26010_valid;

ram_dual_v # (127,7,113) ram_dfs_26010 //114 bytes
(
    //Write to RAM
    .clk        (eth_tx_clk), 
    .din        (ram_dfs_26010_din), 
    .wr         (ram_dfs_26010_wr_en), 
    .wr_addr    (ram_dfs_26010_wr_addr),  

    //Read from RAM
    .rd         (ram_dfs_26010_rd_en),
    .rd_addr    (ram_dfs_26010_rd_addr),   
    .dout       (ram_dfs_26010_dout),
    .valid      (ram_dfs_26010_valid)
);*/


// RAM for DFS_26100
/*reg  [7:0]  ram_dfs_26100_din=0;
reg 		 ram_dfs_26100_wr_en=0;
reg  [6:0]  ram_dfs_26100_wr_addr=0;
reg  [6:0]  ram_dfs_st=0;

reg         ram_dfs_26100_rd_en=0;
reg  [6:0]  ram_dfs_26100_rd_addr=0;
wire [7:0]  ram_dfs_26100_dout;
wire        ram_dfs_26100_valid;

ram_dual_v # (127,7,113) ram_dfs_26100 //114 bytes
(
    //Write to RAM
    .clk       (eth_tx_clk), //event_26100_bins_rd_clk
    .din       (ram_dfs_26100_din), 
    .wr        (ram_dfs_26100_wr_en), 
    .wr_addr   (ram_dfs_26100_wr_addr),  

    //Read from RAM
    .rd        (ram_dfs_26100_rd_en),	
    .rd_addr   (ram_dfs_26100_rd_addr),   
    .dout      (ram_dfs_26100_dout),
    .valid     (ram_dfs_26100_valid)
);*/

reg [1:0]	ram_dfs_st=0;
reg [7:0]	dfs_clear_st=0;
reg [7:0]   clear_26100_dfs_st=0;
reg [31:0]  dfs_timeout=0;
reg [3:0]   dfs_st=0;

reg [15:0]  dfs_zero=0;
reg [15:0]  dfs_bytes=0;
reg [6:0]   zero_st=0;


//*******************************************************************//
// RAM for DFS 26010 & 26100
reg  [7:0]  ram_dfs_din=0;
reg         ram_dfs_wr_en=0;
reg  [6:0]  ram_dfs_wr_addr=0;

reg         ram_dfs_rd_en=0;
reg  [6:0]  ram_dfs_rd_addr=0;
wire [7:0]  ram_dfs_dout;
wire        ram_dfs_valid;

ram_dual_v # (127,7,113) ram_dfs //114 bytes
(
    //Write to RAM
    .clk        (eth_tx_clk), 
    .din        (ram_dfs_din), 
    .wr         (ram_dfs_wr_en), 
    .wr_addr    (ram_dfs_wr_addr),  

    //Read from RAM
    .rd         (ram_dfs_rd_en),
    .rd_addr    (ram_dfs_rd_addr),   
    .dout       (ram_dfs_dout),
    .valid      (ram_dfs_valid)
);


/*
ila_dfs ila_dfs_rx
( 
    .clk        (eth_tx_clk),     
    .probe0     (dfs_st),               //4  
    .probe1     (dfs_rx_cnt),           //10
    .probe2     (dfs_rx_eop),           //1
    .probe3     (dfs_rx_rd_en),         //1
    .probe4     (event_26100_dfs_ok),   //1
    .probe5     (event_26100_dfs_rd),   //1
    .probe6     (ram_dfs_26100_wr_en),  //1
    .probe7     (ram_dfs_26100_wr_addr),//7
    .probe8     (dfs_rx_dout)           //8
);
*/

/*
ila_dfs_tx ila_dfs_tx_inst
( 
    .clk        (eth_rx_clk),     
    .probe0     (eth_rxdv),         //1
    .probe1     (eth_rxer),         //1
    .probe2     (eth_rxd),          //8          
    .probe3     (dfs_tx_wr_en),     //1    
    .probe4     (dfs_tx_din),       //8
    .probe5     (eth_rx_byte_cnt)   //16         
);*/



reg [4:0] eth_pre_26010_26100=0;

localparam      PRE_IDLE                    = 5'd0,
                PRE_26010_HEADER            = 5'd1,
                PRE_26010_CRC               = 5'd2,
                PRE_26010_FIFO_HEADER       = 5'd3,
                PRE_26010_FIFO_DFS_WAIT     = 5'd4,
                PRE_26010_FIFO_DFS_DATA     = 5'd5,
                PRE_26010_FIFO_DFS_ZERO     = 5'd6,
                PRE_26010_FIFO_DFS_TIMEOUT  = 5'd7,
                PRE_26100_HEADER            = 5'd8,
                PRE_26100_CRC               = 5'd9,
                PRE_26100_FIFO_HEADER       = 5'd10,
                PRE_26100_FIFO_BINS_WAIT    = 5'd11,
                PRE_26100_FIFO_BINS_DATA    = 5'd12,
                PRE_26100_FIFO_BINS_TIMEOUT = 5'd13,
                PRE_26100_FIFO_DFS_WAIT     = 5'd14,
                PRE_26100_FIFO_DFS_DATA     = 5'd15,
                PRE_26100_FIFO_DFS_TIMEOUT  = 5'd16,
                PRE_26100_FIFO_DFS_ZERO     = 5'd17,
                PRE_END                     = 5'd18,
                PRE_26010_CLEAR_FIFO        = 5'd19,
                PRE_26100_CLEAR_FIFO        = 5'd20;
                
reg [4:0]  eth_prepare=0;
reg [31:0] bins_26100_timeout=0;
reg [31:0] dfs_26100_timeout=0;
reg [31:0] dfs_26010_timeout=0;
reg [6:0]  arp_byte_cnt=0;

//***********************************************************************************************************************//
//*ETHERNET1: TRANSMIT PACKET'S																							*//
//***********************************************************************************************************************//
always@(posedge eth_tx_clk) begin

	//*******************************************************//
	//Prepare ARP packet from eth, and put in FIFO			*//
	//*******************************************************//
	case(eth_pre_arp)
		4'd0: begin //Idle		
			fifo_eth_arp_wr  <=1'b0;
			eth_pre_arp_bcnt <=16'd0;
			event_eth_arp_rd <=1'b0;
			
			if(event_eth_arp_ok) begin
				eth_pre_arp<=4'd1;
				event_eth_arp_rd<=1'b1;
			end
		end
		
		4'd1: begin //Put it FIFO
            case(arp_byte_cnt)
                
                //PREAMBULE 
                0:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h55; fifo_eth_arp_wr <=1'b1; event_eth_arp_rd<=1'b0; end
                1:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h55; end
                2:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h55; end
                3:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h55; end
                4:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h55; end
                5:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h55; end
                6:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h55; end
                7:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'hD5; end
                //Dest MAC  
                8:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[47:40];  end
                9:  begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[39:32];  end
                10: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[31:24];  end
                11: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[23:16];  end
                12: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[15:8];   end
                13: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[7:0];    end
                //Src MAC
                14: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[47:40];    end
                15: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[39:32];    end
                16: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[31:24];    end
                17: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[23:16];    end
                18: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[15:8];     end
                19: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[7:0];      end
                //TYPE 
                20: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_type[15:8];          end
                21: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_type[7:0];           end
                //HType
                22: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h00;                   end
                23: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h01;                   end
                //IPv4
                24: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h08;                   end
                25: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h00;                   end
                //Hsz
                26: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h06;                   end
                //Psz
                27: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h04;                   end
                //Opcode 0x0002 reply
                28: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h00;                   end
                29: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=8'h02;                   end
                //My MAC 
                30: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[47:40];    end 
                31: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[39:32];    end
                32: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[31:24];    end
                33: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[23:16];    end
                34: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[15:8];     end
                35: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_mac[7:0];      end
                //My IP 
                36: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_ip[31:24];     end  
                37: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_ip[23:16];     end
                38: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_ip[15:8];      end
                39: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_local_ip[7:0];       end
                //Target MAC 
                40: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[47:40];  end
                41: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[39:32];  end
                42: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[31:24];  end
                43: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[23:16];  end
                44: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[15:8];   end
                45: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_MAC_src[7:0];    end
                //Target IP 
                46: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_IP_src[31:24];   end  
                47: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_IP_src[23:16];   end
                48: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_IP_src[15:8];    end
                49: begin arp_byte_cnt <=arp_byte_cnt+1'b1; fifo_eth_arp_din <=eth_ARP_IP_src[7:0];     end
                
                68: begin
                    fifo_eth_arp_wr <=1'b0; 
                    arp_byte_cnt    <=0;
                    eth_pre_arp 	<=0;
                end
                
                default: begin
                    fifo_eth_arp_din <=8'h00;  
                    arp_byte_cnt     <=arp_byte_cnt+1'b1;    
                end
            endcase
		end
		
		
		/*4'd1: begin //Fill
			event_eth_arp_rd<=1'b0;
			
			eth_tx_arp_data[0]  <=8'h55;               //PREAMBULE  
			eth_tx_arp_data[1]  <=8'h55;
			eth_tx_arp_data[2]  <=8'h55;
			eth_tx_arp_data[3]  <=8'h55;
			eth_tx_arp_data[4]  <=8'h55;
			eth_tx_arp_data[5]  <=8'h55;
			eth_tx_arp_data[6]  <=8'h55;
			eth_tx_arp_data[7]  <=8'hD5; 
			
			eth_tx_arp_data[8]  <=eth_ARP_MAC_src[47:40];	//Dest MAC  
			eth_tx_arp_data[9]  <=eth_ARP_MAC_src[39:32];
			eth_tx_arp_data[10] <=eth_ARP_MAC_src[31:24];
			eth_tx_arp_data[11] <=eth_ARP_MAC_src[23:16];
			eth_tx_arp_data[12] <=eth_ARP_MAC_src[15:8];
			eth_tx_arp_data[13] <=eth_ARP_MAC_src[7:0];	
			
			eth_tx_arp_data[14] <=eth_local_mac[47:40];	//Src MAC
			eth_tx_arp_data[15] <=eth_local_mac[39:32];
			eth_tx_arp_data[16] <=eth_local_mac[31:24];
			eth_tx_arp_data[17] <=eth_local_mac[23:16];
			eth_tx_arp_data[18] <=eth_local_mac[15:8];
			eth_tx_arp_data[19] <=eth_local_mac[7:0];	
			
			eth_tx_arp_data[20] <=eth_type[15:8]; 			//TYPE 
			eth_tx_arp_data[21] <=eth_type[7:0];
			eth_tx_arp_data[22] <=8'h00;							//HType
			eth_tx_arp_data[23] <=8'h01;
			eth_tx_arp_data[24] <=8'h08;							//IPv4
			eth_tx_arp_data[25] <=8'h00;
			eth_tx_arp_data[26] <=8'h06;							//Hsz
			eth_tx_arp_data[27] <=8'h04;							//Psz
			eth_tx_arp_data[28] <=8'h00;							//Opcode 0x0002 reply
			eth_tx_arp_data[29] <=8'h02;
			eth_tx_arp_data[30] <=eth_local_mac[47:40];	//My MAC  
			eth_tx_arp_data[31] <=eth_local_mac[39:32];
			eth_tx_arp_data[32] <=eth_local_mac[31:24];
			eth_tx_arp_data[33] <=eth_local_mac[23:16];
			eth_tx_arp_data[34] <=eth_local_mac[15:8];
			eth_tx_arp_data[35] <=eth_local_mac[7:0];
			eth_tx_arp_data[36] <=eth_local_ip[31:24];		//My IP   
			eth_tx_arp_data[37] <=eth_local_ip[23:16];
			eth_tx_arp_data[38] <=eth_local_ip[15:8];
			eth_tx_arp_data[39] <=eth_local_ip[7:0];
			eth_tx_arp_data[40] <=eth_ARP_MAC_src[47:40];	//Target MAC 
			eth_tx_arp_data[41] <=eth_ARP_MAC_src[39:32];
			eth_tx_arp_data[42] <=eth_ARP_MAC_src[31:24];
			eth_tx_arp_data[43] <=eth_ARP_MAC_src[23:16];
			eth_tx_arp_data[44] <=eth_ARP_MAC_src[15:8];
			eth_tx_arp_data[45] <=eth_ARP_MAC_src[7:0];	
			eth_tx_arp_data[46] <=eth_ARP_IP_src[31:24];	//Target IP   
			eth_tx_arp_data[47] <=eth_ARP_IP_src[23:16];
			eth_tx_arp_data[48] <=eth_ARP_IP_src[15:8];
			eth_tx_arp_data[49] <=eth_ARP_IP_src[7:0];
			
			//Padding 18 bytes
			eth_tx_arp_data[50] <=8'h00;
			eth_tx_arp_data[51] <=8'h00;
			eth_tx_arp_data[52] <=8'h00;
			eth_tx_arp_data[53] <=8'h00;
			eth_tx_arp_data[54] <=8'h00;
			eth_tx_arp_data[55] <=8'h00;
			eth_tx_arp_data[56] <=8'h00;
			eth_tx_arp_data[57] <=8'h00;
			eth_tx_arp_data[58] <=8'h00;
			eth_tx_arp_data[59] <=8'h00;
			eth_tx_arp_data[60] <=8'h00;
			eth_tx_arp_data[61] <=8'h00;
			eth_tx_arp_data[62] <=8'h00;
			eth_tx_arp_data[63] <=8'h00;
			eth_tx_arp_data[64] <=8'h00;
			eth_tx_arp_data[65] <=8'h00;
			eth_tx_arp_data[66] <=8'h00;
			eth_tx_arp_data[67] <=8'h00;
			
			eth_pre_arp         <=4'd2;
		end*/

		/*4'd2: begin //Put it FIFO
		  case(eth_pre_arp_bcnt)
		      0: begin
		          fifo_eth_arp_wr  <=1'b1;
                  fifo_eth_arp_din <=eth_tx_arp_data[0];
                  eth_pre_arp_bcnt <=eth_pre_arp_bcnt+1'b1;
		      end
		      
		      67: begin
		          fifo_eth_arp_din <=eth_tx_arp_data[eth_pre_arp_bcnt];
		          eth_pre_arp 	   <=4'd0;
		      end
		  
		      default: begin
		          fifo_eth_arp_din <=eth_tx_arp_data[eth_pre_arp_bcnt];
                  eth_pre_arp_bcnt <=eth_pre_arp_bcnt+1;
		      end
		  endcase
		end*/

		default: eth_pre_arp<=4'd0;
	endcase
	
	
	
	
    /*event_26100_bins_ok
    event_26100_dfs_ok
    
    event_26010_dfs_ok*/
    
    

    
    case(eth_prepare)
        PRE_IDLE: begin
            if(event_26100_bins_ok && event_26100_dfs_ok) begin
                //eth_prepare<=PRE_26100_HEADER;
                eth_prepare<=PRE_26100_CLEAR_FIFO;
                event_26100_dfs_rd<=1'b1;
            end
            else if(event_26010_dfs_ok) begin
                eth_prepare<=PRE_26010_CLEAR_FIFO;
                event_26010_dfs_rd<=1'b1;
            end
            else begin
                eth_prepare<=PRE_IDLE;
            end
        end
        
        PRE_26100_CLEAR_FIFO: begin
            if( fifo_26100_rd_data_count>0 && (fifo_26100_rd_data_count<218) && (eth_tx_state!=tx_26100) ) begin
                fifo_26100_rd_en<=1;
            end
            else begin
                fifo_26100_rd_en<=0;
                eth_prepare<=PRE_26100_HEADER;
            end
        end
        
        PRE_26010_CLEAR_FIFO: begin
            if( fifo_26010_rd_data_count>0 && (fifo_26010_rd_data_count<164) && (eth_tx_state!=tx_26010) ) begin
                fifo_26010_rd_en<=1;
            end
            else begin
                fifo_26010_rd_en<=0;
                eth_prepare<=PRE_26010_HEADER;
            end
        end

        PRE_26010_HEADER: begin
            event_26010_dfs_rd<=1'b0;
            eth_26010_IPv4_ID     <=eth_26010_IPv4_ID+1;
        
            eth_tx_26010_data[0]  <=8'h55;                      //PREAMBULE  
            eth_tx_26010_data[1]  <=8'h55;
            eth_tx_26010_data[2]  <=8'h55;
            eth_tx_26010_data[3]  <=8'h55;
            eth_tx_26010_data[4]  <=8'h55;
            eth_tx_26010_data[5]  <=8'h55;
            eth_tx_26010_data[6]  <=8'h55;
            eth_tx_26010_data[7]  <=8'hD5; 

            eth_tx_26010_data[8]  <=eth_ARP_MAC_src[47:40];     //Dest MAC  
            eth_tx_26010_data[9]  <=eth_ARP_MAC_src[39:32];
            eth_tx_26010_data[10] <=eth_ARP_MAC_src[31:24];
            eth_tx_26010_data[11] <=eth_ARP_MAC_src[23:16];
            eth_tx_26010_data[12] <=eth_ARP_MAC_src[15:8];
            eth_tx_26010_data[13] <=eth_ARP_MAC_src[7:0];

            eth_tx_26010_data[14] <=eth_local_mac[47:40];       //Src MAC
            eth_tx_26010_data[15] <=eth_local_mac[39:32];
            eth_tx_26010_data[16] <=eth_local_mac[31:24];
            eth_tx_26010_data[17] <=eth_local_mac[23:16];
            eth_tx_26010_data[18] <=eth_local_mac[15:8];
            eth_tx_26010_data[19] <=eth_local_mac[7:0];	

            eth_tx_26010_data[20] <=8'h08;                      //TYPE 
            eth_tx_26010_data[21] <=8'h00;
            eth_tx_26010_data[22] <=8'h45;
            eth_tx_26010_data[23] <=8'h00;

            eth_tx_26010_data[24] <=8'h00;                      //Len 20 + 8 + 114 = 142 -> 008E		//====25.06.20			
            eth_tx_26010_data[25] <=8'h8E;

            eth_tx_26010_data[26] <=eth_26010_IPv4_ID[15:8];
            eth_tx_26010_data[27] <=eth_26010_IPv4_ID[7:0];
            
            eth_tx_26010_data[28] <=8'h40;                      //Flags
            eth_tx_26010_data[29] <=8'h00;
            eth_tx_26010_data[30] <=8'h40;                      //TTL
            eth_tx_26010_data[31] <=8'h11;                      //UDP
            
            eth_tx_26010_data[32] <=8'h00;                      //CRC IPv4
            eth_tx_26010_data[33] <=8'h00;
            
            eth_tx_26010_data[34] <=eth_local_ip[31:24];        //My IP   
            eth_tx_26010_data[35] <=eth_local_ip[23:16];
            eth_tx_26010_data[36] <=eth_local_ip[15:8];
            eth_tx_26010_data[37] <=eth_local_ip[7:0];
            
            eth_tx_26010_data[38] <=8'd192;                     //Dst IP
            eth_tx_26010_data[39] <=8'd168;
            eth_tx_26010_data[40] <=8'd4;
            eth_tx_26010_data[41] <=8'd1;                       //CVK
            
            eth_tx_26010_data[42] <=8'h65;                      //SP 26010
            eth_tx_26010_data[43] <=8'h9A;
            
            eth_tx_26010_data[44] <=8'h65;                      //DP 26010
            eth_tx_26010_data[45] <=8'h9A;
                        
            eth_tx_26010_data[46] <=8'h00;                      //Length = 8 + 114 = 122
            eth_tx_26010_data[47] <=8'h7A;

            eth_tx_26010_data[48] <=8'h00;                      //CRC
            eth_tx_26010_data[49] <=8'h00;

            eth_prepare<=PRE_26010_CRC;
        end
        
        PRE_26010_CRC: begin
            if(eth_adc_i==0) begin
                eth_26010_crc <=    {eth_tx_26010_data[24],eth_tx_26010_data[25]} + {eth_tx_26010_data[22],eth_tx_26010_data[23]} +
                                    {eth_tx_26010_data[28],eth_tx_26010_data[29]} + {eth_tx_26010_data[26],eth_tx_26010_data[27]} +
                                    {eth_tx_26010_data[32],eth_tx_26010_data[33]} + {eth_tx_26010_data[30],eth_tx_26010_data[31]} +
                                    {eth_tx_26010_data[36],eth_tx_26010_data[37]} + {eth_tx_26010_data[34],eth_tx_26010_data[35]} +
                                    {eth_tx_26010_data[40],eth_tx_26010_data[41]} + {eth_tx_26010_data[38],eth_tx_26010_data[39]};
                eth_adc_i<=eth_adc_i+1'b1;
            end
            else if(eth_adc_i==1) begin
                eth_26010_crc[16:0] <=eth_26010_crc[31:16]+eth_26010_crc[15:0];
                eth_adc_i           <=eth_adc_i+1'b1;
            end
            else begin
                if(eth_26010_crc[16]) begin //overflow carry
                    eth_tx_26010_data[32]<=~eth_26010_crc[15:8];
                    eth_tx_26010_data[33]<=~eth_26010_crc[7:0] - 1;
                end
                else begin
                    eth_tx_26010_data[32]<=~eth_26010_crc[15:8];
                    eth_tx_26010_data[33]<=~eth_26010_crc[7:0];
                end   
                eth_adc_i<=0;
                addr_26010<=0;
                eth_prepare<=PRE_26010_FIFO_HEADER;
            end
        end
        
        PRE_26010_FIFO_HEADER: begin
            case(fifo_26010_st)
                0: begin
                    fifo_26010_wr_en    <=1;
                    fifo_26010_din		<=eth_tx_26010_data[addr_26010];
                    addr_26010		    <=addr_26010+1;
                    fifo_26010_st		<=fifo_26010_st+1;
                end
                1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49: begin
                    fifo_26010_din		<=eth_tx_26010_data[addr_26010];
                    addr_26010		    <=addr_26010+1;
                    fifo_26010_st		<=fifo_26010_st+1;
                end
                50: begin
                    fifo_26010_wr_en    <=0;
                    addr_26010          <=0;
                    fifo_26010_st		<=0;
                    eth_prepare         <=PRE_26010_FIFO_DFS_WAIT;
                end
                default: fifo_26010_st	<=0;
            endcase
        end
        
        PRE_26010_FIFO_DFS_WAIT: begin
            if( (dfs_rx_cnt>0) && (dfs_rx_eop) ) begin
                dfs_rx_rd_en        <=1'b1;
                dfs_bytes           <=dfs_rx_cnt;
                fifo_26010_st       <=0;
                dfs_26010_timeout   <=0;
                eth_prepare         <=PRE_26010_FIFO_DFS_DATA;
                if(dfs_rx_cnt>=114)
                    dfs_zero<=0;
                else
                    dfs_zero<=16'd114-dfs_rx_cnt;
            end
            else begin
                if(dfs_26010_timeout<32'd62500000) begin 
                    dfs_26010_timeout<=dfs_26010_timeout+1'b1;
                end
                else begin //500 ms timeout
                    dfs_26010_timeout<=0;
                    eth_prepare<=PRE_26010_FIFO_DFS_TIMEOUT;
                end    
            end
        end
        
        PRE_26010_FIFO_DFS_DATA: begin
            case(fifo_26010_st)
                0: begin //Latency 1 clk for read from FIFO
                    fifo_26010_st<=fifo_26010_st+1'b1;
                end
                
                1: begin
                    fifo_26010_wr_en    <=1;
                    fifo_26010_st       <=fifo_26010_st+1'b1;
                    fifo_26010_din		<=dfs_rx_dout;
                end
                
                default: begin
                    fifo_26010_st   <=fifo_26010_st+1'b1;
                    fifo_26010_din  <=dfs_rx_dout;
                end
            endcase
            
            if(dfs_rx_cnt==1) begin //END
                dfs_rx_rd_en <=1'b0;
                fifo_26010_st<=0;
                zero_st      <=0;
                if(dfs_zero>0)
                    eth_prepare<=PRE_26010_FIFO_DFS_ZERO;
                else
                    eth_prepare<=PRE_END;
            end
        end

        PRE_26010_FIFO_DFS_ZERO: begin
            case(zero_st)
                dfs_zero: begin
                    fifo_26010_din  <=8'h00;
                    zero_st         <=0;
                    eth_prepare     <=PRE_END;
                end
                default: begin
                    fifo_26010_din  <=8'h00;
                    zero_st         <=zero_st+1'b1;
                end
            endcase
        end
        
        PRE_26010_FIFO_DFS_TIMEOUT: begin
            case(fifo_26010_st)
                0: begin
                    fifo_26010_wr_en        <=1;
                    fifo_26010_din		    <=8'd0;
                    fifo_26010_st           <=fifo_26010_st+1'b1;
                end
                113: begin
                    fifo_26010_st           <=0;
                    fifo_26010_din		    <=8'd0;
                    eth_prepare             <=PRE_END;
                end

                default: begin
                    fifo_26010_din		    <=8'd0;
                    fifo_26010_st           <=fifo_26010_st+1'b1;
                end
            endcase
        end
        
        //********************************************************************************************************************//
        
        PRE_26100_HEADER: begin
            event_26100_dfs_rd    <=1'b0;
            eth_26100_IPv4_ID     <=eth_26100_IPv4_ID+1;
        
            eth_tx_26100_data[0]  <=8'h55;                      //PREAMBULE  
            eth_tx_26100_data[1]  <=8'h55;
            eth_tx_26100_data[2]  <=8'h55;
            eth_tx_26100_data[3]  <=8'h55;
            eth_tx_26100_data[4]  <=8'h55;
            eth_tx_26100_data[5]  <=8'h55;
            eth_tx_26100_data[6]  <=8'h55;
            eth_tx_26100_data[7]  <=8'hD5; 

            eth_tx_26100_data[8]  <=eth_ARP_MAC_src[47:40];     //Dest MAC  
            eth_tx_26100_data[9]  <=eth_ARP_MAC_src[39:32];
            eth_tx_26100_data[10] <=eth_ARP_MAC_src[31:24];
            eth_tx_26100_data[11] <=eth_ARP_MAC_src[23:16];
            eth_tx_26100_data[12] <=eth_ARP_MAC_src[15:8];
            eth_tx_26100_data[13] <=eth_ARP_MAC_src[7:0];

            eth_tx_26100_data[14] <=eth_local_mac[47:40];       //Src MAC
            eth_tx_26100_data[15] <=eth_local_mac[39:32];
            eth_tx_26100_data[16] <=eth_local_mac[31:24];
            eth_tx_26100_data[17] <=eth_local_mac[23:16];
            eth_tx_26100_data[18] <=eth_local_mac[15:8];
            eth_tx_26100_data[19] <=eth_local_mac[7:0];	

            eth_tx_26100_data[20] <=8'h08;                      //TYPE 
            eth_tx_26100_data[21] <=8'h00;
            eth_tx_26100_data[22] <=8'h45;
            eth_tx_26100_data[23] <=8'h00;

            eth_tx_26100_data[24] <=8'h00;                      //Len 20 + 8 + 168 = 196 -> 00C4		//====17.06.20			
            eth_tx_26100_data[25] <=8'hC4;

            eth_tx_26100_data[26] <=eth_26100_IPv4_ID[15:8];
            eth_tx_26100_data[27] <=eth_26100_IPv4_ID[7:0];
            
            eth_tx_26100_data[28] <=8'h40;                      //Flags
            eth_tx_26100_data[29] <=8'h00;
            eth_tx_26100_data[30] <=8'h40;                      //TTL
            eth_tx_26100_data[31] <=8'h11;                      //UDP
            
            eth_tx_26100_data[32] <=8'h00;                      //CRC IPv4
            eth_tx_26100_data[33] <=8'h00;
            
            eth_tx_26100_data[34] <=eth_local_ip[31:24];        //My IP   
            eth_tx_26100_data[35] <=eth_local_ip[23:16];
            eth_tx_26100_data[36] <=eth_local_ip[15:8];
            eth_tx_26100_data[37] <=eth_local_ip[7:0];
            
            eth_tx_26100_data[38] <=8'd192;                     //Dst IP
            eth_tx_26100_data[39] <=8'd168;
            eth_tx_26100_data[40] <=8'd4;
            eth_tx_26100_data[41] <=8'd1;                       //CVK
            
            eth_tx_26100_data[42] <=8'h65;                      //SP 26100
            eth_tx_26100_data[43] <=8'hF4;
            eth_tx_26100_data[44] <=8'h65;                      //DP 26100
            eth_tx_26100_data[45] <=8'hF4;
                        
            eth_tx_26100_data[46] <=8'h00;                      //Length = 8 + 168 = 176
            eth_tx_26100_data[47] <=8'hB0;

            eth_tx_26100_data[48] <=8'h00;                      //CRC
            eth_tx_26100_data[49] <=8'h00;

            eth_prepare<=PRE_26100_CRC;
        end
        
        PRE_26100_CRC: begin
            if(eth_adc_i==0) begin
                eth_26100_crc <=    {eth_tx_26100_data[24],eth_tx_26100_data[25]} + {eth_tx_26100_data[22],eth_tx_26100_data[23]} +
                                    {eth_tx_26100_data[28],eth_tx_26100_data[29]} + {eth_tx_26100_data[26],eth_tx_26100_data[27]} +
                                    {eth_tx_26100_data[32],eth_tx_26100_data[33]} + {eth_tx_26100_data[30],eth_tx_26100_data[31]} +
                                    {eth_tx_26100_data[36],eth_tx_26100_data[37]} + {eth_tx_26100_data[34],eth_tx_26100_data[35]} +
                                    {eth_tx_26100_data[40],eth_tx_26100_data[41]} + {eth_tx_26100_data[38],eth_tx_26100_data[39]};
                eth_adc_i<=eth_adc_i+1'b1;
            end
            else if(eth_adc_i==1) begin
                eth_26100_crc[16:0] <=eth_26100_crc[31:16]+eth_26100_crc[15:0];
                eth_adc_i           <=eth_adc_i+1'b1;
            end
            else begin
                if(eth_26100_crc[16]) begin //overflow carry
                    eth_tx_26100_data[32]<=~eth_26100_crc[15:8];
                    eth_tx_26100_data[33]<=~eth_26100_crc[7:0] - 1;
                end
                else begin
                    eth_tx_26100_data[32]<=~eth_26100_crc[15:8];
                    eth_tx_26100_data[33]<=~eth_26100_crc[7:0];
                end   
                eth_adc_i<=0;
                eth_prepare<=PRE_26100_FIFO_HEADER;
            end
        end
        
        PRE_26100_FIFO_HEADER: begin
            case(fifo_26100_st)
                0: begin
                    fifo_26100_wr_en    <=1;
                    fifo_26100_din		<=eth_tx_26100_data[addr_26100];
                    addr_26100		    <=addr_26100+1;
                    fifo_26100_st		<=fifo_26100_st+1;
                end
                1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49: begin
                    fifo_26100_din		<=eth_tx_26100_data[addr_26100];
                    addr_26100		    <=addr_26100+1;
                    fifo_26100_st		<=fifo_26100_st+1;
                end
                50: begin
                    fifo_26100_wr_en    <=0;
                    addr_26100          <=0;
                    fifo_26100_st		<=0;
                    eth_prepare         <=PRE_26100_FIFO_BINS_WAIT;
                end
                
                default: fifo_26100_st	<=0;
            endcase
        end
        
        PRE_26100_FIFO_BINS_WAIT: begin
            if(!ram_bins_26100_lock && ram_bins_26100_valid) begin
                ram_bins_26100_rd_en	<=1;
                ram_bins_26100_rd_addr	<=0;
                eth_prepare             <=PRE_26100_FIFO_BINS_DATA;
                bins_26100_timeout      <=0;
            end
            else begin
                bins_26100_timeout<=bins_26100_timeout+1'b1;
                if(bins_26100_timeout>=32'd5000000) begin //40 ms timeout
                    eth_prepare<=PRE_26100_FIFO_BINS_TIMEOUT;
                end
                else 
                    eth_prepare<=PRE_26100_FIFO_BINS_WAIT;
            end
        end
        
        PRE_26100_FIFO_BINS_DATA: begin
            case(fifo_26100_st)
                0: begin
                    fifo_26100_wr_en        <=1;
                    fifo_26100_st           <=fifo_26100_st+1'b1;
                    fifo_26100_din			<=ram_bins_26100_dout;
                    ram_bins_26100_rd_addr	<=ram_bins_26100_rd_addr+1'b1;
                end
                50: begin
                    ram_bins_26100_rd_en	<=0;
                    ram_bins_26100_rd_addr	<=0;
                    fifo_26100_din			<=8'hA1;					//TEST Pressure -> 1 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                51: begin
                    fifo_26100_din			<=8'hB2;					//TEST Pressure -> 2 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                52: begin
                    fifo_26100_din			<=8'hC3;					//TEST Pressure -> 3 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                53: begin
                    fifo_26100_din			<=8'hD4;					//TEST Pressure -> 4 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                54: begin
                    fifo_26100_wr_en        <=0;
                    fifo_26100_st           <=0;
                    eth_prepare             <=PRE_26100_FIFO_DFS_WAIT;
                end
                default: begin
                    fifo_26100_st           <=fifo_26100_st+1'b1;
                    fifo_26100_din			<=ram_bins_26100_dout;
                    ram_bins_26100_rd_addr	<=ram_bins_26100_rd_addr+1;
                end
            endcase
        end
        
        PRE_26100_FIFO_BINS_TIMEOUT: begin
            case(fifo_26100_st)
                0: begin
                    fifo_26100_wr_en        <=1;
                    fifo_26100_din		    <=8'd0;
                    fifo_26100_st           <=fifo_26100_st+1'b1;
                end
                50: begin
                    fifo_26100_din			<=8'hA1;					//TEST Pressure -> 1 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                51: begin
                    fifo_26100_din			<=8'hB2;					//TEST Pressure -> 2 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                52: begin
                    fifo_26100_din			<=8'hC3;					//TEST Pressure -> 3 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                53: begin
                    fifo_26100_din			<=8'hD4;					//TEST Pressure -> 4 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                54: begin
                    fifo_26100_wr_en        <=0;
                    fifo_26100_st           <=0;
                    eth_prepare             <=PRE_26100_FIFO_DFS_WAIT;
                end

                default: begin
                    fifo_26100_din		    <=8'd0;
                    fifo_26100_st           <=fifo_26100_st+1'b1;
                end
            endcase
        end
        
        PRE_26100_FIFO_DFS_WAIT: begin
            if( (dfs_rx_cnt>0) && (dfs_rx_eop) ) begin
                dfs_rx_rd_en        <=1'b1;
                dfs_bytes           <=dfs_rx_cnt;
                fifo_26100_st       <=0;
                dfs_26100_timeout   <=0;
                eth_prepare         <=PRE_26100_FIFO_DFS_DATA;
                if(dfs_rx_cnt>=114)
                    dfs_zero<=0;
                else
                    dfs_zero<=16'd114-dfs_rx_cnt;
            end
            else begin
                if(dfs_26100_timeout<32'd62500000) begin 
                    dfs_26100_timeout<=dfs_26100_timeout+1'b1;
                end
                else begin //500 ms timeout
                    dfs_26100_timeout<=0;
                    eth_prepare<=PRE_26100_FIFO_DFS_TIMEOUT;
                end    
            end
        end
        
        PRE_26100_FIFO_DFS_DATA: begin
            case(fifo_26100_st)
                0: begin //Latency 1 clk for read from FIFO
                    fifo_26100_st<=fifo_26100_st+1'b1;
                end
                
                1: begin
                    fifo_26100_wr_en    <=1;
                    fifo_26100_st       <=fifo_26100_st+1'b1;
                    fifo_26100_din		<=dfs_rx_dout;
                end
                
                default: begin
                    fifo_26100_st   <=fifo_26100_st+1'b1;
                    fifo_26100_din  <=dfs_rx_dout;
                end
            endcase
            
            if(dfs_rx_cnt==1) begin //END
                dfs_rx_rd_en <=1'b0;
                fifo_26100_st<=0;
                zero_st      <=0;
                if(dfs_zero>0)
                    eth_prepare<=PRE_26100_FIFO_DFS_ZERO;
                else
                    eth_prepare<=PRE_END;
            end
        end
        
        PRE_26100_FIFO_DFS_ZERO: begin
            case(zero_st)
                dfs_zero: begin
                    fifo_26100_din  <=8'h00;
                    zero_st         <=0;
                    eth_prepare     <=PRE_END;
                end
                default: begin
                    fifo_26100_din  <=8'h00;
                    zero_st         <=zero_st+1'b1;
                end
            endcase
        end
        
        PRE_26100_FIFO_DFS_TIMEOUT: begin
            case(fifo_26100_st)
                0: begin
                    fifo_26100_wr_en        <=1;
                    fifo_26100_din		    <=8'd0;
                    fifo_26100_st           <=fifo_26100_st+1'b1;
                end
                113: begin
                    fifo_26100_st           <=0;
                    fifo_26100_din		    <=8'd0;
                    eth_prepare             <=PRE_END;
                end

                default: begin
                    fifo_26100_din		    <=8'd0;
                    fifo_26100_st           <=fifo_26100_st+1'b1;
                end
            endcase
        end
        
        PRE_END: begin
            fifo_26010_wr_en<=0;
            fifo_26100_wr_en<=0;
            eth_prepare<=PRE_IDLE;
        end
        
        default: eth_prepare<=PRE_IDLE;
    endcase
    
    
    
    
    
    /*
    dfs_rx_rd_en      1
    dfs_rx_cnt        10
    dfs_rx_eop        1
    dfs_26100_timeout 32
    
    
    */
	
	
	
    //***************************************************************************************//
    //DFS                                                                                   *//
    //***************************************************************************************//
    /*case(dfs_st)

        0: begin 
            if( (dfs_rx_cnt>0) && (dfs_rx_eop) && (ram_dfs_rd_en==0) ) begin
                dfs_timeout         <=0;
                dfs_rx_rd_en        <=1'b1;
                dfs_st              <=dfs_st+1'b1;
                dfs_bytes           <=dfs_rx_cnt;
                
                ram_dfs_wr_en		<=1;
                ram_dfs_wr_addr	<=0;
                
                if(dfs_rx_cnt>=114)
                    dfs_zero<=0;
                else
                    dfs_zero<=16'd114-dfs_rx_cnt;
            end
        end

        1: begin //Latency 1 clk for read from FIFO
            
//             if(event_26100_dfs_ok) begin
//                 event_26100_dfs_rd		<=1;
//                 ram_dfs_26100_wr_en		<=1;
//                 ram_dfs_26100_wr_addr	<=0;
//             end
//             
//             if(event_26010_dfs_ok) begin
//                 event_26010_dfs_rd		<=1;
//                 ram_dfs_26010_wr_en		<=1;
//                 ram_dfs_26010_wr_addr	<=0;
//             end

            ram_dfs_st	<=0;
            dfs_st		<=dfs_st+1'b1;
        end

        2: begin    //WRITE to RAM
            if(dfs_rx_cnt>0) begin
                case(ram_dfs_st)
                    0: begin
//                         Write to RAM 26100
//                         ram_dfs_26100_din		<=dfs_rx_dout;
//                         ram_dfs_26100_wr_addr<=0;
                        
//                         Write to RAM 26010
//                         ram_dfs_26010_din		<=dfs_rx_dout;
//                         ram_dfs_26010_wr_addr<=0;
                        
                        ram_dfs_din     <=dfs_rx_dout;
                        ram_dfs_wr_addr <=0;
                        
                        ram_dfs_st				<=ram_dfs_st+1'b1;
                    end
                    
                    1: begin							
                        //Write to RAM 26100
//                         ram_dfs_26100_din		<=dfs_rx_dout;
//                         ram_dfs_26100_wr_addr<=ram_dfs_26100_wr_addr+1;
//                         
//                         Write to RAM 26010
//                         ram_dfs_26010_din		<=dfs_rx_dout;
//                         ram_dfs_26010_wr_addr<=ram_dfs_26010_wr_addr+1;
                        
                        ram_dfs_din     <=dfs_rx_dout;
                        ram_dfs_wr_addr <=ram_dfs_wr_addr+1;
                        
                        if(dfs_rx_cnt==1) begin //END
                            ram_dfs_st<=0;
                            
//                             if(event_26100_dfs_rd)
//                                 event_26100_dfs_rd<=0;	
//                                 
//                             if(event_26010_dfs_rd)
//                                 event_26010_dfs_rd<=0;
//                             
                            zero_st<=0;
                            if(dfs_zero>0)
                                dfs_st<=dfs_st+1'b1;
                            else
                                dfs_st<=dfs_st+7'd2;
                        end
                    end
                endcase
            end	
        end
        
        3: begin    //ZERO
        
            case(zero_st)
                dfs_zero: begin
                    //Write to RAM 26100
                    ram_dfs_26100_din		<=8'h00;
                    ram_dfs_26100_wr_addr<=ram_dfs_26100_wr_addr+1;
                    
                    //Write to RAM 26010
                    ram_dfs_26010_din		<=8'h00;
                    ram_dfs_26010_wr_addr<=ram_dfs_26010_wr_addr+1;
                    
                    ram_dfs_din     <=8'h00;
                    ram_dfs_wr_addr <=ram_dfs_wr_addr+1;
                    
                    dfs_st					<=dfs_st+1'b1;
                    zero_st					<=0;
                end
                default: begin
                    //Write to RAM 26100
                    ram_dfs_26100_din		<=8'h00;
                    ram_dfs_26100_wr_addr<=ram_dfs_26100_wr_addr+1;
                    
                    //Write to RAM 26010
                    ram_dfs_26010_din		<=8'h00;
                    ram_dfs_26010_wr_addr<=ram_dfs_26010_wr_addr+1;
                    
                    ram_dfs_din     <=8'h00;
                    ram_dfs_wr_addr <=ram_dfs_wr_addr+1;
                    
                    zero_st					<=zero_st+1'b1;
                end
            endcase
        end
        
        4: begin
            dfs_rx_rd_en  			<=0;
            dfs_st					<=0;
            
            ram_dfs_26100_wr_en		<=0;
            ram_dfs_26100_wr_addr	<=0;
            
            ram_dfs_26010_wr_en		<=0;
            ram_dfs_26010_wr_addr	<=0;
            
            ram_dfs_wr_en	<=0;
            ram_dfs_wr_addr	<=0;
        end

        default: dfs_st<=0;
    endcase*/
    //***************************************************************************************//

    
    //***************************************************************************************//
    /*case(eth_pre_26010_26100)
        PRE_IDLE: begin
            ram_bins_26100_rd_en    <=0;
            ram_bins_26100_rd_addr  <=0;
            addr_26100              <=0;
            addr_26010              <=0;
            
            //if(ram_bins_26100_valid) begin
            if(!ram_bins_26100_lock && ram_bins_26100_valid && ram_dfs_valid && ram_dfs_wr_en==0) begin
                ram_bins_26100_rd_en	<=1;
                ram_bins_26100_rd_addr	<=0;
                ram_dfs_rd_en           <=1;
                ram_dfs_rd_addr         <=0;  
                eth_pre_26010_26100 <=PRE_26100_HEADER;
            end
            else if(event_26010_dfs_ok && ram_dfs_valid && ram_dfs_wr_en==0) begin
                event_26010_dfs_rd  <=1;
                ram_dfs_rd_en       <=1;
                ram_dfs_rd_addr     <=0;  
                eth_pre_26010_26100 <=PRE_26010_HEADER;
            end
            else
                eth_pre_26010_26100 <=PRE_IDLE;
        end
        
        PRE_26010_HEADER: begin
            event_26010_dfs_rd    <=0;
            eth_26010_IPv4_ID     <=eth_26010_IPv4_ID+1;
        
            eth_tx_26010_data[0]  <=8'h55;                      //PREAMBULE  
            eth_tx_26010_data[1]  <=8'h55;
            eth_tx_26010_data[2]  <=8'h55;
            eth_tx_26010_data[3]  <=8'h55;
            eth_tx_26010_data[4]  <=8'h55;
            eth_tx_26010_data[5]  <=8'h55;
            eth_tx_26010_data[6]  <=8'h55;
            eth_tx_26010_data[7]  <=8'hD5; 

            eth_tx_26010_data[8]  <=eth_ARP_MAC_src[47:40];     //Dest MAC  
            eth_tx_26010_data[9]  <=eth_ARP_MAC_src[39:32];
            eth_tx_26010_data[10] <=eth_ARP_MAC_src[31:24];
            eth_tx_26010_data[11] <=eth_ARP_MAC_src[23:16];
            eth_tx_26010_data[12] <=eth_ARP_MAC_src[15:8];
            eth_tx_26010_data[13] <=eth_ARP_MAC_src[7:0];

            eth_tx_26010_data[14] <=eth_local_mac[47:40];       //Src MAC
            eth_tx_26010_data[15] <=eth_local_mac[39:32];
            eth_tx_26010_data[16] <=eth_local_mac[31:24];
            eth_tx_26010_data[17] <=eth_local_mac[23:16];
            eth_tx_26010_data[18] <=eth_local_mac[15:8];
            eth_tx_26010_data[19] <=eth_local_mac[7:0];	

            eth_tx_26010_data[20] <=8'h08;                      //TYPE 
            eth_tx_26010_data[21] <=8'h00;
            eth_tx_26010_data[22] <=8'h45;
            eth_tx_26010_data[23] <=8'h00;

            eth_tx_26010_data[24] <=8'h00;                      //Len 20 + 8 + 114 = 142 -> 008E		//====25.06.20			
            eth_tx_26010_data[25] <=8'h8E;

            eth_tx_26010_data[26] <=eth_26010_IPv4_ID[15:8];
            eth_tx_26010_data[27] <=eth_26010_IPv4_ID[7:0];
            
            eth_tx_26010_data[28] <=8'h40;                      //Flags
            eth_tx_26010_data[29] <=8'h00;
            eth_tx_26010_data[30] <=8'h40;                      //TTL
            eth_tx_26010_data[31] <=8'h11;                      //UDP
            
            eth_tx_26010_data[32] <=8'h00;                      //CRC IPv4
            eth_tx_26010_data[33] <=8'h00;
            
            eth_tx_26010_data[34] <=eth_local_ip[31:24];        //My IP   
            eth_tx_26010_data[35] <=eth_local_ip[23:16];
            eth_tx_26010_data[36] <=eth_local_ip[15:8];
            eth_tx_26010_data[37] <=eth_local_ip[7:0];
            
            eth_tx_26010_data[38] <=8'd192;                     //Dst IP
            eth_tx_26010_data[39] <=8'd168;
            eth_tx_26010_data[40] <=8'd4;
            eth_tx_26010_data[41] <=8'd1;                       //CVK
            
            eth_tx_26010_data[42] <=8'h65;                      //SP 26010
            eth_tx_26010_data[43] <=8'h9A;
            
            eth_tx_26010_data[44] <=8'h65;                      //DP 26010
            eth_tx_26010_data[45] <=8'h9A;
                        
            eth_tx_26010_data[46] <=8'h00;                      //Length = 8 + 114 = 122
            eth_tx_26010_data[47] <=8'h7A;

            eth_tx_26010_data[48] <=8'h00;                      //CRC
            eth_tx_26010_data[49] <=8'h00;

            eth_pre_26010_26100   <=PRE_26010_CRC;
        end
        
        PRE_26010_CRC: begin
            if(eth_adc_i==0) begin
                eth_26010_crc <=    {eth_tx_26010_data[24],eth_tx_26010_data[25]} + {eth_tx_26010_data[22],eth_tx_26010_data[23]} +
                                    {eth_tx_26010_data[28],eth_tx_26010_data[29]} + {eth_tx_26010_data[26],eth_tx_26010_data[27]} +
                                    {eth_tx_26010_data[32],eth_tx_26010_data[33]} + {eth_tx_26010_data[30],eth_tx_26010_data[31]} +
                                    {eth_tx_26010_data[36],eth_tx_26010_data[37]} + {eth_tx_26010_data[34],eth_tx_26010_data[35]} +
                                    {eth_tx_26010_data[40],eth_tx_26010_data[41]} + {eth_tx_26010_data[38],eth_tx_26010_data[39]};
                eth_adc_i<=eth_adc_i+1'b1;
            end
            else if(eth_adc_i==1) begin
                eth_26010_crc[16:0] <=eth_26010_crc[31:16]+eth_26010_crc[15:0];
                eth_adc_i           <=eth_adc_i+1'b1;
            end
            else begin
                if(eth_26010_crc[16]) begin //overflow carry
                    eth_tx_26010_data[32]<=~eth_26010_crc[15:8];
                    eth_tx_26010_data[33]<=~eth_26010_crc[7:0] - 1;
                end
                else begin
                    eth_tx_26010_data[32]<=~eth_26010_crc[15:8];
                    eth_tx_26010_data[33]<=~eth_26010_crc[7:0];
                end   
                eth_adc_i<=0;
                eth_pre_26010_26100   <=PRE_26010_FIFO;
            end
        end
        
        PRE_26010_FIFO: begin
            case(fifo_26010_st)
                0: begin
                    fifo_26010_wr_en<=1;
                    fifo_26010_din  <=eth_tx_26010_data[addr_26010];
                    addr_26010		<=addr_26010+1;
                    fifo_26010_st	<=fifo_26010_st+1;
                end
                1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48: begin
                    fifo_26010_din	<=eth_tx_26010_data[addr_26010];
                    addr_26010		<=addr_26010+1;
                    fifo_26010_st	<=fifo_26010_st+1;
                end
                49: begin
                    fifo_26010_din  <=eth_tx_26010_data[addr_26010];
                    fifo_26010_st   <=fifo_26010_st+1;
                end
                50: begin
                    addr_26010	    <=0;
                    fifo_26010_st	<=fifo_26010_st+1;
                    fifo_26010_din	<=ram_dfs_dout;
                    ram_dfs_rd_addr <=ram_dfs_rd_addr+1'b1;
                end
                164: begin//165
                    fifo_26010_wr_en	<=0;
                    fifo_26010_st		<=0;
                    //eth_pre_26010		<=0;
                    ram_dfs_rd_addr     <=0;
                    ram_dfs_rd_en		<=0;
                    eth_pre_26010_26100 <=PRE_IDLE;
                end
                default: begin
                    fifo_26010_st	<=fifo_26010_st+1;
                    fifo_26010_din	<=ram_dfs_dout;
                    ram_dfs_rd_addr	<=ram_dfs_rd_addr+1'b1;	
                end
            endcase
        end
        
        PRE_26100_HEADER: begin
            eth_26100_IPv4_ID     <=eth_26100_IPv4_ID+1;
        
            eth_tx_26100_data[0]  <=8'h55;                      //PREAMBULE  
            eth_tx_26100_data[1]  <=8'h55;
            eth_tx_26100_data[2]  <=8'h55;
            eth_tx_26100_data[3]  <=8'h55;
            eth_tx_26100_data[4]  <=8'h55;
            eth_tx_26100_data[5]  <=8'h55;
            eth_tx_26100_data[6]  <=8'h55;
            eth_tx_26100_data[7]  <=8'hD5; 

            eth_tx_26100_data[8]  <=eth_ARP_MAC_src[47:40];     //Dest MAC  
            eth_tx_26100_data[9]  <=eth_ARP_MAC_src[39:32];
            eth_tx_26100_data[10] <=eth_ARP_MAC_src[31:24];
            eth_tx_26100_data[11] <=eth_ARP_MAC_src[23:16];
            eth_tx_26100_data[12] <=eth_ARP_MAC_src[15:8];
            eth_tx_26100_data[13] <=eth_ARP_MAC_src[7:0];

            eth_tx_26100_data[14] <=eth_local_mac[47:40];       //Src MAC
            eth_tx_26100_data[15] <=eth_local_mac[39:32];
            eth_tx_26100_data[16] <=eth_local_mac[31:24];
            eth_tx_26100_data[17] <=eth_local_mac[23:16];
            eth_tx_26100_data[18] <=eth_local_mac[15:8];
            eth_tx_26100_data[19] <=eth_local_mac[7:0];	

            eth_tx_26100_data[20] <=8'h08;                      //TYPE 
            eth_tx_26100_data[21] <=8'h00;
            eth_tx_26100_data[22] <=8'h45;
            eth_tx_26100_data[23] <=8'h00;

            eth_tx_26100_data[24] <=8'h00;                      //Len 20 + 8 + 168 = 196 -> 00C4		//====17.06.20			
            eth_tx_26100_data[25] <=8'hC4;

            eth_tx_26100_data[26] <=eth_26100_IPv4_ID[15:8];
            eth_tx_26100_data[27] <=eth_26100_IPv4_ID[7:0];
            
            eth_tx_26100_data[28] <=8'h40;                      //Flags
            eth_tx_26100_data[29] <=8'h00;
            eth_tx_26100_data[30] <=8'h40;                      //TTL
            eth_tx_26100_data[31] <=8'h11;                      //UDP
            
            eth_tx_26100_data[32] <=8'h00;                      //CRC IPv4
            eth_tx_26100_data[33] <=8'h00;
            
            eth_tx_26100_data[34] <=eth_local_ip[31:24];        //My IP   
            eth_tx_26100_data[35] <=eth_local_ip[23:16];
            eth_tx_26100_data[36] <=eth_local_ip[15:8];
            eth_tx_26100_data[37] <=eth_local_ip[7:0];
            
            eth_tx_26100_data[38] <=8'd192;                     //Dst IP
            eth_tx_26100_data[39] <=8'd168;
            eth_tx_26100_data[40] <=8'd4;
            eth_tx_26100_data[41] <=8'd1;                       //CVK
            
            eth_tx_26100_data[42] <=8'h65;                      //SP 26100
            eth_tx_26100_data[43] <=8'hF4;
            eth_tx_26100_data[44] <=8'h65;                      //DP 26100
            eth_tx_26100_data[45] <=8'hF4;
                        
            eth_tx_26100_data[46] <=8'h00;                      //Length = 8 + 168 = 176
            eth_tx_26100_data[47] <=8'hB0;

            eth_tx_26100_data[48] <=8'h00;                      //CRC
            eth_tx_26100_data[49] <=8'h00;

            eth_pre_26010_26100<=PRE_26100_CRC;
        end
        
        PRE_26100_CRC: begin
            if(eth_adc_i==0) begin
                eth_26100_crc <=    {eth_tx_26100_data[24],eth_tx_26100_data[25]} + {eth_tx_26100_data[22],eth_tx_26100_data[23]} +
                                    {eth_tx_26100_data[28],eth_tx_26100_data[29]} + {eth_tx_26100_data[26],eth_tx_26100_data[27]} +
                                    {eth_tx_26100_data[32],eth_tx_26100_data[33]} + {eth_tx_26100_data[30],eth_tx_26100_data[31]} +
                                    {eth_tx_26100_data[36],eth_tx_26100_data[37]} + {eth_tx_26100_data[34],eth_tx_26100_data[35]} +
                                    {eth_tx_26100_data[40],eth_tx_26100_data[41]} + {eth_tx_26100_data[38],eth_tx_26100_data[39]};
                eth_adc_i<=eth_adc_i+1'b1;
            end
            else if(eth_adc_i==1) begin
                eth_26100_crc[16:0] <=eth_26100_crc[31:16]+eth_26100_crc[15:0];
                eth_adc_i           <=eth_adc_i+1'b1;
            end
            else begin
                if(eth_26100_crc[16]) begin //overflow carry
                    eth_tx_26100_data[32]<=~eth_26100_crc[15:8];
                    eth_tx_26100_data[33]<=~eth_26100_crc[7:0] - 1;
                end
                else begin
                    eth_tx_26100_data[32]<=~eth_26100_crc[15:8];
                    eth_tx_26100_data[33]<=~eth_26100_crc[7:0];
                end   
                eth_adc_i<=0;
                eth_pre_26010_26100<=PRE_26100_FIFO;
            end
        end
        
        PRE_26100_FIFO: begin
            case(fifo_26100_st)
                0: begin
                    fifo_26100_wr_en        <=1;
                    fifo_26100_din			<=eth_tx_26100_data[addr_26100];
                    addr_26100		        <=addr_26100+1;
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48: begin
                    fifo_26100_din			<=eth_tx_26100_data[addr_26100];
                    addr_26100		        <=addr_26100+1;
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                49: begin
                    fifo_26100_din			<=eth_tx_26100_data[addr_26100];
                    fifo_26100_st			<=fifo_26100_st+1;
                    
                    //READ BINS data from RAM -> 50 bytes
                    //ram_bins_26100_rd_en	<=1;
                    //ram_bins_26100_rd_addr	<=0;
                end
                50: begin
                    addr_26100		        <=0;
                    fifo_26100_st			<=fifo_26100_st+1;
                    fifo_26100_din			<=ram_bins_26100_dout;
                    ram_bins_26100_rd_addr	<=ram_bins_26100_rd_addr+1'b1;
                end
                51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99: begin
                    fifo_26100_st			<=fifo_26100_st+1;
                    fifo_26100_din			<=ram_bins_26100_dout;
                    ram_bins_26100_rd_addr	<=ram_bins_26100_rd_addr+1;
                end
                100: begin
                    ram_bins_26100_rd_en	<=0;
                    ram_bins_26100_rd_addr	<=0;
                    fifo_26100_din			<=8'hA1;					//TEST Pressure -> 1 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                101: begin
                    fifo_26100_din			<=8'hB2;					//TEST Pressure -> 2 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                102: begin
                    fifo_26100_din			<=8'hC3;					//TEST Pressure -> 3 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                103: begin
                    fifo_26100_din			<=8'hD4;					//TEST Pressure -> 4 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                    
//                     READ DFS data from RAM -> 114 bytes
//                     //if(ram_dfs_26100_valid) begin
//                     //    ram_dfs_26100_rd_en<=1;
//                      //   ram_dfs_26100_rd_addr<=0;
//                     //end
//                     
//                     //if(ram_dfs_valid && ram_dfs_wr_en==0) begin
//                      //   ram_dfs_rd_en<=1;
//                     //    ram_dfs_rd_addr<=0;
//                     //end
                end
                104: begin //DFS
                    //fifo_26100_din			<=ram_dfs_26100_dout;
                    //ram_dfs_26100_rd_addr	<=ram_dfs_26100_rd_addr+1'b1;
                    
                    fifo_26100_din  <=ram_dfs_dout;
                    ram_dfs_rd_addr <=ram_dfs_rd_addr+1'b1;
                    fifo_26100_st	<=fifo_26100_st+1;
                end
                217: begin
                    //fifo_26100_din			<=ram_dfs_26100_dout; //8'hF7;					//END DFS byte
                    fifo_26100_din			<=ram_dfs_dout;
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                218: begin
                    fifo_26100_wr_en		<=0;
                    fifo_26100_st			<=0;
                    //eth_pre_26100			<=0;
                    //ram_dfs_26100_rd_addr	<=0;
                    //ram_dfs_26100_rd_en		<=0;
                    ram_dfs_rd_addr	        <=0;
                    ram_dfs_rd_en		    <=0;
                    
                    eth_pre_26010_26100     <=PRE_IDLE;
                end
                default: begin
                    fifo_26100_din			<=8'h00;					//TEST DFS
                    fifo_26100_st			<=fifo_26100_st+1;
                    ///fifo_26100_din			<=ram_dfs_26100_dout;
                    //ram_dfs_26100_rd_addr	<=ram_dfs_26100_rd_addr+1'b1;	
                    
                    fifo_26100_din			<=ram_dfs_dout;
                    ram_dfs_rd_addr	        <=ram_dfs_rd_addr+1'b1;	
                end
            endcase
        end
        
        default: eth_pre_26010_26100<=PRE_IDLE;
    endcase*/
    

    //*****************************************************************************************//
    //Prepare 26100 packet from and put in FIFO                                               *//
    //*****************************************************************************************//
    /*case(eth_pre_26100)
        4'd0: begin //IDLE
            ram_bins_26100_rd_en    <=0;
            ram_bins_26100_rd_addr  <=0;
            addr_26100              <=0;
            
            if(ram_bins_26100_valid) begin
                eth_pre_26100<=eth_pre_26100+1'b1;
            end
        end
        
        4'd1: begin //Prepare Header
        
            eth_26100_IPv4_ID     <=eth_26100_IPv4_ID+1;
        
            eth_tx_26100_data[0]  <=8'h55;                      //PREAMBULE  
            eth_tx_26100_data[1]  <=8'h55;
            eth_tx_26100_data[2]  <=8'h55;
            eth_tx_26100_data[3]  <=8'h55;
            eth_tx_26100_data[4]  <=8'h55;
            eth_tx_26100_data[5]  <=8'h55;
            eth_tx_26100_data[6]  <=8'h55;
            eth_tx_26100_data[7]  <=8'hD5; 

            eth_tx_26100_data[8]  <=eth_ARP_MAC_src[47:40];     //Dest MAC  
            eth_tx_26100_data[9]  <=eth_ARP_MAC_src[39:32];
            eth_tx_26100_data[10] <=eth_ARP_MAC_src[31:24];
            eth_tx_26100_data[11] <=eth_ARP_MAC_src[23:16];
            eth_tx_26100_data[12] <=eth_ARP_MAC_src[15:8];
            eth_tx_26100_data[13] <=eth_ARP_MAC_src[7:0];

            eth_tx_26100_data[14] <=eth_local_mac[47:40];       //Src MAC
            eth_tx_26100_data[15] <=eth_local_mac[39:32];
            eth_tx_26100_data[16] <=eth_local_mac[31:24];
            eth_tx_26100_data[17] <=eth_local_mac[23:16];
            eth_tx_26100_data[18] <=eth_local_mac[15:8];
            eth_tx_26100_data[19] <=eth_local_mac[7:0];	

            eth_tx_26100_data[20] <=8'h08;                      //TYPE 
            eth_tx_26100_data[21] <=8'h00;
            eth_tx_26100_data[22] <=8'h45;
            eth_tx_26100_data[23] <=8'h00;

            eth_tx_26100_data[24] <=8'h00;                      //Len 20 + 8 + 168 = 196 -> 00C4		//====17.06.20			
            eth_tx_26100_data[25] <=8'hC4;

            eth_tx_26100_data[26] <=eth_26100_IPv4_ID[15:8];
            eth_tx_26100_data[27] <=eth_26100_IPv4_ID[7:0];
            
            eth_tx_26100_data[28] <=8'h40;                      //Flags
            eth_tx_26100_data[29] <=8'h00;
            eth_tx_26100_data[30] <=8'h40;                      //TTL
            eth_tx_26100_data[31] <=8'h11;                      //UDP
            
            eth_tx_26100_data[32] <=8'h00;                      //CRC IPv4
            eth_tx_26100_data[33] <=8'h00;
            
            eth_tx_26100_data[34] <=eth_local_ip[31:24];        //My IP   
            eth_tx_26100_data[35] <=eth_local_ip[23:16];
            eth_tx_26100_data[36] <=eth_local_ip[15:8];
            eth_tx_26100_data[37] <=eth_local_ip[7:0];
            
            eth_tx_26100_data[38] <=8'd192;                     //Dst IP
            eth_tx_26100_data[39] <=8'd168;
            eth_tx_26100_data[40] <=8'd4;
            eth_tx_26100_data[41] <=8'd1;                       //CVK
            
            eth_tx_26100_data[42] <=8'h65;                      //SP 26100
            eth_tx_26100_data[43] <=8'hF4;
            eth_tx_26100_data[44] <=8'h65;                      //DP 26100
            eth_tx_26100_data[45] <=8'hF4;
                        
            eth_tx_26100_data[46] <=8'h00;                      //Length = 8 + 168 = 176
            eth_tx_26100_data[47] <=8'hB0;

            eth_tx_26100_data[48] <=8'h00;                      //CRC
            eth_tx_26100_data[49] <=8'h00;

            eth_pre_26100<=eth_pre_26100+1'b1;
        end
        
        4'd2: begin //Generate CRC for IPv4 
            if(eth_adc_i==0) begin
                eth_26100_crc <=    {eth_tx_26100_data[24],eth_tx_26100_data[25]} + {eth_tx_26100_data[22],eth_tx_26100_data[23]} +
                                    {eth_tx_26100_data[28],eth_tx_26100_data[29]} + {eth_tx_26100_data[26],eth_tx_26100_data[27]} +
                                    {eth_tx_26100_data[32],eth_tx_26100_data[33]} + {eth_tx_26100_data[30],eth_tx_26100_data[31]} +
                                    {eth_tx_26100_data[36],eth_tx_26100_data[37]} + {eth_tx_26100_data[34],eth_tx_26100_data[35]} +
                                    {eth_tx_26100_data[40],eth_tx_26100_data[41]} + {eth_tx_26100_data[38],eth_tx_26100_data[39]};
                eth_adc_i<=eth_adc_i+1'b1;
            end
            else if(eth_adc_i==1) begin
                eth_26100_crc[16:0] <=eth_26100_crc[31:16]+eth_26100_crc[15:0];
                eth_adc_i           <=eth_adc_i+1'b1;
            end
            else begin
                if(eth_26100_crc[16]) begin //overflow carry
                    eth_tx_26100_data[32]<=~eth_26100_crc[15:8];
                    eth_tx_26100_data[33]<=~eth_26100_crc[7:0] - 1;
                end
                else begin
                    eth_tx_26100_data[32]<=~eth_26100_crc[15:8];
                    eth_tx_26100_data[33]<=~eth_26100_crc[7:0];
                end   
                eth_adc_i<=0;
                eth_pre_26100<=eth_pre_26100+1'b1;
            end
        end
        
        4'd3: begin //Put to FIFO
            case(fifo_26100_st)
                0: begin
                    fifo_26100_wr_en        <=1;
                    fifo_26100_din			<=eth_tx_26100_data[addr_26100];
                    addr_26100		        <=addr_26100+1;
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48: begin
                    fifo_26100_din			<=eth_tx_26100_data[addr_26100];
                    addr_26100		        <=addr_26100+1;
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                49: begin
                    fifo_26100_din			<=eth_tx_26100_data[addr_26100];
                    fifo_26100_st			<=fifo_26100_st+1;
                    
                    //READ BINS data from RAM -> 50 bytes
                    ram_bins_26100_rd_en	<=1;
                    ram_bins_26100_rd_addr	<=0;
                end
                50: begin
                    addr_26100		        <=0;
                    fifo_26100_st			<=fifo_26100_st+1;
                    fifo_26100_din			<=ram_bins_26100_dout;
                    ram_bins_26100_rd_addr	<=ram_bins_26100_rd_addr+1'b1;
                end
                51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99: begin
                    fifo_26100_st			<=fifo_26100_st+1;
                    fifo_26100_din			<=ram_bins_26100_dout;
                    ram_bins_26100_rd_addr	<=ram_bins_26100_rd_addr+1;
                end
                100: begin
                    ram_bins_26100_rd_en	<=0;
                    ram_bins_26100_rd_addr	<=0;
                    fifo_26100_din			<=8'hA1;					//TEST Pressure -> 1 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                101: begin
                    fifo_26100_din			<=8'hB2;					//TEST Pressure -> 2 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                102: begin
                    fifo_26100_din			<=8'hC3;					//TEST Pressure -> 3 byte
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                103: begin
                    fifo_26100_din			<=8'hD4;					//TEST Pressure -> 4 byte
                    fifo_26100_st			<=fifo_26100_st+1;
 
                    if(ram_dfs_valid && ram_dfs_wr_en==0) begin
                        ram_dfs_rd_en<=1;
                        ram_dfs_rd_addr<=0;
                    end
                end
                104: begin //DFS
                    fifo_26100_din  <=ram_dfs_dout;
                    ram_dfs_rd_addr <=ram_dfs_rd_addr+1'b1;
                    fifo_26100_st	<=fifo_26100_st+1;
                end
                217: begin
                    //fifo_26100_din			<=ram_dfs_26100_dout; //8'hF7;					//END DFS byte
                    fifo_26100_din			<=ram_dfs_dout;
                    fifo_26100_st			<=fifo_26100_st+1;
                end
                218: 		begin
                    fifo_26100_wr_en		<=0;
                    fifo_26100_st			<=0;
                    eth_pre_26100			<=0;
                    ram_dfs_rd_addr	        <=0;
                    ram_dfs_rd_en		     <=0;
                end
                default: begin
                    fifo_26100_din			<=8'h00;					//TEST DFS
                    fifo_26100_st			<=fifo_26100_st+1;
                    
                    fifo_26100_din			<=ram_dfs_dout;
                    ram_dfs_rd_addr	        <=ram_dfs_rd_addr+1'b1;	
                end
            endcase
        end
        default: eth_pre_26100<=0;  
    endcase*/
	
	
	//*****************************************************************************************//
    //Prepare 26010 packet from and put in FIFO                                               *//
    //*****************************************************************************************//
    /*case(eth_pre_26010)
        4'd0: begin //IDLE
//             ram_dfs_26010_rd_en    <=0;
//             ram_dfs_26010_rd_addr  <=0;
//             addr_26010              <=0;
//             
//             if(ram_dfs_26010_valid) begin
//                 eth_pre_26010<=eth_pre_26010+1'b1;
//             end
            
            addr_26010<=0;
            if(event_26010_dfs_ok) begin
                event_26010_dfs_rd  <=1;
                //ram_dfs_26010_wr_en		<=1;
                //ram_dfs_26010_wr_addr	<=0;
            end  
        end
        
        4'd1: begin //Prepare Header
        
            event_26010_dfs_rd    <=0;
            eth_26010_IPv4_ID     <=eth_26010_IPv4_ID+1;
        
            eth_tx_26010_data[0]  <=8'h55;                      //PREAMBULE  
            eth_tx_26010_data[1]  <=8'h55;
            eth_tx_26010_data[2]  <=8'h55;
            eth_tx_26010_data[3]  <=8'h55;
            eth_tx_26010_data[4]  <=8'h55;
            eth_tx_26010_data[5]  <=8'h55;
            eth_tx_26010_data[6]  <=8'h55;
            eth_tx_26010_data[7]  <=8'hD5; 

            eth_tx_26010_data[8]  <=eth_ARP_MAC_src[47:40];     //Dest MAC  
            eth_tx_26010_data[9]  <=eth_ARP_MAC_src[39:32];
            eth_tx_26010_data[10] <=eth_ARP_MAC_src[31:24];
            eth_tx_26010_data[11] <=eth_ARP_MAC_src[23:16];
            eth_tx_26010_data[12] <=eth_ARP_MAC_src[15:8];
            eth_tx_26010_data[13] <=eth_ARP_MAC_src[7:0];

            eth_tx_26010_data[14] <=eth_local_mac[47:40];       //Src MAC
            eth_tx_26010_data[15] <=eth_local_mac[39:32];
            eth_tx_26010_data[16] <=eth_local_mac[31:24];
            eth_tx_26010_data[17] <=eth_local_mac[23:16];
            eth_tx_26010_data[18] <=eth_local_mac[15:8];
            eth_tx_26010_data[19] <=eth_local_mac[7:0];	

            eth_tx_26010_data[20] <=8'h08;                      //TYPE 
            eth_tx_26010_data[21] <=8'h00;
            eth_tx_26010_data[22] <=8'h45;
            eth_tx_26010_data[23] <=8'h00;

            eth_tx_26010_data[24] <=8'h00;                      //Len 20 + 8 + 114 = 142 -> 008E		//====25.06.20			
            eth_tx_26010_data[25] <=8'h8E;

            eth_tx_26010_data[26] <=eth_26010_IPv4_ID[15:8];
            eth_tx_26010_data[27] <=eth_26010_IPv4_ID[7:0];
            
            eth_tx_26010_data[28] <=8'h40;                      //Flags
            eth_tx_26010_data[29] <=8'h00;
            eth_tx_26010_data[30] <=8'h40;                      //TTL
            eth_tx_26010_data[31] <=8'h11;                      //UDP
            
            eth_tx_26010_data[32] <=8'h00;                      //CRC IPv4
            eth_tx_26010_data[33] <=8'h00;
            
            eth_tx_26010_data[34] <=eth_local_ip[31:24];        //My IP   
            eth_tx_26010_data[35] <=eth_local_ip[23:16];
            eth_tx_26010_data[36] <=eth_local_ip[15:8];
            eth_tx_26010_data[37] <=eth_local_ip[7:0];
            
            eth_tx_26010_data[38] <=8'd192;                     //Dst IP
            eth_tx_26010_data[39] <=8'd168;
            eth_tx_26010_data[40] <=8'd4;
            eth_tx_26010_data[41] <=8'd1;                       //CVK
            
            eth_tx_26010_data[42] <=8'h65;                      //SP 26010
            eth_tx_26010_data[43] <=8'h9A;
            
            eth_tx_26010_data[44] <=8'h65;                      //DP 26010
            eth_tx_26010_data[45] <=8'h9A;
                        
            eth_tx_26010_data[46] <=8'h00;                      //Length = 8 + 114 = 122
            eth_tx_26010_data[47] <=8'h7A;

            eth_tx_26010_data[48] <=8'h00;                      //CRC
            eth_tx_26010_data[49] <=8'h00;

            eth_pre_26010<=eth_pre_26010+1'b1;
        end
        
        4'd2: begin //Generate CRC for IPv4 
            if(eth_adc_i==0) begin
                eth_26010_crc <=    {eth_tx_26010_data[24],eth_tx_26010_data[25]} + {eth_tx_26010_data[22],eth_tx_26010_data[23]} +
                                    {eth_tx_26010_data[28],eth_tx_26010_data[29]} + {eth_tx_26010_data[26],eth_tx_26010_data[27]} +
                                    {eth_tx_26010_data[32],eth_tx_26010_data[33]} + {eth_tx_26010_data[30],eth_tx_26010_data[31]} +
                                    {eth_tx_26010_data[36],eth_tx_26010_data[37]} + {eth_tx_26010_data[34],eth_tx_26010_data[35]} +
                                    {eth_tx_26010_data[40],eth_tx_26010_data[41]} + {eth_tx_26010_data[38],eth_tx_26010_data[39]};
                eth_adc_i<=eth_adc_i+1'b1;
            end
            else if(eth_adc_i==1) begin
                eth_26010_crc[16:0] <=eth_26010_crc[31:16]+eth_26010_crc[15:0];
                eth_adc_i           <=eth_adc_i+1'b1;
            end
            else begin
                if(eth_26100_crc[16]) begin //overflow carry
                    eth_tx_26010_data[32]<=~eth_26010_crc[15:8];
                    eth_tx_26010_data[33]<=~eth_26010_crc[7:0] - 1;
                end
                else begin
                    eth_tx_26010_data[32]<=~eth_26010_crc[15:8];
                    eth_tx_26010_data[33]<=~eth_26010_crc[7:0];
                end   
                eth_adc_i<=0;
                eth_pre_26010<=eth_pre_26010+1'b1;
            end
        end
        
        4'd3: begin //Put to FIFO
            case(fifo_26010_st)
                0: begin
                    fifo_26010_wr_en<=1;
                    fifo_26010_din  <=eth_tx_26010_data[addr_26010];
                    addr_26010		<=addr_26010+1;
                    fifo_26010_st	<=fifo_26010_st+1;
                end
                1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48: begin
                    fifo_26010_din	<=eth_tx_26010_data[addr_26010];
                    addr_26010		<=addr_26010+1;
                    fifo_26010_st	<=fifo_26010_st+1;
                end
                49: begin
                    fifo_26010_din  <=eth_tx_26010_data[addr_26010];
                    fifo_26010_st   <=fifo_26010_st+1;
                
                    //READ DFS data from RAM -> 114 bytes
                    //if(ram_dfs_26010_valid) begin
                        //ram_dfs_26010_rd_en<=1;
                        //ram_dfs_26010_rd_addr<=0;
                    //end
                    
                    if(ram_dfs_valid && ram_dfs_wr_en==0) begin
                        ram_dfs_rd_en<=1;
                        //ram_dfs_rd_addr<=0;
                    end
                    
                end
                50: begin
                    addr_26010			    <=0;
                    fifo_26010_st			<=fifo_26010_st+1;
                    fifo_26010_din			<=ram_dfs_26010_dout;
                    ram_dfs_26010_rd_addr   <=ram_dfs_26010_rd_addr+1'b1;
                end
                164: begin//165
                    fifo_26010_wr_en		<=0;
                    fifo_26010_st			<=0;
                    eth_pre_26010			<=0;
                    ram_dfs_26010_rd_addr   <=0;
                    ram_dfs_26010_rd_en		<=0;
                end
                default: begin
                    fifo_26010_st			<=fifo_26010_st+1;
                    fifo_26010_din			<=ram_dfs_26010_dout;
                    ram_dfs_26010_rd_addr	<=ram_dfs_26010_rd_addr+1'b1;	
                end
            endcase
        end
        
        default: eth_pre_26010<=0;  
    endcase*/
	



	//*******************************************************//
	//*Send packet from FIFO's								*//
	//*******************************************************//
	case(eth_tx_state)
		tx_IDLE: begin
			
            if(fifo_eth_arp_data_cnt>=67) begin //ARP
                eth_tx_state<=tx_ARP;
            end
            else if(fifo_26100_rd_data_count>=218) begin
				 eth_tx_state<=tx_26100;
			end
			else if(fifo_26010_rd_data_count>=164) begin
                eth_tx_state<=tx_26010;
            end
            
//            else if(fifo_eth_icmp_data_cnt>=105) begin
//                eth_tx_state<=tx_ICMP;
//            end

            else if(event_eth_adc_ok) begin
                eth_tx_state        <=tx_ADC;
                event_eth_adc_rd    <=1;
            end
            
            else
                eth_tx_state<=tx_IDLE;
            
            //else if(bins_rx_cnt>=50) begin
            /*else if(bins_rx_cnt>=100) begin
                eth_tx_state        <=tx_SKP;
            end*/
            
            
            /*else if( event_eth_control_rs485_ok && ((dfs_rx_cnt>0) && dfs_rx_eop) ) begin //control line rs485
                
                event_eth_control_rs485_rd<=1;

                rs485_len <= 16'd22 + {6'd0, dfs_rx_cnt};
                if( {6'd0, dfs_rx_cnt} < 114) begin
                    rs485_ip4_len  <=16'd20 + 16'd8 + 16'd22 + {6'd0, dfs_rx_cnt} + (16'd114 - {6'd0, dfs_rx_cnt});
                    rs485_udp_len  <=         16'd8 + 16'd22 + {6'd0, dfs_rx_cnt} + (16'd114 - {6'd0, dfs_rx_cnt});
                    zero_cnt <=(16'd114 - {6'd0, dfs_rx_cnt});
                end
                else begin
                    rs485_ip4_len  <=16'd20 + 16'd8 + 16'd22 + {6'd0, dfs_rx_cnt};
                    rs485_udp_len  <=         16'd8 + 16'd22 + {6'd0, dfs_rx_cnt};
                    zero_cnt <=0;
                end
                
                eth_tx_state <=tx_SKP; 
            end*/
            
//            else if(fifo_skp_rd_data_count>=19)begin
//                skp_ip4_len  <=16'd20 + 16'd8 + 16'd22;
//                skp_udp_len  <=16'd8  + 16'd22;
//                skp_len      <={4'd0, fifo_skp_rd_data_count};

//                if( fifo_skp_rd_data_count < 22) begin
//                    zero_cnt <=16'd22 - {4'd0, fifo_skp_rd_data_count};
//                end
//                else begin
//                    zero_cnt <=0;
//                end
                
//                eth_tx_state <=tx_SKP; 
//            end
            
            /*else if( !event_eth_control_rs485_ok && ((dfs_rx_cnt>0) && dfs_rx_eop) ) begin //generator
                dfs_len     <={6'd0, dfs_rx_cnt};
                if( {6'd0, dfs_rx_cnt} < 114) begin
                    dfs_ip4_len  <=16'd20 + 16'd8 + {6'd0, dfs_rx_cnt} + (16'd114 - {6'd0, dfs_rx_cnt});
                    dfs_udp_len  <=16'd8  + {6'd0, dfs_rx_cnt}         + (16'd114 - {6'd0, dfs_rx_cnt});
                    zero_cnt <=(16'd114 - {6'd0, dfs_rx_cnt});
                end
                else begin
                    dfs_ip4_len  <=16'd20 + 16'd8 + {6'd0, dfs_rx_cnt};
                    dfs_udp_len  <=16'd8  + {6'd0, dfs_rx_cnt};
                    zero_cnt <=0;
                end
 
                eth_tx_state<=tx_DFS;
            end*/
            
			crcen<=0;
			crcrst<=1;
			eth_txen<=0;
			
			eth_tx_i<=0;
			eth_tx_j<=0;
			eth_tx_p<=0;

			eth_tx_igp<=4'd0;
			eth_tx_pre<=4'd0;
			eth_tx_temp<=8'd0;
			
			//dfs_rx_rd_en<=0;
			//fifo_skp_rd_en<=0;
		end
		
		/************************************************************/
		tx_ADC:  begin
			event_eth_adc_rd	<=1'b0;
			case(eth_tx_pre)
				4'd0: begin	//Prepare packet
				
					fifo_eth_adc_rd	    <=1'b0;
					adc_rd_addr			<=2;
				
					//pkt_cnt				<=pkt_cnt+1'b1;
					eth_ADC_IPv4_ID		<=eth_ADC_IPv4_ID+1'b1;	//Increment ID
				
					eth_tx_adc_data[0]  <=8'h55;	//PREAMBULE  
					eth_tx_adc_data[1]  <=8'h55;
					eth_tx_adc_data[2]  <=8'h55;
					eth_tx_adc_data[3]  <=8'h55;
					eth_tx_adc_data[4]  <=8'h55;
					eth_tx_adc_data[5]  <=8'h55;
					eth_tx_adc_data[6]  <=8'h55;
					eth_tx_adc_data[7]  <=8'hD5; 
					
//					eth_tx_adc_data[8]  <=8'hFF;	//Dest MAC  
//					eth_tx_adc_data[9]  <=8'hFF;
//					eth_tx_adc_data[10] <=8'hFF;
//					eth_tx_adc_data[11] <=8'hFF;
//					eth_tx_adc_data[12] <=8'hFF;
//					eth_tx_adc_data[13] <=8'hFF;	

                    eth_tx_adc_data[8]  <=eth_ARP_MAC_src[47:40];	//Dest MAC  
					eth_tx_adc_data[9]  <=eth_ARP_MAC_src[39:32];
					eth_tx_adc_data[10] <=eth_ARP_MAC_src[31:24];
					eth_tx_adc_data[11] <=eth_ARP_MAC_src[23:16];
					eth_tx_adc_data[12] <=eth_ARP_MAC_src[15:8];
					eth_tx_adc_data[13] <=eth_ARP_MAC_src[7:0];

					eth_tx_adc_data[14] <=eth_local_mac[47:40];		//Src MAC
					eth_tx_adc_data[15] <=eth_local_mac[39:32];
					eth_tx_adc_data[16] <=eth_local_mac[31:24];
					eth_tx_adc_data[17] <=eth_local_mac[23:16];
					eth_tx_adc_data[18] <=eth_local_mac[15:8];
					eth_tx_adc_data[19] <=eth_local_mac[7:0];	

					eth_tx_adc_data[20] <=8'h08;				//TYPE 
					eth_tx_adc_data[21] <=8'h00;
					eth_tx_adc_data[22] <=8'h45;
					eth_tx_adc_data[23] <=8'h00;
	
					//eth_tx_adc_data[24] <=8'h05;				//Len 20 + 8 + 1390 = 1418 -> 058A		//SKP version
					//eth_tx_adc_data[25] <=8'h8A;	
					
					
					
					eth_tx_adc_data[24] <=8'h05;			 	//Len 20 + 8 + 1422 = 1450 -> 05AA		//BINS version	
                    eth_tx_adc_data[25] <=8'hAA;             
					




					
					eth_tx_adc_data[26] <=eth_ADC_IPv4_ID[15:8];
					eth_tx_adc_data[27] <=eth_ADC_IPv4_ID[7:0];
					eth_tx_adc_data[28] <=8'h40;				//Flags
					eth_tx_adc_data[29] <=8'h00;
					eth_tx_adc_data[30] <=8'h40;				//TTL
					eth_tx_adc_data[31] <=8'h11;				//UDP
					
					eth_tx_adc_data[32] <=8'h00;				//CRC IPv4
					eth_tx_adc_data[33] <=8'h00;
					
					eth_tx_adc_data[34] <=eth_local_ip[31:24];	//My IP   
					eth_tx_adc_data[35] <=eth_local_ip[23:16];
					eth_tx_adc_data[36] <=eth_local_ip[15:8];
					eth_tx_adc_data[37] <=eth_local_ip[7:0];
					
					eth_tx_adc_data[38] <=8'd192;				//Dst IP
					eth_tx_adc_data[39] <=8'd168;
//					eth_tx_adc_data[40] <=8'd0;
//					eth_tx_adc_data[41] <=8'd10;

                    eth_tx_adc_data[40] <=8'd4;
					eth_tx_adc_data[41] <=8'd1;//CVK

					
					/*eth_tx_adc_data[42] <=8'hBB;	//SP
					eth_tx_adc_data[43] <=8'h80;
					eth_tx_adc_data[44] <=8'hBB;	//DP
					eth_tx_adc_data[45] <=8'h80;*/
					
					eth_tx_adc_data[42] <=eth_local_port[15:8];	//SP
					eth_tx_adc_data[43] <=eth_local_port[7:0];
					eth_tx_adc_data[44] <=eth_local_port[15:8];	//DP
					eth_tx_adc_data[45] <=eth_local_port[7:0];

//					eth_tx_adc_data[46] <=8'h05;	//Length = 8 + 1390		//SKP
//					eth_tx_adc_data[47] <=8'h76;
								
                    eth_tx_adc_data[46] <=8'h05;    //Length = 8 + 1422 = 1430  //BINS
                    eth_tx_adc_data[47] <=8'h96; 

					eth_tx_adc_data[48] <=8'h00;	//CRC
					eth_tx_adc_data[49] <=8'h00;

					eth_tx_pre<=4'd1;
				end
				
				4'd1: begin //Generate CRC for IPv4 
					if(eth_adc_i==0) begin											
						eth_adc_crc <={eth_tx_adc_data[24],eth_tx_adc_data[25]} + {eth_tx_adc_data[22],eth_tx_adc_data[23]} +
									  {eth_tx_adc_data[28],eth_tx_adc_data[29]} + {eth_tx_adc_data[26],eth_tx_adc_data[27]} +
									  {eth_tx_adc_data[32],eth_tx_adc_data[33]} + {eth_tx_adc_data[30],eth_tx_adc_data[31]} +
									  {eth_tx_adc_data[36],eth_tx_adc_data[37]} + {eth_tx_adc_data[34],eth_tx_adc_data[35]} +
									  {eth_tx_adc_data[40],eth_tx_adc_data[41]} + {eth_tx_adc_data[38],eth_tx_adc_data[39]};
						eth_adc_i<=eth_adc_i+1'b1;
					end
					else if(eth_adc_i==1) begin
						eth_adc_crc[16:0]<=eth_adc_crc[31:16]+eth_adc_crc[15:0];
						eth_adc_i        <=eth_adc_i+1'b1;
					end
					else begin
					    if(eth_adc_crc[16]) begin //overflow carry
                            eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
                            eth_tx_adc_data[33]<=~eth_adc_crc[7:0] - 1;
                        end
                        else begin
                            eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
                            eth_tx_adc_data[33]<=~eth_adc_crc[7:0];
                        end   
                        eth_adc_i<=0;
                        eth_tx_pre<=4'd2;
					end
				end
				
				4'd2: begin //Send packet
					eth_txen<=1;
					//CRC
					if(eth_tx_j<8) begin
						crcen<=0;  //Disable module FCS
						crcrst<=1; 	//Reset value FCS 
					end
					else begin
						crcen<=1;	//Enable module FCS
						crcrst<=0; 
					end


                    //****************************************************************
                    //End of Packet
                    //if(eth_tx_j== (16'd1439) ) begin  //SKP version
                    if(eth_tx_j== (16'd1471) ) begin    //BINS version
						eth_txd				<=fifo_eth_adc_dout;
						eth_tx_state		<=tx_FCS;
						eth_tx_i		    <=0;
						eth_tx_j			<=0;
						fifo_eth_adc_rd	    <=1'b0;	
					end
					
					//****************************************************************
					//Start of Packet
					else begin
						eth_tx_j<=eth_tx_j+1'b1;
                        if(eth_tx_j<=16'd49) begin		
							eth_txd<=eth_tx_adc_data[eth_tx_j];
							if(eth_tx_j==16'd48) begin
								fifo_eth_adc_rd<=1'b1;
								adc_rd_addr	<=1;
							end	
						end

						else if(eth_tx_j>16'd49) begin		
							eth_txd		<=fifo_eth_adc_dout;
							adc_rd_addr	<=adc_rd_addr+1;
						end
						
					end
					
				end
				
				default: eth_tx_pre<=4'd0;
			endcase
		end
		
		//*****************************************************************************************//
		//*Send 26100 packet from FIFO							   	  											*//
		//*****************************************************************************************//
		tx_26100: begin
			case(eth_tx_pre)
				0: begin
					fifo_26100_rd_en<=1;         
					eth_tx_pre<=eth_tx_pre+1'b1;
				end
				
				1: begin
					eth_tx_pre<=eth_tx_pre+1'b1; //Idle one clk
				end
				
				2: begin
					eth_txen<=1;
					if(eth_tx_j<8) begin
						crcen<=0;  	//Disable module FCS
						crcrst<=1; 	//Reset value FCS 
					end
					else begin
						crcen<=1;	//Enable module FCS
						crcrst<=0; 
					end

					case(eth_tx_j)
						217: begin
						//216: begin
							eth_txd			<=fifo_26100_dout;
							eth_tx_state	<=tx_FCS;
							eth_tx_i		<=0;
							eth_tx_j		<=0;
							fifo_26100_rd_en<=0;
						end
						default: begin
							eth_tx_j<=eth_tx_j+1'b1;
							eth_txd <=fifo_26100_dout;
						end
					endcase	
				end
				default: eth_tx_pre<=4'd0;
			endcase
		end
		//*****************************************************************************************//
		
		
		tx_26010:  begin

            /*case(eth_tx_pre)
            4'd0: begin    //Prepare packet
            
                //dfs_rx_rd_en        <=0;
                dfs_pkt_cnt         <=dfs_pkt_cnt+1;
                
                eth_tx_adc_data[0]  <=8'h55;                    //PREAMBULE  
                eth_tx_adc_data[1]  <=8'h55;
                eth_tx_adc_data[2]  <=8'h55;
                eth_tx_adc_data[3]  <=8'h55;
                eth_tx_adc_data[4]  <=8'h55;
                eth_tx_adc_data[5]  <=8'h55;
                eth_tx_adc_data[6]  <=8'h55;
                eth_tx_adc_data[7]  <=8'hD5; 
                
//                eth_tx_adc_data[8]  <=8'hFF;                    //Dest MAC  
//                eth_tx_adc_data[9]  <=8'hFF;
//                eth_tx_adc_data[10] <=8'hFF;
//                eth_tx_adc_data[11] <=8'hFF;
//                eth_tx_adc_data[12] <=8'hFF;
//                eth_tx_adc_data[13] <=8'hFF;    

                eth_tx_adc_data[8]  <=eth_ARP_MAC_src[47:40];	//Dest MAC  
                eth_tx_adc_data[9]  <=eth_ARP_MAC_src[39:32];
                eth_tx_adc_data[10] <=eth_ARP_MAC_src[31:24];
                eth_tx_adc_data[11] <=eth_ARP_MAC_src[23:16];
                eth_tx_adc_data[12] <=eth_ARP_MAC_src[15:8];
                eth_tx_adc_data[13] <=eth_ARP_MAC_src[7:0];
                
                eth_tx_adc_data[14] <=eth_local_mac[47:40];     //Src MAC
                eth_tx_adc_data[15] <=eth_local_mac[39:32];
                eth_tx_adc_data[16] <=eth_local_mac[31:24];
                eth_tx_adc_data[17] <=eth_local_mac[23:16];
                eth_tx_adc_data[18] <=eth_local_mac[15:8];
                eth_tx_adc_data[19] <=eth_local_mac[7:0];    
                
                eth_tx_adc_data[20] <=8'h08;                    //TYPE 
                eth_tx_adc_data[21] <=8'h00;
                eth_tx_adc_data[22] <=8'h45;
                eth_tx_adc_data[23] <=8'h00;
                
                eth_tx_adc_data[24] <=dfs_ip4_len[15-:8];       //IP4 len =  20 + 8 + DATA len
                eth_tx_adc_data[25] <=dfs_ip4_len[7:0];    
                eth_tx_adc_data[26] <=dfs_pkt_cnt[15:8];
                eth_tx_adc_data[27] <=dfs_pkt_cnt[7:0];
                
                eth_tx_adc_data[28] <=8'h40;                    //Flags
                eth_tx_adc_data[29] <=8'h00;
                eth_tx_adc_data[30] <=8'h80;                    //TTL 40
                eth_tx_adc_data[31] <=8'h11;                    //UDP
                eth_tx_adc_data[32] <=8'h00;                    //CRC IPv4
                eth_tx_adc_data[33] <=8'h00;
                
                eth_tx_adc_data[34] <=eth_local_ip[31:24];      //My IP   
                eth_tx_adc_data[35] <=eth_local_ip[23:16];
                eth_tx_adc_data[36] <=eth_local_ip[15:8];
                eth_tx_adc_data[37] <=eth_local_ip[7:0];
                
                eth_tx_adc_data[38] <=8'd192;                   //Dst IP
                eth_tx_adc_data[39] <=8'd168;
                eth_tx_adc_data[40] <=8'd4;
                eth_tx_adc_data[41] <=8'd1;//CVK

                eth_tx_adc_data[42] <=8'h65;                    //SP 26010
                eth_tx_adc_data[43] <=8'h9A;
                
                eth_tx_adc_data[44] <=8'h65;                    //DP 26010
                eth_tx_adc_data[45] <=8'h9A;
                
                eth_tx_adc_data[46] <=dfs_udp_len[15-:8];       //UDP len = 8 + DATA len
                eth_tx_adc_data[47] <=dfs_udp_len[7:0];
                
                eth_tx_adc_data[48] <=8'h00;    //CRC
                eth_tx_adc_data[49] <=8'h00;

                eth_tx_pre<=4'd1;
            end
            
            4'd1: begin //Generate CRC for IPv4 
                if(eth_adc_i==0) begin                                            
                    eth_adc_crc <=  {eth_tx_adc_data[24],eth_tx_adc_data[25]} + {eth_tx_adc_data[22],eth_tx_adc_data[23]} +
                                    {eth_tx_adc_data[28],eth_tx_adc_data[29]} + {eth_tx_adc_data[26],eth_tx_adc_data[27]} +
                                    {eth_tx_adc_data[32],eth_tx_adc_data[33]} + {eth_tx_adc_data[30],eth_tx_adc_data[31]} +
                                    {eth_tx_adc_data[36],eth_tx_adc_data[37]} + {eth_tx_adc_data[34],eth_tx_adc_data[35]} +
                                    {eth_tx_adc_data[40],eth_tx_adc_data[41]} + {eth_tx_adc_data[38],eth_tx_adc_data[39]};
                    eth_adc_i<=eth_adc_i+1'b1;
                end
                else if(eth_adc_i==1) begin
                    eth_adc_crc[16:0]<=eth_adc_crc[31:16]+eth_adc_crc[15:0];
                    eth_adc_i        <=eth_adc_i+1'b1;
                end
                else begin
                    if(eth_adc_crc[16]) begin //overflow carry
                        eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
                        eth_tx_adc_data[33]<=~eth_adc_crc[7:0] - 1;
                    end
                    else begin
                        eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
                        eth_tx_adc_data[33]<=~eth_adc_crc[7:0];
                    end   
                    eth_adc_i<=0;
                    eth_tx_pre<=4'd2;
                end

//                case(eth_adc_i)
//                   0: begin
//                       eth_adc_crc <={eth_tx_adc_data[24],eth_tx_adc_data[25]} + {eth_tx_adc_data[22],eth_tx_adc_data[23]} +
//                                     {eth_tx_adc_data[28],eth_tx_adc_data[29]} + {eth_tx_adc_data[26],eth_tx_adc_data[27]} +
//                                     {eth_tx_adc_data[32],eth_tx_adc_data[33]} + {eth_tx_adc_data[30],eth_tx_adc_data[31]} +
//                                     {eth_tx_adc_data[36],eth_tx_adc_data[37]} + {eth_tx_adc_data[34],eth_tx_adc_data[35]} +
//                                     {eth_tx_adc_data[40],eth_tx_adc_data[41]} + {eth_tx_adc_data[38],eth_tx_adc_data[39]};
//                       eth_adc_i<=eth_adc_i+1'b1;
//                   end
                   
//                   1: begin
//                       eth_adc_crc[16:0]<=eth_adc_crc[31:16]+eth_adc_crc[15:0];
//                       eth_adc_i<=eth_adc_i+1'b1;
//                   end
                   
//                   2: begin
//                       case(eth_adc_crc[16])
//                           0: begin
//                               eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                               eth_tx_adc_data[33]<=~eth_adc_crc[7:0];
//                           end
                           
//                           1: begin //overflow carry
//                               eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                               eth_tx_adc_data[33]<=~eth_adc_crc[7:0] - 1;
//                           end
//                       endcase
//                       eth_adc_i  <=0;
//                       eth_tx_pre <=4'd2;
//                   end
//                endcase	
                
            end
            
            4'd2: begin //Send packet
                eth_txen<=1;
                //CRC
                if(eth_tx_j<8) begin
                    crcen<=0;       //Disable module FCS
                    crcrst<=1;      //Reset value FCS 
                end
                else begin
                    crcen<=1;       //Enable module FCS
                    crcrst<=0; 
                end
            
            
                //****************************************************************
                //End of Packet
                //if(eth_tx_j==16'd1439) begin    
                if(eth_tx_j == (16'd8 + 16'd14 + 16'd20 + 16'd8 + dfs_len) - 1 ) begin  
                    eth_txd         <=dfs_rx_dout;
                    eth_tx_i        <=0;
                    eth_tx_j        <=0;
                    //dfs_rx_rd_en    <=0;  
                    
                    if(zero_cnt>0) 
                        eth_tx_state<=tx_ZERO;
                    else
                        eth_tx_state<=tx_FCS;
                end
            
                //****************************************************************
                //Start of Packet
                else begin
                    eth_tx_j<=eth_tx_j+1'b1;
                    if(eth_tx_j<=16'd49) begin        
                        eth_txd<=eth_tx_adc_data[eth_tx_j];
                        if(eth_tx_j==16'd48) begin
                            //dfs_rx_rd_en<=1;
                        end    
                    end
                    else if(eth_tx_j>16'd49) begin        
                        eth_txd<=dfs_rx_dout;
                    end
                end
            end
            
            default: eth_tx_pre<=4'd0;
            endcase*/
            
            //eth_tx_state<=tx_IDLE;
            
            
            case(eth_tx_pre)
                0: begin
                    fifo_26010_rd_en<=1;         
                    eth_tx_pre		<=1;
                end

                1: begin
                    eth_tx_pre  <=2; //Idle one clk
                end

                2: begin
                    eth_txen<=1;
                    if(eth_tx_j<8) begin
                        crcen<=0;  	//Disable module FCS
                        crcrst<=1; 	//Reset value FCS 
                    end
                    else begin
                        crcen<=1;	//Enable module FCS
                        crcrst<=0; 
                    end

                    case(eth_tx_j)
                        163: begin//163
                            eth_txd			<=fifo_26010_dout;
                            eth_tx_state	<=tx_FCS;
                            eth_tx_i		<=0;
                            eth_tx_j		<=0;
                            fifo_26010_rd_en<=0;	
                        end
                        default: begin
                            eth_tx_j<=eth_tx_j+1'b1;
                            eth_txd <=fifo_26010_dout;
                        end
                    endcase
                end
                
                default: eth_tx_pre<=4'd0;
            endcase
		end
		
		/*tx_ZERO: begin
            //End of Packet
            if(eth_tx_j==zero_cnt-1) begin
                eth_txd      <=0;
                eth_tx_j     <=0;
                eth_tx_i     <=0;
                zero_cnt     <=0;
                eth_tx_state <=tx_FCS;
            end
            //Start of Packet
            else begin
                eth_txd  <=0;
                eth_tx_j <=eth_tx_j+1'b1;
            end
		end*/
		
		tx_ARP:  begin
			case(eth_tx_pre)
				4'd0: begin
					fifo_eth_arp_rd	<=1'b1;         
					eth_tx_pre		<=4'd1;
				end
				
				4'd1: begin
                    eth_tx_pre      <=4'd2;
				end
				
				4'd2: begin
                    eth_tx_pre      <=4'd3;
                end
				
				4'd3: begin
					eth_txen<=1;
					//CRC
					if(eth_tx_j<8) begin
						crcen<=0;  	//Disable module FCS
						crcrst<=1; 	//Reset value FCS 
					end
					else begin
						crcen<=1;	//Enable module FCS
						crcrst<=0; 
					end
					
					//****************************************************************
					//End of Packet
					if(eth_tx_j==16'd67) begin//67
						eth_txd           <=fifo_eth_arp_dout;
						fifo_eth_arp_rd   <=1'b0;
						eth_tx_j		  <=0;
						eth_tx_i	      <=0;
						eth_tx_state 	  <=tx_FCS;
					end
					
					//Start of Packet
					else begin
						eth_txd 		  <=fifo_eth_arp_dout;
						eth_tx_j		  <=eth_tx_j+1'b1;
					end
				end
				
				default: eth_tx_pre<=4'd0;
			endcase
		end

		tx_ICMP: begin
//            case(eth_tx_pre)
//                4'd0: begin
//                    fifo_eth_icmp_rd <=1'b1;
//                    eth_tx_pre       <=4'd1;
//                end
                
//                4'd1: begin
//                    eth_tx_pre       <=4'd2;
//                end
                
//                4'd2: begin
//                    eth_tx_pre       <=4'd3;
//                end
                
//                4'd3: begin
//                    eth_txen<=1;
//                    //CRC
//                    if(eth_tx_j<8) begin
//                        crcen<=0;      //Disable module FCS
//                        crcrst<=1;     //Reset value FCS 
//                    end
//                    else begin
//                        crcen<=1;    //Enable module FCS
//                        crcrst<=0; 
//                    end
                    
//                    //****************************************************************
//                    //End of Packet
//                    if(eth_tx_j==16'd105) begin
//                        eth_txd           <=fifo_eth_icmp_dout;
//                        fifo_eth_icmp_rd  <=1'b0;
//                        eth_tx_j          <=0;
//                        eth_tx_i          <=0;
//                        eth_tx_state      <=tx_FCS;
//                    end
                    
//                    //Start of Packet
//                    else begin
//                        eth_txd           <=fifo_eth_icmp_dout;
//                        eth_tx_j          <=eth_tx_j+1'b1;
//                    end
//                end

//				default:	eth_tx_state<=tx_IDLE;
//			endcase	
            eth_tx_state<=tx_IDLE;
		end

		tx_FCS:  begin 
			crcen<=1'b0;
			if(eth_tx_i==0)	begin
				//eth_txd	<= {~fcs[24], ~fcs[25], ~fcs[26], ~fcs[27], ~fcs[28], ~fcs[29], ~fcs[30], ~fcs[31]};
				//crc1 		<= {~fcs[24], ~fcs[25], ~fcs[26], ~fcs[27], ~fcs[28], ~fcs[29], ~fcs[30], ~fcs[31]};
				eth_tx_i <=eth_tx_i+1'b1;
				fcs_t	<= {	~crcnext[24], ~crcnext[25], ~crcnext[26], ~crcnext[27], ~crcnext[28], ~crcnext[29], ~crcnext[30], ~crcnext[31], 
								~crcnext[16], ~crcnext[17], ~crcnext[18], ~crcnext[19], ~crcnext[20], ~crcnext[21], ~crcnext[22], ~crcnext[23], 
								~crcnext[8],  ~crcnext[9],  ~crcnext[10], ~crcnext[11], ~crcnext[12], ~crcnext[13], ~crcnext[14], ~crcnext[15], 
								~crcnext[0],  ~crcnext[1],  ~crcnext[2],  ~crcnext[3],  ~crcnext[4],  ~crcnext[5],  ~crcnext[6],  ~crcnext[7]};		
				eth_txd	<= {~crcnext[24], ~crcnext[25], ~crcnext[26], ~crcnext[27], ~crcnext[28], ~crcnext[29], ~crcnext[30], ~crcnext[31]};
			end
			else begin
				if(eth_tx_i==1) begin
					//eth_txd	<={~fcs[16], ~fcs[17], ~fcs[18], ~fcs[19], ~fcs[20], ~fcs[21], ~fcs[22], ~fcs[23]};
					//crc2		<={~fcs[16], ~fcs[17], ~fcs[18], ~fcs[19], ~fcs[20], ~fcs[21], ~fcs[22], ~fcs[23]};
					eth_tx_i <=eth_tx_i+1'b1;
					eth_txd	<=fcs_t[23:16];
			  end
			  else if(eth_tx_i==2) begin
					//eth_txd	<={~fcs[8], ~fcs[9], ~fcs[10], ~fcs[11], ~fcs[12], ~fcs[13], ~fcs[14], ~fcs[15]};
					//crc3		<={~fcs[8], ~fcs[9], ~fcs[10], ~fcs[11], ~fcs[12], ~fcs[13], ~fcs[14], ~fcs[15]};
					eth_tx_i <=eth_tx_i+1'b1;
					eth_txd	<=fcs_t[15:8];
			  end
			  else if(eth_tx_i==3) begin
					//eth_txd	<={~fcs[0], ~fcs[1], ~fcs[2], ~fcs[3], ~fcs[4], ~fcs[5], ~fcs[6], ~fcs[7]};
					//crc4		<={~fcs[0], ~fcs[1], ~fcs[2], ~fcs[3], ~fcs[4], ~fcs[5], ~fcs[6], ~fcs[7]};
					eth_txd	<=fcs_t[7:0];
					
					eth_tx_i<=0;
					eth_tx_j<=0;
					eth_tx_state<=tx_IGP;
			  end
			  else begin
					eth_txer<=1'b1;
			  end
			end
		end

		tx_IGP:  begin
			eth_txen<=1'b0;
			eth_txd<=4'h00;
			if(eth_tx_igp<4'd12)
				eth_tx_igp<=eth_tx_igp+1'b1;
			else
				eth_tx_state<=tx_IDLE;
		end
		
		default: eth_tx_state<=tx_IDLE;
	endcase				
end


ila_eth_rx ila_eth_rx1
(
   .clk        (eth_rx_clk),
   .probe0     (eth_rxdv),          //1
   .probe1     (eth_rxer),          //1
   .probe2     (eth_rxd),           //8
   
   .probe3     (dfs_tx_wr_en),      //1
   .probe4     (dfs_tx_din)         //8
   
   //.probe3     (eth_rx_state),      //4
   //.probe4     (eth_rx_alg_state),  //8
   //.probe5     (event_eth_arp_wr)   //1
);



ila_eth_tx ila_eth_tx1
(
   .clk        (eth_tx_clk),
   .probe0     (eth_txen),           //1
   .probe1     (eth_txd)             //8
);


/*
eth_rx_state;
reg [15:0] 	eth_rx_byte_cnt;
reg [7:0]  	eth_rx_alg_state;
*/



/*
ila_1 ila_eth_tx1
(
   .clk        (eth_tx_clk),
   .probe0     (eth_txen),              //1
   .probe1     (fifo_26010_wr_en),      //1
   .probe2     (eth_txd),               //8
   
   .probe3     (eth_prepare),           //5
   .probe4     (event_26100_bins_ok),   //1
   .probe5     (event_26010_dfs_ok),    //1
   .probe6     (event_26100_dfs_ok),    //1
   
   .probe7     (dfs_rx_rd_en),          //1
   .probe8     (dfs_rx_eop),            //1
   .probe9     (dfs_rx_cnt),            //10
   .probe10    (dfs_26100_timeout)      //32
    
);*/


//ila_3 ila_eth_rx
//(
//    .clk        (eth_rx_clk),
//    .probe0     (eth_rxdv),         //1
//    .probe1     (eth_rxer),         //1
//    .probe2     (eth_rxd),          //8
    
//    .probe3     (event_eth_arp_wr), //1
//    .probe4     (event_eth_arp_ok), //1
//    .probe5     (event_eth_arp_rd), //1
    
    
//    .probe6     (eth_rx_state),     //4
//    .probe7     ({eth_ARP_layer[23:0],eth_rxd}), //32
//    .probe8     ({eth_layer[7:0],eth_rxd})
    
//);

//ila_3 ila_eth_tx
//(
//    .clk        (eth_tx_clk),
//    .probe0     (eth_txen),         //1
//    .probe1     (eth_txer),         //1
//    .probe2     (eth_txd),          //8
    
//    .probe3     (1'b0),             //1
//    .probe4     (1'b0),             //1
//    .probe5     (1'b0)              //1
//);


//ila_4 eth_tx_dbg
//(
//    .clk        (eth_tx_clk),
//    .probe0     (eth_tx_state),         //8
//    .probe1     (eth_tx_pre),           //4
//    .probe2     (eth_txen),             //1
//    .probe3     (eth_tx_j),             //16
//    .probe4     (fifo_eth_arp_rd),      //1
//    .probe5     (fifo_eth_arp_din),     //8
//    .probe6     (fifo_eth_arp_empty),   //1
//    .probe7     (fifo_eth_arp_wr),      //1
//    .probe8     (fifo_eth_arp_dout),    //8
//    .probe9     (fifo_eth_arp_full),    //8
//    .probe10    (fifo_eth_arp_data_cnt),//10   
//    .probe11    (eth_txd)               //8
//);


//ila_4 eth_tx_dbg
//(
//    .clk        (eth_tx_clk),
//    .probe0     (eth_tx_state),         //8
//    .probe1     (eth_tx_pre),           //4
//    .probe2     (eth_txen),             //1
//    .probe3     (eth_tx_j),             //16
//    //.probe4     (0),                    //1
//    //.probe5     (0),                    //8
//    //.probe6     (0),                    //1
//    //.probe7     (0),                    //1
//    //.probe8     (0),                    //8
//    //.probe9     (0),                    //8
//    //.probe10    (0),                    //10   
//    .probe4    (eth_txd)               //8
//);



//(* MARK_DEBUG="true" *)wire [3:0]   eth_rx_state_debug;
//(* MARK_DEBUG="true" *)wire         eth_rxdv_debug;
//(* MARK_DEBUG="true" *)wire [7:0]   eth_rxd_debug;
//(* MARK_DEBUG="true" *)wire         event_eth_arp_wr_debug;

//assign eth_rx_state_debug       = eth_rx_state;
//assign eth_rxdv_debug           = eth_rxdv;
//assign eth_rxd_debug            = eth_rxd;
//assign event_eth_arp_wr_debug   = event_eth_arp_wr;

//ila_rx eth_rx_dbg
//(
//    .clk        (~eth_rx_clk),
//    .probe0     (eth_rx_state_debug),       //8
//    .probe1     (eth_rxdv_debug),           //1
//    .probe2     (eth_rxd_debug),            //8
//    .probe3     (event_eth_arp_wr_debug)    //1
//);

endmodule




//tx_SKP:  begin //bins 50 bytes
//             case(eth_tx_pre)
// 				4'd0: begin	//Prepare packet
// 
// 					eth_ADC_IPv4_ID		<=eth_ADC_IPv4_ID+1'b1;	//Increment ID
// 				
// 					eth_tx_adc_data[0]  <=8'h55;	//PREAMBULE  
// 					eth_tx_adc_data[1]  <=8'h55;
// 					eth_tx_adc_data[2]  <=8'h55;
// 					eth_tx_adc_data[3]  <=8'h55;
// 					eth_tx_adc_data[4]  <=8'h55;
// 					eth_tx_adc_data[5]  <=8'h55;
// 					eth_tx_adc_data[6]  <=8'h55;
// 					eth_tx_adc_data[7]  <=8'hD5; 
// 					
//                     eth_tx_adc_data[8]  <=eth_ARP_MAC_src[47:40];	//Dest MAC  
// 					eth_tx_adc_data[9]  <=eth_ARP_MAC_src[39:32];
// 					eth_tx_adc_data[10] <=eth_ARP_MAC_src[31:24];
// 					eth_tx_adc_data[11] <=eth_ARP_MAC_src[23:16];
// 					eth_tx_adc_data[12] <=eth_ARP_MAC_src[15:8];
// 					eth_tx_adc_data[13] <=eth_ARP_MAC_src[7:0];
// 
// 					eth_tx_adc_data[14] <=eth_local_mac[47:40];		//Src MAC
// 					eth_tx_adc_data[15] <=eth_local_mac[39:32];
// 					eth_tx_adc_data[16] <=eth_local_mac[31:24];
// 					eth_tx_adc_data[17] <=eth_local_mac[23:16];
// 					eth_tx_adc_data[18] <=eth_local_mac[15:8];
// 					eth_tx_adc_data[19] <=eth_local_mac[7:0];	
// 
// 					eth_tx_adc_data[20] <=8'h08;				//TYPE 
// 					eth_tx_adc_data[21] <=8'h00;
// 					eth_tx_adc_data[22] <=8'h45;
// 					eth_tx_adc_data[23] <=8'h00;
//                     
//                     eth_tx_adc_data[24] <=8'h00;			 	//Len 20 + 8 + 100 = 128 -> 0080		//BINS
//                     eth_tx_adc_data[25] <=8'h80;  
// 
// 					eth_tx_adc_data[26] <=eth_ADC_IPv4_ID[15:8];
// 					eth_tx_adc_data[27] <=eth_ADC_IPv4_ID[7:0];
// 					
// 					eth_tx_adc_data[28] <=8'h40;				//Flags
// 					eth_tx_adc_data[29] <=8'h00;
// 					eth_tx_adc_data[30] <=8'h40;				//TTL
// 					eth_tx_adc_data[31] <=8'h11;				//UDP
// 					
// 					eth_tx_adc_data[32] <=8'h00;				//CRC IPv4
// 					eth_tx_adc_data[33] <=8'h00;
// 					
// 					eth_tx_adc_data[34] <=eth_local_ip[31:24];	//My IP   
// 					eth_tx_adc_data[35] <=eth_local_ip[23:16];
// 					eth_tx_adc_data[36] <=eth_local_ip[15:8];
// 					eth_tx_adc_data[37] <=eth_local_ip[7:0];
// 					
// 					eth_tx_adc_data[38] <=8'd192;				//Dst IP
// 					eth_tx_adc_data[39] <=8'd168;
//                     eth_tx_adc_data[40] <=8'd4;
// 					eth_tx_adc_data[41] <=8'd1;//CVK
// 					
// 					eth_tx_adc_data[42] <=eth_local_port[15:8];	//SP
// 					eth_tx_adc_data[43] <=eth_local_port[7:0];
// 					eth_tx_adc_data[44] <=eth_local_port[15:8];	//DP
// 					eth_tx_adc_data[45] <=eth_local_port[7:0];
// 
//                     eth_tx_adc_data[46] <=8'h00;    //Length = 8 + 100 = 108  //BINS
//                     eth_tx_adc_data[47] <=8'h6C; 
//                     
// 					eth_tx_adc_data[48] <=8'h00;	//CRC
// 					eth_tx_adc_data[49] <=8'h00;
// 
// 					eth_tx_pre<=4'd1;
// 				end
// 				
// 				4'd1: begin //Generate CRC for IPv4 
// 					if(eth_adc_i==0) begin											
// 						eth_adc_crc <={eth_tx_adc_data[24],eth_tx_adc_data[25]} + {eth_tx_adc_data[22],eth_tx_adc_data[23]} +
// 									  {eth_tx_adc_data[28],eth_tx_adc_data[29]} + {eth_tx_adc_data[26],eth_tx_adc_data[27]} +
// 									  {eth_tx_adc_data[32],eth_tx_adc_data[33]} + {eth_tx_adc_data[30],eth_tx_adc_data[31]} +
// 									  {eth_tx_adc_data[36],eth_tx_adc_data[37]} + {eth_tx_adc_data[34],eth_tx_adc_data[35]} +
// 									  {eth_tx_adc_data[40],eth_tx_adc_data[41]} + {eth_tx_adc_data[38],eth_tx_adc_data[39]};
// 						eth_adc_i<=eth_adc_i+1'b1;
// 					end
// 					else if(eth_adc_i==1) begin
// 						eth_adc_crc[16:0]<=eth_adc_crc[31:16]+eth_adc_crc[15:0];
// 						eth_adc_i        <=eth_adc_i+1'b1;
// 					end
// 					else begin
// 					    if(eth_adc_crc[16]) begin //overflow carry
//                             eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                             eth_tx_adc_data[33]<=~eth_adc_crc[7:0] - 1;
//                         end
//                         else begin
//                             eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                             eth_tx_adc_data[33]<=~eth_adc_crc[7:0];
//                         end   
//                         eth_adc_i<=0;
//                         eth_tx_pre<=4'd2;
// 					end
// 
// 				end
// 				
// 				4'd2: begin //Send packet
// 					eth_txen<=1;
// 					CRC
// 					if(eth_tx_j<8) begin
// 						crcen<=0;  //Disable module FCS
// 						crcrst<=1; 	//Reset value FCS 
// 					end
// 					else begin
// 						crcen<=1;	//Enable module FCS
// 						crcrst<=0; 
// 					end
// 
//                     if(eth_tx_j== (16'd99+50) ) begin          //BINS 
// 						eth_txd				<=bins_rx_din;//fifo_eth_adc_dout;
// 						eth_tx_state		<=tx_FCS;
// 						eth_tx_i		    <=0;
// 						eth_tx_j			<=0;
// 						fifo_eth_adc_rd	    <=1'b0;	
// 						bins_rx_rd_en<=0;
// 					end
// 					
// 					****************************************************************
// 					Start of Packet
// 					else begin
// 						eth_tx_j<=eth_tx_j+1'b1;
//                         if(eth_tx_j<=16'd49) begin		
// 							eth_txd<=eth_tx_adc_data[eth_tx_j];
// 							if(eth_tx_j==16'd48) begin
// 								bins_rx_rd_en<=1;
// 							end	
// 						end
// 
// 						else if(eth_tx_j>16'd49) begin		
// 							eth_txd		<=bins_rx_din;//fifo_eth_adc_dout;
// 						end
// 						
// 					end
// 					
// 				end
// 				
// 				default: eth_tx_pre<=4'd0;
// 			endcase
			
			//eth_tx_state<=tx_IDLE;
		//end


//*******************************************************//
	//Prepare ICMP packet from eth, and put in FIFO		  *//
	//*******************************************************//
//	case(eth_pre_icmp)
//		4'd0: begin //Idle
//			fifo_eth_icmp_wr  <=1'b0;
//			eth_pre_icmp_bcnt <=16'd0;
//			event_eth_icmp_rd <=1'b0;
			
//			if(event_eth_icmp_ok) begin
//				eth_pre_icmp<=4'd1;
//				event_eth_icmp_rd<=1'b1;
//			end
//		end
		
//		4'd1: begin //Fill
//			event_eth_icmp_rd<=1'b0;
//			eth_icmp_cnt<=eth_icmp_cnt+1'b1;
			
//			//PREAMBULE  
//			eth_tx_icmp_data[0]  <=8'h55;					
//			eth_tx_icmp_data[1]  <=8'h55;
//			eth_tx_icmp_data[2]  <=8'h55;
//			eth_tx_icmp_data[3]  <=8'h55;
//			eth_tx_icmp_data[4]  <=8'h55;
//			eth_tx_icmp_data[5]  <=8'h55;
//			eth_tx_icmp_data[6]  <=8'h55;
//			eth_tx_icmp_data[7]  <=8'hD5; 
			
//			//ETH
//			eth_tx_icmp_data[8]  <=ICMP_MAC_src[47:40];		//Dest MAC  
//			eth_tx_icmp_data[9]  <=ICMP_MAC_src[39:32];
//			eth_tx_icmp_data[10] <=ICMP_MAC_src[31:24];
//			eth_tx_icmp_data[11] <=ICMP_MAC_src[23:16];
//			eth_tx_icmp_data[12] <=ICMP_MAC_src[15:8];
//			eth_tx_icmp_data[13] <=ICMP_MAC_src[7:0];	
			
//			eth_tx_icmp_data[14] <=eth_local_mac[47:40];	//Src MAC
//			eth_tx_icmp_data[15] <=eth_local_mac[39:32];
//			eth_tx_icmp_data[16] <=eth_local_mac[31:24];
//			eth_tx_icmp_data[17] <=eth_local_mac[23:16];
//			eth_tx_icmp_data[18] <=eth_local_mac[15:8];
//			eth_tx_icmp_data[19] <=eth_local_mac[7:0];	

//			//TYPE 
//			eth_tx_icmp_data[20] <=8'h08;			
//			eth_tx_icmp_data[21] <=8'h00;
			
//			//IPv4
//			eth_tx_icmp_data[22] <=8'h45;						//Version number: 4; Header length: 20; 
//			eth_tx_icmp_data[23] <=8'h00;
			
			
//			eth_tx_icmp_data[24] <=8'h00;	//IPv4 total length
//			eth_tx_icmp_data[25] <=8'h54;
			
//			eth_tx_icmp_data[26] <=eth_icmp_cnt[15:8];		//Package serial number
//			eth_tx_icmp_data[27] <=eth_icmp_cnt[7:0];
			
//			eth_tx_icmp_data[28] <=8'h00;						//Fragment offset
//			eth_tx_icmp_data[29] <=8'h00;
//			//eth_tx_icmp_data[30] <=eth_IPv4_ttl;				//TTL 64 8'h40;
//			eth_tx_icmp_data[30] <=8'h40;
			
//			eth_tx_icmp_data[31] <=8'h01;						//Protocol: 01(ICMP)
//			eth_tx_icmp_data[32] <=8'h00;						//Header checksum
//			eth_tx_icmp_data[33] <=8'h00;
			
//			eth_tx_icmp_data[34] <=eth_local_ip[31:24];	//Source IP   
//			eth_tx_icmp_data[35] <=eth_local_ip[23:16];
//			eth_tx_icmp_data[36] <=eth_local_ip[15:8];
//			eth_tx_icmp_data[37] <=eth_local_ip[7:0];
			
//			eth_tx_icmp_data[38] <=ICMP_IP_src[31:24];		//Dest IP
//			eth_tx_icmp_data[39] <=ICMP_IP_src[23:16];
//			eth_tx_icmp_data[40] <=ICMP_IP_src[15:8];
//			eth_tx_icmp_data[41] <=ICMP_IP_src[7:0];
			
//			/*case(eth_ICMP_tlen)
//				16'd64: begin //ICMP packet for Linux OS
//					eth_tx_icmp_data[42]  <=8'h00;						//TYPE:0 (Echo (ping) reply)
//					eth_tx_icmp_data[43]  <=8'h00;						//CODE:0
//					eth_tx_icmp_data[44]  <=8'h00;						//CHECKSUM
//					eth_tx_icmp_data[45]  <=8'h00;
					
//					//Fill data
//					for(int eth_icmp_i=46, eth_icmp_j=0; eth_icmp_i<106; eth_icmp_i=eth_icmp_i+1, eth_icmp_j=eth_icmp_j+1) begin
//						eth_tx_icmp_data[eth_icmp_i] <=eth_ICMP_layer[479-(eth_icmp_j*8)-:8];//487
//					end
//				end
				
//				default: eth_pre_icmp<=4'd0;
//			endcase*/
			
			
//			eth_tx_icmp_data[42]  <=8'h00;						//TYPE:0 (Echo (ping) reply)
//			eth_tx_icmp_data[43]  <=8'h00;						//CODE:0
//			eth_tx_icmp_data[44]  <=8'h00;						//CHECKSUM
//			eth_tx_icmp_data[45]  <=8'h00;
			
//			//Fill data
//			for(int eth_icmp_i=46, eth_icmp_j=0; eth_icmp_i<106; eth_icmp_i=eth_icmp_i+1, eth_icmp_j=eth_icmp_j+1) begin
//				eth_tx_icmp_data[eth_icmp_i] <=eth_ICMP_layer[479-(eth_icmp_j*8)-:8];//487
//			end
//			eth_pre_icmp<=4'd2;
//		end
		
//		4'd2: begin //Generate CRC for IPv4
//			if(eth_icmp_i==0) begin											
//				eth_chk_buf <= {eth_tx_icmp_data[24],eth_tx_icmp_data[25]} + {eth_tx_icmp_data[22],eth_tx_icmp_data[23]} +
//							   {eth_tx_icmp_data[28],eth_tx_icmp_data[29]} + {eth_tx_icmp_data[26],eth_tx_icmp_data[27]} +
//							   {eth_tx_icmp_data[32],eth_tx_icmp_data[33]} + {eth_tx_icmp_data[30],eth_tx_icmp_data[31]} +
//							   {eth_tx_icmp_data[36],eth_tx_icmp_data[37]} + {eth_tx_icmp_data[34],eth_tx_icmp_data[35]} +
//							   {eth_tx_icmp_data[40],eth_tx_icmp_data[41]} + {eth_tx_icmp_data[38],eth_tx_icmp_data[39]};
//				eth_icmp_i<=eth_icmp_i+1'b1;
//			end
//			else if(eth_icmp_i==1) begin
//				eth_chk_buf[15:0]<=eth_chk_buf[31:16]+eth_chk_buf[15:0];
//				eth_icmp_i<=eth_icmp_i+1'b1;
//			end
//			else begin
//				eth_tx_icmp_data[32]<=~eth_chk_buf[15:8];
//				eth_tx_icmp_data[33]<=~eth_chk_buf[7:0];
//				eth_icmp_i<=0;
//				eth_icmp_j<=0;
//				eth_pre_icmp<=4'd3;
//			end
//		end
		
//		4'd3: begin //Generate CRC ICMP
//			if(eth_icmp_i==0) begin
//				case(eth_ICMP_tlen)
//					16'd64: begin //for Linux OS
//						eth_chk_buf <=  {eth_tx_icmp_data[44],eth_tx_icmp_data[45]}   + {eth_tx_icmp_data[42],eth_tx_icmp_data[43]} +
//									    {eth_tx_icmp_data[48],eth_tx_icmp_data[49]}   + {eth_tx_icmp_data[46],eth_tx_icmp_data[47]} +
//										{eth_tx_icmp_data[52],eth_tx_icmp_data[53]}   + {eth_tx_icmp_data[50],eth_tx_icmp_data[51]} +
//										{eth_tx_icmp_data[56],eth_tx_icmp_data[57]}   + {eth_tx_icmp_data[54],eth_tx_icmp_data[55]} +
//										{eth_tx_icmp_data[60],eth_tx_icmp_data[61]}   + {eth_tx_icmp_data[58],eth_tx_icmp_data[59]} +	
//										{eth_tx_icmp_data[64],eth_tx_icmp_data[65]}   + {eth_tx_icmp_data[62],eth_tx_icmp_data[63]} +
//										{eth_tx_icmp_data[68],eth_tx_icmp_data[69]}   + {eth_tx_icmp_data[66],eth_tx_icmp_data[67]} +
//										{eth_tx_icmp_data[72],eth_tx_icmp_data[73]}   + {eth_tx_icmp_data[70],eth_tx_icmp_data[71]} +
//										{eth_tx_icmp_data[76],eth_tx_icmp_data[77]}   + {eth_tx_icmp_data[74],eth_tx_icmp_data[75]} +
//										{eth_tx_icmp_data[80],eth_tx_icmp_data[81]}   + {eth_tx_icmp_data[78],eth_tx_icmp_data[79]} +
//										{eth_tx_icmp_data[84],eth_tx_icmp_data[85]}   + {eth_tx_icmp_data[82],eth_tx_icmp_data[83]} +
//										{eth_tx_icmp_data[88],eth_tx_icmp_data[89]}   + {eth_tx_icmp_data[86],eth_tx_icmp_data[87]} +
//										{eth_tx_icmp_data[92],eth_tx_icmp_data[93]}   + {eth_tx_icmp_data[90],eth_tx_icmp_data[91]} +
//										{eth_tx_icmp_data[96],eth_tx_icmp_data[97]}   + {eth_tx_icmp_data[94],eth_tx_icmp_data[95]} +
//										{eth_tx_icmp_data[100],eth_tx_icmp_data[101]} + {eth_tx_icmp_data[98],eth_tx_icmp_data[99]} +
//										{eth_tx_icmp_data[104],eth_tx_icmp_data[105]} + {eth_tx_icmp_data[102],eth_tx_icmp_data[103]};	
//					end
					
//					default: eth_pre_icmp<=4'd0;
//				endcase
//				eth_icmp_i<=eth_icmp_i+1'b1;
//			end
//			else if(eth_icmp_i==1) begin
//				eth_chk_buf[15:0]<=eth_chk_buf[31:16]+eth_chk_buf[15:0];
//				eth_icmp_i<=eth_icmp_i+1'b1;
//			end
//			else begin
//				eth_tx_icmp_data[44]<=~eth_chk_buf[15:8];
//				eth_tx_icmp_data[45]<=~eth_chk_buf[7:0];
//				eth_icmp_i<=0;
//				eth_icmp_j<=0;
//				case(eth_ICMP_tlen)
//					16'd64:  eth_pre_icmp<=4'd4;
//					default: eth_pre_icmp<=4'd0;
//				endcase
//			end
//		end
		
//		4'd4: begin //Put it FIFO
//            case(eth_pre_icmp_bcnt)
//                0: begin
//                    fifo_eth_icmp_wr  <=1'b1;
//                    fifo_eth_icmp_din <=eth_tx_icmp_data[0];
//                    eth_pre_icmp_bcnt <=eth_pre_icmp_bcnt+1;
//                end
                
//                105: begin
//                    fifo_eth_icmp_din <=eth_tx_icmp_data[eth_pre_icmp_bcnt];
//                    eth_pre_icmp	  <=4'd0;
//                end
                
//                default: begin
//                    fifo_eth_icmp_din <=eth_tx_icmp_data[eth_pre_icmp_bcnt];
//                    eth_pre_icmp_bcnt <=eth_pre_icmp_bcnt+1'b1;
//                end
//            endcase	
//		end
		
//		default: eth_pre_icmp<=4'd0;
//	endcase
//		    case(eth_tx_pre)
//            4'd0: begin //Prepare packet
            
//                fifo_skp_rd_en      <=0;
//                skp_pkt_cnt         <=skp_pkt_cnt+1;
                
//                eth_tx_adc_data[0]  <=8'h55;                    //PREAMBULE  
//                eth_tx_adc_data[1]  <=8'h55;
//                eth_tx_adc_data[2]  <=8'h55;
//                eth_tx_adc_data[3]  <=8'h55;
//                eth_tx_adc_data[4]  <=8'h55;
//                eth_tx_adc_data[5]  <=8'h55;
//                eth_tx_adc_data[6]  <=8'h55;
//                eth_tx_adc_data[7]  <=8'hD5; 
                
//                eth_tx_adc_data[8]  <=8'hFF;                    //Dest MAC  
//                eth_tx_adc_data[9]  <=8'hFF;
//                eth_tx_adc_data[10] <=8'hFF;
//                eth_tx_adc_data[11] <=8'hFF;
//                eth_tx_adc_data[12] <=8'hFF;
//                eth_tx_adc_data[13] <=8'hFF;    
                
//                eth_tx_adc_data[14] <=eth_local_mac[47:40];     //Src MAC
//                eth_tx_adc_data[15] <=eth_local_mac[39:32];
//                eth_tx_adc_data[16] <=eth_local_mac[31:24];
//                eth_tx_adc_data[17] <=eth_local_mac[23:16];
//                eth_tx_adc_data[18] <=eth_local_mac[15:8];
//                eth_tx_adc_data[19] <=eth_local_mac[7:0];    
                
//                eth_tx_adc_data[20] <=8'h08;                    //TYPE 
//                eth_tx_adc_data[21] <=8'h00;
//                eth_tx_adc_data[22] <=8'h45;
//                eth_tx_adc_data[23] <=8'h00;
                
//                eth_tx_adc_data[24] <=skp_ip4_len[15-:8];       //IP4 len =  20 + 8 + DATA len
//                eth_tx_adc_data[25] <=skp_ip4_len[7:0];    
//                eth_tx_adc_data[26] <=skp_pkt_cnt[15:8];
//                eth_tx_adc_data[27] <=skp_pkt_cnt[7:0];
                
//                eth_tx_adc_data[28] <=8'h40;                    //Flags
//                eth_tx_adc_data[29] <=8'h00;
//                eth_tx_adc_data[30] <=8'h80;                    //TTL 40
//                eth_tx_adc_data[31] <=8'h11;                    //UDP
//                eth_tx_adc_data[32] <=8'h00;                    //CRC IPv4
//                eth_tx_adc_data[33] <=8'h00;
                
//                eth_tx_adc_data[34] <=eth_local_ip[31:24];      //My IP   
//                eth_tx_adc_data[35] <=eth_local_ip[23:16];
//                eth_tx_adc_data[36] <=eth_local_ip[15:8];
//                eth_tx_adc_data[37] <=eth_local_ip[7:0];
                
//                eth_tx_adc_data[38] <=8'd192;                   //Dst IP
//                eth_tx_adc_data[39] <=8'd168;
//                eth_tx_adc_data[40] <=8'd4;
//                eth_tx_adc_data[41] <=8'd1; //CVK

//                eth_tx_adc_data[42] <=8'h65;                    //SP 26100
//                eth_tx_adc_data[43] <=8'hF4;
                
//                eth_tx_adc_data[44] <=8'h65;                    //DP 26100
//                eth_tx_adc_data[45] <=8'hF4;
                
//                eth_tx_adc_data[46] <=skp_udp_len[15-:8];       //UDP len = 8 + DATA len
//                eth_tx_adc_data[47] <=skp_udp_len[7:0];
                
//                eth_tx_adc_data[48] <=8'h00;    //CRC
//                eth_tx_adc_data[49] <=8'h00;

//                eth_tx_pre<=4'd1;
//            end
            
//            4'd1: begin //Generate CRC for IPv4 
//                if(eth_adc_i==0) begin                                            
//                    eth_adc_crc <=  {eth_tx_adc_data[24],eth_tx_adc_data[25]} + {eth_tx_adc_data[22],eth_tx_adc_data[23]} +
//                                    {eth_tx_adc_data[28],eth_tx_adc_data[29]} + {eth_tx_adc_data[26],eth_tx_adc_data[27]} +
//                                    {eth_tx_adc_data[32],eth_tx_adc_data[33]} + {eth_tx_adc_data[30],eth_tx_adc_data[31]} +
//                                    {eth_tx_adc_data[36],eth_tx_adc_data[37]} + {eth_tx_adc_data[34],eth_tx_adc_data[35]} +
//                                    {eth_tx_adc_data[40],eth_tx_adc_data[41]} + {eth_tx_adc_data[38],eth_tx_adc_data[39]};
//                    eth_adc_i<=eth_adc_i+1'b1;
//                end
//                else if(eth_adc_i==1) begin
//                    eth_adc_crc[16:0]<=eth_adc_crc[31:16]+eth_adc_crc[15:0];
//                    eth_adc_i        <=eth_adc_i+1'b1;
//                end
//                else begin
//                    if(eth_adc_crc[16]) begin //overflow carry
//                        eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                        eth_tx_adc_data[33]<=~eth_adc_crc[7:0] - 1;
//                    end
//                    else begin
//                        eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                        eth_tx_adc_data[33]<=~eth_adc_crc[7:0];
//                    end   
//                    eth_adc_i<=0;
//                    eth_tx_pre<=4'd2;
//                end

////                case(eth_adc_i)
////                   0: begin
////                       eth_adc_crc <={eth_tx_adc_data[24],eth_tx_adc_data[25]} + {eth_tx_adc_data[22],eth_tx_adc_data[23]} +
////                                     {eth_tx_adc_data[28],eth_tx_adc_data[29]} + {eth_tx_adc_data[26],eth_tx_adc_data[27]} +
////                                     {eth_tx_adc_data[32],eth_tx_adc_data[33]} + {eth_tx_adc_data[30],eth_tx_adc_data[31]} +
////                                     {eth_tx_adc_data[36],eth_tx_adc_data[37]} + {eth_tx_adc_data[34],eth_tx_adc_data[35]} +
////                                     {eth_tx_adc_data[40],eth_tx_adc_data[41]} + {eth_tx_adc_data[38],eth_tx_adc_data[39]};
////                       eth_adc_i<=eth_adc_i+1'b1;
////                   end
                   
////                   1: begin
////                       eth_adc_crc[16:0]<=eth_adc_crc[31:16]+eth_adc_crc[15:0];
////                       eth_adc_i<=eth_adc_i+1'b1;
////                   end
                   
////                   2: begin
////                       case(eth_adc_crc[16])
////                           0: begin
////                               eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
////                               eth_tx_adc_data[33]<=~eth_adc_crc[7:0];
////                           end
                           
////                           1: begin //overflow carry
////                               eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
////                               eth_tx_adc_data[33]<=~eth_adc_crc[7:0] - 1;
////                           end
////                       endcase
////                       eth_adc_i  <=0;
////                       eth_tx_pre <=4'd2;
////                   end
////                endcase	
                
//            end
            
//            4'd2: begin //Send packet
//                eth_txen<=1;
//                //CRC
//                if(eth_tx_j<8) begin
//                    crcen<=0;       //Disable module FCS
//                    crcrst<=1;      //Reset value FCS 
//                end
//                else begin
//                    crcen<=1;       //Enable module FCS
//                    crcrst<=0; 
//                end
            
            
//                //****************************************************************
//                //End of Packet
//                //if(eth_tx_j==16'd1439) begin    
//                if(eth_tx_j == (16'd8 + 16'd14 + 16'd20 + 16'd8 + skp_len) - 1 ) begin  
//                    eth_txd         <=fifo_skp_dout;
//                    eth_tx_i        <=0;
//                    eth_tx_j        <=0;
//                    fifo_skp_rd_en  <=0;  
                    
//                    if(zero_cnt>0) 
//                        eth_tx_state<=tx_ZERO;
//                    else
//                        eth_tx_state<=tx_FCS;
//                end
            
//                //****************************************************************
//                //Start of Packet
//                else begin
//                    eth_tx_j<=eth_tx_j+1'b1;
//                    if(eth_tx_j<=16'd49) begin        
//                        eth_txd<=eth_tx_adc_data[eth_tx_j];
//                        if(eth_tx_j==16'd48) begin
//                            fifo_skp_rd_en<=1;
//                        end    
//                    end
//                    else if(eth_tx_j>16'd49) begin        
//                        eth_txd<=fifo_skp_dout;
//                    end
//                end
//            end
            
//            default: eth_tx_pre<=4'd0;
//            endcase

//            case(eth_tx_pre)
//                0: begin //Prepare packet
//                    event_eth_control_rs485_rd<=0;
//                    rs485_pkt_cnt<=rs485_pkt_cnt+1;
                    
//                    eth_tx_adc_data[0]  <=8'h55;                    //PREAMBULE  
//                    eth_tx_adc_data[1]  <=8'h55;
//                    eth_tx_adc_data[2]  <=8'h55;
//                    eth_tx_adc_data[3]  <=8'h55;
//                    eth_tx_adc_data[4]  <=8'h55;
//                    eth_tx_adc_data[5]  <=8'h55;
//                    eth_tx_adc_data[6]  <=8'h55;
//                    eth_tx_adc_data[7]  <=8'hD5; 
                    
////                    eth_tx_adc_data[8]  <=8'hFF;                    //Dest MAC  
////                    eth_tx_adc_data[9]  <=8'hFF;
////                    eth_tx_adc_data[10] <=8'hFF;
////                    eth_tx_adc_data[11] <=8'hFF;
////                    eth_tx_adc_data[12] <=8'hFF;
////                    eth_tx_adc_data[13] <=8'hFF;    

//                    eth_tx_adc_data[8]  <=eth_ARP_MAC_src[47:40];	//Dest MAC  
//					eth_tx_adc_data[9]  <=eth_ARP_MAC_src[39:32];
//					eth_tx_adc_data[10] <=eth_ARP_MAC_src[31:24];
//					eth_tx_adc_data[11] <=eth_ARP_MAC_src[23:16];
//					eth_tx_adc_data[12] <=eth_ARP_MAC_src[15:8];
//					eth_tx_adc_data[13] <=eth_ARP_MAC_src[7:0];
                    
//                    eth_tx_adc_data[14] <=eth_local_mac[47:40];     //Src MAC
//                    eth_tx_adc_data[15] <=eth_local_mac[39:32];
//                    eth_tx_adc_data[16] <=eth_local_mac[31:24];
//                    eth_tx_adc_data[17] <=eth_local_mac[23:16];
//                    eth_tx_adc_data[18] <=eth_local_mac[15:8];
//                    eth_tx_adc_data[19] <=eth_local_mac[7:0];    
                    
//                    eth_tx_adc_data[20] <=8'h08;                    //TYPE 
//                    eth_tx_adc_data[21] <=8'h00;
//                    eth_tx_adc_data[22] <=8'h45;
//                    eth_tx_adc_data[23] <=8'h00;
                    
//                    eth_tx_adc_data[24] <=rs485_ip4_len[15-:8];       //IP4 len =  20 + 8 + DATA len
//                    eth_tx_adc_data[25] <=rs485_ip4_len[7:0];    
//                    eth_tx_adc_data[26] <=rs485_pkt_cnt[15:8];
//                    eth_tx_adc_data[27] <=rs485_pkt_cnt[7:0];
                    
//                    eth_tx_adc_data[28] <=8'h40;                    //Flags
//                    eth_tx_adc_data[29] <=8'h00;
//                    eth_tx_adc_data[30] <=8'h80;                    //TTL 40
//                    eth_tx_adc_data[31] <=8'h11;                    //UDP
//                    eth_tx_adc_data[32] <=8'h00;                    //CRC IPv4
//                    eth_tx_adc_data[33] <=8'h00;
                    
//                    eth_tx_adc_data[34] <=eth_local_ip[31:24];      //My IP   
//                    eth_tx_adc_data[35] <=eth_local_ip[23:16];
//                    eth_tx_adc_data[36] <=eth_local_ip[15:8];
//                    eth_tx_adc_data[37] <=eth_local_ip[7:0];
                    
//                    eth_tx_adc_data[38] <=8'd192;                   //Dst IP
//                    eth_tx_adc_data[39] <=8'd168;
//                    eth_tx_adc_data[40] <=8'd4;
//                    eth_tx_adc_data[41] <=8'd1;//CVK
    
//                    eth_tx_adc_data[42] <=8'h65;                    //SP 26100
//                    eth_tx_adc_data[43] <=8'hF4;
                    
//                    eth_tx_adc_data[44] <=8'h65;                    //DP 26100
//                    eth_tx_adc_data[45] <=8'hF4;
                    
//                    eth_tx_adc_data[46] <=rs485_udp_len[15-:8];       //UDP len = 8 + DATA len
//                    eth_tx_adc_data[47] <=rs485_udp_len[7:0];
                    
//                    eth_tx_adc_data[48] <=8'h00;    //CRC
//                    eth_tx_adc_data[49] <=8'h00;
//                    eth_tx_pre<=4'd1;
//                end
                
//                1: begin //wait unlock skp data
//                    if(skp_lock) begin
//                        skp_timeout<=skp_timeout+1;
////                        if(skp_timeout>=16'd25) begin
                            
////                            eth_tx_adc_data[50] <= skp_data_prev[0];
////                            eth_tx_adc_data[51] <= skp_data_prev[1];
////                            eth_tx_adc_data[52] <= skp_data_prev[2];
////                            eth_tx_adc_data[53] <= skp_data_prev[3];
////                            eth_tx_adc_data[54] <= skp_data_prev[4];
////                            eth_tx_adc_data[55] <= skp_data_prev[5];
////                            eth_tx_adc_data[56] <= skp_data_prev[6];
////                            eth_tx_adc_data[57] <= skp_data_prev[7];
////                            eth_tx_adc_data[58] <= skp_data_prev[8];
////                            eth_tx_adc_data[59] <= skp_data_prev[9];
////                            eth_tx_adc_data[60] <= skp_data_prev[10];
////                            eth_tx_adc_data[61] <= skp_data_prev[11];
////                            eth_tx_adc_data[62] <= skp_data_prev[12];
////                            eth_tx_adc_data[63] <= skp_data_prev[13];
////                            eth_tx_adc_data[64] <= skp_data_prev[14];
////                            eth_tx_adc_data[65] <= skp_data_prev[15];
////                            eth_tx_adc_data[66] <= skp_data_prev[16];
////                            eth_tx_adc_data[67] <= skp_data_prev[17];
////                            eth_tx_adc_data[68] <= skp_data_prev[18];
////                            eth_tx_adc_data[69] <= skp_data_prev[19];
////                            eth_tx_adc_data[70] <= skp_data_prev[20];
////                            eth_tx_adc_data[71] <= skp_data_prev[21];
                        
////                            skp_timeout<=0;
////                            eth_tx_pre<=4'd2;
////                        end
//                    end
//                    else begin
//                        //SKP
//                        skp_data_prev[0]  <= skp_data[0];
//                        skp_data_prev[1]  <= skp_data[1];
//                        skp_data_prev[2]  <= skp_data[2];
//                        skp_data_prev[3]  <= skp_data[3];
//                        skp_data_prev[4]  <= skp_data[4];
//                        skp_data_prev[5]  <= skp_data[5];
//                        skp_data_prev[6]  <= skp_data[6];
//                        skp_data_prev[7]  <= skp_data[7];
//                        skp_data_prev[8]  <= skp_data[8];
//                        skp_data_prev[9]  <= skp_data[9];
//                        skp_data_prev[10] <= skp_data[10];
//                        skp_data_prev[11] <= skp_data[11];
//                        skp_data_prev[12] <= skp_data[12];
//                        skp_data_prev[13] <= skp_data[13];
//                        skp_data_prev[14] <= skp_data[14];
//                        skp_data_prev[15] <= skp_data[15];
//                        skp_data_prev[16] <= skp_data[16];
//                        skp_data_prev[17] <= skp_data[17];
//                        skp_data_prev[18] <= skp_data[18];
//                        skp_data_prev[19] <= skp_data[19];
//                        skp_data_prev[20] <= skp_data[20];
//                        skp_data_prev[21] <= skp_data[21];
                        
//                        eth_tx_adc_data[50] <= skp_data[0];
//                        eth_tx_adc_data[51] <= skp_data[1];
//                        eth_tx_adc_data[52] <= skp_data[2];
//                        eth_tx_adc_data[53] <= skp_data[3];
//                        eth_tx_adc_data[54] <= skp_data[4];
//                        eth_tx_adc_data[55] <= skp_data[5];
//                        eth_tx_adc_data[56] <= skp_data[6];
//                        eth_tx_adc_data[57] <= skp_data[7];
//                        eth_tx_adc_data[58] <= skp_data[8];
//                        eth_tx_adc_data[59] <= skp_data[9];
//                        eth_tx_adc_data[60] <= skp_data[10];
//                        eth_tx_adc_data[61] <= skp_data[11];
//                        eth_tx_adc_data[62] <= skp_data[12];
//                        eth_tx_adc_data[63] <= skp_data[13];
//                        eth_tx_adc_data[64] <= skp_data[14];
//                        eth_tx_adc_data[65] <= skp_data[15];
//                        eth_tx_adc_data[66] <= skp_data[16];
//                        eth_tx_adc_data[67] <= skp_data[17];
//                        eth_tx_adc_data[68] <= skp_data[18];
//                        eth_tx_adc_data[69] <= skp_data[19];
//                        eth_tx_adc_data[70] <= skp_data[20];
//                        eth_tx_adc_data[71] <= skp_data[21];
                    
//                        skp_timeout<=0;
//                        eth_tx_pre<=4'd2;
//                    end
//                end

//                2: begin //Generate CRC for IPv4
//                    if(eth_adc_i==0) begin                                            
//                        eth_adc_crc <=  {eth_tx_adc_data[24],eth_tx_adc_data[25]} + {eth_tx_adc_data[22],eth_tx_adc_data[23]} +
//                                        {eth_tx_adc_data[28],eth_tx_adc_data[29]} + {eth_tx_adc_data[26],eth_tx_adc_data[27]} +
//                                        {eth_tx_adc_data[32],eth_tx_adc_data[33]} + {eth_tx_adc_data[30],eth_tx_adc_data[31]} +
//                                        {eth_tx_adc_data[36],eth_tx_adc_data[37]} + {eth_tx_adc_data[34],eth_tx_adc_data[35]} +
//                                        {eth_tx_adc_data[40],eth_tx_adc_data[41]} + {eth_tx_adc_data[38],eth_tx_adc_data[39]};
//                        eth_adc_i<=eth_adc_i+1'b1;
//                    end
//                    else if(eth_adc_i==1) begin
//                        eth_adc_crc[16:0]<=eth_adc_crc[31:16]+eth_adc_crc[15:0];
//                        eth_adc_i        <=eth_adc_i+1'b1;
//                    end
//                    else begin
//                        if(eth_adc_crc[16]) begin //overflow carry
//                            eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                            eth_tx_adc_data[33]<=~eth_adc_crc[7:0] - 1;
//                        end
//                        else begin
//                            eth_tx_adc_data[32]<=~eth_adc_crc[15:8];
//                            eth_tx_adc_data[33]<=~eth_adc_crc[7:0];
//                        end   
//                        eth_adc_i<=0;
//                        eth_tx_pre<=4'd3;
//                    end
//                end
                
//                3: begin
//                    eth_txen<=1;
//                    //CRC
//                    if(eth_tx_j<8) begin
//                        crcen<=0;       //Disable module FCS
//                        crcrst<=1;      //Reset value FCS 
//                    end
//                    else begin
//                        crcen<=1;       //Enable module FCS
//                        crcrst<=0; 
//                    end
                
                
//                    //****************************************************************
//                    //End of Packet
//                    //if(eth_tx_j==16'd1439) begin    
//                    if(eth_tx_j == (16'd8 + 16'd14 + 16'd20 + 16'd8 + rs485_len) - 1 ) begin  
//                        eth_txd         <=dfs_rx_dout;
//                        eth_tx_i        <=0;
//                        eth_tx_j        <=0;
//                        dfs_rx_rd_en    <=0;  
                        
//                        if(zero_cnt>0) 
//                            eth_tx_state<=tx_ZERO;
//                        else
//                            eth_tx_state<=tx_FCS;
//                    end
                
//                    //****************************************************************
//                    //Start of Packet
//                    else begin
//                        eth_tx_j<=eth_tx_j+1'b1;
//                        //if(eth_tx_j<=16'd49) begin 
//                        if(eth_tx_j<=16'd71) begin        
//                            eth_txd<=eth_tx_adc_data[eth_tx_j];
//                            //if(eth_tx_j==16'd48) begin
//                            if(eth_tx_j==16'd70) begin
//                                dfs_rx_rd_en<=1;
//                            end    
//                        end
//                        //else if(eth_tx_j>16'd49) begin  
//                        else if(eth_tx_j>16'd71) begin       
//                            eth_txd<=dfs_rx_dout;
//                        end
//                    end
//                end
                
//                default: eth_tx_pre<=4'd0;
//            endcase
