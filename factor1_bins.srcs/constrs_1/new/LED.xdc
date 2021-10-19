#
# Global config bank properties
#
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]


#[Place 30-574] Poor placement for routing between an IO pin and BUFG. If this sub optimal condition is acceptable for this design, you may use the CLOCK_DEDICATED_ROUTE constraint in the .xdc file to demote this message to a WARNING. However, the use of this override is highly discouraged. These examples can be used directly in the .xdc file to override this clock rule.
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets envelope_IBUF]





############################################################################
#ARTIX7 A35

#set_property PACKAGE_PIN E6      [get_ports led_1]
#set_property IOSTANDARD LVCMOS33 [get_ports led_1]

#set_property PACKAGE_PIN N11     [get_ports sys_clk]
#set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]

#set_property PACKAGE_PIN K5      [get_ports sys_rst_n]
#set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]

############################################################################
# Ethernet pins                                                            #
############################################################################
#set_property PACKAGE_PIN C4 [get_ports PHY_RESET_N]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RESET_N]

#set_property PACKAGE_PIN D3 [get_ports PHY_MDC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDC]

#set_property PACKAGE_PIN E3 [get_ports PHY_MDIO]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDIO]

#set_property PACKAGE_PIN A5 [get_ports PHY_GTXC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_GTXC]
#set_property SLEW FAST [get_ports PHY_GTXC]

#set_property PACKAGE_PIN A7 [get_ports PHY_RXDV]

##set_property PACKAGE_PIN   J5       [get_ports PHY_RXC]
#set_property PACKAGE_PIN D4 [get_ports PHY_RXC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXC]

#set_property PACKAGE_PIN D5 [get_ports PHY_RXER]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXER]

#set_property PACKAGE_PIN A3 [get_ports PHY_TXEN]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXEN]
#set_property SLEW FAST [get_ports PHY_TXEN]

#set_property PACKAGE_PIN A2 [get_ports PHY_TXC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXC]

#set_property PACKAGE_PIN E2 [get_ports PHY_TXER]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXER]
#set_property SLEW FAST [get_ports PHY_TXER]

#set_property PACKAGE_PIN B7 [get_ports {PHY_RXD[0]}]
#set_property PACKAGE_PIN B5 [get_ports {PHY_RXD[1]}]
#set_property PACKAGE_PIN B6 [get_ports {PHY_RXD[2]}]
#set_property PACKAGE_PIN J4 [get_ports {PHY_RXD[3]}]
#set_property PACKAGE_PIN G4 [get_ports {PHY_RXD[4]}]
#set_property PACKAGE_PIN G5 [get_ports {PHY_RXD[5]}]
#set_property PACKAGE_PIN C6 [get_ports {PHY_RXD[6]}]
#set_property PACKAGE_PIN C7 [get_ports {PHY_RXD[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXD*]

#set_property PACKAGE_PIN B4 [get_ports {PHY_TXD[0]}]
##set_property PACKAGE_PIN   D4       [get_ports {PHY_TXD[1]}]
#set_property PACKAGE_PIN J5 [get_ports {PHY_TXD[1]}]
#set_property PACKAGE_PIN C2 [get_ports {PHY_TXD[2]}]
#set_property PACKAGE_PIN C3 [get_ports {PHY_TXD[3]}]
#set_property PACKAGE_PIN B2 [get_ports {PHY_TXD[4]}]
#set_property PACKAGE_PIN B1 [get_ports {PHY_TXD[5]}]
#set_property PACKAGE_PIN C1 [get_ports {PHY_TXD[6]}]
#set_property PACKAGE_PIN D1 [get_ports {PHY_TXD[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXD*]
#set_property SLEW FAST [get_ports PHY_TXD*]


############################################################################
# Envelope pins                                                            #
############################################################################
#set_property PACKAGE_PIN    K1          [get_ports envelope]
#set_property IOSTANDARD     LVCMOS33    [get_ports envelope]


############################################################################
# RS485-1 pins                                                             #
############################################################################
#set_property PACKAGE_PIN    F3          [get_ports ser1_rx]
#set_property IOSTANDARD     LVCMOS33    [get_ports ser1_rx]

#set_property PACKAGE_PIN    G1          [get_ports ser1_tx]
#set_property IOSTANDARD     LVCMOS33    [get_ports ser1_tx]

#set_property PACKAGE_PIN    H1          [get_ports ser1_rse]
#set_property IOSTANDARD     LVCMOS33    [get_ports ser1_rse]


############################################################################
# RS485-2 pins                                                             #
############################################################################
#set_property PACKAGE_PIN    F4          [get_ports ser2_rx]
#set_property IOSTANDARD     LVCMOS33    [get_ports ser2_rx]

#set_property PACKAGE_PIN    G2          [get_ports ser2_tx]
#set_property IOSTANDARD     LVCMOS33    [get_ports ser2_tx]

#set_property PACKAGE_PIN    H2          [get_ports ser2_rse]
#set_property IOSTANDARD     LVCMOS33    [get_ports ser2_rse]


############################################################################
# DDS pins                                                                 #
############################################################################
#set_property PACKAGE_PIN E5 [get_ports dds_rst]
#set_property IOSTANDARD LVCMOS33 [get_ports dds_rst]

#set_property PACKAGE_PIN F2 [get_ports dds_sclk]
#set_property IOSTANDARD LVCMOS33 [get_ports dds_sclk]

