//`timescale 1ns / 1ps
`timescale 1ns / 100ps
`define EOF -1
`define NULL 0


`include "uart_tx_dfs.sv"

module dfs_tb;


//***********************************************************************
// duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns for 50Mhz
//localparam period_200Mhz = 2.5; //ns 


//reg         clk_10M;
//reg         clk_20M;
reg         clk_50M;
//reg         clk_200M;
reg         rst_n=0;
integer     samples;

initial begin

    //clk_10M     = 0;
    //clk_20M     = 0;
    clk_50M     = 0;
    //clk_200M    = 0;
    
    rst_n       = 0;
    samples     = 1000000;
    //TxInt       = 0;

    // Deactivate reset signal.
    #20  rst_n = 1;
    #20  rst_n = 0;
    #20  rst_n = 1;
end


// always begin
//     Tick clock every 2.5ns (1 cycle = 5ns = 200MHz).
//     #2.5 clk_200M = ~clk_200M;
// end
// 
// always begin
//     #25 clk_20M = ~clk_20M;
// end

// always begin
//     #50 clk_10M = ~clk_10M;
// end

always begin
    #10 clk_50M = ~clk_50M; 
end



reg [7:0]   tx_byte=0;
reg         tx_en=0;
wire        tx_busy;
wire        tx_ready;
wire        serial_tx_out;

reg [7:0] tx_packet1 [50:0]; 
reg [7:0] tx_packet2 [50:0]; 
reg [7:0] tx_packet3 [50:0]; 
//reg [7:0] tx_packet4 [49:0]; 
//reg [7:0] tx_packet5 [49:0]; 

