
z
Command: %s
53*	vivadotcl2I
5synth_design -top factor1_bins -part xc7a100tfgg676-22default:defaultZ4-113h px? 
:
Starting synth_design
149*	vivadotclZ4-321h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a100t2default:defaultZ17-349h px? 
W
Loading part %s157*device2$
xc7a100tfgg676-22default:defaultZ21-403h px? 
?
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
42default:defaultZ8-7079h px? 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px? 
`
#Helper process launched with PID %s4824*oasys2
295682default:defaultZ8-7075h px? 
?
%s*synth2?
?Starting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:04 . Memory (MB): peak = 2339.246 ; gain = 0.000 ; free physical = 1490 ; free virtual = 8358
2default:defaulth px? 
?
synthesizing module '%s'%s4497*oasys2 
factor1_bins2default:default2
 2default:default2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
232default:default8@Z8-6157h px? 
N
%s
*synth26
"	Parameter IDLE bound to: 3'b000 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter WRITE bound to: 3'b001 
2default:defaulth p
x
? 
N
%s
*synth26
"	Parameter READ bound to: 3'b010 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter PAUSE bound to: 3'b011 
2default:defaulth p
x
? 
e
%s
*synth2M
9	Parameter adc_read_ofset bound to: 270 - type: integer 
2default:defaulth p
x
? 
?
synthesizing module '%s'%s4497*oasys2
pll2default:default2
 2default:default2b
L/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll.v2default:default2
732default:default8@Z8-6157h px? 
?
synthesizing module '%s'%s4497*oasys2
pll_clk_wiz2default:default2
 2default:default2j
T/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll_clk_wiz.v2default:default2
712default:default8@Z8-6157h px? 
?
synthesizing module '%s'%s4497*oasys2
IBUF2default:default2
 2default:default2M
7/opt/Xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
329832default:default8@Z8-6157h px? 
g
%s
*synth2O
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter IBUF_DELAY_VALUE bound to: 0 - type: string 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter IBUF_LOW_PWR bound to: TRUE - type: string 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter IFD_DELAY_VALUE bound to: AUTO - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
IBUF2default:default2
 2default:default2
12default:default2
12default:default2M
7/opt/Xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
329832default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2

MMCME2_ADV2default:default2
 2default:default2M
7/opt/Xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
399982default:default8@Z8-6157h px? 
e
%s
*synth2M
9	Parameter BANDWIDTH bound to: OPTIMIZED - type: string 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKFBOUT_MULT_F bound to: 20.000000 - type: double 
2default:defaulth p
x
? 
i
%s
*synth2Q
=	Parameter CLKFBOUT_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
l
%s
*synth2T
@	Parameter CLKFBOUT_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
i
%s
*synth2Q
=	Parameter CLKIN1_PERIOD bound to: 20.000000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKIN2_PERIOD bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT0_DIVIDE_F bound to: 6.250000 - type: double 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT0_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT0_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT0_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT1_DIVIDE bound to: 8 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT1_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT1_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT1_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter CLKOUT2_DIVIDE bound to: 20 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT2_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT2_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT2_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
e
%s
*synth2M
9	Parameter CLKOUT3_DIVIDE bound to: 100 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT3_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT3_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT3_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
g
%s
*synth2O
;	Parameter CLKOUT4_CASCADE bound to: FALSE - type: string 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT4_DIVIDE bound to: 1 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT4_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT4_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT4_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT5_DIVIDE bound to: 1 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT5_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT5_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT5_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter CLKOUT6_DIVIDE bound to: 1 - type: integer 
2default:defaulth p
x
? 
m
%s
*synth2U
A	Parameter CLKOUT6_DUTY_CYCLE bound to: 0.500000 - type: double 
2default:defaulth p
x
? 
h
%s
*synth2P
<	Parameter CLKOUT6_PHASE bound to: 0.000000 - type: double 
2default:defaulth p
x
? 
k
%s
*synth2S
?	Parameter CLKOUT6_USE_FINE_PS bound to: FALSE - type: string 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter COMPENSATION bound to: ZHOLD - type: string 
2default:defaulth p
x
? 
b
%s
*synth2J
6	Parameter DIVCLK_DIVIDE bound to: 1 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter IS_CLKINSEL_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
X
%s
*synth2@
,	Parameter IS_PSEN_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter IS_PSINCDEC_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	Parameter IS_PWRDWN_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
W
%s
*synth2?
+	Parameter IS_RST_INVERTED bound to: 1'b0 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter REF_JITTER1 bound to: 0.010000 - type: double 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter REF_JITTER2 bound to: 0.010000 - type: double 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter SS_EN bound to: FALSE - type: string 
2default:defaulth p
x
? 
e
%s
*synth2M
9	Parameter SS_MODE bound to: CENTER_HIGH - type: string 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter SS_MOD_PERIOD bound to: 10000 - type: integer 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter STARTUP_WAIT bound to: FALSE - type: string 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

MMCME2_ADV2default:default2
 2default:default2
22default:default2
12default:default2M
7/opt/Xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
399982default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
BUFG2default:default2
 2default:default2M
7/opt/Xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
10832default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
BUFG2default:default2
 2default:default2
32default:default2
12default:default2M
7/opt/Xilinx/Vivado/2020.2/scripts/rt/data/unisim_comp.v2default:default2
10832default:default8@Z8-6155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pll_clk_wiz2default:default2
 2default:default2
42default:default2
12default:default2j
T/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll_clk_wiz.v2default:default2
712default:default8@Z8-6155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pll2default:default2
 2default:default2
52default:default2
12default:default2b
L/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll.v2default:default2
732default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
pll_dac2default:default2
 2default:default2?
j/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/pll_dac_stub.v2default:default2
52default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pll_dac2default:default2
 2default:default2
62default:default2
12default:default2?
j/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/pll_dac_stub.v2default:default2
52default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
mac2default:default2
 2default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
232default:default8@Z8-6157h px? 
\
%s
*synth2D
0	Parameter rx_IDLE bound to: 0 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter rx_PREAMBULE bound to: 1 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter rx_ETH_layer bound to: 2 - type: integer 
2default:defaulth p
x
? 
b
%s
*synth2J
6	Parameter rx_IPv4_layer bound to: 3 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter rx_ARP_layer bound to: 4 - type: integer 
2default:defaulth p
x
? 
_
%s
*synth2G
3	Parameter rx_ARP_TRL bound to: 5 - type: integer 
2default:defaulth p
x
? 
_
%s
*synth2G
3	Parameter rx_ARP_FCS bound to: 6 - type: integer 
2default:defaulth p
x
? 
b
%s
*synth2J
6	Parameter rx_ICMP_layer bound to: 7 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter rx_ICMP_FCS bound to: 8 - type: integer 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter rx_UDP_layer bound to: 9 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter rx_APO bound to: 10 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter rx_DFS bound to: 11 - type: integer 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter rx_RS485 bound to: 12 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter rx_VARU bound to: 13 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter rx_BINS bound to: 14 - type: integer 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter rx_DELAY bound to: 15 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter tx_IDLE bound to: 0 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter tx_ADC bound to: 1 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter tx_ARP bound to: 2 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter tx_UDP bound to: 3 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter tx_ICMP bound to: 4 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter tx_26010 bound to: 5 - type: integer 
2default:defaulth p
x
? 
]
%s
*synth2E
1	Parameter tx_26100 bound to: 6 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter tx_FCS bound to: 7 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter tx_IGP bound to: 8 - type: integer 
2default:defaulth p
x
? 
T
%s
*synth2<
(	Parameter PRE_IDLE bound to: 5'b00000 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter PRE_26010_HEADER bound to: 5'b00001 
2default:defaulth p
x
? 
Y
%s
*synth2A
-	Parameter PRE_26010_CRC bound to: 5'b00010 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter PRE_26010_FIFO_HEADER bound to: 5'b00011 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter PRE_26010_FIFO_DFS_WAIT bound to: 5'b00100 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter PRE_26010_FIFO_DFS_DATA bound to: 5'b00101 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter PRE_26010_FIFO_DFS_ZERO bound to: 5'b00110 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter PRE_26010_FIFO_DFS_TIMEOUT bound to: 5'b00111 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter PRE_26100_HEADER bound to: 5'b01000 
2default:defaulth p
x
? 
Y
%s
*synth2A
-	Parameter PRE_26100_CRC bound to: 5'b01001 
2default:defaulth p
x
? 
a
%s
*synth2I
5	Parameter PRE_26100_FIFO_HEADER bound to: 5'b01010 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter PRE_26100_FIFO_BINS_WAIT bound to: 5'b01011 
2default:defaulth p
x
? 
d
%s
*synth2L
8	Parameter PRE_26100_FIFO_BINS_DATA bound to: 5'b01100 
2default:defaulth p
x
? 
g
%s
*synth2O
;	Parameter PRE_26100_FIFO_BINS_TIMEOUT bound to: 5'b01101 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter PRE_26100_FIFO_DFS_WAIT bound to: 5'b01110 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter PRE_26100_FIFO_DFS_DATA bound to: 5'b01111 
2default:defaulth p
x
? 
f
%s
*synth2N
:	Parameter PRE_26100_FIFO_DFS_TIMEOUT bound to: 5'b10000 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter PRE_26100_FIFO_DFS_ZERO bound to: 5'b10001 
2default:defaulth p
x
? 
S
%s
*synth2;
'	Parameter PRE_END bound to: 5'b10010 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter PRE_26010_CLEAR_FIFO bound to: 5'b10011 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter PRE_26100_CLEAR_FIFO bound to: 5'b10100 
2default:defaulth p
x
? 
?
synthesizing module '%s'%s4497*oasys2
crc2default:default2
 2default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/crc.sv2default:default2
232default:default8@Z8-6157h px? 
W
%s
*synth2?
+	Parameter Tp bound to: 1 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
crc2default:default2
 2default:default2
72default:default2
12default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/crc.sv2default:default2
232default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
events2default:default2
 2default:default2c
M/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/events.sv2default:default2
232default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
events2default:default2
 2default:default2
82default:default2
12default:default2c
M/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/events.sv2default:default2
232default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
fifo_apo2default:default2
 2default:default2?
k/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/fifo_apo_stub.v2default:default2
62default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
fifo_apo2default:default2
 2default:default2
92default:default2
12default:default2?
k/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/fifo_apo_stub.v2default:default2
62default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
ram_adc2default:default2
 2default:default2d
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_adc.sv2default:default2
452default:default8@Z8-6157h px? 
]
%s
*synth2E
1	Parameter words bound to: 4096 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter addr_w bound to: 12 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ram_adc2default:default2
 2default:default2
102default:default2
12default:default2d
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_adc.sv2default:default2
452default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
fifo_arp2default:default2
 2default:default2?
k/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/fifo_arp_stub.v2default:default2
62default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
fifo_arp2default:default2
 2default:default2
112default:default2
12default:default2?
k/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/fifo_arp_stub.v2default:default2
62default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
fifo_ser2default:default2
 2default:default2?
k/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/fifo_ser_stub.v2default:default2
62default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
fifo_ser2default:default2
 2default:default2
122default:default2
12default:default2?
k/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/fifo_ser_stub.v2default:default2
62default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2

ram_dual_v2default:default2
 2default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual_v.sv2default:default2
232default:default8@Z8-6157h px? 
\
%s
*synth2D
0	Parameter words bound to: 127 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter addr_w bound to: 7 - type: integer 
2default:defaulth p
x
? 
_
%s
*synth2G
3	Parameter addr_end bound to: 113 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

ram_dual_v2default:default2
 2default:default2
132default:default2
12default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual_v.sv2default:default2
232default:default8@Z8-6155h px? 
?
Util %s: %s4024*oasys2 
Can't resize2default:default2&
variable case item2default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
20852default:default8@Z8-5575h px? 
?
Util %s: %s4024*oasys2 
Can't resize2default:default2&
variable case item2default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
23862default:default8@Z8-5575h px? 
?
Fall outputs are unconnected for this instance and logic may be removed3605*oasys2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
40442default:default8@Z8-4446h px? 
?
synthesizing module '%s'%s4497*oasys2

ila_eth_rx2default:default2
 2default:default2?
m/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/ila_eth_rx_stub.v2default:default2
62default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

ila_eth_rx2default:default2
 2default:default2
142default:default2
12default:default2?
m/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/ila_eth_rx_stub.v2default:default2
62default:default8@Z8-6155h px? 
?
Fall outputs are unconnected for this instance and logic may be removed3605*oasys2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
40612default:default8@Z8-4446h px? 
?
synthesizing module '%s'%s4497*oasys2

ila_eth_tx2default:default2
 2default:default2?
m/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/ila_eth_tx_stub.v2default:default2
62default:default8@Z8-6157h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

ila_eth_tx2default:default2
 2default:default2
152default:default2
12default:default2?
m/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/realtime/ila_eth_tx_stub.v2default:default2
62default:default8@Z8-6155h px? 
?
fMark debug on the nets applies keep_hierarchy on instance '%s'. This will prevent further optimization4399*oasys2
ila_eth_rx12default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
40442default:default8@Z8-6071h px? 
?
fMark debug on the nets applies keep_hierarchy on instance '%s'. This will prevent further optimization4399*oasys2
ila_eth_tx12default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
40612default:default8@Z8-6071h px? 
?
fMark debug on the nets applies keep_hierarchy on instance '%s'. This will prevent further optimization4399*oasys2
crc_inst2default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
3352default:default8@Z8-6071h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
mac2default:default2
 2default:default2
162default:default2
12default:default2`
J/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/mac.sv2default:default2
232default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
ad98502default:default2
 2default:default2c
