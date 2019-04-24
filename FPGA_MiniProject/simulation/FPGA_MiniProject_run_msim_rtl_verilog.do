transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/altera_up_avalon_adv_adc.v}
vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/VGA_IP_Top.v}
vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/VGA_IP.v}
vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/FPGA_MiniProject.v}
vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/sineGen.v}
vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/Sample_IP.v}
vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/ADA_Generated.v}
vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/SevenSeg_IP.v}

vlog -vlog01compat -work work +incdir+C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject {C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/VGATB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  VGATest_tb

do C:/FPGA/DE1_SoC_SCOPE/FPGA_MiniProject/simulation/load_sim.tcl
