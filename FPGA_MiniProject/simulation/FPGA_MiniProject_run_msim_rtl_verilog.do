transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/FPGA_MiniProject {D:/FPGA_MiniProject/VGA_IP_Top.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_MiniProject {D:/FPGA_MiniProject/VGA_IP.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_MiniProject {D:/FPGA_MiniProject/FPGA_MiniProject.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_MiniProject {D:/FPGA_MiniProject/sineGen.v}
vlog -vlog01compat -work work +incdir+D:/FPGA_MiniProject {D:/FPGA_MiniProject/Sample_IP.v}

vlog -vlog01compat -work work +incdir+D:/FPGA_MiniProject {D:/FPGA_MiniProject/VGATB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  VGATest_tb

do D:/FPGA_MiniProject/simulation/load_sim.tcl