M/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ad9850.sv2default:default2
232default:default8@Z8-6157h px? 
?
1ignoring non-constant assignment in initial block311*oasys2c
M/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ad9850.sv2default:default2
682default:default8@Z8-311h px? 
?
-case statement is not full and has no default155*oasys2c
M/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ad9850.sv2default:default2
1302default:default8@Z8-155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ad98502default:default2
 2default:default2
172default:default2
12default:default2c
M/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ad9850.sv2default:default2
232default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
	rs485_dfs2default:default2
 2default:default2b
L/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/rs485.sv2default:default2
232default:default8@Z8-6157h px? 
]
%s
*synth2E
1	Parameter speed bound to: 9600 - type: integer 
2default:defaulth p
x
? 
?
synthesizing module '%s'%s4497*oasys2
uart_rx_dfs2default:default2
 2default:default2h
R/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/uart_rx_dfs.sv2default:default2
322default:default8@Z8-6157h px? 
d
%s
*synth2L
8	Parameter CLKS_PER_BIT bound to: 5208 - type: integer 
2default:defaulth p
x
? 
N
%s
*synth26
"	Parameter IDLE bound to: 3'b000 
2default:defaulth p
x
? 
V
%s
*synth2>
*	Parameter RX_START_BIT bound to: 3'b001 
2default:defaulth p
x
? 
V
%s
*synth2>
*	Parameter RX_DATA_BITS bound to: 3'b010 
2default:defaulth p
x
? 
W
%s
*synth2?
+	Parameter RX_PARITY_BIT bound to: 3'b011 
2default:defaulth p
x
? 
U
%s
*synth2=
)	Parameter RX_STOP_BIT bound to: 3'b100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter CLEANUP bound to: 3'b101 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_rx_dfs2default:default2
 2default:default2
