
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px? 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px? 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px? 
?
yIO port buffering is incomplete: Device port %s expects both input and output buffering but the buffers are incomplete.%s*DRC2>
 "(
PHY_MDIOPHY_MDIO2default:default2default:default28
  DRC|Netlist|Port|Required Buffer2default:default8ZRPBF-3h px? 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px? 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
42default:defaultZ30-611h px? 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px? 
?

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:00.012default:default2
2818.1842default:default2
0.0002default:default2
17812default:default2
223122default:defaultZ17-722h px? 
[
FPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 10f9bd3a7
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:00.02 ; elapsed = 00:00:00.16 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1781 ; free virtual = 223122default:defaulth px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:00.012default:default2
2818.1842default:default2
0.0002default:default2
17812default:default2
223132default:defaultZ17-722h px? 
?

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px? 
?
?A LUT '%s' is driving clock pin of %s registers. This could lead to large hold time violations. First few involved registers are:
%s524*place2.
mac_inst/fifo_apo_inst_i_12default:default2
732default:default2?
?	mac_inst/fifo_apo_inst/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.wr_rst_busy_i_reg {FDPE}
	mac_inst/fifo_apo_inst/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.sckt_wr_rst_ic_reg {FDPE}
	mac_inst/fifo_apo_inst/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[3] {FDCE}
	mac_inst/fifo_apo_inst/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnsckt_wrst.gic_rst.rd_rst_wr_ext_reg[2] {FDCE}
	mac_inst/fifo_apo_inst/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/grstd1.grst_full.grst_f.rst_d3_reg {FDPE}
2default:defaultZ30-568h px? 
g
RPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: f7471b88
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:01 ; elapsed = 00:00:01 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1739 ; free virtual = 222922default:defaulth px? 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px? 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 12ed54ea0
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1768 ; free virtual = 223152default:defaulth px? 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px? 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 12ed54ea0
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1768 ; free virtual = 223152default:defaulth px? 
I
4Phase 1 Placer Initialization | Checksum: 12ed54ea0
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:03 ; elapsed = 00:00:03 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1768 ; free virtual = 223162default:defaulth px? 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px? 
C
.Phase 2.1 Floorplanning | Checksum: 1df8f87c9
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:04 ; elapsed = 00:00:03 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1760 ; free virtual = 223102default:defaulth px? 
x

Phase %s%s
101*constraints2
2.2 2default:default2)
Global Placement Core2default:defaultZ18-101h px? 
?

Phase %s%s
101*constraints2
2.2.1 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px? 
u
7Found %s candidate LUT instances to create LUTNM shape
536*physynth2
1602default:defaultZ32-1018h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
722default:default2!
nets or cells2default:default2
22default:default2
cells2default:default2
702default:default2
cells2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
?
?Very high fanout net '%s' has -through timing constraint at pin '%s' or its immediate connected net. To preserve -through timing constraint its fanout number considered in optimization is changed from %s to %s and it is not considered a very high fanout net anymore. Please consider modifying/removing the '-through' timing constraint on the net segment or hierarchy pin.
540*physynth2F
adc_wr_addr_reg_n_0_[0]adc_wr_addr_reg_n_0_[0]2default:default2
 2default:default2
10272default:default2
2602default:default8Z32-1022h px? 
?
?Very high fanout net '%s' has -through timing constraint at pin '%s' or its immediate connected net. To preserve -through timing constraint its fanout number considered in optimization is changed from %s to %s and it is not considered a very high fanout net anymore. Please consider modifying/removing the '-through' timing constraint on the net segment or hierarchy pin.
540*physynth2F
adc_wr_addr_reg_n_0_[1]adc_wr_addr_reg_n_0_[1]2default:default2
 2default:default2
10282default:default2
2612default:default8Z32-1022h px? 
?
?Very high fanout net '%s' has -through timing constraint at pin '%s' or its immediate connected net. To preserve -through timing constraint its fanout number considered in optimization is changed from %s to %s and it is not considered a very high fanout net anymore. Please consider modifying/removing the '-through' timing constraint on the net segment or hierarchy pin.
540*physynth2F
adc_wr_addr_reg_n_0_[2]adc_wr_addr_reg_n_0_[2]2default:default2
 2default:default2
