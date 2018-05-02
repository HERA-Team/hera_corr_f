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
	set FPGAClockPeriod 5
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
	set IP_Revision {149164447}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {User_Company}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {pfb_fir_gen_8192ch_core}
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
		{{pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i0_vivado.coe}}
		{{pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i1_vivado.coe}}
		{{pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i2_vivado.coe}}
		{{pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i3_vivado.coe}}
		{{pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i4_vivado.coe}}
		{{pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i5_vivado.coe}}
		{{pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6_vivado.coe}}
		{{pfb_fir_gen_8192ch_core_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{pfb_fir_gen_8192ch_core.vhd} -lib {xil_defaultlib}}
		{{pfb_fir_gen_8192ch_core_clock.xdc}}
		{{pfb_fir_gen_8192ch_core.xdc}}
	}
	set SimPeriod 1
	set SimTime 10
	set SimulationTime {255.00000000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {/home/jackh/herafengine/pfb_fir_gen_8192ch_core}
	set TopLevelModule {pfb_fir_gen_8192ch_core}
	set TopLevelSimulinkHandle 96688
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface pol5_in1 Name {pol5_in1}
	dict set TopLevelPortInterface pol5_in1 Type Fix_8_7
	dict set TopLevelPortInterface pol5_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol5_in1 BinaryPoint 7
	dict set TopLevelPortInterface pol5_in1 Width 8
	dict set TopLevelPortInterface pol5_in1 DatFile {pfb_fir_gen_8192ch_core_pol5_in1.dat}
	dict set TopLevelPortInterface pol5_in1 IconText {pol5_in1}
	dict set TopLevelPortInterface pol5_in1 Direction in
	dict set TopLevelPortInterface pol5_in1 Period 1
	dict set TopLevelPortInterface pol5_in1 Interface 0
	dict set TopLevelPortInterface pol5_in1 InterfaceName {}
	dict set TopLevelPortInterface pol5_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol5_in1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol5_in1 Locs {}
	dict set TopLevelPortInterface pol5_in1 IOStandard {}
	dict set TopLevelPortInterface pol4_in1 Name {pol4_in1}
	dict set TopLevelPortInterface pol4_in1 Type Fix_8_7
	dict set TopLevelPortInterface pol4_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol4_in1 BinaryPoint 7
	dict set TopLevelPortInterface pol4_in1 Width 8
	dict set TopLevelPortInterface pol4_in1 DatFile {pfb_fir_gen_8192ch_core_pol4_in1.dat}
	dict set TopLevelPortInterface pol4_in1 IconText {pol4_in1}
	dict set TopLevelPortInterface pol4_in1 Direction in
	dict set TopLevelPortInterface pol4_in1 Period 1
	dict set TopLevelPortInterface pol4_in1 Interface 0
	dict set TopLevelPortInterface pol4_in1 InterfaceName {}
	dict set TopLevelPortInterface pol4_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol4_in1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol4_in1 Locs {}
	dict set TopLevelPortInterface pol4_in1 IOStandard {}
	dict set TopLevelPortInterface pol5_in0 Name {pol5_in0}
	dict set TopLevelPortInterface pol5_in0 Type Fix_8_7
	dict set TopLevelPortInterface pol5_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol5_in0 BinaryPoint 7
	dict set TopLevelPortInterface pol5_in0 Width 8
	dict set TopLevelPortInterface pol5_in0 DatFile {pfb_fir_gen_8192ch_core_pol5_in0.dat}
	dict set TopLevelPortInterface pol5_in0 IconText {pol5_in0}
	dict set TopLevelPortInterface pol5_in0 Direction in
	dict set TopLevelPortInterface pol5_in0 Period 1
	dict set TopLevelPortInterface pol5_in0 Interface 0
	dict set TopLevelPortInterface pol5_in0 InterfaceName {}
	dict set TopLevelPortInterface pol5_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol5_in0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol5_in0 Locs {}
	dict set TopLevelPortInterface pol5_in0 IOStandard {}
	dict set TopLevelPortInterface pol4_in0 Name {pol4_in0}
	dict set TopLevelPortInterface pol4_in0 Type Fix_8_7
	dict set TopLevelPortInterface pol4_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol4_in0 BinaryPoint 7
	dict set TopLevelPortInterface pol4_in0 Width 8
	dict set TopLevelPortInterface pol4_in0 DatFile {pfb_fir_gen_8192ch_core_pol4_in0.dat}
	dict set TopLevelPortInterface pol4_in0 IconText {pol4_in0}
	dict set TopLevelPortInterface pol4_in0 Direction in
	dict set TopLevelPortInterface pol4_in0 Period 1
	dict set TopLevelPortInterface pol4_in0 Interface 0
	dict set TopLevelPortInterface pol4_in0 InterfaceName {}
	dict set TopLevelPortInterface pol4_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol4_in0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol4_in0 Locs {}
	dict set TopLevelPortInterface pol4_in0 IOStandard {}
	dict set TopLevelPortInterface sync Name {sync}
	dict set TopLevelPortInterface sync Type UFix_32_0
	dict set TopLevelPortInterface sync ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync BinaryPoint 0
	dict set TopLevelPortInterface sync Width 32
	dict set TopLevelPortInterface sync DatFile {pfb_fir_gen_8192ch_core_sync.dat}
	dict set TopLevelPortInterface sync IconText {sync}
	dict set TopLevelPortInterface sync Direction in
	dict set TopLevelPortInterface sync Period 1
	dict set TopLevelPortInterface sync Interface 0
	dict set TopLevelPortInterface sync InterfaceName {}
	dict set TopLevelPortInterface sync InterfaceString {DATA}
	dict set TopLevelPortInterface sync ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface sync Locs {}
	dict set TopLevelPortInterface sync IOStandard {}
	dict set TopLevelPortInterface pol3_in1 Name {pol3_in1}
	dict set TopLevelPortInterface pol3_in1 Type Fix_8_7
	dict set TopLevelPortInterface pol3_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol3_in1 BinaryPoint 7
	dict set TopLevelPortInterface pol3_in1 Width 8
	dict set TopLevelPortInterface pol3_in1 DatFile {pfb_fir_gen_8192ch_core_pol3_in1.dat}
	dict set TopLevelPortInterface pol3_in1 IconText {pol3_in1}
	dict set TopLevelPortInterface pol3_in1 Direction in
	dict set TopLevelPortInterface pol3_in1 Period 1
	dict set TopLevelPortInterface pol3_in1 Interface 0
	dict set TopLevelPortInterface pol3_in1 InterfaceName {}
	dict set TopLevelPortInterface pol3_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol3_in1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol3_in1 Locs {}
	dict set TopLevelPortInterface pol3_in1 IOStandard {}
	dict set TopLevelPortInterface pol3_in0 Name {pol3_in0}
	dict set TopLevelPortInterface pol3_in0 Type Fix_8_7
	dict set TopLevelPortInterface pol3_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol3_in0 BinaryPoint 7
	dict set TopLevelPortInterface pol3_in0 Width 8
	dict set TopLevelPortInterface pol3_in0 DatFile {pfb_fir_gen_8192ch_core_pol3_in0.dat}
	dict set TopLevelPortInterface pol3_in0 IconText {pol3_in0}
	dict set TopLevelPortInterface pol3_in0 Direction in
	dict set TopLevelPortInterface pol3_in0 Period 1
	dict set TopLevelPortInterface pol3_in0 Interface 0
	dict set TopLevelPortInterface pol3_in0 InterfaceName {}
	dict set TopLevelPortInterface pol3_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol3_in0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol3_in0 Locs {}
	dict set TopLevelPortInterface pol3_in0 IOStandard {}
	dict set TopLevelPortInterface pol2_in1 Name {pol2_in1}
	dict set TopLevelPortInterface pol2_in1 Type Fix_8_7
	dict set TopLevelPortInterface pol2_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol2_in1 BinaryPoint 7
	dict set TopLevelPortInterface pol2_in1 Width 8
	dict set TopLevelPortInterface pol2_in1 DatFile {pfb_fir_gen_8192ch_core_pol2_in1.dat}
	dict set TopLevelPortInterface pol2_in1 IconText {pol2_in1}
	dict set TopLevelPortInterface pol2_in1 Direction in
	dict set TopLevelPortInterface pol2_in1 Period 1
	dict set TopLevelPortInterface pol2_in1 Interface 0
	dict set TopLevelPortInterface pol2_in1 InterfaceName {}
	dict set TopLevelPortInterface pol2_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol2_in1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol2_in1 Locs {}
	dict set TopLevelPortInterface pol2_in1 IOStandard {}
	dict set TopLevelPortInterface pol2_in0 Name {pol2_in0}
	dict set TopLevelPortInterface pol2_in0 Type Fix_8_7
	dict set TopLevelPortInterface pol2_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol2_in0 BinaryPoint 7
	dict set TopLevelPortInterface pol2_in0 Width 8
	dict set TopLevelPortInterface pol2_in0 DatFile {pfb_fir_gen_8192ch_core_pol2_in0.dat}
	dict set TopLevelPortInterface pol2_in0 IconText {pol2_in0}
	dict set TopLevelPortInterface pol2_in0 Direction in
	dict set TopLevelPortInterface pol2_in0 Period 1
	dict set TopLevelPortInterface pol2_in0 Interface 0
	dict set TopLevelPortInterface pol2_in0 InterfaceName {}
	dict set TopLevelPortInterface pol2_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol2_in0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol2_in0 Locs {}
	dict set TopLevelPortInterface pol2_in0 IOStandard {}
	dict set TopLevelPortInterface pol1_in1 Name {pol1_in1}
	dict set TopLevelPortInterface pol1_in1 Type Fix_8_7
	dict set TopLevelPortInterface pol1_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol1_in1 BinaryPoint 7
	dict set TopLevelPortInterface pol1_in1 Width 8
	dict set TopLevelPortInterface pol1_in1 DatFile {pfb_fir_gen_8192ch_core_pol1_in1.dat}
	dict set TopLevelPortInterface pol1_in1 IconText {pol1_in1}
	dict set TopLevelPortInterface pol1_in1 Direction in
	dict set TopLevelPortInterface pol1_in1 Period 1
	dict set TopLevelPortInterface pol1_in1 Interface 0
	dict set TopLevelPortInterface pol1_in1 InterfaceName {}
	dict set TopLevelPortInterface pol1_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol1_in1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol1_in1 Locs {}
	dict set TopLevelPortInterface pol1_in1 IOStandard {}
	dict set TopLevelPortInterface pol1_in0 Name {pol1_in0}
	dict set TopLevelPortInterface pol1_in0 Type Fix_8_7
	dict set TopLevelPortInterface pol1_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol1_in0 BinaryPoint 7
	dict set TopLevelPortInterface pol1_in0 Width 8
	dict set TopLevelPortInterface pol1_in0 DatFile {pfb_fir_gen_8192ch_core_pol1_in0.dat}
	dict set TopLevelPortInterface pol1_in0 IconText {pol1_in0}
	dict set TopLevelPortInterface pol1_in0 Direction in
	dict set TopLevelPortInterface pol1_in0 Period 1
	dict set TopLevelPortInterface pol1_in0 Interface 0
	dict set TopLevelPortInterface pol1_in0 InterfaceName {}
	dict set TopLevelPortInterface pol1_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol1_in0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol1_in0 Locs {}
	dict set TopLevelPortInterface pol1_in0 IOStandard {}
	dict set TopLevelPortInterface pol0_in1 Name {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in1 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in1 Width 8
	dict set TopLevelPortInterface pol0_in1 DatFile {pfb_fir_gen_8192ch_core_pol0_in1.dat}
	dict set TopLevelPortInterface pol0_in1 IconText {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Direction in
	dict set TopLevelPortInterface pol0_in1 Period 1
	dict set TopLevelPortInterface pol0_in1 Interface 0
	dict set TopLevelPortInterface pol0_in1 InterfaceName {}
	dict set TopLevelPortInterface pol0_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol0_in1 Locs {}
	dict set TopLevelPortInterface pol0_in1 IOStandard {}
	dict set TopLevelPortInterface pol0_in0 Name {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Type Fix_8_7
	dict set TopLevelPortInterface pol0_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in0 BinaryPoint 7
	dict set TopLevelPortInterface pol0_in0 Width 8
	dict set TopLevelPortInterface pol0_in0 DatFile {pfb_fir_gen_8192ch_core_pol0_in0.dat}
	dict set TopLevelPortInterface pol0_in0 IconText {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Direction in
	dict set TopLevelPortInterface pol0_in0 Period 1
	dict set TopLevelPortInterface pol0_in0 Interface 0
	dict set TopLevelPortInterface pol0_in0 InterfaceName {}
	dict set TopLevelPortInterface pol0_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol0_in0 Locs {}
	dict set TopLevelPortInterface pol0_in0 IOStandard {}
	dict set TopLevelPortInterface pol0_out0 Name {pol0_out0}
	dict set TopLevelPortInterface pol0_out0 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out0 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out0 Width 12
	dict set TopLevelPortInterface pol0_out0 DatFile {pfb_fir_gen_8192ch_core_pol0_out0.dat}
	dict set TopLevelPortInterface pol0_out0 IconText {pol0_out0}
	dict set TopLevelPortInterface pol0_out0 Direction out
	dict set TopLevelPortInterface pol0_out0 Period 1
	dict set TopLevelPortInterface pol0_out0 Interface 0
	dict set TopLevelPortInterface pol0_out0 InterfaceName {}
	dict set TopLevelPortInterface pol0_out0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol0_out0 Locs {}
	dict set TopLevelPortInterface pol0_out0 IOStandard {}
	dict set TopLevelPortInterface pol0_out1 Name {pol0_out1}
	dict set TopLevelPortInterface pol0_out1 Type Fix_12_11
	dict set TopLevelPortInterface pol0_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_out1 BinaryPoint 11
	dict set TopLevelPortInterface pol0_out1 Width 12
	dict set TopLevelPortInterface pol0_out1 DatFile {pfb_fir_gen_8192ch_core_pol0_out1.dat}
	dict set TopLevelPortInterface pol0_out1 IconText {pol0_out1}
	dict set TopLevelPortInterface pol0_out1 Direction out
	dict set TopLevelPortInterface pol0_out1 Period 1
	dict set TopLevelPortInterface pol0_out1 Interface 0
	dict set TopLevelPortInterface pol0_out1 InterfaceName {}
	dict set TopLevelPortInterface pol0_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_out1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol0_out1 Locs {}
	dict set TopLevelPortInterface pol0_out1 IOStandard {}
	dict set TopLevelPortInterface pol1_out0 Name {pol1_out0}
	dict set TopLevelPortInterface pol1_out0 Type Fix_12_11
	dict set TopLevelPortInterface pol1_out0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol1_out0 BinaryPoint 11
	dict set TopLevelPortInterface pol1_out0 Width 12
	dict set TopLevelPortInterface pol1_out0 DatFile {pfb_fir_gen_8192ch_core_pol1_out0.dat}
	dict set TopLevelPortInterface pol1_out0 IconText {pol1_out0}
	dict set TopLevelPortInterface pol1_out0 Direction out
	dict set TopLevelPortInterface pol1_out0 Period 1
	dict set TopLevelPortInterface pol1_out0 Interface 0
	dict set TopLevelPortInterface pol1_out0 InterfaceName {}
	dict set TopLevelPortInterface pol1_out0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol1_out0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol1_out0 Locs {}
	dict set TopLevelPortInterface pol1_out0 IOStandard {}
	dict set TopLevelPortInterface pol1_out1 Name {pol1_out1}
	dict set TopLevelPortInterface pol1_out1 Type Fix_12_11
	dict set TopLevelPortInterface pol1_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol1_out1 BinaryPoint 11
	dict set TopLevelPortInterface pol1_out1 Width 12
	dict set TopLevelPortInterface pol1_out1 DatFile {pfb_fir_gen_8192ch_core_pol1_out1.dat}
	dict set TopLevelPortInterface pol1_out1 IconText {pol1_out1}
	dict set TopLevelPortInterface pol1_out1 Direction out
	dict set TopLevelPortInterface pol1_out1 Period 1
	dict set TopLevelPortInterface pol1_out1 Interface 0
	dict set TopLevelPortInterface pol1_out1 InterfaceName {}
	dict set TopLevelPortInterface pol1_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol1_out1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol1_out1 Locs {}
	dict set TopLevelPortInterface pol1_out1 IOStandard {}
	dict set TopLevelPortInterface pol2_out0 Name {pol2_out0}
	dict set TopLevelPortInterface pol2_out0 Type Fix_12_11
	dict set TopLevelPortInterface pol2_out0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol2_out0 BinaryPoint 11
	dict set TopLevelPortInterface pol2_out0 Width 12
	dict set TopLevelPortInterface pol2_out0 DatFile {pfb_fir_gen_8192ch_core_pol2_out0.dat}
	dict set TopLevelPortInterface pol2_out0 IconText {pol2_out0}
	dict set TopLevelPortInterface pol2_out0 Direction out
	dict set TopLevelPortInterface pol2_out0 Period 1
	dict set TopLevelPortInterface pol2_out0 Interface 0
	dict set TopLevelPortInterface pol2_out0 InterfaceName {}
	dict set TopLevelPortInterface pol2_out0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol2_out0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol2_out0 Locs {}
	dict set TopLevelPortInterface pol2_out0 IOStandard {}
	dict set TopLevelPortInterface pol2_out1 Name {pol2_out1}
	dict set TopLevelPortInterface pol2_out1 Type Fix_12_11
	dict set TopLevelPortInterface pol2_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol2_out1 BinaryPoint 11
	dict set TopLevelPortInterface pol2_out1 Width 12
	dict set TopLevelPortInterface pol2_out1 DatFile {pfb_fir_gen_8192ch_core_pol2_out1.dat}
	dict set TopLevelPortInterface pol2_out1 IconText {pol2_out1}
	dict set TopLevelPortInterface pol2_out1 Direction out
	dict set TopLevelPortInterface pol2_out1 Period 1
	dict set TopLevelPortInterface pol2_out1 Interface 0
	dict set TopLevelPortInterface pol2_out1 InterfaceName {}
	dict set TopLevelPortInterface pol2_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol2_out1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol2_out1 Locs {}
	dict set TopLevelPortInterface pol2_out1 IOStandard {}
	dict set TopLevelPortInterface pol3_out0 Name {pol3_out0}
	dict set TopLevelPortInterface pol3_out0 Type Fix_12_11
	dict set TopLevelPortInterface pol3_out0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol3_out0 BinaryPoint 11
	dict set TopLevelPortInterface pol3_out0 Width 12
	dict set TopLevelPortInterface pol3_out0 DatFile {pfb_fir_gen_8192ch_core_pol3_out0.dat}
	dict set TopLevelPortInterface pol3_out0 IconText {pol3_out0}
	dict set TopLevelPortInterface pol3_out0 Direction out
	dict set TopLevelPortInterface pol3_out0 Period 1
	dict set TopLevelPortInterface pol3_out0 Interface 0
	dict set TopLevelPortInterface pol3_out0 InterfaceName {}
	dict set TopLevelPortInterface pol3_out0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol3_out0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol3_out0 Locs {}
	dict set TopLevelPortInterface pol3_out0 IOStandard {}
	dict set TopLevelPortInterface pol3_out1 Name {pol3_out1}
	dict set TopLevelPortInterface pol3_out1 Type Fix_12_11
	dict set TopLevelPortInterface pol3_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol3_out1 BinaryPoint 11
	dict set TopLevelPortInterface pol3_out1 Width 12
	dict set TopLevelPortInterface pol3_out1 DatFile {pfb_fir_gen_8192ch_core_pol3_out1.dat}
	dict set TopLevelPortInterface pol3_out1 IconText {pol3_out1}
	dict set TopLevelPortInterface pol3_out1 Direction out
	dict set TopLevelPortInterface pol3_out1 Period 1
	dict set TopLevelPortInterface pol3_out1 Interface 0
	dict set TopLevelPortInterface pol3_out1 InterfaceName {}
	dict set TopLevelPortInterface pol3_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol3_out1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol3_out1 Locs {}
	dict set TopLevelPortInterface pol3_out1 IOStandard {}
	dict set TopLevelPortInterface sync_out Name {sync_out}
	dict set TopLevelPortInterface sync_out Type Bool
	dict set TopLevelPortInterface sync_out ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync_out BinaryPoint 0
	dict set TopLevelPortInterface sync_out Width 1
	dict set TopLevelPortInterface sync_out DatFile {pfb_fir_gen_8192ch_core_sync_out.dat}
	dict set TopLevelPortInterface sync_out IconText {sync_out}
	dict set TopLevelPortInterface sync_out Direction out
	dict set TopLevelPortInterface sync_out Period 1
	dict set TopLevelPortInterface sync_out Interface 0
	dict set TopLevelPortInterface sync_out InterfaceName {}
	dict set TopLevelPortInterface sync_out InterfaceString {DATA}
	dict set TopLevelPortInterface sync_out ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface sync_out Locs {}
	dict set TopLevelPortInterface sync_out IOStandard {}
	dict set TopLevelPortInterface pol4_out0 Name {pol4_out0}
	dict set TopLevelPortInterface pol4_out0 Type Fix_12_11
	dict set TopLevelPortInterface pol4_out0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol4_out0 BinaryPoint 11
	dict set TopLevelPortInterface pol4_out0 Width 12
	dict set TopLevelPortInterface pol4_out0 DatFile {pfb_fir_gen_8192ch_core_pol4_out0.dat}
	dict set TopLevelPortInterface pol4_out0 IconText {pol4_out0}
	dict set TopLevelPortInterface pol4_out0 Direction out
	dict set TopLevelPortInterface pol4_out0 Period 1
	dict set TopLevelPortInterface pol4_out0 Interface 0
	dict set TopLevelPortInterface pol4_out0 InterfaceName {}
	dict set TopLevelPortInterface pol4_out0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol4_out0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol4_out0 Locs {}
	dict set TopLevelPortInterface pol4_out0 IOStandard {}
	dict set TopLevelPortInterface pol5_out0 Name {pol5_out0}
	dict set TopLevelPortInterface pol5_out0 Type Fix_12_11
	dict set TopLevelPortInterface pol5_out0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol5_out0 BinaryPoint 11
	dict set TopLevelPortInterface pol5_out0 Width 12
	dict set TopLevelPortInterface pol5_out0 DatFile {pfb_fir_gen_8192ch_core_pol5_out0.dat}
	dict set TopLevelPortInterface pol5_out0 IconText {pol5_out0}
	dict set TopLevelPortInterface pol5_out0 Direction out
	dict set TopLevelPortInterface pol5_out0 Period 1
	dict set TopLevelPortInterface pol5_out0 Interface 0
	dict set TopLevelPortInterface pol5_out0 InterfaceName {}
	dict set TopLevelPortInterface pol5_out0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol5_out0 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol5_out0 Locs {}
	dict set TopLevelPortInterface pol5_out0 IOStandard {}
	dict set TopLevelPortInterface pol4_out1 Name {pol4_out1}
	dict set TopLevelPortInterface pol4_out1 Type Fix_12_11
	dict set TopLevelPortInterface pol4_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol4_out1 BinaryPoint 11
	dict set TopLevelPortInterface pol4_out1 Width 12
	dict set TopLevelPortInterface pol4_out1 DatFile {pfb_fir_gen_8192ch_core_pol4_out1.dat}
	dict set TopLevelPortInterface pol4_out1 IconText {pol4_out1}
	dict set TopLevelPortInterface pol4_out1 Direction out
	dict set TopLevelPortInterface pol4_out1 Period 1
	dict set TopLevelPortInterface pol4_out1 Interface 0
	dict set TopLevelPortInterface pol4_out1 InterfaceName {}
	dict set TopLevelPortInterface pol4_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol4_out1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol4_out1 Locs {}
	dict set TopLevelPortInterface pol4_out1 IOStandard {}
	dict set TopLevelPortInterface pol5_out1 Name {pol5_out1}
	dict set TopLevelPortInterface pol5_out1 Type Fix_12_11
	dict set TopLevelPortInterface pol5_out1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol5_out1 BinaryPoint 11
	dict set TopLevelPortInterface pol5_out1 Width 12
	dict set TopLevelPortInterface pol5_out1 DatFile {pfb_fir_gen_8192ch_core_pol5_out1.dat}
	dict set TopLevelPortInterface pol5_out1 IconText {pol5_out1}
	dict set TopLevelPortInterface pol5_out1 Direction out
	dict set TopLevelPortInterface pol5_out1 Period 1
	dict set TopLevelPortInterface pol5_out1 Interface 0
	dict set TopLevelPortInterface pol5_out1 InterfaceName {}
	dict set TopLevelPortInterface pol5_out1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol5_out1 ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface pol5_out1 Locs {}
	dict set TopLevelPortInterface pol5_out1 IOStandard {}
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
	dict set TopLevelPortInterface clk ClockDomain {pfb_fir_gen_8192ch_core}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project