182default:default2
12default:default2h
R/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/uart_rx_dfs.sv2default:default2
322default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
uart_tx_dfs2default:default2
 2default:default2h
R/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/uart_tx_dfs.sv2default:default2
302default:default8@Z8-6157h px? 
d
%s
*synth2L
8	Parameter CLKS_PER_BIT bound to: 5208 - type: integer 
2default:defaulth p
x
? 
N
%s
*synth26
"	Parameter IDLE bound to: 3'b000 
2default:defaulth p
x
? 
V
%s
*synth2>
*	Parameter TX_START_BIT bound to: 3'b001 
2default:defaulth p
x
? 
V
%s
*synth2>
*	Parameter TX_DATA_BITS bound to: 3'b010 
2default:defaulth p
x
? 
U
%s
*synth2=
)	Parameter TX_STOP_BIT bound to: 3'b011 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter CLEANUP bound to: 3'b100 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_tx_dfs2default:default2
 2default:default2
192default:default2
12default:default2h
R/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/uart_tx_dfs.sv2default:default2
302default:default8@Z8-6155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	rs485_dfs2default:default2
 2default:default2
202default:default2
12default:default2b
L/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/rs485.sv2default:default2
232default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2

rs485_bins2default:default2
 2default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/rs485_bins.sv2default:default2
232default:default8@Z8-6157h px? 
?
synthesizing module '%s'%s4497*oasys2
UART_RX2default:default2
 2default:default2d
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/UART_RX.sv2default:default2
302default:default8@Z8-6157h px? 
d
%s
*synth2L
8	Parameter CLKS_PER_BIT bound to: 1085 - type: integer 
2default:defaulth p
x
? 
N
%s
*synth26
"	Parameter IDLE bound to: 3'b000 
2default:defaulth p
x
? 
V
%s
*synth2>
*	Parameter RX_START_BIT bound to: 3'b001 
2default:defaulth p
x
? 
V
%s
*synth2>
*	Parameter RX_DATA_BITS bound to: 3'b010 
2default:defaulth p
x
? 
W
%s
*synth2?
+	Parameter RX_PARITY_BIT bound to: 3'b011 
2default:defaulth p
x
? 
U
%s
*synth2=
)	Parameter RX_STOP_BIT bound to: 3'b100 
2default:defaulth p
x
? 
Q
%s
*synth29
%	Parameter CLEANUP bound to: 3'b101 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
UART_RX2default:default2
 2default:default2
212default:default2
12default:default2d
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/UART_RX.sv2default:default2
302default:default8@Z8-6155h px? 
?
-case statement is not full and has no default155*oasys2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/rs485_bins.sv2default:default2
1222default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/rs485_bins.sv2default:default2
1602default:default8@Z8-155h px? 
?
synthesizing module '%s'%s4497*oasys2 
uart_tx_bins2default:default2
 2default:default2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/uart_tx_bins.sv2default:default2
232default:default8@Z8-6157h px? 
l
%s
*synth2T
@	Parameter CLOCK_FREQUENCY bound to: 125000000 - type: integer 
2default:defaulth p
x
? 
c
%s
*synth2K
7	Parameter BAUD_RATE bound to: 115200 - type: integer 
2default:defaulth p
x
? 
O
%s
*synth27
#	Parameter PARITY bound to: 2'b01 
2default:defaulth p
x
? 
n
%s
*synth2V
B	Parameter HALF_BAUD_CLK_REG_VALUE bound to: 541 - type: integer 
2default:defaulth p
x
? 
l
%s
*synth2T
@	Parameter HALF_BAUD_CLK_REG_SIZE bound to: 10 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2 
uart_tx_bins2default:default2
 2default:default2
222default:default2
12default:default2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/uart_tx_bins.sv2default:default2
232default:default8@Z8-6155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

rs485_bins2default:default2
 2default:default2
232default:default2
12default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/rs485_bins.sv2default:default2
232default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2
	ram_dual22default:default2
 2default:default2f
