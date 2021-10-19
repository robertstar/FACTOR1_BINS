-makelib xcelium_lib/xpm -sv \
  "/home/vladimir/Vitis/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/home/vladimir/Vitis/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/home/vladimir/Vitis/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../ip/pll_dac_1/pll_dac_clk_wiz.v" \
  "../../../ip/pll_dac_1/pll_dac.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

