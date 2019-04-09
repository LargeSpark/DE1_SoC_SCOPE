transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject {M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/VGA_IP.v}
vlog -vlog01compat -work work +incdir+M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject {M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/FPGA_MiniProject.v}
vlog -vlog01compat -work work +incdir+M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject {M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/FreqDiv.v}