10272default:default2
2602default:default8Z32-1022h px? 
?
?Very high fanout net '%s' has -through timing constraint at pin '%s' or its immediate connected net. To preserve -through timing constraint its fanout number considered in optimization is changed from %s to %s and it is not considered a very high fanout net anymore. Please consider modifying/removing the '-through' timing constraint on the net segment or hierarchy pin.
540*physynth2F
adc_wr_addr_reg_n_0_[3]adc_wr_addr_reg_n_0_[3]2default:default2
 2default:default2
10272default:default2
2602default:default8Z32-1022h px? 
?
?Very high fanout net '%s' has -through timing constraint at pin '%s' or its immediate connected net. To preserve -through timing constraint its fanout number considered in optimization is changed from %s to %s and it is not considered a very high fanout net anymore. Please consider modifying/removing the '-through' timing constraint on the net segment or hierarchy pin.
540*physynth2F
adc_wr_addr_reg_n_0_[4]adc_wr_addr_reg_n_0_[4]2default:default2
 2default:default2
10282default:default2
2612default:default8Z32-1022h px? 
?
?Very high fanout net '%s' has -through timing constraint at pin '%s' or its immediate connected net. To preserve -through timing constraint its fanout number considered in optimization is changed from %s to %s and it is not considered a very high fanout net anymore. Please consider modifying/removing the '-through' timing constraint on the net segment or hierarchy pin.
540*physynth2F
adc_wr_addr_reg_n_0_[5]adc_wr_addr_reg_n_0_[5]2default:default2
 2default:default2
10282default:default2
2612default:default8Z32-1022h px? 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px? 
?
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
h
DNo candidate cells for SRL register optimization found in the design349*physynthZ32-677h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
i
ENo candidate cells for BRAM register optimization found in the design297*physynthZ32-526h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2818.1842default:default2
0.0002default:default2
17422default:default2
222952default:defaultZ17-722h px? 
B
-
Summary of Physical Synthesis Optimizations
*commonh px? 
B
-============================================
*commonh px? 


*commonh px? 


*commonh px? 
?
?-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Optimization                                     |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?
|  LUT Combining                                    |            2  |             70  |                    72  |           0  |           1  |  00:00:00  |
|  Very High Fanout                                 |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register                                     |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register to Pipeline                       |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register                                   |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  BRAM Register                                    |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Dynamic/Static Region Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                                            |            2  |             70  |                    72  |           0  |           7  |  00:00:00  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
T
?Phase 2.2.1 Physical Synthesis In Placer | Checksum: 1340e6515
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:16 ; elapsed = 00:00:10 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1742 ; free virtual = 222952default:defaulth px? 
K
6Phase 2.2 Global Placement Core | Checksum: 1e1a82b13
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:16 ; elapsed = 00:00:10 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222942default:defaulth px? 
D
/Phase 2 Global Placement | Checksum: 1e1a82b13
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:16 ; elapsed = 00:00:10 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1743 ; free virtual = 222962default:defaulth px? 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px? 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px? 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 19430dc0d
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:17 ; elapsed = 00:00:10 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1742 ; free virtual = 222952default:defaulth px? 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px? 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 130a10344
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:18 ; elapsed = 00:00:11 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1740 ; free virtual = 222932default:defaulth px? 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px? 
K
6Phase 3.3 Area Swap Optimization | Checksum: c97e35a3
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:18 ; elapsed = 00:00:11 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1740 ; free virtual = 222932default:defaulth px? 
?

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px? 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 137c3b347
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:18 ; elapsed = 00:00:11 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1740 ; free virtual = 222932default:defaulth px? 
t

Phase %s%s
101*constraints2
3.5 2default:default2%
Fast Optimization2default:defaultZ18-101h px? 
F
1Phase 3.5 Fast Optimization | Checksum: 8b3457f1
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:22 ; elapsed = 00:00:14 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222942default:defaulth px? 


Phase %s%s
101*constraints2
3.6 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px? 
R
=Phase 3.6 Small Shape Detail Placement | Checksum: 1a93d1332
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:23 ; elapsed = 00:00:16 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1737 ; free virtual = 222912default:defaulth px? 
u