initial begin
    tx_packet1[0]  <=8'hC1;
    tx_packet1[1]  <=8'hC1;
    tx_packet1[2]  <=8'hA1;
    tx_packet1[3]  <=8'hB2;
    tx_packet1[4]  <=8'h01;
    tx_packet1[5]  <=8'h02;
    tx_packet1[6]  <=8'h03;
    tx_packet1[7]  <=8'h04;
    tx_packet1[8]  <=8'h05;
    tx_packet1[9]  <=8'h06;
    tx_packet1[10] <=8'hC1;
    tx_packet1[11] <=8'h07;
    tx_packet1[12] <=8'h08;
    tx_packet1[13] <=8'h09;
    tx_packet1[14] <=8'h10;
    tx_packet1[15] <=8'h11;
    tx_packet1[16] <=8'h12;
    tx_packet1[17] <=8'h13;
    tx_packet1[18] <=8'h14;
    tx_packet1[19] <=8'h15;
    tx_packet1[20] <=8'h16;
    tx_packet1[21] <=8'h17;
    tx_packet1[22] <=8'h18;
    tx_packet1[23] <=8'h19;
    tx_packet1[24] <=8'h20;
    tx_packet1[25] <=8'h00;
    tx_packet1[26] <=8'h00;
    tx_packet1[27] <=8'h00;
    tx_packet1[28] <=8'h00;
    tx_packet1[29] <=8'h00;
    tx_packet1[30] <=8'h00;
    tx_packet1[31] <=8'h00;
    tx_packet1[32] <=8'h00;
    tx_packet1[33] <=8'h00;
    tx_packet1[34] <=8'h00;
    tx_packet1[35] <=8'h00;
    tx_packet1[36] <=8'h00;
    tx_packet1[37] <=8'h00;
    tx_packet1[38] <=8'h00;
    tx_packet1[39] <=8'h00;
    tx_packet1[40] <=8'h00;
    tx_packet1[41] <=8'h00;
    tx_packet1[42] <=8'h00;
    tx_packet1[43] <=8'h00;
    tx_packet1[44] <=8'h00;
    tx_packet1[45] <=8'h00;
    tx_packet1[46] <=8'h00;
    tx_packet1[47] <=8'h00;
    tx_packet1[48] <=8'hE1;
    tx_packet1[49] <=8'hF2;
    tx_packet1[50] <=8'h00;
    
    
    tx_packet2[0]  <=8'hC1;
    tx_packet2[1]  <=8'hC1;
    tx_packet2[2]  <=8'hA2;
    tx_packet2[3]  <=8'hB3;
    tx_packet2[4]  <=8'h00;
    tx_packet2[5]  <=8'h00;
    tx_packet2[6]  <=8'h00;
    tx_packet2[7]  <=8'h00;
    tx_packet2[8]  <=8'h00;
    tx_packet2[9]  <=8'h00;
    tx_packet2[10] <=8'h00;
    tx_packet2[11] <=8'h00;
    tx_packet2[12] <=8'h00;
    tx_packet2[13] <=8'h00;
    tx_packet2[14] <=8'h00;
    tx_packet2[15] <=8'h00;
    tx_packet2[16] <=8'h00;
    tx_packet2[17] <=8'h00;
    tx_packet2[18] <=8'h00;
    tx_packet2[19] <=8'h00;
    tx_packet2[20] <=8'h00;
    tx_packet2[21] <=8'h00;
    tx_packet2[22] <=8'h00;
    tx_packet2[23] <=8'h00;
    tx_packet2[24] <=8'h00;
    tx_packet2[25] <=8'h00;
    tx_packet2[26] <=8'h00;
    tx_packet2[27] <=8'h00;
    tx_packet2[28] <=8'h00;
    tx_packet2[29] <=8'h00;
    tx_packet2[30] <=8'h00;
    tx_packet2[31] <=8'h00;
    tx_packet2[32] <=8'h00;
    tx_packet2[33] <=8'h00;
    tx_packet2[34] <=8'h00;
    tx_packet2[35] <=8'h00;
    tx_packet2[36] <=8'h00;
    tx_packet2[37] <=8'h00;
    tx_packet2[38] <=8'h00;
    tx_packet2[39] <=8'h00;
    tx_packet2[40] <=8'h00;
    tx_packet2[41] <=8'h00;
    tx_packet2[42] <=8'h00;
    tx_packet2[43] <=8'h00;
    tx_packet2[44] <=8'h00;
    tx_packet2[45] <=8'h00;
    tx_packet2[46] <=8'h00;
    tx_packet2[47] <=8'h00;
    tx_packet2[48] <=8'hE2;
    tx_packet2[49] <=8'hF3;
    tx_packet2[50] <=8'h00;
    
    
    tx_packet3[0]  <=8'hC1;
    tx_packet3[1]  <=8'hC1;
    tx_packet3[2]  <=8'hA3;
    tx_packet3[3]  <=8'hB4;
    tx_packet3[4]  <=8'h00;
    tx_packet3[5]  <=8'h00;
    tx_packet3[6]  <=8'h00;
    tx_packet3[7]  <=8'h00;
    tx_packet3[8]  <=8'h00;
    tx_packet3[9]  <=8'h00;
    tx_packet3[10] <=8'h00;
    tx_packet3[11] <=8'h00;
    tx_packet3[12] <=8'hC1;
    tx_packet3[13] <=8'h00;
    tx_packet3[14] <=8'h00;
    tx_packet3[15] <=8'h00;
    tx_packet3[16] <=8'h00;
    tx_packet3[17] <=8'h00;
    tx_packet3[18] <=8'h00;
    tx_packet3[19] <=8'h00;
    tx_packet3[20] <=8'h00;
    tx_packet3[21] <=8'h00;
    tx_packet3[22] <=8'h00;
    tx_packet3[23] <=8'h00;
    tx_packet3[24] <=8'h00;
    tx_packet3[25] <=8'h00;
    tx_packet3[26] <=8'h00;
    tx_packet3[27] <=8'h00;
    tx_packet3[28] <=8'h00;
    tx_packet3[29] <=8'h00;
    tx_packet3[30] <=8'h00;
    tx_packet3[31] <=8'h00;
    tx_packet3[32] <=8'h00;
    tx_packet3[33] <=8'h00;
    tx_packet3[34] <=8'h00;
    tx_packet3[35] <=8'h00;
    tx_packet3[36] <=8'h00;
    tx_packet3[37] <=8'h00;
    tx_packet3[38] <=8'h00;
    tx_packet3[39] <=8'h00;
    tx_packet3[40] <=8'h00;
    tx_packet3[41] <=8'h00;
    tx_packet3[42] <=8'h00;
    tx_packet3[43] <=8'h00;
    tx_packet3[44] <=8'h00;
    tx_packet3[45] <=8'h00;
    tx_packet3[46] <=8'h00;
    tx_packet3[47] <=8'h00;
    tx_packet3[48] <=8'hE3;
    tx_packet3[49] <=8'hF4;
    tx_packet3[50] <=8'h00;