#set_property PACKAGE_PIN E1 [get_ports dds_upd]
#set_property IOSTANDARD LVCMOS33 [get_ports dds_upd]

#set_property PACKAGE_PIN F5 [get_ports dds_data]
#set_property IOSTANDARD LVCMOS33 [get_ports dds_data]


############################################################################
# ADC & ctrl pins                                                          #
############################################################################
#set_property PACKAGE_PIN M2 [get_ports rk_o]
#set_property IOSTANDARD LVCMOS33 [get_ports rk_o]

#set_property PACKAGE_PIN M1 [get_ports ru_o]
#set_property IOSTANDARD LVCMOS33 [get_ports ru_o]

#set_property PACKAGE_PIN T2 [get_ports rst_adc_o]
#set_property IOSTANDARD LVCMOS33 [get_ports rst_adc_o]

#set_property PACKAGE_PIN T4 [get_ports conv_o]
#set_property IOSTANDARD LVCMOS33 [get_ports conv_o]
#set_property SLEW FAST [get_ports conv_o]

#set_property PACKAGE_PIN T3 [get_ports clk_adc_o]
#set_property IOSTANDARD LVCMOS33 [get_ports clk_adc_o]
#set_property SLEW FAST [get_ports clk_adc_o]

#set_property PACKAGE_PIN R6 [get_ports {cs_o[0]}]
#set_property PACKAGE_PIN T5 [get_ports {cs_o[1]}]
#set_property PACKAGE_PIN R5 [get_ports {cs_o[2]}]
#set_property PACKAGE_PIN P6 [get_ports {cs_o[3]}]
#set_property PACKAGE_PIN M6 [get_ports {cs_o[4]}]
#set_property PACKAGE_PIN N6 [get_ports {cs_o[5]}]
#set_property PACKAGE_PIN P5 [get_ports {cs_o[6]}]
#set_property PACKAGE_PIN L5 [get_ports {cs_o[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports cs_o*]
#set_property SLEW FAST [get_ports cs_o*]

#set_property PACKAGE_PIN R7 [get_ports {adc_data_1_i[0]}]
#set_property PACKAGE_PIN R8 [get_ports {adc_data_1_i[1]}]
#set_property PACKAGE_PIN R10 [get_ports {adc_data_1_i[2]}]
#set_property PACKAGE_PIN R11 [get_ports {adc_data_1_i[3]}]
#set_property PACKAGE_PIN P9 [get_ports {adc_data_1_i[4]}]
#set_property PACKAGE_PIN P11 [get_ports {adc_data_1_i[5]}]
#set_property PACKAGE_PIN K13 [get_ports {adc_data_1_i[6]}]
#set_property PACKAGE_PIN N12 [get_ports {adc_data_1_i[7]}]
#set_property PACKAGE_PIN R12 [get_ports {adc_data_1_i[8]}]
#set_property PACKAGE_PIN R13 [get_ports {adc_data_1_i[9]}]
#set_property PACKAGE_PIN P14 [get_ports {adc_data_1_i[10]}]
#set_property PACKAGE_PIN T15 [get_ports {adc_data_1_i[11]}]
#set_property PACKAGE_PIN R16 [get_ports {adc_data_1_i[12]}]
#set_property PACKAGE_PIN P16 [get_ports {adc_data_1_i[13]}]
#set_property PACKAGE_PIN N16 [get_ports {adc_data_1_i[14]}]
#set_property PACKAGE_PIN N13 [get_ports {adc_data_1_i[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports adc_data_1_i*]

#set_property PACKAGE_PIN M12 [get_ports {adc_data_2_i[0]}]
#set_property PACKAGE_PIN N14 [get_ports {adc_data_2_i[1]}]
#set_property PACKAGE_PIN P15 [get_ports {adc_data_2_i[2]}]
#set_property PACKAGE_PIN R15 [get_ports {adc_data_2_i[3]}]
#set_property PACKAGE_PIN T14 [get_ports {adc_data_2_i[4]}]
#set_property PACKAGE_PIN P13 [get_ports {adc_data_2_i[5]}]
#set_property PACKAGE_PIN T13 [get_ports {adc_data_2_i[6]}]
#set_property PACKAGE_PIN T12 [get_ports {adc_data_2_i[7]}]
#set_property PACKAGE_PIN L13 [get_ports {adc_data_2_i[8]}]
#set_property PACKAGE_PIN K12 [get_ports {adc_data_2_i[9]}]
#set_property PACKAGE_PIN P10 [get_ports {adc_data_2_i[10]}]
#set_property PACKAGE_PIN N9 [get_ports {adc_data_2_i[11]}]
#set_property PACKAGE_PIN T10 [get_ports {adc_data_2_i[12]}]
#set_property PACKAGE_PIN T9 [get_ports {adc_data_2_i[13]}]
#set_property PACKAGE_PIN T8 [get_ports {adc_data_2_i[14]}]
#set_property PACKAGE_PIN T7 [get_ports {adc_data_2_i[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports adc_data_2_i*]


#############################################################################
## Clock constraints                                                        #
#############################################################################
#create_clock -period 8.000 -name ts_PHY_RXC [get_ports PHY_RXC]
#create_clock -period 8.000 -name ts_PHY_GTXC [get_ports PHY_GTXC]
#create_clock -period 5000.000 -name ts_conv_o [get_ports conv_o]
#create_clock -period 6.250 -name ts_clk_adc_o [get_ports clk_adc_o]

