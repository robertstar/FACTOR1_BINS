# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: new/LED.xdc

# IP: ip/pll/pll.xci
set_property KEEP_HIERARCHY SOFT [get_cells -hier -filter {REF_NAME==pll || ORIG_REF_NAME==pll} -quiet] -quiet

# XDC: ip/pll/pll_board.xdc
set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==pll || ORIG_REF_NAME==pll} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: ip/pll/pll.xdc
#dup# set_property KEEP_HIERARCHY SOFT [get_cells [split [join [get_cells -hier -filter {REF_NAME==pll || ORIG_REF_NAME==pll} -quiet] {/inst } ]/inst ] -quiet] -quiet

# XDC: ip/pll/pll_ooc.xdc