end


wire tx_done;

uart_tx_dfs uart_tx_dfs
(
    .i_Clock        (clk_50M),
    .i_TX_DV        (tx_en),
    .i_TX_Byte      (tx_byte), 
    .o_TX_Active    (tx_busy),   //busy - active high 1
    .o_TX_Serial    (serial_out),
    .o_TX_Done      (tx_done)
);

//TX
/*
uart_tx_bins uart_tx_inst
(
	.clockIN		(clk_50M),
	.nTxResetIN		(1'b1),
	.txDataIN		(tx_byte),
	.txLoadIN		(tx_en),
	.txIdleOUT		(tx_busy), //active tx -> tx_busy -> low; idle -> high
	.txReadyOUT		(tx_ready),
	.txOUT			(serial_tx_out)
);*/

/*
wire serial_rx_in = serial_tx_out;
wire rx_busy;
wire rx_done;
wire [7:0] rx_byte;*/

//RX

/*
uart_rx_bins uart_rx_inst
(
	.clockIN		(clk_50M),
	.nRxResetIN		(1'b1),
	.rxIN			(serial_rx_in), 
	.rxIdleOUT		(rx_busy),
	.rxReadyOUT		(rx_done),
	.rxDataOUT		(rx_byte)
);*/

/*
wire serial_rdy;
UART_RX uart_rx_inst
(
    .i_Clock        (clk_50M),
    .i_RX_Serial    (serial_rx_in),
    .o_RX_DV        (serial_rdy),
    .o_RX_Byte      (rx_byte)
);*/


reg [3:0]  send_st=0;
// reg [31:0] timer_10ms=0;
// reg [31:0] timer_100ms=0;
// reg [31:0] timer_1s=0;
// reg [7:0]  send_cnt=8'd0;

reg [7:0]  i=0;
reg [3:0]  packet_st=0;

/*test send to uart*/

/*
always@(posedge clk_50M) begin
    
    case(send_st)
        0: begin
            tx_en   <=1'b1;
            case(packet_st)
                0: tx_byte <=tx_packet1[i];
                1: tx_byte <=tx_packet2[i];
                2: tx_byte <=tx_packet3[i];
                default: packet_st <=0;
            endcase
            send_st <=send_st+1;
        end
        
        1: begin
            tx_en<=1'b0;
            i<=i+1;
            send_st<=send_st+1;
        end
        
        2: begin
            if(tx_done) begin
                send_st<=0;
                if(i==51) begin
                    i=0;
                    packet_st<=packet_st+1;
                    if(packet_st==2)
                        packet_st<=0;
                end
            end
        end

    endcase
end*/

reg [3:0]  fifo_tx_state=0;
wire [9:0] fifo_tx_rd_data_count=42;
reg        fifo_tx_rd_en=0;

always@(posedge clk_50M) begin 
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
            tx_byte      <=tx_packet1[i];//fifo_tx_dout;
            fifo_tx_rd_en<=0;
            fifo_tx_state<=3;
        end
        
        3: begin
            tx_en<=0;
            if(tx_busy) begin
                //fifo_tx_state<=0;
                fifo_tx_state<=4;
                i<=i+1;
            end
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
                tx_byte      <=tx_packet1[i];//fifo_tx_dout;
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
        


        
        