#create_clock -period 100.000 -name ts_clk10 [get_nets clk_10Mhz]
#create_clock -period 8.000 -name ts_clk125 [get_nets clk_125Mhz]
#create_clock -period 6.250 -name ts_clk160 [get_nets clk_160Mhz]

############################################################################





############################################################################
# ARTIX7 A100
############################################################################

set_property PACKAGE_PIN J19 [get_ports led_1]
set_property IOSTANDARD LVCMOS33 [get_ports led_1]

set_property PACKAGE_PIN U22 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]

set_property PACKAGE_PIN H19 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]

############################################################################
# Ethernet pins                                                            #
############################################################################
##set_property PACKAGE_PIN    C4          [get_ports PHY_RESET_N]
#set_property PACKAGE_PIN    G4          [get_ports PHY_RESET_N]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_RESET_N]

##set_property PACKAGE_PIN    D3          [get_ports PHY_MDC]
#set_property PACKAGE_PIN    M2          [get_ports PHY_MDC]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_MDC]

##set_property PACKAGE_PIN    E3          [get_ports PHY_MDIO]
#set_property PACKAGE_PIN    L2          [get_ports PHY_MDIO]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_MDIO]

##set_property PACKAGE_PIN    A5          [get_ports PHY_GTXC]
#set_property PACKAGE_PIN    D1          [get_ports PHY_GTXC]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_GTXC]
#set_property SLEW FAST                  [get_ports PHY_GTXC]

##set_property PACKAGE_PIN    A7          [get_ports PHY_RXDV]
#set_property PACKAGE_PIN    B5          [get_ports PHY_RXDV]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_RXDV]

##set_property PACKAGE_PIN    D4          [get_ports PHY_RXC]
#set_property PACKAGE_PIN    F4          [get_ports PHY_RXC]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_RXC]

##set_property PACKAGE_PIN    D5          [get_ports PHY_RXER]
#set_property PACKAGE_PIN    C1          [get_ports PHY_RXER]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_RXER]

##set_property PACKAGE_PIN    A3          [get_ports PHY_TXEN]
#set_property PACKAGE_PIN    F2          [get_ports PHY_TXEN]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_TXEN]
#set_property SLEW FAST                  [get_ports PHY_TXEN]

##set_property PACKAGE_PIN    A2          [get_ports PHY_TXC]
#set_property PACKAGE_PIN    J4          [get_ports PHY_TXC]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_TXC]

##set_property PACKAGE_PIN    E2          [get_ports PHY_TXER]
#set_property PACKAGE_PIN    G9          [get_ports PHY_TXER]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_TXER]
#set_property SLEW FAST                  [get_ports PHY_TXER]

#set_property PACKAGE_PIN    A5          [get_ports {PHY_RXD[0]}]
#set_property PACKAGE_PIN    B4          [get_ports {PHY_RXD[1]}]
#set_property PACKAGE_PIN    A4          [get_ports {PHY_RXD[2]}]
#set_property PACKAGE_PIN    B2          [get_ports {PHY_RXD[3]}]
#set_property PACKAGE_PIN    C4          [get_ports {PHY_RXD[4]}]
#set_property PACKAGE_PIN    D4          [get_ports {PHY_RXD[5]}]
#set_property PACKAGE_PIN    E5          [get_ports {PHY_RXD[6]}]
#set_property PACKAGE_PIN    D5          [get_ports {PHY_RXD[7]}]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_RXD*]

#set_property PACKAGE_PIN    E2          [get_ports {PHY_TXD[0]}]
#set_property PACKAGE_PIN    C2          [get_ports {PHY_TXD[1]}]
#set_property PACKAGE_PIN    G2          [get_ports {PHY_TXD[2]}]
#set_property PACKAGE_PIN    G1          [get_ports {PHY_TXD[3]}]
#set_property PACKAGE_PIN    H4          [get_ports {PHY_TXD[4]}]
#set_property PACKAGE_PIN    H2          [get_ports {PHY_TXD[5]}]
#set_property PACKAGE_PIN    H1          [get_ports {PHY_TXD[6]}]
#set_property PACKAGE_PIN    H9          [get_ports {PHY_TXD[7]}]
#set_property IOSTANDARD     LVCMOS33    [get_ports PHY_TXD*]
#set_property SLEW FAST                  [get_ports PHY_TXD*]




set_property PACKAGE_PIN D1 [get_ports PHY_RESET_N]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_RESET_N]


set_property PACKAGE_PIN H1 [get_ports PHY_MDC]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDC]


set_property PACKAGE_PIN H2 [get_ports PHY_MDIO]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDIO]


set_property PACKAGE_PIN E5 [get_ports PHY_GTXC]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_GTXC]
set_property SLEW FAST [get_ports PHY_GTXC]


set_property PACKAGE_PIN A5 [get_ports PHY_RXDV]


set_property PACKAGE_PIN D4 [get_ports PHY_RXC]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXC]


set_property PACKAGE_PIN D5 [get_ports PHY_RXER]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXER]


set_property PACKAGE_PIN B1 [get_ports PHY_TXEN]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXEN]
set_property SLEW FAST [get_ports PHY_TXEN]


set_property PACKAGE_PIN F4 [get_ports PHY_TXC]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXC]


set_property PACKAGE_PIN J4 [get_ports PHY_TXER]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXER]
set_property SLEW FAST [get_ports PHY_TXER]

