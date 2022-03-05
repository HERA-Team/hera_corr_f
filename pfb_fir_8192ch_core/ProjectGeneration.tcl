# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in System Generator. 
#


namespace eval ::xilinx::dsp::planaheaddriver {
	set Compilation {IP Catalog}
	set CompilationFlow {IP}
	set CreateInterfaceDocument {off}
	set DSPDevice {xc7k325t}
	set DSPFamily {kintex7}
	set DSPPackage {fbg676}
	set DSPSpeed {-3}
	set FPGAClockPeriod 10
	set GenerateTestBench 0
	set HDLLanguage {vhdl}
	set IPOOCCacheRootPath {/home/kocz/.Xilinx/Sysgen/SysgenVivado/lnx64.o/ip}
	set IP_Auto_Infer {1}
	set IP_Categories_Text {System_Generator_for_DSP}
	set IP_Common_Repos {0}
	set IP_Description {}
	set IP_Dir {}
	set IP_Library_Text {SysGen}
	set IP_LifeCycle_Menu {2}
	set IP_Logo {sysgen_icon_100.png}
	set IP_Name {}
	set IP_Revision {264546063}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {User_Company}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {pfb_fir_8192ch_core}
	set ProjectFiles {
		{{conv_pkg.vhd} -lib {xil_defaultlib}}
		{{synth_reg.vhd} -lib {xil_defaultlib}}
		{{synth_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{srl17e.vhd} -lib {xil_defaultlib}}
		{{srl33e.vhd} -lib {xil_defaultlib}}
		{{synth_reg_reg.vhd} -lib {xil_defaultlib}}
		{{single_reg_w_init.vhd} -lib {xil_defaultlib}}
		{{xlclockdriver_rd.vhd} -lib {xil_defaultlib}}
		{{vivado_ip.tcl}}
		{{xpm_b591c5_vivado.mem}}
		{{xpm_085f89_vivado.mem}}
		{{xpm_2a067a_vivado.mem}}
		{{xpm_8bdd51_vivado.mem}}
		{{xpm_24d74b_vivado.mem}}
		{{xpm_28b985_vivado.mem}}
		{{xpm_00361e_vivado.mem}}
		{{xpm_fdd2fa_vivado.mem}}
		{{xpm_26831e_vivado.mem}}
		{{xpm_97b9fc_vivado.mem}}
		{{xpm_09d550_vivado.mem}}
		{{xpm_0ba527_vivado.mem}}
		{{xpm_27c51a_vivado.mem}}
		{{xpm_41a3f3_vivado.mem}}
		{{xpm_27bcea_vivado.mem}}
		{{xpm_ed7be7_vivado.mem}}
		{{xpm_594fb6_vivado.mem}}
		{{xpm_4eb95b_vivado.mem}}
		{{xpm_a580d1_vivado.mem}}
		{{xpm_840a2f_vivado.mem}}
		{{xpm_97f6be_vivado.mem}}
		{{xpm_7a3863_vivado.mem}}
		{{xpm_00bad8_vivado.mem}}
		{{xpm_b19351_vivado.mem}}
		{{xpm_01b889_vivado.mem}}
		{{xpm_6edd36_vivado.mem}}
		{{xpm_fdb2fe_vivado.mem}}
		{{xpm_99c7cd_vivado.mem}}
		{{xpm_fc3b92_vivado.mem}}
		{{xpm_3407be_vivado.mem}}
		{{xpm_b41c5d_vivado.mem}}
		{{xpm_fcb056_vivado.mem}}
		{{xpm_f3ecb2_vivado.mem}}
		{{xpm_e9ac52_vivado.mem}}
		{{xpm_8a3683_vivado.mem}}
		{{xpm_4b6fda_vivado.mem}}
		{{xpm_1c5cde_vivado.mem}}
		{{xpm_1f8fc2_vivado.mem}}
		{{xpm_a7dc62_vivado.mem}}
		{{xpm_e12e42_vivado.mem}}
		{{xpm_2be436_vivado.mem}}
		{{xpm_7a5e25_vivado.mem}}
		{{xpm_60a890_vivado.mem}}
		{{xpm_b8ecfc_vivado.mem}}
		{{xpm_7055a8_vivado.mem}}
		{{xpm_fc3989_vivado.mem}}
		{{xpm_143592_vivado.mem}}
		{{xpm_c0b730_vivado.mem}}
		{{xpm_eb1976_vivado.mem}}
		{{xpm_79cec1_vivado.mem}}
		{{xpm_02948c_vivado.mem}}
		{{xpm_e15e47_vivado.mem}}
		{{xpm_5d48a2_vivado.mem}}
		{{xpm_8b256c_vivado.mem}}
		{{xpm_35cf89_vivado.mem}}
		{{xpm_9cb890_vivado.mem}}
		{{xpm_e3835e_vivado.mem}}
		{{xpm_5d81c0_vivado.mem}}
		{{xpm_3f8c05_vivado.mem}}
		{{xpm_4b5444_vivado.mem}}
		{{xpm_6a8440_vivado.mem}}
		{{xpm_54fbf7_vivado.mem}}
		{{xpm_c72eb8_vivado.mem}}
		{{xpm_e18f49_vivado.mem}}
		{{xpm_9f008d_vivado.mem}}
		{{pfb_fir_8192ch_core_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{pfb_fir_8192ch_core.vhd} -lib {xil_defaultlib}}
		{{pfb_fir_8192ch_core_clock.xdc}}
		{{pfb_fir_8192ch_core.xdc}}
	}
	set SimPeriod 1
	set SimTime 262144
	set SimulationTime {2621650.00000000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {/data/home/kocz/casper/models/hera_corr_f/pfb_fir_8192ch_core}
	set TopLevelModule {pfb_fir_8192ch_core}
	set TopLevelSimulinkHandle 74189
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface sync Name {sync}
	dict set TopLevelPortInterface sync Type UFix_32_0
	dict set TopLevelPortInterface sync ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync BinaryPoint 0
	dict set TopLevelPortInterface sync Width 32
	dict set TopLevelPortInterface sync DatFile {pfb_fir_8192ch_core_sync.dat}
	dict set TopLevelPortInterface sync IconText {sync}
	dict set TopLevelPortInterface sync Direction in
	dict set TopLevelPortInterface sync Period 1
	dict set TopLevelPortInterface sync Interface 0
	dict set TopLevelPortInterface sync InterfaceName {}
	dict set TopLevelPortInterface sync InterfaceString {DATA}
	dict set TopLevelPortInterface sync ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface sync Locs {}
	dict set TopLevelPortInterface sync IOStandard {}
	dict set TopLevelPortInterface pol0_in9 Name {pol0_in9}
	dict set TopLevelPortInterface pol0_in9 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in9 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in9 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in9 Width 8
	dict set TopLevelPortInterface pol0_in9 DatFile {pfb_fir_8192ch_core_pol0_in9.dat}
	dict set TopLevelPortInterface pol0_in9 IconText {pol0_in9}
	dict set TopLevelPortInterface pol0_in9 Direction in
	dict set TopLevelPortInterface pol0_in9 Period 1
	dict set TopLevelPortInterface pol0_in9 Interface 0
	dict set TopLevelPortInterface pol0_in9 InterfaceName {}
	dict set TopLevelPortInterface pol0_in9 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in9 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in9 Locs {}
	dict set TopLevelPortInterface pol0_in9 IOStandard {}
	dict set TopLevelPortInterface pol0_in8 Name {pol0_in8}
	dict set TopLevelPortInterface pol0_in8 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in8 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in8 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in8 Width 8
	dict set TopLevelPortInterface pol0_in8 DatFile {pfb_fir_8192ch_core_pol0_in8.dat}
	dict set TopLevelPortInterface pol0_in8 IconText {pol0_in8}
	dict set TopLevelPortInterface pol0_in8 Direction in
	dict set TopLevelPortInterface pol0_in8 Period 1
	dict set TopLevelPortInterface pol0_in8 Interface 0
	dict set TopLevelPortInterface pol0_in8 InterfaceName {}
	dict set TopLevelPortInterface pol0_in8 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in8 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in8 Locs {}
	dict set TopLevelPortInterface pol0_in8 IOStandard {}
	dict set TopLevelPortInterface pol0_in7 Name {pol0_in7}
	dict set TopLevelPortInterface pol0_in7 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in7 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in7 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in7 Width 8
	dict set TopLevelPortInterface pol0_in7 DatFile {pfb_fir_8192ch_core_pol0_in7.dat}
	dict set TopLevelPortInterface pol0_in7 IconText {pol0_in7}
	dict set TopLevelPortInterface pol0_in7 Direction in
	dict set TopLevelPortInterface pol0_in7 Period 1
	dict set TopLevelPortInterface pol0_in7 Interface 0
	dict set TopLevelPortInterface pol0_in7 InterfaceName {}
	dict set TopLevelPortInterface pol0_in7 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in7 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in7 Locs {}
	dict set TopLevelPortInterface pol0_in7 IOStandard {}
	dict set TopLevelPortInterface pol0_in6 Name {pol0_in6}
	dict set TopLevelPortInterface pol0_in6 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in6 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in6 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in6 Width 8
	dict set TopLevelPortInterface pol0_in6 DatFile {pfb_fir_8192ch_core_pol0_in6.dat}
	dict set TopLevelPortInterface pol0_in6 IconText {pol0_in6}
	dict set TopLevelPortInterface pol0_in6 Direction in
	dict set TopLevelPortInterface pol0_in6 Period 1
	dict set TopLevelPortInterface pol0_in6 Interface 0
	dict set TopLevelPortInterface pol0_in6 InterfaceName {}
	dict set TopLevelPortInterface pol0_in6 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in6 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in6 Locs {}
	dict set TopLevelPortInterface pol0_in6 IOStandard {}
	dict set TopLevelPortInterface pol0_in5 Name {pol0_in5}
	dict set TopLevelPortInterface pol0_in5 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in5 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in5 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in5 Width 8
	dict set TopLevelPortInterface pol0_in5 DatFile {pfb_fir_8192ch_core_pol0_in5.dat}
	dict set TopLevelPortInterface pol0_in5 IconText {pol0_in5}
	dict set TopLevelPortInterface pol0_in5 Direction in
	dict set TopLevelPortInterface pol0_in5 Period 1
	dict set TopLevelPortInterface pol0_in5 Interface 0
	dict set TopLevelPortInterface pol0_in5 InterfaceName {}
	dict set TopLevelPortInterface pol0_in5 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in5 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in5 Locs {}
	dict set TopLevelPortInterface pol0_in5 IOStandard {}
	dict set TopLevelPortInterface pol0_in4 Name {pol0_in4}
	dict set TopLevelPortInterface pol0_in4 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in4 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in4 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in4 Width 8
	dict set TopLevelPortInterface pol0_in4 DatFile {pfb_fir_8192ch_core_pol0_in4.dat}
	dict set TopLevelPortInterface pol0_in4 IconText {pol0_in4}
	dict set TopLevelPortInterface pol0_in4 Direction in
	dict set TopLevelPortInterface pol0_in4 Period 1
	dict set TopLevelPortInterface pol0_in4 Interface 0
	dict set TopLevelPortInterface pol0_in4 InterfaceName {}
	dict set TopLevelPortInterface pol0_in4 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in4 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in4 Locs {}
	dict set TopLevelPortInterface pol0_in4 IOStandard {}
	dict set TopLevelPortInterface pol0_in3 Name {pol0_in3}
	dict set TopLevelPortInterface pol0_in3 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in3 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in3 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in3 Width 8
	dict set TopLevelPortInterface pol0_in3 DatFile {pfb_fir_8192ch_core_pol0_in3.dat}
	dict set TopLevelPortInterface pol0_in3 IconText {pol0_in3}
	dict set TopLevelPortInterface pol0_in3 Direction in
	dict set TopLevelPortInterface pol0_in3 Period 1
	dict set TopLevelPortInterface pol0_in3 Interface 0
	dict set TopLevelPortInterface pol0_in3 InterfaceName {}
	dict set TopLevelPortInterface pol0_in3 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in3 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in3 Locs {}
	dict set TopLevelPortInterface pol0_in3 IOStandard {}
	dict set TopLevelPortInterface pol0_in2 Name {pol0_in2}
	dict set TopLevelPortInterface pol0_in2 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in2 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in2 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in2 Width 8
	dict set TopLevelPortInterface pol0_in2 DatFile {pfb_fir_8192ch_core_pol0_in2.dat}
	dict set TopLevelPortInterface pol0_in2 IconText {pol0_in2}
	dict set TopLevelPortInterface pol0_in2 Direction in
	dict set TopLevelPortInterface pol0_in2 Period 1
	dict set TopLevelPortInterface pol0_in2 Interface 0
	dict set TopLevelPortInterface pol0_in2 InterfaceName {}
	dict set TopLevelPortInterface pol0_in2 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in2 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in2 Locs {}
	dict set TopLevelPortInterface pol0_in2 IOStandard {}
	dict set TopLevelPortInterface pol0_in15 Name {pol0_in15}
	dict set TopLevelPortInterface pol0_in15 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in15 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in15 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in15 Width 8
	dict set TopLevelPortInterface pol0_in15 DatFile {pfb_fir_8192ch_core_pol0_in15.dat}
	dict set TopLevelPortInterface pol0_in15 IconText {pol0_in15}
	dict set TopLevelPortInterface pol0_in15 Direction in
	dict set TopLevelPortInterface pol0_in15 Period 1
	dict set TopLevelPortInterface pol0_in15 Interface 0
	dict set TopLevelPortInterface pol0_in15 InterfaceName {}
	dict set TopLevelPortInterface pol0_in15 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in15 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in15 Locs {}
	dict set TopLevelPortInterface pol0_in15 IOStandard {}
	dict set TopLevelPortInterface pol0_in14 Name {pol0_in14}
	dict set TopLevelPortInterface pol0_in14 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in14 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in14 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in14 Width 8
	dict set TopLevelPortInterface pol0_in14 DatFile {pfb_fir_8192ch_core_pol0_in14.dat}
	dict set TopLevelPortInterface pol0_in14 IconText {pol0_in14}
	dict set TopLevelPortInterface pol0_in14 Direction in
	dict set TopLevelPortInterface pol0_in14 Period 1
	dict set TopLevelPortInterface pol0_in14 Interface 0
	dict set TopLevelPortInterface pol0_in14 InterfaceName {}
	dict set TopLevelPortInterface pol0_in14 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in14 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in14 Locs {}
	dict set TopLevelPortInterface pol0_in14 IOStandard {}
	dict set TopLevelPortInterface pol0_in13 Name {pol0_in13}
	dict set TopLevelPortInterface pol0_in13 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in13 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in13 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in13 Width 8
	dict set TopLevelPortInterface pol0_in13 DatFile {pfb_fir_8192ch_core_pol0_in13.dat}
	dict set TopLevelPortInterface pol0_in13 IconText {pol0_in13}
	dict set TopLevelPortInterface pol0_in13 Direction in
	dict set TopLevelPortInterface pol0_in13 Period 1
	dict set TopLevelPortInterface pol0_in13 Interface 0
	dict set TopLevelPortInterface pol0_in13 InterfaceName {}
	dict set TopLevelPortInterface pol0_in13 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in13 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in13 Locs {}
	dict set TopLevelPortInterface pol0_in13 IOStandard {}
	dict set TopLevelPortInterface pol0_in12 Name {pol0_in12}
	dict set TopLevelPortInterface pol0_in12 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in12 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in12 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in12 Width 8
	dict set TopLevelPortInterface pol0_in12 DatFile {pfb_fir_8192ch_core_pol0_in12.dat}
	dict set TopLevelPortInterface pol0_in12 IconText {pol0_in12}
	dict set TopLevelPortInterface pol0_in12 Direction in
	dict set TopLevelPortInterface pol0_in12 Period 1
	dict set TopLevelPortInterface pol0_in12 Interface 0
	dict set TopLevelPortInterface pol0_in12 InterfaceName {}
	dict set TopLevelPortInterface pol0_in12 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in12 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in12 Locs {}
	dict set TopLevelPortInterface pol0_in12 IOStandard {}
	dict set TopLevelPortInterface pol0_in11 Name {pol0_in11}
	dict set TopLevelPortInterface pol0_in11 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in11 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in11 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in11 Width 8
	dict set TopLevelPortInterface pol0_in11 DatFile {pfb_fir_8192ch_core_pol0_in11.dat}
	dict set TopLevelPortInterface pol0_in11 IconText {pol0_in11}
	dict set TopLevelPortInterface pol0_in11 Direction in
	dict set TopLevelPortInterface pol0_in11 Period 1
	dict set TopLevelPortInterface pol0_in11 Interface 0
	dict set TopLevelPortInterface pol0_in11 InterfaceName {}
	dict set TopLevelPortInterface pol0_in11 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in11 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in11 Locs {}
	dict set TopLevelPortInterface pol0_in11 IOStandard {}
	dict set TopLevelPortInterface pol0_in10 Name {pol0_in10}
	dict set TopLevelPortInterface pol0_in10 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in10 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in10 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in10 Width 8
	dict set TopLevelPortInterface pol0_in10 DatFile {pfb_fir_8192ch_core_pol0_in10.dat}
	dict set TopLevelPortInterface pol0_in10 IconText {pol0_in10}
	dict set TopLevelPortInterface pol0_in10 Direction in
	dict set TopLevelPortInterface pol0_in10 Period 1
	dict set TopLevelPortInterface pol0_in10 Interface 0
	dict set TopLevelPortInterface pol0_in10 InterfaceName {}
	dict set TopLevelPortInterface pol0_in10 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in10 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in10 Locs {}
	dict set TopLevelPortInterface pol0_in10 IOStandard {}
	dict set TopLevelPortInterface pol0_in1 Name {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in1 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in1 Width 8
	dict set TopLevelPortInterface pol0_in1 DatFile {pfb_fir_8192ch_core_pol0_in1.dat}
	dict set TopLevelPortInterface pol0_in1 IconText {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Direction in
	dict set TopLevelPortInterface pol0_in1 Period 1
	dict set TopLevelPortInterface pol0_in1 Interface 0
	dict set TopLevelPortInterface pol0_in1 InterfaceName {}
	dict set TopLevelPortInterface pol0_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in1 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in1 Locs {}
	dict set TopLevelPortInterface pol0_in1 IOStandard {}
	dict set TopLevelPortInterface pol0_in0 Name {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in0 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in0 Width 8
	dict set TopLevelPortInterface pol0_in0 DatFile {pfb_fir_8192ch_core_pol0_in0.dat}
	dict set TopLevelPortInterface pol0_in0 IconText {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Direction in
	dict set TopLevelPortInterface pol0_in0 Period 1
	dict set TopLevelPortInterface pol0_in0 Interface 0
	dict set TopLevelPortInterface pol0_in0 InterfaceName {}
	dict set TopLevelPortInterface pol0_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in0 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_in0 Locs {}
	dict set TopLevelPortInterface pol0_in0 IOStandard {}
	dict set TopLevelPortInterface pol0_out0 Name {pol0_out0}
	dict set TopLevelPortInterface pol0_out0 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out0 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out0 Width 12
	dict set TopLevelPortInterface pol0_out0 DatFile {pfb_fir_8192ch_core_pol0_out0.dat}
	dict set TopLevelPortInterface pol0_out0 IconText {pol0_out0}
	dict set TopLevelPortInterface pol0_out0 Direction out
	dict set TopLevelPortInterface pol0_out0 Period 1
	dict set TopLevelPortInterface pol0_out0 Interface 0
	dict set TopLevelPortInterface pol0_out0 InterfaceName {}
	dict set TopLevelPortInterface pol0_out0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out0 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out0 Locs {}
	dict set TopLevelPortInterface pol0_out0 IOStandard {}
	dict set TopLevelPortInterface pol0_out1 Name {pol0_out1}
	dict set TopLevelPortInterface pol0_out1 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out1 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out1 Width 12
	dict set TopLevelPortInterface pol0_out1 DatFile {pfb_fir_8192ch_core_pol0_out1.dat}
	dict set TopLevelPortInterface pol0_out1 IconText {pol0_out1}
	dict set TopLevelPortInterface pol0_out1 Direction out
	dict set TopLevelPortInterface pol0_out1 Period 1
	dict set TopLevelPortInterface pol0_out1 Interface 0
	dict set TopLevelPortInterface pol0_out1 InterfaceName {}
	dict set TopLevelPortInterface pol0_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out1 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out1 Locs {}
	dict set TopLevelPortInterface pol0_out1 IOStandard {}
	dict set TopLevelPortInterface pol0_out10 Name {pol0_out10}
	dict set TopLevelPortInterface pol0_out10 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out10 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out10 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out10 Width 12
	dict set TopLevelPortInterface pol0_out10 DatFile {pfb_fir_8192ch_core_pol0_out10.dat}
	dict set TopLevelPortInterface pol0_out10 IconText {pol0_out10}
	dict set TopLevelPortInterface pol0_out10 Direction out
	dict set TopLevelPortInterface pol0_out10 Period 1
	dict set TopLevelPortInterface pol0_out10 Interface 0
	dict set TopLevelPortInterface pol0_out10 InterfaceName {}
	dict set TopLevelPortInterface pol0_out10 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out10 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out10 Locs {}
	dict set TopLevelPortInterface pol0_out10 IOStandard {}
	dict set TopLevelPortInterface pol0_out11 Name {pol0_out11}
	dict set TopLevelPortInterface pol0_out11 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out11 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out11 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out11 Width 12
	dict set TopLevelPortInterface pol0_out11 DatFile {pfb_fir_8192ch_core_pol0_out11.dat}
	dict set TopLevelPortInterface pol0_out11 IconText {pol0_out11}
	dict set TopLevelPortInterface pol0_out11 Direction out
	dict set TopLevelPortInterface pol0_out11 Period 1
	dict set TopLevelPortInterface pol0_out11 Interface 0
	dict set TopLevelPortInterface pol0_out11 InterfaceName {}
	dict set TopLevelPortInterface pol0_out11 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out11 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out11 Locs {}
	dict set TopLevelPortInterface pol0_out11 IOStandard {}
	dict set TopLevelPortInterface pol0_out12 Name {pol0_out12}
	dict set TopLevelPortInterface pol0_out12 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out12 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out12 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out12 Width 12
	dict set TopLevelPortInterface pol0_out12 DatFile {pfb_fir_8192ch_core_pol0_out12.dat}
	dict set TopLevelPortInterface pol0_out12 IconText {pol0_out12}
	dict set TopLevelPortInterface pol0_out12 Direction out
	dict set TopLevelPortInterface pol0_out12 Period 1
	dict set TopLevelPortInterface pol0_out12 Interface 0
	dict set TopLevelPortInterface pol0_out12 InterfaceName {}
	dict set TopLevelPortInterface pol0_out12 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out12 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out12 Locs {}
	dict set TopLevelPortInterface pol0_out12 IOStandard {}
	dict set TopLevelPortInterface pol0_out13 Name {pol0_out13}
	dict set TopLevelPortInterface pol0_out13 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out13 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out13 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out13 Width 12
	dict set TopLevelPortInterface pol0_out13 DatFile {pfb_fir_8192ch_core_pol0_out13.dat}
	dict set TopLevelPortInterface pol0_out13 IconText {pol0_out13}
	dict set TopLevelPortInterface pol0_out13 Direction out
	dict set TopLevelPortInterface pol0_out13 Period 1
	dict set TopLevelPortInterface pol0_out13 Interface 0
	dict set TopLevelPortInterface pol0_out13 InterfaceName {}
	dict set TopLevelPortInterface pol0_out13 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out13 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out13 Locs {}
	dict set TopLevelPortInterface pol0_out13 IOStandard {}
	dict set TopLevelPortInterface pol0_out14 Name {pol0_out14}
	dict set TopLevelPortInterface pol0_out14 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out14 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out14 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out14 Width 12
	dict set TopLevelPortInterface pol0_out14 DatFile {pfb_fir_8192ch_core_pol0_out14.dat}
	dict set TopLevelPortInterface pol0_out14 IconText {pol0_out14}
	dict set TopLevelPortInterface pol0_out14 Direction out
	dict set TopLevelPortInterface pol0_out14 Period 1
	dict set TopLevelPortInterface pol0_out14 Interface 0
	dict set TopLevelPortInterface pol0_out14 InterfaceName {}
	dict set TopLevelPortInterface pol0_out14 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out14 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out14 Locs {}
	dict set TopLevelPortInterface pol0_out14 IOStandard {}
	dict set TopLevelPortInterface pol0_out15 Name {pol0_out15}
	dict set TopLevelPortInterface pol0_out15 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out15 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out15 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out15 Width 12
	dict set TopLevelPortInterface pol0_out15 DatFile {pfb_fir_8192ch_core_pol0_out15.dat}
	dict set TopLevelPortInterface pol0_out15 IconText {pol0_out15}
	dict set TopLevelPortInterface pol0_out15 Direction out
	dict set TopLevelPortInterface pol0_out15 Period 1
	dict set TopLevelPortInterface pol0_out15 Interface 0
	dict set TopLevelPortInterface pol0_out15 InterfaceName {}
	dict set TopLevelPortInterface pol0_out15 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out15 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out15 Locs {}
	dict set TopLevelPortInterface pol0_out15 IOStandard {}
	dict set TopLevelPortInterface pol0_out2 Name {pol0_out2}
	dict set TopLevelPortInterface pol0_out2 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out2 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out2 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out2 Width 12
	dict set TopLevelPortInterface pol0_out2 DatFile {pfb_fir_8192ch_core_pol0_out2.dat}
	dict set TopLevelPortInterface pol0_out2 IconText {pol0_out2}
	dict set TopLevelPortInterface pol0_out2 Direction out
	dict set TopLevelPortInterface pol0_out2 Period 1
	dict set TopLevelPortInterface pol0_out2 Interface 0
	dict set TopLevelPortInterface pol0_out2 InterfaceName {}
	dict set TopLevelPortInterface pol0_out2 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out2 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out2 Locs {}
	dict set TopLevelPortInterface pol0_out2 IOStandard {}
	dict set TopLevelPortInterface pol0_out3 Name {pol0_out3}
	dict set TopLevelPortInterface pol0_out3 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out3 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out3 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out3 Width 12
	dict set TopLevelPortInterface pol0_out3 DatFile {pfb_fir_8192ch_core_pol0_out3.dat}
	dict set TopLevelPortInterface pol0_out3 IconText {pol0_out3}
	dict set TopLevelPortInterface pol0_out3 Direction out
	dict set TopLevelPortInterface pol0_out3 Period 1
	dict set TopLevelPortInterface pol0_out3 Interface 0
	dict set TopLevelPortInterface pol0_out3 InterfaceName {}
	dict set TopLevelPortInterface pol0_out3 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out3 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out3 Locs {}
	dict set TopLevelPortInterface pol0_out3 IOStandard {}
	dict set TopLevelPortInterface pol0_out4 Name {pol0_out4}
	dict set TopLevelPortInterface pol0_out4 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out4 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out4 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out4 Width 12
	dict set TopLevelPortInterface pol0_out4 DatFile {pfb_fir_8192ch_core_pol0_out4.dat}
	dict set TopLevelPortInterface pol0_out4 IconText {pol0_out4}
	dict set TopLevelPortInterface pol0_out4 Direction out
	dict set TopLevelPortInterface pol0_out4 Period 1
	dict set TopLevelPortInterface pol0_out4 Interface 0
	dict set TopLevelPortInterface pol0_out4 InterfaceName {}
	dict set TopLevelPortInterface pol0_out4 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out4 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out4 Locs {}
	dict set TopLevelPortInterface pol0_out4 IOStandard {}
	dict set TopLevelPortInterface pol0_out5 Name {pol0_out5}
	dict set TopLevelPortInterface pol0_out5 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out5 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out5 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out5 Width 12
	dict set TopLevelPortInterface pol0_out5 DatFile {pfb_fir_8192ch_core_pol0_out5.dat}
	dict set TopLevelPortInterface pol0_out5 IconText {pol0_out5}
	dict set TopLevelPortInterface pol0_out5 Direction out
	dict set TopLevelPortInterface pol0_out5 Period 1
	dict set TopLevelPortInterface pol0_out5 Interface 0
	dict set TopLevelPortInterface pol0_out5 InterfaceName {}
	dict set TopLevelPortInterface pol0_out5 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out5 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out5 Locs {}
	dict set TopLevelPortInterface pol0_out5 IOStandard {}
	dict set TopLevelPortInterface pol0_out6 Name {pol0_out6}
	dict set TopLevelPortInterface pol0_out6 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out6 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out6 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out6 Width 12
	dict set TopLevelPortInterface pol0_out6 DatFile {pfb_fir_8192ch_core_pol0_out6.dat}
	dict set TopLevelPortInterface pol0_out6 IconText {pol0_out6}
	dict set TopLevelPortInterface pol0_out6 Direction out
	dict set TopLevelPortInterface pol0_out6 Period 1
	dict set TopLevelPortInterface pol0_out6 Interface 0
	dict set TopLevelPortInterface pol0_out6 InterfaceName {}
	dict set TopLevelPortInterface pol0_out6 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out6 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out6 Locs {}
	dict set TopLevelPortInterface pol0_out6 IOStandard {}
	dict set TopLevelPortInterface pol0_out7 Name {pol0_out7}
	dict set TopLevelPortInterface pol0_out7 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out7 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out7 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out7 Width 12
	dict set TopLevelPortInterface pol0_out7 DatFile {pfb_fir_8192ch_core_pol0_out7.dat}
	dict set TopLevelPortInterface pol0_out7 IconText {pol0_out7}
	dict set TopLevelPortInterface pol0_out7 Direction out
	dict set TopLevelPortInterface pol0_out7 Period 1
	dict set TopLevelPortInterface pol0_out7 Interface 0
	dict set TopLevelPortInterface pol0_out7 InterfaceName {}
	dict set TopLevelPortInterface pol0_out7 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out7 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out7 Locs {}
	dict set TopLevelPortInterface pol0_out7 IOStandard {}
	dict set TopLevelPortInterface pol0_out8 Name {pol0_out8}
	dict set TopLevelPortInterface pol0_out8 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out8 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out8 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out8 Width 12
	dict set TopLevelPortInterface pol0_out8 DatFile {pfb_fir_8192ch_core_pol0_out8.dat}
	dict set TopLevelPortInterface pol0_out8 IconText {pol0_out8}
	dict set TopLevelPortInterface pol0_out8 Direction out
	dict set TopLevelPortInterface pol0_out8 Period 1
	dict set TopLevelPortInterface pol0_out8 Interface 0
	dict set TopLevelPortInterface pol0_out8 InterfaceName {}
	dict set TopLevelPortInterface pol0_out8 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out8 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out8 Locs {}
	dict set TopLevelPortInterface pol0_out8 IOStandard {}
	dict set TopLevelPortInterface pol0_out9 Name {pol0_out9}
	dict set TopLevelPortInterface pol0_out9 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out9 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out9 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out9 Width 12
	dict set TopLevelPortInterface pol0_out9 DatFile {pfb_fir_8192ch_core_pol0_out9.dat}
	dict set TopLevelPortInterface pol0_out9 IconText {pol0_out9}
	dict set TopLevelPortInterface pol0_out9 Direction out
	dict set TopLevelPortInterface pol0_out9 Period 1
	dict set TopLevelPortInterface pol0_out9 Interface 0
	dict set TopLevelPortInterface pol0_out9 InterfaceName {}
	dict set TopLevelPortInterface pol0_out9 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out9 ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface pol0_out9 Locs {}
	dict set TopLevelPortInterface pol0_out9 IOStandard {}
	dict set TopLevelPortInterface sync_out Name {sync_out}
	dict set TopLevelPortInterface sync_out Type Bool
	dict set TopLevelPortInterface sync_out ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync_out BinaryPoint 0
	dict set TopLevelPortInterface sync_out Width 1
	dict set TopLevelPortInterface sync_out DatFile {pfb_fir_8192ch_core_sync_out.dat}
	dict set TopLevelPortInterface sync_out IconText {sync_out}
	dict set TopLevelPortInterface sync_out Direction out
	dict set TopLevelPortInterface sync_out Period 1
	dict set TopLevelPortInterface sync_out Interface 0
	dict set TopLevelPortInterface sync_out InterfaceName {}
	dict set TopLevelPortInterface sync_out InterfaceString {DATA}
	dict set TopLevelPortInterface sync_out ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface sync_out Locs {}
	dict set TopLevelPortInterface sync_out IOStandard {}
	dict set TopLevelPortInterface clk Name {clk}
	dict set TopLevelPortInterface clk Type -
	dict set TopLevelPortInterface clk ArithmeticType xlUnsigned
	dict set TopLevelPortInterface clk BinaryPoint 0
	dict set TopLevelPortInterface clk Width 1
	dict set TopLevelPortInterface clk DatFile {}
	dict set TopLevelPortInterface clk Direction in
	dict set TopLevelPortInterface clk Period 1
	dict set TopLevelPortInterface clk Interface 6
	dict set TopLevelPortInterface clk InterfaceName {}
	dict set TopLevelPortInterface clk InterfaceString {CLOCK}
	dict set TopLevelPortInterface clk ClockDomain {pfb_fir_8192ch_core}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project