//************************************************************************************************//
//sync & write to fifo
/*reg [3:0] write_st=0;
reg [7:0] write_cnt=0;
reg [1:0] rdy_st=0;
//reg serial_rdy=0;
reg [7:0] sync=0;

wire        fifo_rx_wr_clk;
reg  [7:0]  fifo_rx_din=0;
wire        fifo_rx_full;
wire        fifo_rx_empty;
wire [9:0]  fifo_rx_wr_data_count;
reg         fifo_rx_wr_en=0;
reg [3:0]  	fifo_tx_state;

reg [3:0]   sync_st=0;

assign fifo_rx_wr_clk   = clk_50M;*/

//READ from UART & WRITE to FIFO
always@(posedge clk_50M) begin

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
                        
                        default: sync_st<=0;
                    endcase
                    
                    
                end
			endcase	
		end
		
		1: begin
            sync_st<=0;
			fifo_rx_din <=8'hC1;//rx_byte;         
			write_cnt   <=write_cnt+1'b1;
			write_st    <=write_st+1'b1;
		end
		
		2: begin
			case(serial_rdy)
                0: begin
                    fifo_rx_wr_en<=0;
                    //fifo_rx_din  <=0; 
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
	endcase*/
	//************************************************************************************//
	
end


//open file and read
/*initial begin
	@(posedge clk); 
	rst<=1'b0;
	fd=$fopen("fm_signal.bin","r");
	while(! $feof(fd)) begin
		//code = $fgets ( str, fd );
		//code = $sscanf(str, "%h", A);
		//$display ("Line: %s", str);
		
		A = $fgetc(fd);
 		@(posedge clk);
	end
	$fclose(fd);
	$finish;
end	*/

initial begin
	@(posedge clk_50M); 
	//fd=$fopen("cic_out_signal.bin","a+");
	while(samples>0) begin
		@(posedge clk_50M);
// 		$fwrite(fd,"%c%c",cic_d_out_real[7:0], cic_d_out_real[15:8]);
// 		$fwrite(fd,"%c%c",SINout2[7:0], SINout2[15:8]);
// 		$fwrite(fd,"%c",sinewave);
		samples<=samples-1'b1;
	end
// 	$fclose(fd);
	$finish;
end		


//создаем файл VCD для последующего анализа сигналов
initial begin
 	$dumpfile("dfs.vcd");
  	$dumpvars(0,dfs_tb);
end
	
// Monitor the output
//initial
//$monitor($time, , COSout, , SINout, , angle, , A);
	
endmodule







// wire signed  [17:0]  nco_out1;
// wire signed  [17:0]  nco_out2;

//reg signed  [17:0]  Nco1=0;

//reg signed [63:0] i;
// reg [29:0] PD_out;

// reg [7:0] A; //register declaration for storing each line of file.
// integer   fd; //file descriptors
// reg [8*10:1] str;  
// integer code;
// integer char;


// localparam An = 32000/1.647;
// localparam width = 32; //width of x and y
// 
// reg [width-1:0] Xin=0, Yin=0;
// reg [31:0] angle_rf=32'h3FDCB3DB;//90 deg
// reg [31:0] angle_1200=0;
// reg [31:0] angle_2400=0;

// wire signed [width-1:0] rf_cos,  rf_sin;
// wire signed [width-1:0] dds_cos, dds_sin;

// wire [27:0] phdet;
// wire [27:0] phdet2;
// wire signed [44:0] fir_out;

// wire [13:0] signal;
// wire [13:0] nco;

// wire rf_en;
// wire dds_en;
// 
// reg [13:0] signal;
// reg [13:0] nco;

// reg [0:15] sin_table [0:1023];
// initial $readmemh("sin.rom", sin_table);

// initial begin
//     Xin <= An;     // Xout = 32000*cos(angle)
//     Yin <= 0;      // Yout = 32000*sin(angle)
//     
//     signal<=0;
//     nco<=0;
// end