set_property PACKAGE_PIN B5 [get_ports {PHY_RXD[0]}]
set_property PACKAGE_PIN A4 [get_ports {PHY_RXD[1]}]
set_property PACKAGE_PIN B4 [get_ports {PHY_RXD[2]}]
set_property PACKAGE_PIN A2 [get_ports {PHY_RXD[3]}]
set_property PACKAGE_PIN A3 [get_ports {PHY_RXD[4]}]
set_property PACKAGE_PIN C2 [get_ports {PHY_RXD[5]}]
set_property PACKAGE_PIN B2 [get_ports {PHY_RXD[6]}]
set_property PACKAGE_PIN C4 [get_ports {PHY_RXD[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXD*]

set_property PACKAGE_PIN C1 [get_ports {PHY_TXD[0]}]
set_property PACKAGE_PIN E1 [get_ports {PHY_TXD[1]}]
set_property PACKAGE_PIN E2 [get_ports {PHY_TXD[2]}]
set_property PACKAGE_PIN F2 [get_ports {PHY_TXD[3]}]
set_property PACKAGE_PIN G4 [get_ports {PHY_TXD[4]}]
set_property PACKAGE_PIN G1 [get_ports {PHY_TXD[5]}]
set_property PACKAGE_PIN G2 [get_ports {PHY_TXD[6]}]
set_property PACKAGE_PIN H4 [get_ports {PHY_TXD[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXD*]
set_property SLEW FAST [get_ports PHY_TXD*]





############################################################################
# DAC pins                                                                 #
############################################################################
#set_property PACKAGE_PIN    P5          [get_ports bclk]
#set_property IOSTANDARD     LVCMOS33    [get_ports bclk]

#set_property PACKAGE_PIN    P1          [get_ports bclk]
#set_property IOSTANDARD     LVCMOS33    [get_ports bclk]

#set_property PACKAGE_PIN    P6          [get_ports ddata]
#set_property IOSTANDARD     LVCMOS33    [get_ports ddata]

#set_property PACKAGE_PIN    M1          [get_ports lrck]
#set_property IOSTANDARD     LVCMOS33    [get_ports lrck]


set_property PACKAGE_PIN    N1 [get_ports bclk]
set_property IOSTANDARD     LVCMOS33 [get_ports bclk]

set_property PACKAGE_PIN    P6 [get_ports ddata]
set_property IOSTANDARD     LVCMOS33 [get_ports ddata]

set_property PACKAGE_PIN    T4 [get_ports lrck]
set_property IOSTANDARD     LVCMOS33 [get_ports lrck]


############################################################################
# Envelope pins                                                            #
############################################################################
set_property PACKAGE_PIN M5 [get_ports envelope]
set_property IOSTANDARD LVCMOS33 [get_ports envelope]

############################################################################
# Trigger pins                                                            #
############################################################################
#set_property PACKAGE_PIN    M6          [get_ports trigger_out]
#set_property IOSTANDARD     LVCMOS33    [get_ports trigger_out]

############################################################################
# RS485-1 pins                                                             #
############################################################################
set_property PACKAGE_PIN M4 [get_ports ser1_rx]
set_property IOSTANDARD LVCMOS33 [get_ports ser1_rx]

set_property PACKAGE_PIN R3 [get_ports ser1_tx]
set_property IOSTANDARD LVCMOS33 [get_ports ser1_tx]

set_property PACKAGE_PIN K1 [get_ports ser1_rse]
set_property IOSTANDARD LVCMOS33 [get_ports ser1_rse]


############################################################################
# RS485-2 pins                                                             #
############################################################################
set_property PACKAGE_PIN L4 [get_ports ser2_rx]
set_property IOSTANDARD LVCMOS33 [get_ports ser2_rx]

set_property PACKAGE_PIN P3 [get_ports ser2_tx]
set_property IOSTANDARD LVCMOS33 [get_ports ser2_tx]

set_property PACKAGE_PIN J1 [get_ports ser2_rse]
set_property IOSTANDARD LVCMOS33 [get_ports ser2_rse]


############################################################################
# DDS pins                                                                 #
############################################################################
set_property PACKAGE_PIN N2 [get_ports dds_rst]
set_property IOSTANDARD LVCMOS33 [get_ports dds_rst]

set_property PACKAGE_PIN K5 [get_ports dds_sclk]
set_property IOSTANDARD LVCMOS33 [get_ports dds_sclk]

set_property PACKAGE_PIN L5 [get_ports dds_upd]
set_property IOSTANDARD LVCMOS33 [get_ports dds_upd]

set_property PACKAGE_PIN N3 [get_ports dds_data]
set_property IOSTANDARD LVCMOS33 [get_ports dds_data]


############################################################################
# ADC & ctrl pins                                                          #
############################################################################
set_property PACKAGE_PIN AC26 [get_ports rk_o]
set_property IOSTANDARD LVCMOS33 [get_ports rk_o]

set_property PACKAGE_PIN AB26 [get_ports ru_o]
set_property IOSTANDARD LVCMOS33 [get_ports ru_o]

set_property PACKAGE_PIN Y22 [get_ports rst_adc_o]
set_property IOSTANDARD LVCMOS33 [get_ports rst_adc_o]

set_property PACKAGE_PIN W23 [get_ports conv_o]
set_property IOSTANDARD LVCMOS33 [get_ports conv_o]
set_property SLEW FAST [get_ports conv_o]

set_property PACKAGE_PIN V23 [get_ports clk_adc_o]
set_property IOSTANDARD LVCMOS33 [get_ports clk_adc_o]
set_property SLEW FAST [get_ports clk_adc_o]

set_property PACKAGE_PIN P23 [get_ports {cs_o[0]}]
set_property PACKAGE_PIN P24 [get_ports {cs_o[1]}]
set_property PACKAGE_PIN R25 [get_ports {cs_o[2]}]
set_property PACKAGE_PIN P25 [get_ports {cs_o[3]}]
set_property PACKAGE_PIN T24 [get_ports {cs_o[4]}]
set_property PACKAGE_PIN T25 [get_ports {cs_o[5]}]
set_property PACKAGE_PIN U21 [get_ports {cs_o[6]}]
set_property PACKAGE_PIN V21 [get_ports {cs_o[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports cs_o*]
set_property SLEW FAST [get_ports cs_o*]

set_property PACKAGE_PIN N21 [get_ports {adc_data_1_i[0]}]
set_property PACKAGE_PIN M24 [get_ports {adc_data_1_i[1]}]
set_property PACKAGE_PIN R26 [get_ports {adc_data_1_i[2]}]
set_property PACKAGE_PIN L22 [get_ports {adc_data_1_i[3]}]
set_property PACKAGE_PIN N26 [get_ports {adc_data_1_i[4]}]
set_property PACKAGE_PIN K22 [get_ports {adc_data_1_i[5]}]
set_property PACKAGE_PIN K25 [get_ports {adc_data_1_i[6]}]
set_property PACKAGE_PIN K21 [get_ports {adc_data_1_i[7]}]
set_property PACKAGE_PIN H21 [get_ports {adc_data_1_i[8]}]
set_property PACKAGE_PIN G20 [get_ports {adc_data_1_i[9]}]
set_property PACKAGE_PIN J25 [get_ports {adc_data_1_i[10]}]
set_property PACKAGE_PIN G22 [get_ports {adc_data_1_i[11]}]
set_property PACKAGE_PIN F23 [get_ports {adc_data_1_i[12]}]
set_property PACKAGE_PIN H26 [get_ports {adc_data_1_i[13]}]
set_property PACKAGE_PIN E25 [get_ports {adc_data_1_i[14]}]
set_property PACKAGE_PIN E26 [get_ports {adc_data_1_i[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports adc_data_1_i*]

set_property PACKAGE_PIN D26 [get_ports {adc_data_2_i[0]}]
set_property PACKAGE_PIN D25 [get_ports {adc_data_2_i[1]}]
set_property PACKAGE_PIN G26 [get_ports {adc_data_2_i[2]}]
set_property PACKAGE_PIN E23 [get_ports {adc_data_2_i[3]}]
set_property PACKAGE_PIN F22 [get_ports {adc_data_2_i[4]}]
set_property PACKAGE_PIN J26 [get_ports {adc_data_2_i[5]}]
set_property PACKAGE_PIN G21 [get_ports {adc_data_2_i[6]}]
set_property PACKAGE_PIN H22 [get_ports {adc_data_2_i[7]}]
set_property PACKAGE_PIN J21 [get_ports {adc_data_2_i[8]}]
set_property PACKAGE_PIN K26 [get_ports {adc_data_2_i[9]}]
set_property PACKAGE_PIN K23 [get_ports {adc_data_2_i[10]}]
set_property PACKAGE_PIN M26 [get_ports {adc_data_2_i[11]}]
set_property PACKAGE_PIN L23 [get_ports {adc_data_2_i[12]}]
set_property PACKAGE_PIN P26 [get_ports {adc_data_2_i[13]}]
set_property PACKAGE_PIN M25 [get_ports {adc_data_2_i[14]}]
set_property PACKAGE_PIN N22 [get_ports {adc_data_2_i[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports adc_data_2_i*]


#############################################################################
## Clock constraints                                                        #
#############################################################################
#create_clock -period 20.000     -name ts_sys_clk    [get_ports sys_clk]
create_clock -period 8.000 -name ts_PHY_RXC [get_ports PHY_RXC]
create_clock -period 8.000 -name ts_PHY_GTXC [get_ports PHY_GTXC]
create_clock -period 5000.000 -name ts_conv_o [get_ports conv_o]
create_clock -period 6.250 -name ts_clk_adc_o [get_ports clk_adc_o]

#create_clock -period 100.000    -name ts_clk10      [get_nets clk_10Mhz]
create_clock -period 8.000 -name ts_clk125 [get_nets clk_125Mhz]
create_clock -period 6.250 -name ts_clk160 [get_nets clk_160Mhz]




create_clock -period 5000.000 -name ts_ser1_rx [get_ports ser1_rx]
create_clock -period 5000.000 -name ts_ser1_tx [get_ports ser1_tx]
create_clock -period 5000.000 -name ts_ser1_rse [get_ports ser1_rse]

create_clock -period 5000.000 -name ts_ser2_rx [get_ports ser2_rx]
create_clock -period 5000.000 -name ts_ser2_tx [get_ports ser2_tx]
create_clock -period 5000.000 -name ts_ser2_rse [get_ports ser2_rse]


set_property PULLUP true [get_ports ser1_rx]
set_property PULLUP true [get_ports ser2_rx]

############################################################################



#Net e_rxc TNM_NET = e_rxc_pin;
#TIMESPEC TS_e_rxc_pin = PERIOD e_rxc_pin 8ns;

#Net e_gtxc TNM_NET = e_gtxc_pin;
#TIMESPEC TS_e_gtxc_pin = PERIOD e_gtxc_pin 8ns;


#NET "e_txd<?>" OFFSET=OUT 1ns AFTER e_gtxc;
#NET "e_txen"   OFFSET=OUT 1ns AFTER e_gtxc;
#NET "e_txer"   OFFSET=OUT 1ns AFTER e_gtxc;

#set_output_delay -clock [get_clocks ts_PHY_GTXC] -max  1.000 [get_ports {PHY_TXEN PHY_TXD* PHY_TXER}]
#set_output_delay -clock [get_clocks ts_PHY_GTXC] -min -1.000 [get_ports {PHY_TXEN PHY_TXD* PHY_TXER}]

#set_output_delay -clock [get_clocks PHY_GTXC] -max -add_delay 1.000 [get_ports {PHY_TXD*}]

#set_input_delay  -clock [get_clocks Clkif] -min 0.530  [get_ports DIN]

#NET "e_rxc" CLOCK_DEDICATED_ROUTE = FALSE;

#[Place 30-876] Port 'PHY_RXC'  is assigned to PACKAGE_PIN 'F4'  which can only be used as the N side of a differential clock input.
#Please use the following constraint(s) to pass this DRC check:
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {PHY_RXC_IBUF}]


















#create_clock -period 8.0        -name ts_e_rx_clk   [get_nets eth_rx_clk]
#create_clock -period 8.0        -name ts_e_tx_clk   [get_nets eth_tx_clk]


#set_input_delay -clock  ts_clk160    2.0            [get_ports {adc_data_1_i*}]
#set_input_delay -clock  ts_clk160    2.0 -min       [get_ports {adc_data_1_i*}]

#set_input_delay -clock  ts_clk160    2.0            [get_ports {adc_data_2_i*}]
#set_input_delay -clock  ts_clk160    2.0 -min       [get_ports {adc_data_2_i*}]





#set_input_delay -clock [get_clocks *axi_ethernet_3/inst/mac/inst_rgmii_rx_clk] -max -1.4                        [get_ports -of [get_nets -of [get_pins "*/axi_ethernet_3/rgmii_rd[*] */axi_ethernet_3/rgmii_rx_ctl"]]]
#set_input_delay -clock [get_clocks *axi_ethernet_3/inst/mac/inst_rgmii_rx_clk] -min -2.8                        [get_ports -of [get_nets -of [get_pins "*/axi_ethernet_3/rgmii_rd[*] */axi_ethernet_3/rgmii_rx_ctl"]]]
#set_input_delay -clock [get_clocks *axi_ethernet_3/inst/mac/inst_rgmii_rx_clk] -clock_fall -max -1.4 -add_delay [get_ports -of [get_nets -of [get_pins "*/axi_ethernet_3/rgmii_rd[*] */axi_ethernet_3/rgmii_rx_ctl"]]]
#set_input_delay -clock [get_clocks *axi_ethernet_3/inst/mac/inst_rgmii_rx_clk] -clock_fall -min -2.8 -add_delay [get_ports -of [get_nets -of [get_pins "*/axi_ethernet_3/rgmii_rd[*] */axi_ethernet_3/rgmii_rx_ctl"]]]

#set_output_delay -clock [get_clocks rgmii_port_0_txc] -max -1.0                                                 [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}]
#set_output_delay -clock [get_clocks rgmii_port_0_txc] -min -2.5                                                 [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}] -add_delay
#set_output_delay -clock [get_clocks rgmii_port_0_txc] -clock_fall -max -1.0                                     [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}]
#set_output_delay -clock [get_clocks rgmii_port_0_txc] -clock_fall -min -2.5                                     [get_ports {rgmii_port_0_td[*] rgmii_port_0_tx_ctl}]




##
## Global config bank properties
##
#set_property CFGBVS VCCO [current_design]
#set_property CONFIG_VOLTAGE 3.3 [current_design]

#set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]


#set_property PACKAGE_PIN J19 [get_ports led_1]
#set_property IOSTANDARD LVCMOS33 [get_ports led_1]

#set_property PACKAGE_PIN U22 [get_ports sys_clk]
#set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]

#set_property PACKAGE_PIN H19 [get_ports sys_rst_n]
#set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]

#############################################################################
## Ethernet pins                                                            #
#############################################################################
#set_property PACKAGE_PIN L23 [get_ports PHY_RESET_N]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RESET_N]

#set_property PACKAGE_PIN P25 [get_ports PHY_MDC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDC]

#set_property PACKAGE_PIN R25 [get_ports PHY_MDIO]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_MDIO]

#set_property PACKAGE_PIN K22 [get_ports PHY_GTXC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_GTXC]
#set_property SLEW FAST [get_ports PHY_GTXC]

#set_property PACKAGE_PIN F22 [get_ports PHY_RXDV]

#set_property PACKAGE_PIN G20 [get_ports PHY_RXC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXC]

#set_property PACKAGE_PIN K26 [get_ports PHY_RXER]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXER]

#set_property PACKAGE_PIN M26 [get_ports PHY_TXEN]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXEN]
#set_property SLEW FAST [get_ports PHY_TXEN]

#set_property PACKAGE_PIN M25 [get_ports PHY_TXC]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXC]

#set_property PACKAGE_PIN P23 [get_ports PHY_TXER]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXER]

#set_property PACKAGE_PIN G22 [get_ports {PHY_RXD[0]}]
#set_property PACKAGE_PIN J26 [get_ports {PHY_RXD[1]}]
#set_property PACKAGE_PIN J25 [get_ports {PHY_RXD[2]}]
#set_property PACKAGE_PIN G21 [get_ports {PHY_RXD[3]}]
#set_property PACKAGE_PIN H22 [get_ports {PHY_RXD[4]}]
#set_property PACKAGE_PIN H21 [get_ports {PHY_RXD[5]}]
#set_property PACKAGE_PIN J21 [get_ports {PHY_RXD[6]}]
#set_property PACKAGE_PIN K21 [get_ports {PHY_RXD[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_RXD*]

#set_property PACKAGE_PIN N26 [get_ports {PHY_TXD[0]}]
#set_property PACKAGE_PIN L22 [get_ports {PHY_TXD[1]}]
#set_property PACKAGE_PIN P26 [get_ports {PHY_TXD[2]}]
#set_property PACKAGE_PIN R26 [get_ports {PHY_TXD[3]}]
#set_property PACKAGE_PIN M24 [get_ports {PHY_TXD[4]}]
#set_property PACKAGE_PIN N22 [get_ports {PHY_TXD[5]}]
#set_property PACKAGE_PIN N21 [get_ports {PHY_TXD[6]}]
#set_property PACKAGE_PIN P24 [get_ports {PHY_TXD[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports PHY_TXD*]
#set_property SLEW FAST [get_ports PHY_TXD*]

#############################################################################
## ADC ctrl pins                                                            #
#############################################################################
#set_property PACKAGE_PIN A5 [get_ports rk_o]
#set_property IOSTANDARD LVCMOS33 [get_ports rk_o]

#set_property PACKAGE_PIN B5 [get_ports ru_o]
#set_property IOSTANDARD LVCMOS33 [get_ports ru_o]

#set_property PACKAGE_PIN A4 [get_ports rst_adc_o]
#set_property IOSTANDARD LVCMOS33 [get_ports rst_adc_o]

#set_property PACKAGE_PIN B4 [get_ports conv_o]
#set_property IOSTANDARD LVCMOS33 [get_ports conv_o]
#set_property SLEW FAST [get_ports conv_o]

#set_property PACKAGE_PIN A2 [get_ports clk_adc_o]
#set_property IOSTANDARD LVCMOS33 [get_ports clk_adc_o]
#set_property SLEW FAST [get_ports clk_adc_o]


#set_property PACKAGE_PIN A3 [get_ports {cs_o[0]}]
#set_property PACKAGE_PIN C2 [get_ports {cs_o[1]}]
#set_property PACKAGE_PIN B2 [get_ports {cs_o[2]}]
#set_property PACKAGE_PIN D4 [get_ports {cs_o[3]}]
#set_property PACKAGE_PIN C4 [get_ports {cs_o[4]}]
#set_property PACKAGE_PIN D5 [get_ports {cs_o[5]}]
#set_property PACKAGE_PIN E5 [get_ports {cs_o[6]}]
#set_property PACKAGE_PIN B1 [get_ports {cs_o[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports cs_o*]


#set_property PACKAGE_PIN C1 [get_ports {adc_data_1_i[0]}]
#set_property PACKAGE_PIN D1 [get_ports {adc_data_1_i[1]}]
#set_property PACKAGE_PIN E1 [get_ports {adc_data_1_i[2]}]
#set_property PACKAGE_PIN E2 [get_ports {adc_data_1_i[3]}]
#set_property PACKAGE_PIN F2 [get_ports {adc_data_1_i[4]}]
#set_property PACKAGE_PIN F4 [get_ports {adc_data_1_i[5]}]
#set_property PACKAGE_PIN G4 [get_ports {adc_data_1_i[6]}]
#set_property PACKAGE_PIN G1 [get_ports {adc_data_1_i[7]}]
#set_property PACKAGE_PIN G2 [get_ports {adc_data_1_i[8]}]
#set_property PACKAGE_PIN H4 [get_ports {adc_data_1_i[9]}]
#set_property PACKAGE_PIN J4 [get_ports {adc_data_1_i[10]}]
#set_property PACKAGE_PIN H1 [get_ports {adc_data_1_i[11]}]
#set_property PACKAGE_PIN H2 [get_ports {adc_data_1_i[12]}]
#set_property PACKAGE_PIN G9 [get_ports {adc_data_1_i[13]}]
#set_property PACKAGE_PIN H9 [get_ports {adc_data_1_i[14]}]
#set_property PACKAGE_PIN L2 [get_ports {adc_data_1_i[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports adc_data_1_i*]


#set_property PACKAGE_PIN M2 [get_ports {adc_data_2_i[0]}]
#set_property PACKAGE_PIN N3 [get_ports {adc_data_2_i[1]}]
#set_property PACKAGE_PIN N2 [get_ports {adc_data_2_i[2]}]
#set_property PACKAGE_PIN K5 [get_ports {adc_data_2_i[3]}]
#set_property PACKAGE_PIN L5 [get_ports {adc_data_2_i[4]}]
#set_property PACKAGE_PIN L4 [get_ports {adc_data_2_i[5]}]
#set_property PACKAGE_PIN M4 [get_ports {adc_data_2_i[6]}]
#set_property PACKAGE_PIN P3 [get_ports {adc_data_2_i[7]}]
#set_property PACKAGE_PIN R3 [get_ports {adc_data_2_i[8]}]
#set_property PACKAGE_PIN J1 [get_ports {adc_data_2_i[9]}]
#set_property PACKAGE_PIN K1 [get_ports {adc_data_2_i[10]}]
#set_property PACKAGE_PIN M5 [get_ports {adc_data_2_i[11]}]
#set_property PACKAGE_PIN M6 [get_ports {adc_data_2_i[12]}]
#set_property PACKAGE_PIN T3 [get_ports {adc_data_2_i[13]}]
#set_property PACKAGE_PIN T4 [get_ports {adc_data_2_i[14]}]
#set_property PACKAGE_PIN P5 [get_ports {adc_data_2_i[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports adc_data_2_i*]


#############################################################################
## Clock constraints                                                        #
#############################################################################
#create_clock -period 20.000 -name ts_sys_clk [get_ports sys_clk]
#create_clock -period 8.000 -name ts_PHY_RXC [get_ports PHY_RXC]
#create_clock -period 8.000 -name ts_PHY_GTXC [get_ports PHY_GTXC]



##create_clock     -period 8.000    -name PHY_GTXC [get_ports PHY_GTXC]
##create_clock     -period 8.000    -name ADC_CLK  [get_ports ADC_CLK]
##create_clock     -period 8.000    -name DAC_CLK  [get_ports DAC_CLK]
##create_clock     -period 6.250    -name conv_o  [get_ports conv_o]
##create_clock     -period 6.250    -name clk_160Mhz  [get_ports clk_160Mhz]
##create_generated_clock -name clk_160Mhz [get_pins pll2_inst/clk_out1]
##create_clock      -period 6.250     -name clk_160Mhz [get_pins pll2_inst/clk_out1]
##set_input_delay  -clock [get_clocks Clkif] -min 0.530  [get_ports DIN]
##set_input_delay  -clock [get_clocks Clkif] -max 7.700  [get_ports DIN]
##set_output_delay -clock [get_clocks Clkif] -min -0.030 [get_ports DOUT]
##set_output_delay -clock [get_clocks Clkif] -max 1.800  [get_ports DOUT]
##set_output_delay -clock [get_clocks PHY_GTXC] -min -add_delay 0.000 [get_ports {PHY_TXD*}]
##set_output_delay -clock [get_clocks PHY_GTXC] -max -add_delay 1.000 [get_ports {PHY_TXD*}]
##set_output_delay -clock [get_clocks PHY_GTXC] -min -add_delay 0.000 [get_ports PHY_TXEN]
##set_output_delay -clock [get_clocks PHY_GTXC] -max -add_delay 1.000 [get_ports PHY_TXEN]
##set_output_delay -clock [get_clocks PHY_GTXC] -min -add_delay 0.000 [get_ports PHY_TXER]
##set_output_delay -clock [get_clocks PHY_GTXC] -max -add_delay 1.000 [get_ports PHY_TXER]



##create_pblock pblock_mac_inst
##add_cells_to_pblock [get_pblocks pblock_mac_inst] [get_cells -quiet [list mac_inst]]
##resize_pblock [get_pblocks pblock_mac_inst] -add {SLICE_X0Y51:SLICE_X49Y98}
##resize_pblock [get_pblocks pblock_mac_inst] -add {DSP48_X0Y22:DSP48_X0Y37}
##resize_pblock [get_pblocks pblock_mac_inst] -add {RAMB18_X0Y22:RAMB18_X0Y37}
##resize_pblock [get_pblocks pblock_mac_inst] -add {RAMB36_X0Y11:RAMB36_X0Y18}

set_property BEL DFF [get_cells {mac_inst/dfs_tx_din_reg[7]}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din_reg[7]}]
set_property BEL D6LUT [get_cells {mac_inst/dfs_tx_din[7]_i_2}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din[7]_i_2}]
set_property BEL C6LUT [get_cells {mac_inst/dfs_tx_din[6]_i_1}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din[6]_i_1}]
set_property BEL B6LUT [get_cells {mac_inst/dfs_tx_din[5]_i_1}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din[5]_i_1}]
set_property BEL A6LUT [get_cells {mac_inst/dfs_tx_din[4]_i_1}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din[4]_i_1}]
set_property BEL CFF [get_cells {mac_inst/dfs_tx_din_reg[6]}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din_reg[6]}]
set_property BEL BFF [get_cells {mac_inst/dfs_tx_din_reg[5]}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din_reg[5]}]
set_property BEL AFF [get_cells {mac_inst/dfs_tx_din_reg[4]}]
set_property LOC SLICE_X28Y78 [get_cells {mac_inst/dfs_tx_din_reg[4]}]
set_property BEL C6LUT [get_cells {mac_inst/dfs_tx_din[3]_i_1}]
set_property BEL A6LUT [get_cells {mac_inst/dfs_tx_din[1]_i_1}]
set_property BEL BFF [get_cells {mac_inst/dfs_tx_din_reg[2]}]
set_property BEL DFF [get_cells {mac_inst/dfs_tx_din_reg[0]}]
set_property BEL D6LUT [get_cells {mac_inst/dfs_tx_din[0]_i_1}]
set_property BEL B6LUT [get_cells {mac_inst/dfs_tx_din[2]_i_1}]
set_property BEL AFF [get_cells {mac_inst/dfs_tx_din_reg[1]}]
set_property BEL CFF [get_cells {mac_inst/dfs_tx_din_reg[3]}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din[3]_i_1}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din[1]_i_1}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din_reg[2]}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din_reg[0]}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din[0]_i_1}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din[2]_i_1}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din_reg[1]}]
set_property LOC SLICE_X28Y77 [get_cells {mac_inst/dfs_tx_din_reg[3]}]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_125Mhz]