P/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual2.sv2default:default2
232default:default8@Z8-6157h px? 
[
%s
*synth2C
/	Parameter words bound to: 64 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter addr_w bound to: 6 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	ram_dual22default:default2
 2default:default2
242default:default2
12default:default2f
P/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual2.sv2default:default2
232default:default8@Z8-6155h px? 
?
synthesizing module '%s'%s4497*oasys2.
ram_dual_v__parameterized02default:default2
 2default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual_v.sv2default:default2
232default:default8@Z8-6157h px? 
[
%s
*synth2C
/	Parameter words bound to: 64 - type: integer 
2default:defaulth p
x
? 
[
%s
*synth2C
/	Parameter addr_w bound to: 6 - type: integer 
2default:defaulth p
x
? 
^
%s
*synth2F
2	Parameter addr_end bound to: 49 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2.
ram_dual_v__parameterized02default:default2
 2default:default2
242default:default2
12default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual_v.sv2default:default2
232default:default8@Z8-6155h px? 
?
default block is never used226*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
8012default:default8@Z8-226h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
8082default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
8132default:default8@Z8-155h px? 
?
default block is never used226*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
8342default:default8@Z8-226h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
8422default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
9242default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
10212default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
10342default:default8@Z8-155h px? 
?
synthesizing module '%s'%s4497*oasys2.
ram_dual_v__parameterized12default:default2
 2default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual_v.sv2default:default2
232default:default8@Z8-6157h px? 
]
%s
*synth2E
1	Parameter words bound to: 1050 - type: integer 
2default:defaulth p
x
? 
\
%s
*synth2D
0	Parameter addr_w bound to: 10 - type: integer 
2default:defaulth p
x
? 
`
%s
*synth2H
4	Parameter addr_end bound to: 1024 - type: integer 
2default:defaulth p
x
? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2.
ram_dual_v__parameterized12default:default2
 2default:default2
242default:default2
12default:default2g
Q/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/ram_dual_v.sv2default:default2
232default:default8@Z8-6155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
20862default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
21502default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
22222default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
24662default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
22652default:default8@Z8-155h px? 
?
-case statement is not full and has no default155*oasys2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
22062default:default8@Z8-155h px? 
?
'done synthesizing module '%s'%s (%s#%s)4495*oasys2 
factor1_bins2default:default2
 2default:default2
252default:default2
12default:default2i
S/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/new/factor1_bins.sv2default:default2
232default:default8@Z8-6155h px? 
?
%s*synth2?
?Finished RTL Elaboration : Time (s): cpu = 00:00:06 ; elapsed = 00:00:07 . Memory (MB): peak = 2339.246 ; gain = 0.000 ; free physical = 2213 ; free virtual = 9095
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 2339.246 ; gain = 0.000 ; free physical = 2234 ; free virtual = 9122
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 2339.246 ; gain = 0.000 ; free physical = 2234 ; free virtual = 9122
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.092default:default2
00:00:00.092default:default2
2339.2462default:default2
0.0002default:default2
22222default:default2
91112default:defaultZ17-722h px? 
e
-Analyzing %s Unisim elements for replacement
17*netlist2
12default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
>

Processing XDC Constraints
244*projectZ1-262h px? 
=
Initializing timing engine
348*projectZ1-569h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2)
mac_inst/fifo_26100	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2)
mac_inst/fifo_26100	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2)
mac_inst/fifo_26010	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2)
mac_inst/fifo_26010	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2,
rs485_dfs_inst/fifo_rx	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2,
rs485_dfs_inst/fifo_rx	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2,
rs485_dfs_inst/fifo_tx	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2,
rs485_dfs_inst/fifo_tx	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2-
rs485_bins_inst/fifo_rx	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2-
rs485_bins_inst/fifo_rx	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2-
rs485_bins_inst/fifo_tx	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_ser/fifo_ser/fifo_ser_in_context.xdc2default:default2-
rs485_bins_inst/fifo_tx	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_arp/fifo_arp/fifo_arp_in_context.xdc2default:default2,
mac_inst/fifo_arp_inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_arp/fifo_arp/fifo_arp_in_context.xdc2default:default2,
mac_inst/fifo_arp_inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_apo/fifo_apo/fifo_apo_in_context.xdc2default:default2,
mac_inst/fifo_apo_inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
l/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/fifo_apo/fifo_apo/fifo_apo_in_context.xdc2default:default2,
mac_inst/fifo_apo_inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
?/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/ila_eth_rx/ila_eth_rx/ila_eth_rx_in_context.xdc2default:default2*
mac_inst/ila_eth_rx1	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
?/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/ila_eth_rx/ila_eth_rx/ila_eth_rx_in_context.xdc2default:default2*
mac_inst/ila_eth_rx1	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
?/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/ila_eth_tx/ila_eth_tx/ila_eth_tx_in_context.xdc2default:default2*
mac_inst/ila_eth_tx1	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
?/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/ila_eth_tx/ila_eth_tx/ila_eth_tx_in_context.xdc2default:default2*
mac_inst/ila_eth_tx1	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
{/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/pll_dac_1/pll_dac/pll_dac_in_context.xdc2default:default2
pll_dac1	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
{/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/.Xil/Vivado-29548-pc/pll_dac_1/pll_dac/pll_dac_in_context.xdc2default:default2
pll_dac1	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2j
T/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll_board.xdc2default:default2#
pll_inst/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2j
T/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll_board.xdc2default:default2#
pll_inst/inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2d
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll.xdc2default:default2#
pll_inst/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2d
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll.xdc2default:default2#
pll_inst/inst	2default:default8Z20-847h px? 
?
?Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2b
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/sources_1/ip/pll/pll.xdc2default:default22
.Xil/factor1_bins_propImpl.xdc2default:defaultZ1-236h px? 
8
Deriving generated clocks
2*timingZ38-2h px? 
?
Parsing XDC File [%s]
179*designutils2a
K/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/constrs_1/new/LED.xdc2default:default8Z20-179h px? 
?
Finished Parsing XDC File [%s]
178*designutils2a
K/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/constrs_1/new/LED.xdc2default:default8Z20-178h px? 
?
?Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2_
K/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.srcs/constrs_1/new/LED.xdc2default:default22
.Xil/factor1_bins_propImpl.xdc2default:defaultZ1-236h px? 
?
Parsing XDC File [%s]
179*designutils2b
L/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/dont_touch.xdc2default:default8Z20-179h px? 
?
Finished Parsing XDC File [%s]
178*designutils2b
L/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/dont_touch.xdc2default:default8Z20-178h px? 
?
?Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2`
L/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/dont_touch.xdc2default:default22
.Xil/factor1_bins_propImpl.xdc2default:defaultZ1-236h px? 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2379.0862default:default2
0.0002default:default2
21142default:default2
90042default:defaultZ17-722h px? 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common24
 Constraint Validation Runtime : 2default:default2
00:00:00.032default:default2
00:00:00.032default:default2
2379.0862default:default2
0.0002default:default2
21142default:default2
90042default:defaultZ17-722h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2'
mac_inst/fifo_260102default:default2
rd_clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2'
mac_inst/fifo_261002default:default2
rd_clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2*
mac_inst/fifo_apo_inst2default:default2
rd_clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2*
mac_inst/fifo_arp_inst2default:default2
clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2(
mac_inst/ila_eth_rx12default:default2
clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2(
mac_inst/ila_eth_tx12default:default2
clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2+
rs485_bins_inst/fifo_rx2default:default2
rd_clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2+
rs485_bins_inst/fifo_tx2default:default2
rd_clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2*
rs485_dfs_inst/fifo_rx2default:default2
rd_clk2default:default2
8.0002default:defaultZ38-316h px? 
?
?Clock period '%s' specified during out-of-context synthesis of instance '%s' at clock pin '%s' is different from the actual clock period '%s', this can lead to different synthesis results.
203*timing2
10.0002default:default2*
rs485_dfs_inst/fifo_tx2default:default2
wr_clk2default:default2
8.0002default:defaultZ38-316h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Constraint Validation : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 2379.086 ; gain = 39.840 ; free physical = 2224 ; free virtual = 9107
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Loading part: xc7a100tfgg676-2
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Loading Part and Timing Information : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 2379.086 ; gain = 39.840 ; free physical = 2224 ; free virtual = 9107
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:15 ; elapsed = 00:00:16 . Memory (MB): peak = 2379.086 ; gain = 39.840 ; free physical = 2224 ; free virtual = 9107
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2$
eth_rx_state_reg2default:default2
mac2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2#
eth_pre_arp_reg2default:default2
mac2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2#
eth_prepare_reg2default:default2
mac2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2 
eth_tx_i_reg2default:default2
mac2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2

alg_st_reg2default:default2
ad98502default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2
alg_dds_reg2default:default2
ad98502default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2!
r_SM_Main_reg2default:default2
uart_rx_dfs2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2!
r_SM_Main_reg2default:default2
uart_tx_dfs2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2%
fifo_tx_state_reg2default:default2
	rs485_dfs2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2!
r_SM_Main_reg2default:default2
UART_RX2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2 
write_st_reg2default:default2

rs485_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2%
fifo_tx_state_reg2default:default2

rs485_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2#
alg_rst_phy_reg2default:default2 
factor1_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2

dac_st_reg2default:default2 
factor1_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2
bins_st_reg2default:default2 
factor1_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2
apo_alg_reg2default:default2 
factor1_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2 
alg_work_reg2default:default2 
factor1_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2

env_st_reg2default:default2 
factor1_bins2default:defaultZ8-802h px? 
?
3inferred FSM for state register '%s' in module '%s'802*oasys2
	adc_i_reg2default:default2 
factor1_bins2default:defaultZ8-802h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                 rx_IDLE |                             0000 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_            rx_PREAMBULE |                             0001 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_            rx_ETH_layer |                             0010 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2s
_           rx_IPv4_layer |                             0011 |                             0011
2default:defaulth p
x
? 
?
%s
*synth2s
_            rx_UDP_layer |                             0100 |                             1001
2default:defaulth p
x
? 
?
%s
*synth2s
_                  rx_APO |                             0101 |                             1010
2default:defaulth p
x
? 
?
%s
*synth2s
_                  rx_DFS |                             0110 |                             1011
2default:defaulth p
x
? 
?
%s
*synth2s
_                 rx_BINS |                             0111 |                             1110
2default:defaulth p
x
? 
?
%s
*synth2s
_                 rx_VARU |                             1000 |                             1101
2default:defaulth p
x
? 
?
%s
*synth2s
_            rx_ARP_layer |                             1001 |                             0100
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2$
eth_rx_state_reg2default:default2

sequential2default:default2
mac2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                PRE_IDLE |                            00000 |                            00000
2default:defaulth p
x
? 
?
%s
*synth2s
_    PRE_26100_CLEAR_FIFO |                            00001 |                            10100
2default:defaulth p
x
? 
?
%s
*synth2s
_        PRE_26100_HEADER |                            00010 |                            01000
2default:defaulth p
x
? 
?
%s
*synth2s
_           PRE_26100_CRC |                            00011 |                            01001
2default:defaulth p
x
? 
?
%s
*synth2s
_   PRE_26100_FIFO_HEADER |                            00100 |                            01010
2default:defaulth p
x
? 
?
%s
*synth2s
_PRE_26100_FIFO_BINS_WAIT |                            00101 |                            01011
2default:defaulth p
x
? 
?
%s
*synth2s
_PRE_26100_FIFO_BINS_DATA |                            00110 |                            01100
2default:defaulth p
x
? 
?
%s
*synth2v
bPRE_26100_FIFO_BINS_TIMEOUT |                            00111 |                            01101
2default:defaulth p
x
? 
?
%s
*synth2s
_ PRE_26100_FIFO_DFS_WAIT |                            01000 |                            01110
2default:defaulth p
x
? 
?
%s
*synth2s
_ PRE_26100_FIFO_DFS_DATA |                            01001 |                            01111
2default:defaulth p
x
? 
?
%s
*synth2s
_ PRE_26100_FIFO_DFS_ZERO |                            01010 |                            10001
2default:defaulth p
x
? 
?
%s
*synth2u
aPRE_26100_FIFO_DFS_TIMEOUT |                            01011 |                            10000
2default:defaulth p
x
? 
?
%s
*synth2s
_    PRE_26010_CLEAR_FIFO |                            01100 |                            10011
2default:defaulth p
x
? 
?
%s
*synth2s
_        PRE_26010_HEADER |                            01101 |                            00001
2default:defaulth p
x
? 
?
%s
*synth2s
_           PRE_26010_CRC |                            01110 |                            00010
2default:defaulth p
x
? 
?
%s
*synth2s
_   PRE_26010_FIFO_HEADER |                            01111 |                            00011
2default:defaulth p
x
? 
?
%s
*synth2s
_ PRE_26010_FIFO_DFS_WAIT |                            10000 |                            00100
2default:defaulth p
x
? 
?
%s
*synth2s
_ PRE_26010_FIFO_DFS_DATA |                            10001 |                            00101
2default:defaulth p
x
? 
?
%s
*synth2s
_ PRE_26010_FIFO_DFS_ZERO |                            10010 |                            00110
2default:defaulth p
x
? 
?
%s
*synth2u
aPRE_26010_FIFO_DFS_TIMEOUT |                            10011 |                            00111
2default:defaulth p
x
? 
?
%s
*synth2s
_                 PRE_END |                            10100 |                            10010
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2#
eth_prepare_reg2default:default2

sequential2default:default2
mac2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                               00 |                 0000000000000000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                               01 |                 0000000000000001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE2 |                               10 |                 0000000000000010
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                               11 |                 0000000000000011
2default:defaulth p
x
? 
.
%s
*synth2
*
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2 
eth_tx_i_reg2default:default2

sequential2default:default2
mac2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                                0 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                                1 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2#
eth_pre_arp_reg2default:default2

sequential2default:default2
mac2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                              001 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                              010 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                              100 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2

alg_st_reg2default:default2
one-hot2default:default2
ad98502default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE5 |                     000000000001 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE4 |                     000000000010 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                     000000000100 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                     000000001000 |                             0011
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                     000000010000 |                             0100
2default:defaulth p
x
? 
?
%s
*synth2s
_                iSTATE10 |                     000000100000 |                             0101
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE9 |                     000001000000 |                             0110
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE7 |                     000010000000 |                             0111
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE8 |                     000100000000 |                             1000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE6 |                     001000000000 |                             1001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE3 |                     010000000000 |                             1010
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE2 |                     100000000000 |                             1011
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
alg_dds_reg2default:default2
one-hot2default:default2
ad98502default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                    IDLE |                            00001 |                              000
2default:defaulth p
x
? 
?
%s
*synth2s
_            RX_START_BIT |                            00010 |                              001
2default:defaulth p
x
? 
?
%s
*synth2s
_            RX_DATA_BITS |                            00100 |                              010
2default:defaulth p
x
? 
?
%s
*synth2s
_             RX_STOP_BIT |                            01000 |                              100
2default:defaulth p
x
? 
?
%s
*synth2s
_                 CLEANUP |                            10000 |                              101
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2!
r_SM_Main_reg2default:default2
one-hot2default:default2
uart_rx_dfs2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                    IDLE |                              000 |                              000
2default:defaulth p
x
? 
?
%s
*synth2s
_            TX_START_BIT |                              001 |                              001
2default:defaulth p
x
? 
?
%s
*synth2s
_            TX_DATA_BITS |                              010 |                              010
2default:defaulth p
x
? 
?
%s
*synth2s
_             TX_STOP_BIT |                              011 |                              011
2default:defaulth p
x
? 
?
%s
*synth2s
_                 CLEANUP |                              100 |                              100
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2!
r_SM_Main_reg2default:default2

sequential2default:default2
uart_tx_dfs2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                              000 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                              001 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE5 |                              010 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                              011 |                             0011
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE2 |                              100 |                             0100
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE4 |                              101 |                             0101
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE3 |                              110 |                             0110
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2%
fifo_tx_state_reg2default:default2

sequential2default:default2
	rs485_dfs2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                    IDLE |                           000001 |                              000
2default:defaulth p
x
? 
?
%s
*synth2s
_            RX_START_BIT |                           000010 |                              001
2default:defaulth p
x
? 
?
%s
*synth2s
_            RX_DATA_BITS |                           000100 |                              010
2default:defaulth p
x
? 
?
%s
*synth2s
_           RX_PARITY_BIT |                           001000 |                              011
2default:defaulth p
x
? 
?
%s
*synth2s
_             RX_STOP_BIT |                           010000 |                              100
2default:defaulth p
x
? 
?
%s
*synth2s
_                 CLEANUP |                           100000 |                              101
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2!
r_SM_Main_reg2default:default2
one-hot2default:default2
UART_RX2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE3 |                       0000000001 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE2 |                       0000000010 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                       0000000100 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                       0000001000 |                             0011
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                       0000010000 |                             0100
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE8 |                       0000100000 |                             0101
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE6 |                       0001000000 |                             0110
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE4 |                       0010000000 |                             0111
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE5 |                       0100000000 |                             1000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE7 |                       1000000000 |                             1111
2default:defaulth p
x
? 
.
%s
*synth2
*
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2%
fifo_tx_state_reg2default:default2
one-hot2default:default2

rs485_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                              001 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                              010 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                              100 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2 
write_st_reg2default:default2
one-hot2default:default2

rs485_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                              001 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                              010 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                              100 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2#
alg_rst_phy_reg2default:default2
one-hot2default:default2 
factor1_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                             0001 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                             0010 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                             0100 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE2 |                             1000 |                             0011
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
apo_alg_reg2default:default2
one-hot2default:default2 
factor1_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                                0 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                                1 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	adc_i_reg2default:default2

sequential2default:default2 
factor1_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                              001 |                               00
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                              010 |                               01
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                              100 |                               10
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2

env_st_reg2default:default2
one-hot2default:default2 
factor1_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                             0001 |                             0000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                             0010 |                             0001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                             0100 |                             0010
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE2 |                             1000 |                             0011
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
bins_st_reg2default:default2
one-hot2default:default2 
factor1_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                                0 |                         00000000
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                                1 |                         00000001
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2 
alg_work_reg2default:default2

sequential2default:default2 
factor1_bins2default:defaultZ8-3354h px? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE1 |                             0001 |                              000
2default:defaulth p
x
? 
?
%s
*synth2s
_                  iSTATE |                             0010 |                              001
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE0 |                             0100 |                              010
2default:defaulth p
x
? 
?
%s
*synth2s
_                 iSTATE2 |                             1000 |                              111
2default:defaulth p
x
? 
.
%s
*synth2
*
2default:defaulth p
x
? 
?
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2

dac_st_reg2default:default2
one-hot2default:default2 
factor1_bins2default:defaultZ8-3354h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:22 ; elapsed = 00:00:24 . Memory (MB): peak = 2379.086 ; gain = 39.840 ; free physical = 2217 ; free virtual = 9096
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
? 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   32 Bit       Adders := 7     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   26 Bit       Adders := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  10 Input   20 Bit       Adders := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   17 Bit       Adders := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   16 Bit       Adders := 7     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   13 Bit       Adders := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   12 Bit       Adders := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   11 Bit       Adders := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   10 Bit       Adders := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    8 Bit       Adders := 13    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    7 Bit       Adders := 4     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    6 Bit       Adders := 5     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    4 Bit       Adders := 4     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    3 Bit       Adders := 3     
2default:defaulth p
x
? 
8
%s
*synth2 
+---XORs : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   2 Input      1 Bit         XORs := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   3 Input      1 Bit         XORs := 6     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   6 Input      1 Bit         XORs := 7     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   8 Input      1 Bit         XORs := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   5 Input      1 Bit         XORs := 4     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   7 Input      1 Bit         XORs := 7     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  10 Input      1 Bit         XORs := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   9 Input      1 Bit         XORs := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	  12 Input      1 Bit         XORs := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	   4 Input      1 Bit         XORs := 1     
2default:defaulth p
x
? 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               48 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               32 Bit    Registers := 16    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               26 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               24 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               16 Bit    Registers := 94    
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               13 Bit    Registers := 1     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               12 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               11 Bit    Registers := 2     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	               10 Bit    Registers := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                8 Bit    Registers := 152   
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                7 Bit    Registers := 3     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                6 Bit    Registers := 5     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                4 Bit    Registers := 8     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                3 Bit    Registers := 4     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                2 Bit    Registers := 4     
2default:defaulth p
x
? 
Z
%s
*synth2B
.	                1 Bit    Registers := 97    
2default:defaulth p
x
? 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
? 
X
%s
*synth2@
,	  16 Input   48 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  10 Input   48 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   32 Bit        Muxes := 23    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  16 Input   32 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  13 Input   32 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  10 Input   32 Bit        Muxes := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  21 Input   32 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   9 Input   32 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input   32 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input   32 Bit        Muxes := 6     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  15 Input   32 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input   32 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   26 Bit        Muxes := 4     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   17 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   16 Bit        Muxes := 12    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   8 Input   16 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  10 Input   16 Bit        Muxes := 5     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  16 Input   16 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  20 Input   16 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   13 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   5 Input   13 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   12 Bit        Muxes := 6     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input   12 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  12 Input   12 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  15 Input   12 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input   12 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   11 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input   11 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input   11 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  10 Input   10 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input   10 Bit        Muxes := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    8 Bit        Muxes := 45    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input    8 Bit        Muxes := 14    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  12 Input    8 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  15 Input    8 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  10 Input    8 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input    8 Bit        Muxes := 7     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input    8 Bit        Muxes := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   7 Input    8 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  21 Input    8 Bit        Muxes := 5     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   5 Input    8 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  31 Input    8 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   9 Input    8 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    7 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  21 Input    7 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  52 Input    7 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input    6 Bit        Muxes := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    6 Bit        Muxes := 21    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  21 Input    6 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input    6 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input    6 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   5 Input    6 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  21 Input    5 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    5 Bit        Muxes := 15    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input    5 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  52 Input    5 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   5 Input    5 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    4 Bit        Muxes := 10    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  32 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input    4 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  13 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   9 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input    4 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   8 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  21 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    3 Bit        Muxes := 18    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   8 Input    3 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   7 Input    3 Bit        Muxes := 3     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   5 Input    3 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  15 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input    2 Bit        Muxes := 8     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   7 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   9 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    2 Bit        Muxes := 8     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  12 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 334   
2default:defaulth p
x
? 
X
%s
*synth2@
,	   4 Input    1 Bit        Muxes := 73    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   3 Input    1 Bit        Muxes := 42    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   7 Input    1 Bit        Muxes := 12    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  15 Input    1 Bit        Muxes := 9     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   8 Input    1 Bit        Muxes := 11    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  12 Input    1 Bit        Muxes := 9     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  16 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  13 Input    1 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  10 Input    1 Bit        Muxes := 25    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  21 Input    1 Bit        Muxes := 30    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   9 Input    1 Bit        Muxes := 17    
2default:defaulth p
x
? 
X
%s
*synth2@
,	   5 Input    1 Bit        Muxes := 19    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  52 Input    1 Bit        Muxes := 4     
2default:defaulth p
x
? 
X
%s
*synth2@
,	   6 Input    1 Bit        Muxes := 42    
2default:defaulth p
x
? 
X
%s
*synth2@
,	  11 Input    1 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  87 Input    1 Bit        Muxes := 2     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  20 Input    1 Bit        Muxes := 1     
2default:defaulth p
x
? 
X
%s
*synth2@
,	  46 Input    1 Bit        Muxes := 1     
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2k
WPart Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB18 80 RAMB36 40)
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2?
?RAM Pipeline Warning: Read Address Register Found For RAM ram_adc/ram_reg. We will not be able to pipeline it. This may degrade performance. 
2default:defaulth p
x
? 
?
%s
*synth2?
?RAM Pipeline Warning: Read Address Register Found For RAM ram_adc/ram_reg. We will not be able to pipeline it. This may degrade performance. 
2default:defaulth p
x
? 
?
%s
*synth2?
?RAM Pipeline Warning: Read Address Register Found For RAM ram_adc/ram_reg. We will not be able to pipeline it. This may degrade performance. 
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:42 ; elapsed = 00:00:45 . Memory (MB): peak = 2379.086 ; gain = 39.840 ; free physical = 2161 ; free virtual = 9058
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth px? 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px? 
d
%s*synth2L
8
Block RAM: Preliminary Mapping	Report (see note below)
2default:defaulth px? 
?
%s*synth2?
?+------------+-----------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth px? 
?
%s*synth2?
?|Module Name | RTL Object      | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
2default:defaulth px? 
?
%s*synth2?
?+------------+-----------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth px? 
?
%s*synth2?
?|mac_inst    | ram_adc/ram_reg | 4 K x 8(READ_FIRST)    | W |   | 4 K x 8(WRITE_FIRST)   |   | R | Port A and B     | 0      | 1      | 
2default:defaulth px? 
?
%s*synth2?
?+------------+-----------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

2default:defaulth px? 
?
%s*synth2?
?Note: The table above is a preliminary report that shows the Block RAMs at the current stage of the synthesis flow. Some Block RAMs may be reimplemented as non Block RAM primitives later in the synthesis flow. Multiple instantiated Block RAMs are reported only once. 
2default:defaulth px? 
j
%s*synth2R
>
Distributed RAM: Preliminary Mapping	Report (see note below)
2default:defaulth px? 
?
%s*synth2}
i+-------------+------------------------+-----------+----------------------+----------------------------+
2default:defaulth px? 
?
%s*synth2~
j|Module Name  | RTL Object             | Inference | Size (Depth x Width) | Primitives                 | 
2default:defaulth px? 
?
%s*synth2}
i+-------------+------------------------+-----------+----------------------+----------------------------+
2default:defaulth px? 
?
%s*synth2~
j|factor1_bins | ram_bins_26100/ram_reg | Implied   | 64 x 8               | RAM64X1D x 2	RAM64M x 2	   | 
2default:defaulth px? 
?
%s*synth2~
j|factor1_bins | ram_varu/ram_reg       | Implied   | 1 K x 8              | RAM64X1D x 32	RAM64M x 32	 | 
2default:defaulth px? 
?
%s*synth2~
j|factor1_bins | ram_bins/ram_reg       | Implied   | 64 x 8               | RAM64X1D x 2	RAM64M x 2	   | 
2default:defaulth px? 
?
%s*synth2~
j+-------------+------------------------+-----------+----------------------+----------------------------+

2default:defaulth px? 
?
%s*synth2?
?Note: The table above is a preliminary report that shows the Distributed RAMs at the current stage of the synthesis flow. Some Distributed RAMs may be reimplemented as non Distributed RAM primitives later in the synthesis flow. Multiple instantiated RAMs are reported only once.
2default:defaulth px? 
?
%s*synth2?
?---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth px? 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:47 ; elapsed = 00:00:50 . Memory (MB): peak = 2379.086 ; gain = 39.840 ; free physical = 2037 ; free virtual = 8931
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Timing Optimization : Time (s): cpu = 00:01:04 ; elapsed = 00:01:07 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2094 ; free virtual = 8944
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2?
?---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!
Block RAM: Final Mapping	Report
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+-----------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth p
x
? 
?
%s
*synth2?
?|Module Name | RTL Object      | PORT A (Depth x Width) | W | R | PORT B (Depth x Width) | W | R | Ports driving FF | RAMB18 | RAMB36 | 
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+-----------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+
2default:defaulth p
x
? 
?
%s
*synth2?
?|mac_inst    | ram_adc/ram_reg | 4 K x 8(READ_FIRST)    | W |   | 4 K x 8(WRITE_FIRST)   |   | R | Port A and B     | 0      | 1      | 
2default:defaulth p
x
? 
?
%s
*synth2?
?+------------+-----------------+------------------------+---+---+------------------------+---+---+------------------+--------+--------+

2default:defaulth p
x
? 
S
%s
*synth2;
'
Distributed RAM: Final Mapping	Report
2default:defaulth p
x
? 
?
%s
*synth2}
i+-------------+------------------------+-----------+----------------------+----------------------------+
2default:defaulth p
x
? 
?
%s
*synth2~
j|Module Name  | RTL Object             | Inference | Size (Depth x Width) | Primitives                 | 
2default:defaulth p
x
? 
?
%s
*synth2}
i+-------------+------------------------+-----------+----------------------+----------------------------+
2default:defaulth p
x
? 
?
%s
*synth2~
j|factor1_bins | ram_bins_26100/ram_reg | Implied   | 64 x 8               | RAM64X1D x 2	RAM64M x 2	   | 
2default:defaulth p
x
? 
?
%s
*synth2~
j|factor1_bins | ram_varu/ram_reg       | Implied   | 1 K x 8              | RAM64X1D x 32	RAM64M x 32	 | 
2default:defaulth p
x
? 
?
%s
*synth2~
j|factor1_bins | ram_bins/ram_reg       | Implied   | 64 x 8               | RAM64X1D x 2	RAM64M x 2	   | 
2default:defaulth p
x
? 
?
%s
*synth2~
j+-------------+------------------------+-----------+----------------------+----------------------------+

