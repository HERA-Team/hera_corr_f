# Note: This file is produced automatically, and will be overwritten the next
# time you press "Generate" in System Generator. 
#


namespace eval ::xilinx::dsp::planaheaddriver {
	set Compilation {IP Catalog}
	set CompilationFlow {IP}
	set CreateInterfaceDocument {off}
	set DSPDevice {xc7k160t}
	set DSPFamily {kintex7}
	set DSPPackage {ffg676}
	set DSPSpeed {-2}
	set FPGAClockPeriod 100
	set GenerateTestBench 0
	set HDLLanguage {vhdl}
	set IPOOCCacheRootPath {/home/jackh/.Xilinx/Sysgen/SysgenVivado/lnx64.o/ip}
	set IP_Auto_Infer {1}
	set IP_Categories_Text {System_Generator_for_DSP}
	set IP_Common_Repos {0}
	set IP_Description {}
	set IP_Dir {}
	set IP_Library_Text {SysGen}
	set IP_LifeCycle_Menu {2}
	set IP_Logo {sysgen_icon_100.png}
	set IP_Name {}
	set IP_Revision {150469605}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {User_Company}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {fft_8192_1a_core}
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
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i0_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i1_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i2_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i3_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i4_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i5_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i0_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i1_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i2_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i3_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i6_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i7_vivado.coe}}
		{{fft_8192_1a_core_blk_mem_gen_v8_3_i8_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i4_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i5_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i6_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i7_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i8_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i9_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i10_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i11_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i12_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i13_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i14_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i15_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i16_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i17_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i18_vivado.coe}}
		{{fft_8192_1a_core_dist_mem_gen_v8_0_i19_vivado.coe}}
		{{fft_8192_1a_core_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{fft_8192_1a_core.vhd} -lib {xil_defaultlib}}
		{{fft_8192_1a_core_clock.xdc}}
		{{fft_8192_1a_core.xdc}}
	}
	set SimPeriod 1
	set SimTime 6144
	set SimulationTime {614700.00000000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {/home/jackh/herafengine/fft_8192_1a_core}
	set TopLevelModule {fft_8192_1a_core}
	set TopLevelSimulinkHandle 75505
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface sync Name {sync}
	dict set TopLevelPortInterface sync Type UFix_32_0
	dict set TopLevelPortInterface sync ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync BinaryPoint 0
	dict set TopLevelPortInterface sync Width 32
	dict set TopLevelPortInterface sync DatFile {fft_8192_1a_core_sync.dat}
	dict set TopLevelPortInterface sync IconText {sync}
	dict set TopLevelPortInterface sync Direction in
	dict set TopLevelPortInterface sync Period 1
	dict set TopLevelPortInterface sync Interface 0
	dict set TopLevelPortInterface sync InterfaceName {}
	dict set TopLevelPortInterface sync InterfaceString {DATA}
	dict set TopLevelPortInterface sync ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface sync Locs {}
	dict set TopLevelPortInterface sync IOStandard {}
	dict set TopLevelPortInterface shift Name {shift}
	dict set TopLevelPortInterface shift Type UFix_16_0
	dict set TopLevelPortInterface shift ArithmeticType xlUnsigned
	dict set TopLevelPortInterface shift BinaryPoint 0
	dict set TopLevelPortInterface shift Width 16
	dict set TopLevelPortInterface shift DatFile {fft_8192_1a_core_shift.dat}
	dict set TopLevelPortInterface shift IconText {shift}
	dict set TopLevelPortInterface shift Direction in
	dict set TopLevelPortInterface shift Period 1
	dict set TopLevelPortInterface shift Interface 0
	dict set TopLevelPortInterface shift InterfaceName {}
	dict set TopLevelPortInterface shift InterfaceString {DATA}
	dict set TopLevelPortInterface shift ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface shift Locs {}
	dict set TopLevelPortInterface shift IOStandard {}
	dict set TopLevelPortInterface pol0_in9 Name {pol0_in9}
	dict set TopLevelPortInterface pol0_in9 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in9 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in9 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in9 Width 12
	dict set TopLevelPortInterface pol0_in9 DatFile {fft_8192_1a_core_pol0_in9.dat}
	dict set TopLevelPortInterface pol0_in9 IconText {pol0_in9}
	dict set TopLevelPortInterface pol0_in9 Direction in
	dict set TopLevelPortInterface pol0_in9 Period 1
	dict set TopLevelPortInterface pol0_in9 Interface 0
	dict set TopLevelPortInterface pol0_in9 InterfaceName {}
	dict set TopLevelPortInterface pol0_in9 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in9 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in9 Locs {}
	dict set TopLevelPortInterface pol0_in9 IOStandard {}
	dict set TopLevelPortInterface pol0_in8 Name {pol0_in8}
	dict set TopLevelPortInterface pol0_in8 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in8 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in8 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in8 Width 12
	dict set TopLevelPortInterface pol0_in8 DatFile {fft_8192_1a_core_pol0_in8.dat}
	dict set TopLevelPortInterface pol0_in8 IconText {pol0_in8}
	dict set TopLevelPortInterface pol0_in8 Direction in
	dict set TopLevelPortInterface pol0_in8 Period 1
	dict set TopLevelPortInterface pol0_in8 Interface 0
	dict set TopLevelPortInterface pol0_in8 InterfaceName {}
	dict set TopLevelPortInterface pol0_in8 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in8 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in8 Locs {}
	dict set TopLevelPortInterface pol0_in8 IOStandard {}
	dict set TopLevelPortInterface pol0_in7 Name {pol0_in7}
	dict set TopLevelPortInterface pol0_in7 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in7 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in7 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in7 Width 12
	dict set TopLevelPortInterface pol0_in7 DatFile {fft_8192_1a_core_pol0_in7.dat}
	dict set TopLevelPortInterface pol0_in7 IconText {pol0_in7}
	dict set TopLevelPortInterface pol0_in7 Direction in
	dict set TopLevelPortInterface pol0_in7 Period 1
	dict set TopLevelPortInterface pol0_in7 Interface 0
	dict set TopLevelPortInterface pol0_in7 InterfaceName {}
	dict set TopLevelPortInterface pol0_in7 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in7 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in7 Locs {}
	dict set TopLevelPortInterface pol0_in7 IOStandard {}
	dict set TopLevelPortInterface pol0_in6 Name {pol0_in6}
	dict set TopLevelPortInterface pol0_in6 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in6 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in6 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in6 Width 12
	dict set TopLevelPortInterface pol0_in6 DatFile {fft_8192_1a_core_pol0_in6.dat}
	dict set TopLevelPortInterface pol0_in6 IconText {pol0_in6}
	dict set TopLevelPortInterface pol0_in6 Direction in
	dict set TopLevelPortInterface pol0_in6 Period 1
	dict set TopLevelPortInterface pol0_in6 Interface 0
	dict set TopLevelPortInterface pol0_in6 InterfaceName {}
	dict set TopLevelPortInterface pol0_in6 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in6 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in6 Locs {}
	dict set TopLevelPortInterface pol0_in6 IOStandard {}
	dict set TopLevelPortInterface pol0_in5 Name {pol0_in5}
	dict set TopLevelPortInterface pol0_in5 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in5 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in5 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in5 Width 12
	dict set TopLevelPortInterface pol0_in5 DatFile {fft_8192_1a_core_pol0_in5.dat}
	dict set TopLevelPortInterface pol0_in5 IconText {pol0_in5}
	dict set TopLevelPortInterface pol0_in5 Direction in
	dict set TopLevelPortInterface pol0_in5 Period 1
	dict set TopLevelPortInterface pol0_in5 Interface 0
	dict set TopLevelPortInterface pol0_in5 InterfaceName {}
	dict set TopLevelPortInterface pol0_in5 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in5 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in5 Locs {}
	dict set TopLevelPortInterface pol0_in5 IOStandard {}
	dict set TopLevelPortInterface pol0_in4 Name {pol0_in4}
	dict set TopLevelPortInterface pol0_in4 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in4 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in4 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in4 Width 12
	dict set TopLevelPortInterface pol0_in4 DatFile {fft_8192_1a_core_pol0_in4.dat}
	dict set TopLevelPortInterface pol0_in4 IconText {pol0_in4}
	dict set TopLevelPortInterface pol0_in4 Direction in
	dict set TopLevelPortInterface pol0_in4 Period 1
	dict set TopLevelPortInterface pol0_in4 Interface 0
	dict set TopLevelPortInterface pol0_in4 InterfaceName {}
	dict set TopLevelPortInterface pol0_in4 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in4 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in4 Locs {}
	dict set TopLevelPortInterface pol0_in4 IOStandard {}
	dict set TopLevelPortInterface pol0_in3 Name {pol0_in3}
	dict set TopLevelPortInterface pol0_in3 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in3 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in3 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in3 Width 12
	dict set TopLevelPortInterface pol0_in3 DatFile {fft_8192_1a_core_pol0_in3.dat}
	dict set TopLevelPortInterface pol0_in3 IconText {pol0_in3}
	dict set TopLevelPortInterface pol0_in3 Direction in
	dict set TopLevelPortInterface pol0_in3 Period 1
	dict set TopLevelPortInterface pol0_in3 Interface 0
	dict set TopLevelPortInterface pol0_in3 InterfaceName {}
	dict set TopLevelPortInterface pol0_in3 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in3 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in3 Locs {}
	dict set TopLevelPortInterface pol0_in3 IOStandard {}
	dict set TopLevelPortInterface pol0_in2 Name {pol0_in2}
	dict set TopLevelPortInterface pol0_in2 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in2 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in2 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in2 Width 12
	dict set TopLevelPortInterface pol0_in2 DatFile {fft_8192_1a_core_pol0_in2.dat}
	dict set TopLevelPortInterface pol0_in2 IconText {pol0_in2}
	dict set TopLevelPortInterface pol0_in2 Direction in
	dict set TopLevelPortInterface pol0_in2 Period 1
	dict set TopLevelPortInterface pol0_in2 Interface 0
	dict set TopLevelPortInterface pol0_in2 InterfaceName {}
	dict set TopLevelPortInterface pol0_in2 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in2 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in2 Locs {}
	dict set TopLevelPortInterface pol0_in2 IOStandard {}
	dict set TopLevelPortInterface pol0_in15 Name {pol0_in15}
	dict set TopLevelPortInterface pol0_in15 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in15 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in15 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in15 Width 12
	dict set TopLevelPortInterface pol0_in15 DatFile {fft_8192_1a_core_pol0_in15.dat}
	dict set TopLevelPortInterface pol0_in15 IconText {pol0_in15}
	dict set TopLevelPortInterface pol0_in15 Direction in
	dict set TopLevelPortInterface pol0_in15 Period 1
	dict set TopLevelPortInterface pol0_in15 Interface 0
	dict set TopLevelPortInterface pol0_in15 InterfaceName {}
	dict set TopLevelPortInterface pol0_in15 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in15 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in15 Locs {}
	dict set TopLevelPortInterface pol0_in15 IOStandard {}
	dict set TopLevelPortInterface pol0_in14 Name {pol0_in14}
	dict set TopLevelPortInterface pol0_in14 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in14 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in14 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in14 Width 12
	dict set TopLevelPortInterface pol0_in14 DatFile {fft_8192_1a_core_pol0_in14.dat}
	dict set TopLevelPortInterface pol0_in14 IconText {pol0_in14}
	dict set TopLevelPortInterface pol0_in14 Direction in
	dict set TopLevelPortInterface pol0_in14 Period 1
	dict set TopLevelPortInterface pol0_in14 Interface 0
	dict set TopLevelPortInterface pol0_in14 InterfaceName {}
	dict set TopLevelPortInterface pol0_in14 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in14 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in14 Locs {}
	dict set TopLevelPortInterface pol0_in14 IOStandard {}
	dict set TopLevelPortInterface pol0_in13 Name {pol0_in13}
	dict set TopLevelPortInterface pol0_in13 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in13 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in13 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in13 Width 12
	dict set TopLevelPortInterface pol0_in13 DatFile {fft_8192_1a_core_pol0_in13.dat}
	dict set TopLevelPortInterface pol0_in13 IconText {pol0_in13}
	dict set TopLevelPortInterface pol0_in13 Direction in
	dict set TopLevelPortInterface pol0_in13 Period 1
	dict set TopLevelPortInterface pol0_in13 Interface 0
	dict set TopLevelPortInterface pol0_in13 InterfaceName {}
	dict set TopLevelPortInterface pol0_in13 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in13 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in13 Locs {}
	dict set TopLevelPortInterface pol0_in13 IOStandard {}
	dict set TopLevelPortInterface pol0_in12 Name {pol0_in12}
	dict set TopLevelPortInterface pol0_in12 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in12 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in12 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in12 Width 12
	dict set TopLevelPortInterface pol0_in12 DatFile {fft_8192_1a_core_pol0_in12.dat}
	dict set TopLevelPortInterface pol0_in12 IconText {pol0_in12}
	dict set TopLevelPortInterface pol0_in12 Direction in
	dict set TopLevelPortInterface pol0_in12 Period 1
	dict set TopLevelPortInterface pol0_in12 Interface 0
	dict set TopLevelPortInterface pol0_in12 InterfaceName {}
	dict set TopLevelPortInterface pol0_in12 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in12 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in12 Locs {}
	dict set TopLevelPortInterface pol0_in12 IOStandard {}
	dict set TopLevelPortInterface pol0_in11 Name {pol0_in11}
	dict set TopLevelPortInterface pol0_in11 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in11 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in11 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in11 Width 12
	dict set TopLevelPortInterface pol0_in11 DatFile {fft_8192_1a_core_pol0_in11.dat}
	dict set TopLevelPortInterface pol0_in11 IconText {pol0_in11}
	dict set TopLevelPortInterface pol0_in11 Direction in
	dict set TopLevelPortInterface pol0_in11 Period 1
	dict set TopLevelPortInterface pol0_in11 Interface 0
	dict set TopLevelPortInterface pol0_in11 InterfaceName {}
	dict set TopLevelPortInterface pol0_in11 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in11 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in11 Locs {}
	dict set TopLevelPortInterface pol0_in11 IOStandard {}
	dict set TopLevelPortInterface pol0_in10 Name {pol0_in10}
	dict set TopLevelPortInterface pol0_in10 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in10 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in10 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in10 Width 12
	dict set TopLevelPortInterface pol0_in10 DatFile {fft_8192_1a_core_pol0_in10.dat}
	dict set TopLevelPortInterface pol0_in10 IconText {pol0_in10}
	dict set TopLevelPortInterface pol0_in10 Direction in
	dict set TopLevelPortInterface pol0_in10 Period 1
	dict set TopLevelPortInterface pol0_in10 Interface 0
	dict set TopLevelPortInterface pol0_in10 InterfaceName {}
	dict set TopLevelPortInterface pol0_in10 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in10 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in10 Locs {}
	dict set TopLevelPortInterface pol0_in10 IOStandard {}
	dict set TopLevelPortInterface pol0_in1 Name {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in1 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in1 Width 12
	dict set TopLevelPortInterface pol0_in1 DatFile {fft_8192_1a_core_pol0_in1.dat}
	dict set TopLevelPortInterface pol0_in1 IconText {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Direction in
	dict set TopLevelPortInterface pol0_in1 Period 1
	dict set TopLevelPortInterface pol0_in1 Interface 0
	dict set TopLevelPortInterface pol0_in1 InterfaceName {}
	dict set TopLevelPortInterface pol0_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in1 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in1 Locs {}
	dict set TopLevelPortInterface pol0_in1 IOStandard {}
	dict set TopLevelPortInterface pol0_in0 Name {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in0 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in0 Width 12
	dict set TopLevelPortInterface pol0_in0 DatFile {fft_8192_1a_core_pol0_in0.dat}
	dict set TopLevelPortInterface pol0_in0 IconText {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Direction in
	dict set TopLevelPortInterface pol0_in0 Period 1
	dict set TopLevelPortInterface pol0_in0 Interface 0
	dict set TopLevelPortInterface pol0_in0 InterfaceName {}
	dict set TopLevelPortInterface pol0_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in0 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface pol0_in0 Locs {}
	dict set TopLevelPortInterface pol0_in0 IOStandard {}
	dict set TopLevelPortInterface out0 Name {out0}
	dict set TopLevelPortInterface out0 Type UFix_36_0
	dict set TopLevelPortInterface out0 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out0 BinaryPoint 0
	dict set TopLevelPortInterface out0 Width 36
	dict set TopLevelPortInterface out0 DatFile {fft_8192_1a_core_out0.dat}
	dict set TopLevelPortInterface out0 IconText {out0}
	dict set TopLevelPortInterface out0 Direction out
	dict set TopLevelPortInterface out0 Period 1
	dict set TopLevelPortInterface out0 Interface 0
	dict set TopLevelPortInterface out0 InterfaceName {}
	dict set TopLevelPortInterface out0 InterfaceString {DATA}
	dict set TopLevelPortInterface out0 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out0 Locs {}
	dict set TopLevelPortInterface out0 IOStandard {}
	dict set TopLevelPortInterface out1 Name {out1}
	dict set TopLevelPortInterface out1 Type UFix_36_0
	dict set TopLevelPortInterface out1 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out1 BinaryPoint 0
	dict set TopLevelPortInterface out1 Width 36
	dict set TopLevelPortInterface out1 DatFile {fft_8192_1a_core_out1.dat}
	dict set TopLevelPortInterface out1 IconText {out1}
	dict set TopLevelPortInterface out1 Direction out
	dict set TopLevelPortInterface out1 Period 1
	dict set TopLevelPortInterface out1 Interface 0
	dict set TopLevelPortInterface out1 InterfaceName {}
	dict set TopLevelPortInterface out1 InterfaceString {DATA}
	dict set TopLevelPortInterface out1 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out1 Locs {}
	dict set TopLevelPortInterface out1 IOStandard {}
	dict set TopLevelPortInterface out2 Name {out2}
	dict set TopLevelPortInterface out2 Type UFix_36_0
	dict set TopLevelPortInterface out2 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out2 BinaryPoint 0
	dict set TopLevelPortInterface out2 Width 36
	dict set TopLevelPortInterface out2 DatFile {fft_8192_1a_core_out2.dat}
	dict set TopLevelPortInterface out2 IconText {out2}
	dict set TopLevelPortInterface out2 Direction out
	dict set TopLevelPortInterface out2 Period 1
	dict set TopLevelPortInterface out2 Interface 0
	dict set TopLevelPortInterface out2 InterfaceName {}
	dict set TopLevelPortInterface out2 InterfaceString {DATA}
	dict set TopLevelPortInterface out2 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out2 Locs {}
	dict set TopLevelPortInterface out2 IOStandard {}
	dict set TopLevelPortInterface out3 Name {out3}
	dict set TopLevelPortInterface out3 Type UFix_36_0
	dict set TopLevelPortInterface out3 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out3 BinaryPoint 0
	dict set TopLevelPortInterface out3 Width 36
	dict set TopLevelPortInterface out3 DatFile {fft_8192_1a_core_out3.dat}
	dict set TopLevelPortInterface out3 IconText {out3}
	dict set TopLevelPortInterface out3 Direction out
	dict set TopLevelPortInterface out3 Period 1
	dict set TopLevelPortInterface out3 Interface 0
	dict set TopLevelPortInterface out3 InterfaceName {}
	dict set TopLevelPortInterface out3 InterfaceString {DATA}
	dict set TopLevelPortInterface out3 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out3 Locs {}
	dict set TopLevelPortInterface out3 IOStandard {}
	dict set TopLevelPortInterface out4 Name {out4}
	dict set TopLevelPortInterface out4 Type UFix_36_0
	dict set TopLevelPortInterface out4 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out4 BinaryPoint 0
	dict set TopLevelPortInterface out4 Width 36
	dict set TopLevelPortInterface out4 DatFile {fft_8192_1a_core_out4.dat}
	dict set TopLevelPortInterface out4 IconText {out4}
	dict set TopLevelPortInterface out4 Direction out
	dict set TopLevelPortInterface out4 Period 1
	dict set TopLevelPortInterface out4 Interface 0
	dict set TopLevelPortInterface out4 InterfaceName {}
	dict set TopLevelPortInterface out4 InterfaceString {DATA}
	dict set TopLevelPortInterface out4 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out4 Locs {}
	dict set TopLevelPortInterface out4 IOStandard {}
	dict set TopLevelPortInterface out5 Name {out5}
	dict set TopLevelPortInterface out5 Type UFix_36_0
	dict set TopLevelPortInterface out5 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out5 BinaryPoint 0
	dict set TopLevelPortInterface out5 Width 36
	dict set TopLevelPortInterface out5 DatFile {fft_8192_1a_core_out5.dat}
	dict set TopLevelPortInterface out5 IconText {out5}
	dict set TopLevelPortInterface out5 Direction out
	dict set TopLevelPortInterface out5 Period 1
	dict set TopLevelPortInterface out5 Interface 0
	dict set TopLevelPortInterface out5 InterfaceName {}
	dict set TopLevelPortInterface out5 InterfaceString {DATA}
	dict set TopLevelPortInterface out5 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out5 Locs {}
	dict set TopLevelPortInterface out5 IOStandard {}
	dict set TopLevelPortInterface out6 Name {out6}
	dict set TopLevelPortInterface out6 Type UFix_36_0
	dict set TopLevelPortInterface out6 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out6 BinaryPoint 0
	dict set TopLevelPortInterface out6 Width 36
	dict set TopLevelPortInterface out6 DatFile {fft_8192_1a_core_out6.dat}
	dict set TopLevelPortInterface out6 IconText {out6}
	dict set TopLevelPortInterface out6 Direction out
	dict set TopLevelPortInterface out6 Period 1
	dict set TopLevelPortInterface out6 Interface 0
	dict set TopLevelPortInterface out6 InterfaceName {}
	dict set TopLevelPortInterface out6 InterfaceString {DATA}
	dict set TopLevelPortInterface out6 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out6 Locs {}
	dict set TopLevelPortInterface out6 IOStandard {}
	dict set TopLevelPortInterface out7 Name {out7}
	dict set TopLevelPortInterface out7 Type UFix_36_0
	dict set TopLevelPortInterface out7 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out7 BinaryPoint 0
	dict set TopLevelPortInterface out7 Width 36
	dict set TopLevelPortInterface out7 DatFile {fft_8192_1a_core_out7.dat}
	dict set TopLevelPortInterface out7 IconText {out7}
	dict set TopLevelPortInterface out7 Direction out
	dict set TopLevelPortInterface out7 Period 1
	dict set TopLevelPortInterface out7 Interface 0
	dict set TopLevelPortInterface out7 InterfaceName {}
	dict set TopLevelPortInterface out7 InterfaceString {DATA}
	dict set TopLevelPortInterface out7 ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface out7 Locs {}
	dict set TopLevelPortInterface out7 IOStandard {}
	dict set TopLevelPortInterface overflow Name {overflow}
	dict set TopLevelPortInterface overflow Type UFix_4_0
	dict set TopLevelPortInterface overflow ArithmeticType xlUnsigned
	dict set TopLevelPortInterface overflow BinaryPoint 0
	dict set TopLevelPortInterface overflow Width 4
	dict set TopLevelPortInterface overflow DatFile {fft_8192_1a_core_overflow.dat}
	dict set TopLevelPortInterface overflow IconText {overflow}
	dict set TopLevelPortInterface overflow Direction out
	dict set TopLevelPortInterface overflow Period 1
	dict set TopLevelPortInterface overflow Interface 0
	dict set TopLevelPortInterface overflow InterfaceName {}
	dict set TopLevelPortInterface overflow InterfaceString {DATA}
	dict set TopLevelPortInterface overflow ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface overflow Locs {}
	dict set TopLevelPortInterface overflow IOStandard {}
	dict set TopLevelPortInterface sync_out Name {sync_out}
	dict set TopLevelPortInterface sync_out Type Bool
	dict set TopLevelPortInterface sync_out ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync_out BinaryPoint 0
	dict set TopLevelPortInterface sync_out Width 1
	dict set TopLevelPortInterface sync_out DatFile {fft_8192_1a_core_sync_out.dat}
	dict set TopLevelPortInterface sync_out IconText {sync_out}
	dict set TopLevelPortInterface sync_out Direction out
	dict set TopLevelPortInterface sync_out Period 1
	dict set TopLevelPortInterface sync_out Interface 0
	dict set TopLevelPortInterface sync_out InterfaceName {}
	dict set TopLevelPortInterface sync_out InterfaceString {DATA}
	dict set TopLevelPortInterface sync_out ClockDomain {fft_8192_1a_core}
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
	dict set TopLevelPortInterface clk ClockDomain {fft_8192_1a_core}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project