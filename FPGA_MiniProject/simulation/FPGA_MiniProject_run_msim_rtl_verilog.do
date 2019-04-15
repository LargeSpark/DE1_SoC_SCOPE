transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject {M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/VGA_IP.v}
vlog -vlog01compat -work work +incdir+M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject {M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/FPGA_MiniProject.v}
vlog -vlog01compat -work work +incdir+M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject {M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/VGAClock.v}

vlog -vlog01compat -work work +incdir+M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject {M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/VGATB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  VGATest_tb

do M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/simulation/load_sim.tcl