2default:defaulth p
x
? 
?
%s
*synth2?
?---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
?The timing for the instance %s (implemented as a %s RAM) might be sub-optimal as no optional output register could be merged into the ram block. Providing additional output register may help in improving timing.
4799*oasys2,
mac_inst/ram_adc/ram_reg2default:default2
Block2default:defaultZ8-7052h px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Technology Mapping : Time (s): cpu = 00:01:06 ; elapsed = 00:01:10 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished IO Insertion : Time (s): cpu = 00:01:09 ; elapsed = 00:01:13 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Instances : Time (s): cpu = 00:01:09 ; elapsed = 00:01:13 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Rebuilding User Hierarchy : Time (s): cpu = 00:01:10 ; elapsed = 00:01:13 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Ports : Time (s): cpu = 00:01:10 ; elapsed = 00:01:13 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Handling Custom Attributes : Time (s): cpu = 00:01:10 ; elapsed = 00:01:13 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Renaming Generated Nets : Time (s): cpu = 00:01:10 ; elapsed = 00:01:13 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
? 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
? 
O
%s
*synth27
#|      |BlackBox name |Instances |
2default:defaulth p
x
? 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
? 
O
%s
*synth27
#|1     |fifo_apo      |         1|
2default:defaulth p
x
? 
O
%s
*synth27
#|2     |fifo_arp      |         1|
2default:defaulth p
x
? 
O
%s
*synth27
#|3     |fifo_ser      |         6|
2default:defaulth p
x
? 
O
%s
*synth27
#|4     |ila_eth_rx    |         1|
2default:defaulth p
x
? 
O
%s
*synth27
#|5     |ila_eth_tx    |         1|
2default:defaulth p
x
? 
O
%s
*synth27
#|6     |pll_dac       |         1|
2default:defaulth p
x
? 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
? 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px? 
H
%s*synth20
+------+-----------+------+
2default:defaulth px? 
H
%s*synth20
|      |Cell       |Count |
2default:defaulth px? 
H
%s*synth20
+------+-----------+------+
2default:defaulth px? 
H
%s*synth20
|1     |fifo_apo   |     1|
2default:defaulth px? 
H
%s*synth20
|2     |fifo_arp   |     1|
2default:defaulth px? 
H
%s*synth20
|3     |fifo_ser   |     1|
2default:defaulth px? 
H
%s*synth20
|4     |fifo_ser_  |     5|
2default:defaulth px? 
H
%s*synth20
|9     |ila_eth_rx |     1|
2default:defaulth px? 
H
%s*synth20
|10    |ila_eth_tx |     1|
2default:defaulth px? 
H
%s*synth20
|11    |pll_dac    |     1|
2default:defaulth px? 
H
%s*synth20
|12    |BUFG       |     8|
2default:defaulth px? 
H
%s*synth20
|13    |CARRY4     |   226|
2default:defaulth px? 
H
%s*synth20
|14    |LUT1       |   155|
2default:defaulth px? 
H
%s*synth20
|15    |LUT2       |   515|
2default:defaulth px? 
H
%s*synth20
|16    |LUT3       |   363|
2default:defaulth px? 
H
%s*synth20
|17    |LUT4       |   379|
2default:defaulth px? 
H
%s*synth20
|18    |LUT5       |   364|
2default:defaulth px? 
H
%s*synth20
|19    |LUT6       |  1304|
2default:defaulth px? 
H
%s*synth20
|20    |MMCME2_ADV |     1|
2default:defaulth px? 
H
%s*synth20
|21    |MUXF7      |   191|
2default:defaulth px? 
H
%s*synth20
|22    |MUXF8      |    34|
2default:defaulth px? 
H
%s*synth20
|23    |RAM64M     |    36|
2default:defaulth px? 
H
%s*synth20
|24    |RAM64X1D   |    36|
2default:defaulth px? 
H
%s*synth20
|25    |RAMB36E1   |     1|
2default:defaulth px? 
H
%s*synth20
|26    |FDCE       |    10|
2default:defaulth px? 
H
%s*synth20
|27    |FDPE       |    42|
2default:defaulth px? 
H
%s*synth20
|28    |FDRE       |  3281|
2default:defaulth px? 
H
%s*synth20
|30    |FDSE       |    29|
2default:defaulth px? 
H
%s*synth20
|31    |LDC        |     8|
2default:defaulth px? 
H
%s*synth20
|32    |IBUF       |    48|
2default:defaulth px? 
H
%s*synth20
|33    |OBUF       |    39|
2default:defaulth px? 
H
%s*synth20
+------+-----------+------+
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
?
%s*synth2?
?Finished Writing Synthesis Report : Time (s): cpu = 00:01:10 ; elapsed = 00:01:14 . Memory (MB): peak = 2466.430 ; gain = 127.184 ; free physical = 2099 ; free virtual = 8949
2default:defaulth px? 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
? 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 0 warnings.
2default:defaulth p
x
? 
?
%s
*synth2?
?Synthesis Optimization Runtime : Time (s): cpu = 00:01:06 ; elapsed = 00:01:10 . Memory (MB): peak = 2466.430 ; gain = 87.344 ; free physical = 2147 ; free virtual = 8997
2default:defaulth p
x
? 
?
%s
*synth2?
?Synthesis Optimization Complete : Time (s): cpu = 00:01:10 ; elapsed = 00:01:14 . Memory (MB): peak = 2466.438 ; gain = 127.184 ; free physical = 2147 ; free virtual = 8997
2default:defaulth p
x
? 
B
 Translating synthesized netlist