// wire        lf_out_en;
// wire [29:0] lf_out;
// 
// wire [13:0] s1;
// wire [13:0] s2;
// 
// wire [15:0] s3;
// wire [15:0] s4;
// 
// wire [31:0] s5_mult;
// 
// 
// wire s3_lsb;
// wire s4_lsb;
// wire s34xor;
// 
// wire [15:0] s5;
// wire [15:0] s6;
// 
// wire [27:0] s7xor;
// wire [27:0] phdiv2;

// let's create a 16 bits free-running binary counter
//reg [15:0] cnt1=0;
//reg [15:0] cnt2=0;
//always @(posedge clk_50M) cnt1 <= cnt1 + 16'h1;
//always @(posedge clk_50M) cnt2 <= cnt2 + 16'h1;

// and use it to generate the DAC signal output
//wire cnt_tap1 = cnt1[7:6] ;     // we take one bit out of the counter (here bit 7 = the 8th bit)
//wire cnt_tap2 = cnt2[5];     // we take one bit out of the counter (here bit 7 = the 8th bit)

// assign s1 = {14{rf_sin[31]}}; 
// assign s2 = {14{dds_sin[31]}}; 
// 
// assign s3      = sin_table[angle_rf[31:22]]; 
// assign s4      = sin_table[angle_1200[31:22]]; 
// assign s5_mult = s3 + s4;



// 
// assign s5 = {16{s3[15]}}; 
// assign s6 = {16{s4[15]}}; 
// 
// assign s7xor  = s3 ^ s4;
// assign phdiv2 = phdet / 2;


// assign s3_lsb = s3[15];
// assign s4_lsb = s4[15];
// assign s34xor = s3_lsb ^ s4_lsb;



// assign  signal = rf_sin  [15-:14] + 14'd8191;
// assign  nco    = dds_sin [15-:14] + 14'd8191;

// assign  signal = rf_cos  [16-:14];
// assign  nco    = dds_cos [16-:14];







//***********************************************************************
// reg TxInt=0;
// wire TxDone;
// wire [31:0] TxData [0:15];
// wire [7:0]  TxOut;
// wire        dbit;
// wire        bit_clk;
// wire [10:0] bit_ind;
// 
// reg  [31:0]  CtlTxData [0:15];
// reg  [2:0]   ModOutDiv=3'd1;
// 
// 
// 
// initial begin
//     CtlTxData[0]  <= 32'h1ACFFC1D;
//     CtlTxData[1]  <= 32'h01010101;
//     CtlTxData[2]  <= 32'h02020202;
//     CtlTxData[3]  <= 32'h03030303;
//     CtlTxData[4]  <= 32'hAA00B1D2;
//     CtlTxData[5]  <= 32'd0;
//     CtlTxData[6]  <= 32'd0;
//     CtlTxData[7]  <= 32'd0;
//     CtlTxData[8]  <= 32'd0;
//     CtlTxData[9]  <= 32'd0;
//     CtlTxData[10] <= 32'd0;
//     CtlTxData[11] <= 32'd0;
//     CtlTxData[12] <= 32'd0;
//     CtlTxData[13] <= 32'd0;
//     CtlTxData[14] <= 32'd0;
//     CtlTxData[15] <= 32'hFFFFFFAB;
// end
// 
// 
// assign TxData = CtlTxData;
// 
// 
// BpskMod modulator(
//     
//     .Reset_n(rst_n),
//     .Clk(clk_50M),
//     .OutDiv(ModOutDiv),
//     
//     .Data(TxData),
//     .Int(TxInt),
//     .Done(TxDone),
//     .Bit(dbit),
//     .Bit_clk(bit_clk),
//     .Bit_ind(bit_ind),
//     
//     .Out(TxOut)
// );



