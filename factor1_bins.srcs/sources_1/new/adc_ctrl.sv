`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2019 10:38:48
// Design Name: 
// Module Name: adc_ctrl
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


module adc_ctrl ( input clk_i, rst_i,
                input [31:0] conv_i, input logic conv_en_i,
                output logic rst_adc_o, conv_start_o, clk_adc_o, output logic [7:0] cs_o, input [15:0] data_adc_1_i, data_adc_2_i, 
                output logic data_adc_check_o, output logic data_adc_out_en_o, output logic [15:0] data_adc_out_o,
                output logic data_adc_ready_o,
                input data_head_en_i,
                output logic data_adc_end_o );
						
	
parameter conv_start_ofset = 1;
parameter conv_start_time = 11;
parameter adc_read_ofset = 270;
logic adc_read;
parameter clk_adc_period = 12;		//160
parameter clk_adc_rise = 10;	

//logic [9:0] conv;				//====31.10
logic [15:0] conv;				//====31.10
parameter conv_period = 800;
//parameter conv_period = 1200;
//parameter conv_period = 1600;
//parameter conv_period = 250;

logic [7:0] clk_adc_duration;	
logic [6:0] clk_adc_nn;
parameter clk_adc_NN = 43;	
logic [31:0] data_adc;	
logic [31:0] data_adc_1;
logic data_adc_out_en;	
logic data_adc_out_en_nn;
logic [7:0] data_out_nn;
logic data_adc_out_en_1;
logic data_adc_out_en_2;
logic data_adc_out_en_3;
logic data_adc_out_en_4;
logic data_adc_out_en_5;
logic [6:0] data_adc_nn;

logic data_adc_end;
logic [15:0] cnt;
logic [2:0] data_adc_end_nn;

initial begin
        conv_start_o = 1;
        adc_read = 0;
        clk_adc_duration = 0;
        clk_adc_o = 1;
        cs_o = '1;
        clk_adc_nn = 0; 
        data_adc_check_o = 0;
        data_adc_out_en = 0;
        data_adc_out_en_nn = 0;
        data_out_nn = 0;
//        data_adc_out_en_1 = 1;
//        data_adc_out_en_o = 0;
        conv = 0;
		  data_adc_end = 0;
		  data_adc_end_o = 0;
		  data_adc_end_nn = 0;
end

assign rst_adc_o = 0;





always @(posedge clk_i or posedge rst_i) begin
    if(rst_i) begin
        conv_start_o <= 1;
        adc_read <= 0;
        clk_adc_duration <= 0;
        clk_adc_o <= 1;
        cs_o <= '1;
        clk_adc_nn <= 0; 
        data_adc_check_o <= 0;
        data_adc_out_en <= 0;
        data_adc_out_en_nn <= 0;
        data_out_nn <= 0;
//        data_adc_out_en_1 <= 1;
//        data_adc_out_en_o <= 0;
        conv <= 0;
		  data_adc_end = 0;
		  data_adc_end_o <= 0;
    end
    else begin
	     if(cnt != 1000) cnt <= cnt + 1;
	     else           cnt <= 0;
	 
        if(conv_en_i)
            if(conv != conv_period - 1)   conv <= conv + 1;
            else                       conv <= 0;
			else   
			conv <= 0;
	 		  
		  if(conv == conv_start_ofset)   conv_start_o <= 0;
        if(conv == conv_start_time)   conv_start_o <= 1;
		  
//		  if(conv == conv_start_ofset)   data_adc_end_o <= 0;		//====31.10
		 
        if(conv == adc_read_ofset)   adc_read <= 1;
		 
        if(conv == adc_read_ofset)   clk_adc_o <= 0; 
		  
        if(conv == adc_read_ofset)   cs_o <= 8'b1111_1110;
		 
        if(adc_read) begin
            if(clk_adc_duration != clk_adc_period - 1)   clk_adc_duration <= clk_adc_duration + 1;
				else begin
                clk_adc_duration <= 0;
				end
				
            if(clk_adc_duration == clk_adc_rise - 1)                                     clk_adc_o <= 1;
            if(clk_adc_duration == clk_adc_period - 1 && clk_adc_nn != clk_adc_NN - 1)   clk_adc_o <= 0;
            if(clk_adc_duration == clk_adc_period - 1 && clk_adc_nn == clk_adc_NN - 1)   clk_adc_o <= 1;
				
            if(clk_adc_duration == clk_adc_period - 1) begin
                if(clk_adc_nn != clk_adc_NN - 1)   clk_adc_nn <= clk_adc_nn + 1;
					 else begin
                    clk_adc_nn <= 0;
						  adc_read <= 0;
					 end
					 
                case(clk_adc_nn)   
                    5:    cs_o <= 8'b1111_1101; 
                    6:    cs_o <= 8'b1111_1011;
                    12:   cs_o <= 8'b1111_0111;
                    18:   cs_o <= 8'b1110_1111;
                    24:   cs_o <= 8'b1101_1111;
                    30:   cs_o <= 8'b1011_1111;
                    36:   cs_o <= 8'b0111_1111;
                    42:   cs_o <= 8'b1111_1111; 
                endcase	
					
					if(clk_adc_nn == 42)   data_adc_end <= 1;
            end
				
		/*		if(clk_adc_duration == clk_adc_period - 1) begin
				    if(clk_adc_nn == 0)   data_adc <= {16'hA1B2, 16'hC3D4};
					 else                data_adc <= 32'd0;
				end	*/
				
				
				
				
            if(clk_adc_duration == clk_adc_rise - 1)   data_adc <= {data_adc_1_i, data_adc_2_i};
				
            if(clk_adc_duration == clk_adc_rise - 1)     data_adc_out_en <= 1;
        end
		 
        data_adc_out_en_4 <= data_adc_out_en_3;
        data_adc_out_en_5 <= data_adc_out_en_4;
		  		
        if(data_adc_out_en) begin
            if(data_adc_out_en_nn != 1)   data_adc_out_en_nn <= data_adc_out_en_nn + 1;
				else begin
                data_adc_out_en_nn <= 0;
					 data_adc_out_en <= 0;
            end
        end
		  
        if(clk_adc_nn != 6 && data_adc_out_en) begin
//            data_adc_out_en_o <= 1;							//====30.10
            if(data_adc_out_en_nn == 0)   data_adc_out_o <= data_adc[31:16];
            if(data_adc_out_en_nn == 1)   data_adc_out_o <= data_adc[15:0];
        end
		 
        if(clk_adc_nn == 6 && data_adc_out_en_nn == 0 && data_adc_out_en) begin
//            data_adc_out_en_o <= 1;							//====30.10
            if(data_adc_out_en_nn == 0)   data_adc_out_o <= data_adc[31:16];
            if(data_adc_out_en_nn == 1)   data_adc_out_o <= data_adc[15:0];
        end
		  
        if(!(clk_adc_nn != 6 & data_adc_out_en) && !(clk_adc_nn == 6 && data_adc_out_en_nn == 0 && data_adc_out_en)) begin
            data_adc_out_en_o <= 0;
            data_adc_out_o <= 0;
				
				if(data_adc_end) begin
                data_adc_end <= 0;
                data_adc_end_o <= 1;
            end
        end

        if(clk_adc_nn == 0 && data_adc_out_en) begin			//====30.10
            data_adc_out_en_o <= 1;
        end	
		  
		  if(data_adc_end_o) begin								//====05.11
		      if(data_adc_end_nn != 5) begin 
                data_adc_end_nn <= data_adc_end_nn + 1;
		      end
				else begin
				    data_adc_end_nn <= 0;
				    data_adc_end_o <= 0;
				end
		  end
		  
		 
//        if(data_adc_end_o)   data_adc_end_o <= 0;		//====31.10
		  
    end		
end
endmodule













