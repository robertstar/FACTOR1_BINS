`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2019 08:24:09
// Design Name: 
// Module Name: ad9850
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


module ad9850
( 
    input 				clk, 
    input 				rst,
    input    			load,
    input 	wire [31:0] freq,
    output 				sclk, 
    output 	reg 		update, 
    output 	reg 		sdata,
    output 	reg 		reset				
);

reg en;	
reg sclk_t;	
reg clkw;
reg [31:0] sclk_cnt;
reg [3:0]  alg_dds;
reg [31:0] delay_cnt;
reg [7:0]  bit_no;
reg [31:0] rst_cnt;

reg [39:0] 	dds_word;
reg [31:0] 	dds_freq;
reg [31:0] 	alg_st_cnt;
reg [3:0]  	alg_st;
reg			load_1;

initial begin
    clkw       <=0;
	alg_dds	   <=0;
	sclk_cnt   <=0;
	sclk_t	   <=0;
	update	   <=0;
	en		   <=0;
	delay_cnt  <=0;
	reset      <=0;
	rst_cnt	   <=0;
	bit_no 	   <=0;
	alg_st	   <=0;
	load_1	   <=0;
	alg_st_cnt <=0;
	dds_freq   <=32'h00008638;
	
//	freq	   <={16'h0000,16'h8638}; //1kHz
//	dds_word   <={8'h00,16'h0000,16'h8638};
	dds_word   <={8'h00,dds_freq};
end


//assign sclk = (en)?sclk_t:0;
assign sclk = clkw;


reg [3:0] alg_rst=0;
reg dds_ser_init=0;	
reg i=0;

//create clock
always@(posedge clk) begin 	    //125Mhz
	if(sclk_cnt < 125) begin 	
		sclk_cnt<=sclk_cnt+1;
	end
	else begin
		sclk_cnt<=0;
		sclk_t<=~sclk_t;
	end

	case(alg_st)
		0: begin
			if(load) begin
				alg_st   <=alg_st+1;
				load_1   <=1;
				dds_word <={8'h00,freq};
			end
		end
		
		1: begin
            if(alg_dds==1) begin
				load_1<=0;
				alg_st<=alg_st+1;
			end
		end
		
		2: begin
			alg_st<=0;
		end
		
		default: alg_st<=0;
		
	endcase
end


//ila_1 ila_dbg
//(
//    .clk        (clk),
//    .probe0     (load),     //1
//    .probe1     (sclk_t),   //1
//    .probe2     (clkw),     //1
//    .probe3     (reset),    //1
//    .probe4     (update),   //1
//    .probe5     (sdata),    //1
//    .probe6     (alg_dds)   //4
//);	
	
always@(posedge sclk_t) begin

    case(alg_dds)

        //WAIT
        0: begin
            if(load_1) begin
                alg_dds <=1;
                reset   <=0;
                update  <=0;
                clkw    <=0;
            end
        end
        
        //Reset
        1: begin
            reset   <=1;
            if(delay_cnt<=10) begin
                delay_cnt<=delay_cnt+1;
            end
            else begin
                alg_dds <=2;
                delay_cnt<=0;
            end
        end
        
        2: begin
            reset   <=0;
            alg_dds <=3;
        end
        
        3: begin
            clkw <=1;
            alg_dds <=4;
        end
        
        4: begin
            clkw <=0;
            alg_dds <=5;
        end
        
        5: begin
            update  <=1;
            if(delay_cnt<=10) begin
                delay_cnt<=delay_cnt+1;
            end
            else begin
                alg_dds <=6;
                delay_cnt<=0;
            end
        end
        
        6: begin
            update  <=0;
            alg_dds <=7;
        end
        
        7: begin
            sdata   <=dds_word[bit_no];
            alg_dds <=8;
        end
        
        8: begin
            clkw    <=1;
            alg_dds <=9;
        end
        
        9: begin
            clkw <=0;
            if(bit_no<39) begin
                alg_dds <=7;
                bit_no  <=bit_no+1;
            end
            else begin
                alg_dds <=10;
                bit_no  <=0;
            end
        end
        
        10: begin
            //en	<=0;
            update  <=1;
            if(delay_cnt<=10) begin
                delay_cnt<=delay_cnt+1;
            end
            else begin
                alg_dds   <=11;
                delay_cnt <=0;
            end
        end

        11: begin
            //END INIT DDS
            update  <=0;
            alg_dds <=0;
        end
    
        //default: alg_dds<=0;
    endcase

end

endmodule





        
//        3: begin
//            update   <=1;
//            if(delay_cnt<=10) begin
//                delay_cnt<=delay_cnt+1;
//            end
//            else begin
//                alg_dds <=4;
//                delay_cnt<=0;
//            end
//        end
        
//        4: begin
//            update  <=0;
//            alg_dds <=5;
//        end









//            en	<=0;
//            case(bit_no)
            
//                0: begin
//                    sdata   <=dds_word[0];
//                    bit_no  <=bit_no+1;
//                end
                
//                39: begin
//                    sdata   <=dds_word[bit_no];
//                    bit_no  <=0;
//                    alg_dds <=6;
//                end

//                default: begin
//                    sdata   <=dds_word[bit_no];
//                    bit_no  <=bit_no+1;
//                end
//            endcase
        
//        5: begin
//            update  <=1;
//            if(delay_cnt<=100) begin
//                delay_cnt<=delay_cnt+1;
//            end
//            else begin
//                alg_dds <=6;
//                delay_cnt<=0;
//            end
//        end
        
//        6: begin
//            update  <=0;
//            alg_dds <=7;
//        end        
        
//            case(i)
//               0: begin
//                    clkw<=1;
//                    if(bit_no<39) begin
//                        sdata   <=dds_word[bit_no];
//                        bit_no  <=bit_no+1;
//                    end
//                    else begin
//                        sdata   <=dds_word[bit_no];
//                        bit_no  <=0;
//                        alg_dds <=8;
//                    end
//                    i<=1;
//               end
               
//               1: begin
//                    clkw<=0;
//                    i<=0;
//               end
               
//               default: i<=0;
//            endcase 