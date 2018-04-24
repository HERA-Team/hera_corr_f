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
	set IP_Revision {150307412}
	set IP_Socket_IP {0}
	set IP_Socket_IP_Proj_Path {}
	set IP_Vendor_Text {User_Company}
	set IP_Version_Text {1.0}
	set ImplStrategyName {Vivado Implementation Defaults}
	set PostProjectCreationProc {dsp_package_for_vivado_ip_integrator}
	set Project {fft_2048ch_6a_core}
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
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i0_vivado.coe}}
		{{fft_2048ch_6a_core_dist_mem_gen_v8_0_i0_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i1_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i2_vivado.coe}}
		{{fft_2048ch_6a_core_dist_mem_gen_v8_0_i1_vivado.coe}}
		{{fft_2048ch_6a_core_dist_mem_gen_v8_0_i2_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i3_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i4_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i5_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i6_vivado.coe}}
		{{fft_2048ch_6a_core_dist_mem_gen_v8_0_i3_vivado.coe}}
		{{fft_2048ch_6a_core_dist_mem_gen_v8_0_i4_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i7_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i8_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i9_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i10_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i11_vivado.coe}}
		{{fft_2048ch_6a_core_blk_mem_gen_v8_3_i12_vivado.coe}}
		{{fft_2048ch_6a_core_dist_mem_gen_v8_0_i5_vivado.coe}}
		{{fft_2048ch_6a_core_entity_declarations.vhd} -lib {xil_defaultlib}}
		{{fft_2048ch_6a_core.vhd} -lib {xil_defaultlib}}
		{{fft_2048ch_6a_core_clock.xdc}}
		{{fft_2048ch_6a_core.xdc}}
	}
	set SimPeriod 1
	set SimTime 6144
	set SimulationTime {614700.00000000 ns}
	set SynthStrategyName {Vivado Synthesis Defaults}
	set SynthesisTool {Vivado}
	set TargetDir {/home/jackh/herafengine/fft_2048ch_6a_core}
	set TopLevelModule {fft_2048ch_6a_core}
	set TopLevelSimulinkHandle 217067
	set VHDLLib {xil_defaultlib}
	set TopLevelPortInterface {}
	dict set TopLevelPortInterface sync Name {sync}
	dict set TopLevelPortInterface sync Type UFix_32_0
	dict set TopLevelPortInterface sync ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync BinaryPoint 0
	dict set TopLevelPortInterface sync Width 32
	dict set TopLevelPortInterface sync DatFile {fft_2048ch_6a_core_sync.dat}
	dict set TopLevelPortInterface sync IconText {sync}
	dict set TopLevelPortInterface sync Direction in
	dict set TopLevelPortInterface sync Period 1
	dict set TopLevelPortInterface sync Interface 0
	dict set TopLevelPortInterface sync InterfaceName {}
	dict set TopLevelPortInterface sync InterfaceString {DATA}
	dict set TopLevelPortInterface sync ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface sync Locs {}
	dict set TopLevelPortInterface sync IOStandard {}
	dict set TopLevelPortInterface shift Name {shift}
	dict set TopLevelPortInterface shift Type UFix_16_0
	dict set TopLevelPortInterface shift ArithmeticType xlUnsigned
	dict set TopLevelPortInterface shift BinaryPoint 0
	dict set TopLevelPortInterface shift Width 16
	dict set TopLevelPortInterface shift DatFile {fft_2048ch_6a_core_shift.dat}
	dict set TopLevelPortInterface shift IconText {shift}
	dict set TopLevelPortInterface shift Direction in
	dict set TopLevelPortInterface shift Period 1
	dict set TopLevelPortInterface shift Interface 0
	dict set TopLevelPortInterface shift InterfaceName {}
	dict set TopLevelPortInterface shift InterfaceString {DATA}
	dict set TopLevelPortInterface shift ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface shift Locs {}
	dict set TopLevelPortInterface shift IOStandard {}
	dict set TopLevelPortInterface pol5_in1 Name {pol5_in1}
	dict set TopLevelPortInterface pol5_in1 Type Fix_12_11
	dict set TopLevelPortInterface pol5_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol5_in1 BinaryPoint 11
	dict set TopLevelPortInterface pol5_in1 Width 12
	dict set TopLevelPortInterface pol5_in1 DatFile {fft_2048ch_6a_core_pol5_in1.dat}
	dict set TopLevelPortInterface pol5_in1 IconText {pol5_in1}
	dict set TopLevelPortInterface pol5_in1 Direction in
	dict set TopLevelPortInterface pol5_in1 Period 1
	dict set TopLevelPortInterface pol5_in1 Interface 0
	dict set TopLevelPortInterface pol5_in1 InterfaceName {}
	dict set TopLevelPortInterface pol5_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol5_in1 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol5_in1 Locs {}
	dict set TopLevelPortInterface pol5_in1 IOStandard {}
	dict set TopLevelPortInterface pol5_in0 Name {pol5_in0}
	dict set TopLevelPortInterface pol5_in0 Type Fix_12_11
	dict set TopLevelPortInterface pol5_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol5_in0 BinaryPoint 11
	dict set TopLevelPortInterface pol5_in0 Width 12
	dict set TopLevelPortInterface pol5_in0 DatFile {fft_2048ch_6a_core_pol5_in0.dat}
	dict set TopLevelPortInterface pol5_in0 IconText {pol5_in0}
	dict set TopLevelPortInterface pol5_in0 Direction in
	dict set TopLevelPortInterface pol5_in0 Period 1
	dict set TopLevelPortInterface pol5_in0 Interface 0
	dict set TopLevelPortInterface pol5_in0 InterfaceName {}
	dict set TopLevelPortInterface pol5_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol5_in0 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol5_in0 Locs {}
	dict set TopLevelPortInterface pol5_in0 IOStandard {}
	dict set TopLevelPortInterface pol4_in1 Name {pol4_in1}
	dict set TopLevelPortInterface pol4_in1 Type Fix_12_11
	dict set TopLevelPortInterface pol4_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol4_in1 BinaryPoint 11
	dict set TopLevelPortInterface pol4_in1 Width 12
	dict set TopLevelPortInterface pol4_in1 DatFile {fft_2048ch_6a_core_pol4_in1.dat}
	dict set TopLevelPortInterface pol4_in1 IconText {pol4_in1}
	dict set TopLevelPortInterface pol4_in1 Direction in
	dict set TopLevelPortInterface pol4_in1 Period 1
	dict set TopLevelPortInterface pol4_in1 Interface 0
	dict set TopLevelPortInterface pol4_in1 InterfaceName {}
	dict set TopLevelPortInterface pol4_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol4_in1 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol4_in1 Locs {}
	dict set TopLevelPortInterface pol4_in1 IOStandard {}
	dict set TopLevelPortInterface pol4_in0 Name {pol4_in0}
	dict set TopLevelPortInterface pol4_in0 Type Fix_12_11
	dict set TopLevelPortInterface pol4_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol4_in0 BinaryPoint 11
	dict set TopLevelPortInterface pol4_in0 Width 12
	dict set TopLevelPortInterface pol4_in0 DatFile {fft_2048ch_6a_core_pol4_in0.dat}
	dict set TopLevelPortInterface pol4_in0 IconText {pol4_in0}
	dict set TopLevelPortInterface pol4_in0 Direction in
	dict set TopLevelPortInterface pol4_in0 Period 1
	dict set TopLevelPortInterface pol4_in0 Interface 0
	dict set TopLevelPortInterface pol4_in0 InterfaceName {}
	dict set TopLevelPortInterface pol4_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol4_in0 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol4_in0 Locs {}
	dict set TopLevelPortInterface pol4_in0 IOStandard {}
	dict set TopLevelPortInterface pol3_in1 Name {pol3_in1}
	dict set TopLevelPortInterface pol3_in1 Type Fix_12_11
	dict set TopLevelPortInterface pol3_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol3_in1 BinaryPoint 11
	dict set TopLevelPortInterface pol3_in1 Width 12
	dict set TopLevelPortInterface pol3_in1 DatFile {fft_2048ch_6a_core_pol3_in1.dat}
	dict set TopLevelPortInterface pol3_in1 IconText {pol3_in1}
	dict set TopLevelPortInterface pol3_in1 Direction in
	dict set TopLevelPortInterface pol3_in1 Period 1
	dict set TopLevelPortInterface pol3_in1 Interface 0
	dict set TopLevelPortInterface pol3_in1 InterfaceName {}
	dict set TopLevelPortInterface pol3_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol3_in1 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol3_in1 Locs {}
	dict set TopLevelPortInterface pol3_in1 IOStandard {}
	dict set TopLevelPortInterface pol3_in0 Name {pol3_in0}
	dict set TopLevelPortInterface pol3_in0 Type Fix_12_11
	dict set TopLevelPortInterface pol3_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol3_in0 BinaryPoint 11
	dict set TopLevelPortInterface pol3_in0 Width 12
	dict set TopLevelPortInterface pol3_in0 DatFile {fft_2048ch_6a_core_pol3_in0.dat}
	dict set TopLevelPortInterface pol3_in0 IconText {pol3_in0}
	dict set TopLevelPortInterface pol3_in0 Direction in
	dict set TopLevelPortInterface pol3_in0 Period 1
	dict set TopLevelPortInterface pol3_in0 Interface 0
	dict set TopLevelPortInterface pol3_in0 InterfaceName {}
	dict set TopLevelPortInterface pol3_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol3_in0 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol3_in0 Locs {}
	dict set TopLevelPortInterface pol3_in0 IOStandard {}
	dict set TopLevelPortInterface pol2_in1 Name {pol2_in1}
	dict set TopLevelPortInterface pol2_in1 Type Fix_12_11
	dict set TopLevelPortInterface pol2_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol2_in1 BinaryPoint 11
	dict set TopLevelPortInterface pol2_in1 Width 12
	dict set TopLevelPortInterface pol2_in1 DatFile {fft_2048ch_6a_core_pol2_in1.dat}
	dict set TopLevelPortInterface pol2_in1 IconText {pol2_in1}
	dict set TopLevelPortInterface pol2_in1 Direction in
	dict set TopLevelPortInterface pol2_in1 Period 1
	dict set TopLevelPortInterface pol2_in1 Interface 0
	dict set TopLevelPortInterface pol2_in1 InterfaceName {}
	dict set TopLevelPortInterface pol2_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol2_in1 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol2_in1 Locs {}
	dict set TopLevelPortInterface pol2_in1 IOStandard {}
	dict set TopLevelPortInterface pol2_in0 Name {pol2_in0}
	dict set TopLevelPortInterface pol2_in0 Type Fix_12_11
	dict set TopLevelPortInterface pol2_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol2_in0 BinaryPoint 11
	dict set TopLevelPortInterface pol2_in0 Width 12
	dict set TopLevelPortInterface pol2_in0 DatFile {fft_2048ch_6a_core_pol2_in0.dat}
	dict set TopLevelPortInterface pol2_in0 IconText {pol2_in0}
	dict set TopLevelPortInterface pol2_in0 Direction in
	dict set TopLevelPortInterface pol2_in0 Period 1
	dict set TopLevelPortInterface pol2_in0 Interface 0
	dict set TopLevelPortInterface pol2_in0 InterfaceName {}
	dict set TopLevelPortInterface pol2_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol2_in0 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol2_in0 Locs {}
	dict set TopLevelPortInterface pol2_in0 IOStandard {}
	dict set TopLevelPortInterface pol1_in1 Name {pol1_in1}
	dict set TopLevelPortInterface pol1_in1 Type Fix_12_11
	dict set TopLevelPortInterface pol1_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol1_in1 BinaryPoint 11
	dict set TopLevelPortInterface pol1_in1 Width 12
	dict set TopLevelPortInterface pol1_in1 DatFile {fft_2048ch_6a_core_pol1_in1.dat}
	dict set TopLevelPortInterface pol1_in1 IconText {pol1_in1}
	dict set TopLevelPortInterface pol1_in1 Direction in
	dict set TopLevelPortInterface pol1_in1 Period 1
	dict set TopLevelPortInterface pol1_in1 Interface 0
	dict set TopLevelPortInterface pol1_in1 InterfaceName {}
	dict set TopLevelPortInterface pol1_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol1_in1 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol1_in1 Locs {}
	dict set TopLevelPortInterface pol1_in1 IOStandard {}
	dict set TopLevelPortInterface pol1_in0 Name {pol1_in0}
	dict set TopLevelPortInterface pol1_in0 Type Fix_12_11
	dict set TopLevelPortInterface pol1_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol1_in0 BinaryPoint 11
	dict set TopLevelPortInterface pol1_in0 Width 12
	dict set TopLevelPortInterface pol1_in0 DatFile {fft_2048ch_6a_core_pol1_in0.dat}
	dict set TopLevelPortInterface pol1_in0 IconText {pol1_in0}
	dict set TopLevelPortInterface pol1_in0 Direction in
	dict set TopLevelPortInterface pol1_in0 Period 1
	dict set TopLevelPortInterface pol1_in0 Interface 0
	dict set TopLevelPortInterface pol1_in0 InterfaceName {}
	dict set TopLevelPortInterface pol1_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol1_in0 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol1_in0 Locs {}
	dict set TopLevelPortInterface pol1_in0 IOStandard {}
	dict set TopLevelPortInterface pol0_in1 Name {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in1 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in1 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in1 Width 12
	dict set TopLevelPortInterface pol0_in1 DatFile {fft_2048ch_6a_core_pol0_in1.dat}
	dict set TopLevelPortInterface pol0_in1 IconText {pol0_in1}
	dict set TopLevelPortInterface pol0_in1 Direction in
	dict set TopLevelPortInterface pol0_in1 Period 1
	dict set TopLevelPortInterface pol0_in1 Interface 0
	dict set TopLevelPortInterface pol0_in1 InterfaceName {}
	dict set TopLevelPortInterface pol0_in1 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in1 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol0_in1 Locs {}
	dict set TopLevelPortInterface pol0_in1 IOStandard {}
	dict set TopLevelPortInterface pol0_in0 Name {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Type Fix_12_11
	dict set TopLevelPortInterface pol0_in0 ArithmeticType xlSigned
	dict set TopLevelPortInterface pol0_in0 BinaryPoint 11
	dict set TopLevelPortInterface pol0_in0 Width 12
	dict set TopLevelPortInterface pol0_in0 DatFile {fft_2048ch_6a_core_pol0_in0.dat}
	dict set TopLevelPortInterface pol0_in0 IconText {pol0_in0}
	dict set TopLevelPortInterface pol0_in0 Direction in
	dict set TopLevelPortInterface pol0_in0 Period 1
	dict set TopLevelPortInterface pol0_in0 Interface 0
	dict set TopLevelPortInterface pol0_in0 InterfaceName {}
	dict set TopLevelPortInterface pol0_in0 InterfaceString {DATA}
	dict set TopLevelPortInterface pol0_in0 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface pol0_in0 Locs {}
	dict set TopLevelPortInterface pol0_in0 IOStandard {}
	dict set TopLevelPortInterface out0 Name {out0}
	dict set TopLevelPortInterface out0 Type UFix_38_0
	dict set TopLevelPortInterface out0 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out0 BinaryPoint 0
	dict set TopLevelPortInterface out0 Width 38
	dict set TopLevelPortInterface out0 DatFile {fft_2048ch_6a_core_out0.dat}
	dict set TopLevelPortInterface out0 IconText {out0}
	dict set TopLevelPortInterface out0 Direction out
	dict set TopLevelPortInterface out0 Period 1
	dict set TopLevelPortInterface out0 Interface 0
	dict set TopLevelPortInterface out0 InterfaceName {}
	dict set TopLevelPortInterface out0 InterfaceString {DATA}
	dict set TopLevelPortInterface out0 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface out0 Locs {}
	dict set TopLevelPortInterface out0 IOStandard {}
	dict set TopLevelPortInterface out1 Name {out1}
	dict set TopLevelPortInterface out1 Type UFix_38_0
	dict set TopLevelPortInterface out1 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out1 BinaryPoint 0
	dict set TopLevelPortInterface out1 Width 38
	dict set TopLevelPortInterface out1 DatFile {fft_2048ch_6a_core_out1.dat}
	dict set TopLevelPortInterface out1 IconText {out1}
	dict set TopLevelPortInterface out1 Direction out
	dict set TopLevelPortInterface out1 Period 1
	dict set TopLevelPortInterface out1 Interface 0
	dict set TopLevelPortInterface out1 InterfaceName {}
	dict set TopLevelPortInterface out1 InterfaceString {DATA}
	dict set TopLevelPortInterface out1 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface out1 Locs {}
	dict set TopLevelPortInterface out1 IOStandard {}
	dict set TopLevelPortInterface out2 Name {out2}
	dict set TopLevelPortInterface out2 Type UFix_38_0
	dict set TopLevelPortInterface out2 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out2 BinaryPoint 0
	dict set TopLevelPortInterface out2 Width 38
	dict set TopLevelPortInterface out2 DatFile {fft_2048ch_6a_core_out2.dat}
	dict set TopLevelPortInterface out2 IconText {out2}
	dict set TopLevelPortInterface out2 Direction out
	dict set TopLevelPortInterface out2 Period 1
	dict set TopLevelPortInterface out2 Interface 0
	dict set TopLevelPortInterface out2 InterfaceName {}
	dict set TopLevelPortInterface out2 InterfaceString {DATA}
	dict set TopLevelPortInterface out2 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface out2 Locs {}
	dict set TopLevelPortInterface out2 IOStandard {}
	dict set TopLevelPortInterface out3 Name {out3}
	dict set TopLevelPortInterface out3 Type UFix_38_0
	dict set TopLevelPortInterface out3 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out3 BinaryPoint 0
	dict set TopLevelPortInterface out3 Width 38
	dict set TopLevelPortInterface out3 DatFile {fft_2048ch_6a_core_out3.dat}
	dict set TopLevelPortInterface out3 IconText {out3}
	dict set TopLevelPortInterface out3 Direction out
	dict set TopLevelPortInterface out3 Period 1
	dict set TopLevelPortInterface out3 Interface 0
	dict set TopLevelPortInterface out3 InterfaceName {}
	dict set TopLevelPortInterface out3 InterfaceString {DATA}
	dict set TopLevelPortInterface out3 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface out3 Locs {}
	dict set TopLevelPortInterface out3 IOStandard {}
	dict set TopLevelPortInterface out4 Name {out4}
	dict set TopLevelPortInterface out4 Type UFix_38_0
	dict set TopLevelPortInterface out4 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out4 BinaryPoint 0
	dict set TopLevelPortInterface out4 Width 38
	dict set TopLevelPortInterface out4 DatFile {fft_2048ch_6a_core_out4.dat}
	dict set TopLevelPortInterface out4 IconText {out4}
	dict set TopLevelPortInterface out4 Direction out
	dict set TopLevelPortInterface out4 Period 1
	dict set TopLevelPortInterface out4 Interface 0
	dict set TopLevelPortInterface out4 InterfaceName {}
	dict set TopLevelPortInterface out4 InterfaceString {DATA}
	dict set TopLevelPortInterface out4 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface out4 Locs {}
	dict set TopLevelPortInterface out4 IOStandard {}
	dict set TopLevelPortInterface out5 Name {out5}
	dict set TopLevelPortInterface out5 Type UFix_38_0
	dict set TopLevelPortInterface out5 ArithmeticType xlUnsigned
	dict set TopLevelPortInterface out5 BinaryPoint 0
	dict set TopLevelPortInterface out5 Width 38
	dict set TopLevelPortInterface out5 DatFile {fft_2048ch_6a_core_out5.dat}
	dict set TopLevelPortInterface out5 IconText {out5}
	dict set TopLevelPortInterface out5 Direction out
	dict set TopLevelPortInterface out5 Period 1
	dict set TopLevelPortInterface out5 Interface 0
	dict set TopLevelPortInterface out5 InterfaceName {}
	dict set TopLevelPortInterface out5 InterfaceString {DATA}
	dict set TopLevelPortInterface out5 ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface out5 Locs {}
	dict set TopLevelPortInterface out5 IOStandard {}
	dict set TopLevelPortInterface overflow Name {overflow}
	dict set TopLevelPortInterface overflow Type UFix_6_0
	dict set TopLevelPortInterface overflow ArithmeticType xlUnsigned
	dict set TopLevelPortInterface overflow BinaryPoint 0
	dict set TopLevelPortInterface overflow Width 6
	dict set TopLevelPortInterface overflow DatFile {fft_2048ch_6a_core_overflow.dat}
	dict set TopLevelPortInterface overflow IconText {overflow}
	dict set TopLevelPortInterface overflow Direction out
	dict set TopLevelPortInterface overflow Period 1
	dict set TopLevelPortInterface overflow Interface 0
	dict set TopLevelPortInterface overflow InterfaceName {}
	dict set TopLevelPortInterface overflow InterfaceString {DATA}
	dict set TopLevelPortInterface overflow ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface overflow Locs {}
	dict set TopLevelPortInterface overflow IOStandard {}
	dict set TopLevelPortInterface sync_out Name {sync_out}
	dict set TopLevelPortInterface sync_out Type Bool
	dict set TopLevelPortInterface sync_out ArithmeticType xlUnsigned
	dict set TopLevelPortInterface sync_out BinaryPoint 0
	dict set TopLevelPortInterface sync_out Width 1
	dict set TopLevelPortInterface sync_out DatFile {fft_2048ch_6a_core_sync_out.dat}
	dict set TopLevelPortInterface sync_out IconText {sync_out}
	dict set TopLevelPortInterface sync_out Direction out
	dict set TopLevelPortInterface sync_out Period 1
	dict set TopLevelPortInterface sync_out Interface 0
	dict set TopLevelPortInterface sync_out InterfaceName {}
	dict set TopLevelPortInterface sync_out InterfaceString {DATA}
	dict set TopLevelPortInterface sync_out ClockDomain {fft_2048ch_6a_core}
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
	dict set TopLevelPortInterface clk ClockDomain {fft_2048ch_6a_core}
	dict set TopLevelPortInterface clk Locs {}
	dict set TopLevelPortInterface clk IOStandard {}
	dict set TopLevelPortInterface clk AssociatedInterfaces {}
	dict set TopLevelPortInterface clk AssociatedResets {}
	set MemoryMappedPort {}
}

source SgPaProject.tcl
::xilinx::dsp::planaheadworker::dsp_create_project