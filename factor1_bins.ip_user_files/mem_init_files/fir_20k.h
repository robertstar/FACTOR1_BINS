
//------------------------------------------------------------------------------
// (c) Copyright 2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------ 
//
// C Model configuration for the "fir_20k" instance.
//
//------------------------------------------------------------------------------
//
// coefficients: 1,11,41,89,129,121,49,-39,-73,-25,45,53,-8,-57,-27,43,54,-14,-67,-24,60,62,-31,-87,-16,88,70,-59,-113,1,128,72,-102,-140,35,177,62,-164,-163,92,235,30,-248,-174,181,299,-36,-359,-161,317,363,-157,-505,-106,525,421,-374,-712,36,880,469,-817,-1081,412,1712,500,-2261,-2424,2634,10062,13618,10062,2634,-2424,-2261,500,1712,412,-1081,-817,469,880,36,-712,-374,421,525,-106,-505,-157,363,317,-161,-359,-36,299,181,-174,-248,30,235,92,-163,-164,62,177,35,-140,-102,72,128,1,-113,-59,70,88,-16,-87,-31,62,60,-24,-67,-14,54,43,-27,-57,-8,53,45,-25,-73,-39,49,121,129,89,41,11,1
// chanpats: 173
// name: fir_20k
// filter_type: 2
// rate_change: 0
// interp_rate: 1
// decim_rate: 2
// zero_pack_factor: 1
// coeff_padding: 1
// num_coeffs: 141
// coeff_sets: 1
// reloadable: 0
// is_halfband: 0
// quantization: 0
// coeff_width: 16
// coeff_fract_width: 0
// chan_seq: 0
// num_channels: 128
// num_paths: 1
// data_width: 16
// data_fract_width: 0
// output_rounding_mode: 0
// output_width: 33
// output_fract_width: 0
// config_method: 0

const double fir_20k_coefficients[141] = {1,11,41,89,129,121,49,-39,-73,-25,45,53,-8,-57,-27,43,54,-14,-67,-24,60,62,-31,-87,-16,88,70,-59,-113,1,128,72,-102,-140,35,177,62,-164,-163,92,235,30,-248,-174,181,299,-36,-359,-161,317,363,-157,-505,-106,525,421,-374,-712,36,880,469,-817,-1081,412,1712,500,-2261,-2424,2634,10062,13618,10062,2634,-2424,-2261,500,1712,412,-1081,-817,469,880,36,-712,-374,421,525,-106,-505,-157,363,317,-161,-359,-36,299,181,-174,-248,30,235,92,-163,-164,62,177,35,-140,-102,72,128,1,-113,-59,70,88,-16,-87,-31,62,60,-24,-67,-14,54,43,-27,-57,-8,53,45,-25,-73,-39,49,121,129,89,41,11,1};

const xip_fir_v7_2_pattern fir_20k_chanpats[1] = {P_BASIC};

static xip_fir_v7_2_config gen_fir_20k_config() {
  xip_fir_v7_2_config config;
  config.name                = "fir_20k";
  config.filter_type         = 2;
  config.rate_change         = XIP_FIR_INTEGER_RATE;
  config.interp_rate         = 1;
  config.decim_rate          = 2;
  config.zero_pack_factor    = 1;
  config.coeff               = &fir_20k_coefficients[0];
  config.coeff_padding       = 1;
  config.num_coeffs          = 141;
  config.coeff_sets          = 1;
  config.reloadable          = 0;
  config.is_halfband         = 0;
  config.quantization        = XIP_FIR_INTEGER_COEFF;
  config.coeff_width         = 16;
  config.coeff_fract_width   = 0;
  config.chan_seq            = XIP_FIR_BASIC_CHAN_SEQ;
  config.num_channels        = 128;
  config.init_pattern        = fir_20k_chanpats[0];
  config.num_paths           = 1;
  config.data_width          = 16;
  config.data_fract_width    = 0;
  config.output_rounding_mode= XIP_FIR_FULL_PRECISION;
  config.output_width        = 33;
  config.output_fract_width  = 0,
  config.config_method       = XIP_FIR_CONFIG_SINGLE;
  return config;
}

const xip_fir_v7_2_config fir_20k_config = gen_fir_20k_config();