//*************************************************************
// reg [3:0]  avg_st=0;
// reg [0:27] avg_r [0:15];
// 
// reg [27:0] summ=0;
// reg summ_valid=0;
// 
// reg [31:0] cnt3=0;
// reg [31:0] ph=32'd85899346;


//wire tx_xor;

//assign tx_xor = TxOut[6] ^ TxOut[5] ^ TxOut[4] ^ TxOut[3] ^ TxOut[2] ^ TxOut[1] ^ TxOut[0];
//assign tx_xor = TxOut[6] ^ TxOut[5] ^ TxOut[4];

// initial begin
//     avg_r[0] <= 0;
//     avg_r[1] <= 0;
//     avg_r[2] <= 0;
//     avg_r[3] <= 0;
//     avg_r[4] <= 0;
//     avg_r[5] <= 0;
// end


// reg         i_ld=0;
// reg  [30:0] i_step=0;
// reg         i_ce=0;
// reg   [4:0] i_lgcoeff=5;
// wire [31:0] o_phase;
// wire  [1:0] o_err;
// 
// initial begin
//     i_step  = 31'd85899346; // 1Mhz
//     i_step  = 31'd71582788; //833333,333333333 Hz
//     i_step  = 31'd17895697; //250k
//     
//     #10 i_ld = 1;
//     #10 i_ld = 0;
//     #50 i_ce = 1;
// end

// sdpll   sdpll_1(clk_50M, i_ld, i_step, i_ce, s3_lsb, i_lgcoeff, o_phase, o_err);
// sdpll   sdpll_1(clk_50M, i_ld, i_step, i_ce, s5_mult[16], i_lgcoeff, o_phase, o_err);
// 
// 
// wire [15:0] nco_pll;
// assign nco_pll = sin_table[o_phase[31:22]]; 



// reg   [31:0] ph0=0;
// reg   [31:0] ph1=0;
// reg   [31:0] ph2=0;
// reg   [31:0] ph_sub=0;
// reg   [31:0] freq=0; 

//     angle_rf   <= angle_rf   + 32'd429505320; //5.000100 Mhz
//     angle_rf   <= angle_rf   + 32'd429496730; //5 Mhz
//     
//     
//     angle_dds  <= angle_dds  + 32'd429496730; //5 Mhz
//     
//     angle_1200  <= angle_1200  + 32'd103079; //1200 Hz
//     
//     angle_1200  <= angle_1200  + 32'd1288490; //15000 Hz
//     angle_2400  <= angle_2400  + 32'd206158; //2400 Hz
//     
//     angle_rf   <= angle_rf   + 32'd85907936; //1.000100 Mhz
//     angle_rf   <= angle_rf   + 32'd85899346; //1 Mhz
//     angle_dds  <= angle_dds  + 32'd85899346 + lf_out; //1 Mhz
//     angle_dds  <= angle_dds  + 32'd85899346; //1 Mhz
//     
//     
//     
//     if(TxDone)
//         TxInt<=0;
//     
//     
//     angle_rf   <= angle_rf   + ph; //1 Mhz
//     
//     if(cnt3<=20000) begin
//         cnt3<=cnt3+1; 
//     end
// 
//         angle_rf   <= angle_rf   + 32'd85985245; //1.001000 Mhz
// 
//     case(cnt3)
//         3000: begin angle_rf<=0; ph<=32'd85985245 ; end
//         6000: begin angle_rf<=0; ph<=32'd85899346 ; end
//         9000: begin angle_rf<=0; ph<=0            ; end
//         9100: begin angle_rf<=0; ph<=32'd86328843 ; end
//     endcase
//     
//     
//     **************************************************************
//     ph0 <= o_phase;
//     ph1 <= ph0;
//     ph2 <= ph1;
//     
//     if( (ph0 > ph1) && (ph1 > ph2) ) begin
//         ph_sub  <= ph0 - ph1;
//     end
//     else if( (ph0 < ph1) && (ph1 < ph2) ) begin
//         ph_sub  <= ph1 - ph0;
//     end
//     
//     freq <= (50000000 * ph_sub) / 4294967296;
//     **************************************************************
//     
//     
//     
//     angle_dds  <= angle_dds  + 32'd85899346; //1 Mhz

