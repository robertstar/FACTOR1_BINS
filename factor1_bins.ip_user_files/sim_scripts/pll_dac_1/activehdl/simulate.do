onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+pll_dac -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.pll_dac xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {pll_dac.udo}

run -all

endsim

quit -force