Phase %s%s
101*constraints2
3.7 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px? 
H
3Phase 3.7 Re-assign LUT pins | Checksum: 177c85272
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:24 ; elapsed = 00:00:16 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1737 ; free virtual = 222912default:defaulth px? 
?

Phase %s%s
101*constraints2
3.8 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px? 
T
?Phase 3.8 Pipeline Register Optimization | Checksum: 153eb50a0
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:24 ; elapsed = 00:00:16 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1737 ; free virtual = 222912default:defaulth px? 
t

Phase %s%s
101*constraints2
3.9 2default:default2%
Fast Optimization2default:defaultZ18-101h px? 
G
2Phase 3.9 Fast Optimization | Checksum: 10d657b78
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:33 ; elapsed = 00:00:24 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222972default:defaulth px? 
D
/Phase 3 Detail Placement | Checksum: 10d657b78
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:33 ; elapsed = 00:00:24 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222972default:defaulth px? 
?

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px? 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
?

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px? 
V
APost Placement Optimization Initialization | Checksum: 21ab93369
*commonh px? 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px? 
?
?BUFG insertion identified %s candidate nets. Inserted BUFG: %s, Replicated BUFG Driver: %s, Skipped due to Placement/Routing Conflicts: %s, Skipped due to Timing Degradation: %s, Skipped due to Illegal Netlist: %s.43*	placeflow2
02default:default2
02default:default2
02default:default2
02default:default2
02default:default2
02default:defaultZ46-56h px? 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 21ab93369
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:35 ; elapsed = 00:00:25 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1736 ; free virtual = 222912default:defaulth px? 
?
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
-3.3332default:defaultZ30-746h px? 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 1e1a96f3e
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1740 ; free virtual = 222942default:defaulth px? 
N
9Phase 4.1 Post Commit Optimization | Checksum: 1e1a96f3e
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1740 ; free virtual = 222942default:defaulth px? 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px? 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 1e1a96f3e
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222952default:defaulth px? 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px? 
F
1Phase 4.3 Placer Reporting | Checksum: 1e1a96f3e
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222952default:defaulth px? 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2818.1842default:default2
0.0002default:default2
17412default:default2
222952default:defaultZ17-722h px? 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 15453b760
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222952default:defaulth px? 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 15453b760
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222952default:defaulth px? 
=
(Ending Placer Task | Checksum: cfcf58e5
*commonh px? 
?

%s
*constraints2?
?Time (s): cpu = 00:00:59 ; elapsed = 00:00:48 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1741 ; free virtual = 222952default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
872default:default2
92default:default2
02default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
place_design: 2default:default2
00:01:022default:default2
00:00:502default:default2
2818.1842default:default2
0.0002default:default2
17542default:default2
223082default:defaultZ17-722h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2818.1842default:default2
0.0002default:default2
17542default:default2
223082default:defaultZ17-722h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:012default:default2
00:00:00.402default:default2
2818.1842default:default2
0.0002default:default2
17402default:default2
223062default:defaultZ17-722h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2Y
E/home/vladimir/FACTOR2_bins/project_led.runs/impl_2/factor_placed.dcp2default:defaultZ17-1381h px? 
a
%s4*runtcl2E
1Executing : report_io -file factor_io_placed.rpt
2default:defaulth px? 
?
?report_io: Time (s): cpu = 00:00:00.15 ; elapsed = 00:00:00.22 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1735 ; free virtual = 22292
*commonh px? 
?
%s4*runtcl2x
dExecuting : report_utilization -file factor_utilization_placed.rpt -pb factor_utilization_placed.pb
2default:defaulth px? 
~
%s4*runtcl2b
NExecuting : report_control_sets -verbose -file factor_control_sets_placed.rpt
2default:defaulth px? 
?
?report_control_sets: Time (s): cpu = 00:00:00.08 ; elapsed = 00:00:00.13 . Memory (MB): peak = 2818.184 ; gain = 0.000 ; free physical = 1749 ; free virtual = 22306
*commonh px? 


End Record