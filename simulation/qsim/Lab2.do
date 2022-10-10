onerror {exit -code 1}
vlib work
vlog -work work Lab2.vo
vlog -work work testingMulti.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.fourBitMulti_vlg_vec_tst -voptargs="+acc"
vcd file -direction Lab2.msim.vcd
vcd add -internal fourBitMulti_vlg_vec_tst/*
vcd add -internal fourBitMulti_vlg_vec_tst/i1/*
run -all
quit -f