350*projectZ1-571h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.052default:default2
00:00:00.052default:default2
2466.4382default:default2
0.0002default:default2
22322default:default2
90832default:defaultZ17-722h px? 
g
-Analyzing %s Unisim elements for replacement
17*netlist2
5422default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2466.4382default:default2
0.0002default:default2
21822default:default2
90322default:defaultZ17-722h px? 
?
!Unisim Transformation Summary:
%s111*project2?
?  A total of 89 instances were transformed.
  FDRE_1 => FDRE (inverted pins: C): 9 instances
  LDC => LDCE: 8 instances
  RAM64M => RAM64M (RAMD64E(x4)): 36 instances
  RAM64X1D => RAM64X1D (RAMD64E(x2)): 36 instances
2default:defaultZ1-111h px? 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1352default:default2
132default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
synth_design: 2default:default2
00:01:202default:default2
00:01:202default:default2
2466.4382default:default2
127.3052default:default2
24092default:default2
92592default:defaultZ17-722h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2b
N/home/master/FPGA_proj/FACTOR1_bins/factor1_bins.runs/synth_6/factor1_bins.dcp2default:defaultZ17-1381h px? 
?
%s4*runtcl2?
nExecuting : report_utilization -file factor1_bins_utilization_synth.rpt -pb factor1_bins_utilization_synth.pb
2default:defaulth px? 
?
Exiting %s at %s...
206*common2
Vivado2default:default2,
Tue Oct 19 16:27:05 20212default:defaultZ17-206h px? 


End Record