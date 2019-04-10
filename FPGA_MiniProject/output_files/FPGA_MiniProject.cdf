/* Quartus Prime Version 17.1.1 Internal Build 593 12/11/2017 SJ Standard Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEMA5F31) Path("M:/MASTERS/FPGA/FPGA_WS/FPGA_MiniProject/output_files/") File("FPGA_MiniProject.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