// always @(posedge clk_200) begin
//     PD_out<={fir_Iout[29] ^ fir_Qout[29],fir_Qout[28:0]};
// end

// cordic          signal_rf  (clk_50M, rf_cos,  rf_sin,  Xin, Yin, angle_rf, rf_en);  
// cordic          dds        (clk_50M, dds_cos, dds_sin, Xin, Yin, angle_dds, dds_en);

//MultPhaseDet    pdet       (clk_50M, s3[15-:14],  s4[15-:14],     phdet);
//loopfilter      lf1        (clk_50M, !rst_n, rf_en, fir_out[32-:18], lf_out_en, lf_out  );
//loopfilter      lf1        (clk_50M, !rst_n, summ_valid, summ[27-:18], lf_out_en, lf_out  );
//MultPhaseDet    pdet2      (clk_50M, s5[15-:14],  s6[15-:14],     phdet2);







// 0	0.0223	0.0222975707	   6381
// 1	0.0343	0.034297235	       9815
// 2	0.0469	0.0468979308	  13421
// 3	0.0693	0.0692968383	  19831
// 4	0.0832	0.0831974395	  23809
// 5	0.1014	0.1013996094	  29018
// 6	0.1077	0.1076999573	  30821
// 7	0.1145	0.1145	          32767
// 8	0.1077	0.1076999573	  30821
// 9	0.1014	0.1013996094	  29018
// 10	0.0832	0.0831974395	  23809
// 11	0.0693	0.0692968383	  19831
// 12	0.0469	0.0468979308	  13421
// 13	0.0343	0.034297235	       9815

// 	fir #( .TAPS(14) ) fir_lp_inst(
//   									.clk( clk_50M && rf_en && dds_en ),
// 								  	.coefs( {
// 										16'd6381,
// 										16'd9815,
// 										16'd13421,
// 										16'd19831,
// 										16'd23809,
// 										16'd29018,
// 										16'd30821,
// 										16'd32767,
// 										16'd30821,
// 										16'd29018,
// 										16'd23809,
// 										16'd19831,
// 										16'd13421,
// 										16'd9815
// 										} ),
// 								  	.in(s7xor[27-:16]),
// 								  	.in(rf_sin[15:0]),
// 									.out(fir_out)
// 	);





//     case(lf_out_en)
//         
//         0: begin
//             angle_dds  <= angle_dds  + 32'd85899346; //1 Mhz
//         end
//         
//         1: begin
//             angle_dds  <= angle_dds  + 32'd85899346 + lf_out; //1 Mhz
//         end
//         
//     endcase
    

    
    
//     signal <= rf_cos  [15-:14];
//     nco    <= dds_cos [15-:14];
//     
//     
//     avg_r[0]<= fir_out[32-:27];
//     avg_r[0]<= s7xor;
//     avg_r[1]<= avg_r[0];
//     avg_r[2]<= avg_r[1];
//     avg_r[3]<= avg_r[2];
//     avg_r[4]<= avg_r[3];
//     avg_r[5]<= avg_r[4];
//     
//     if(avg_st<5) begin
//         avg_st<=avg_st+1;
//         summ_valid<=0;
//     end
//     else begin
//         summ        <=avg_r[0] + avg_r[1] + avg_r[2] + avg_r[3] + avg_r[4] + avg_r[5];
//         summ_valid  <=1;
//         avg_st      <=0;
//     end



// nco signal1
// (
//     .clk        (clk_20M),
//     .rst_n      (rst_n),
//     .NcoPhase   (9'd95),
//     .NcoOut     (nco_out1) // Q7.10
// );

// nco nco2
// (
//     .clk        (clk_200M),
//     .rst_n      (rst_n),
//     .NcoPhase   (9'd128), //shift to 90 degree
//     .NcoOut     (nco_out2)
// );
