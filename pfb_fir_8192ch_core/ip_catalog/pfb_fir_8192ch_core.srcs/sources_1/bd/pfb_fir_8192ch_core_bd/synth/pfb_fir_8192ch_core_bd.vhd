--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
--Date        : Sat Mar  5 05:20:36 2022
--Host        : acme1 running 64-bit Ubuntu 16.04.2 LTS
--Command     : generate_target pfb_fir_8192ch_core_bd.bd
--Design      : pfb_fir_8192ch_core_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pfb_fir_8192ch_core_bd is
  port (
    clk : in STD_LOGIC;
    pol0_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in10 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in11 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in12 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in13 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in14 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in15 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in3 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in4 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in5 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in6 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in7 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in8 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in9 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out10 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out11 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out12 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out13 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out14 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out15 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out2 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out3 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out4 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out5 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out6 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out7 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out8 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out9 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of pfb_fir_8192ch_core_bd : entity is "pfb_fir_8192ch_core_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=pfb_fir_8192ch_core_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=1,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SYSGEN,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of pfb_fir_8192ch_core_bd : entity is "pfb_fir_8192ch_core_bd.hwdef";
end pfb_fir_8192ch_core_bd;

architecture STRUCTURE of pfb_fir_8192ch_core_bd is
  component pfb_fir_8192ch_core_bd_pfb_fir_8192ch_core_1_0 is
  port (
    pol0_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in10 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in11 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in12 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in13 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in14 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in15 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in3 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in4 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in5 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in6 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in7 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in8 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in9 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    pol0_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out10 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out11 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out12 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out13 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out14 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out15 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out2 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out3 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out4 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out5 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out6 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out7 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out8 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out9 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component pfb_fir_8192ch_core_bd_pfb_fir_8192ch_core_1_0;
  signal clk_1 : STD_LOGIC;
  signal pfb_fir_8192ch_core_1_pol0_out0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out10 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out11 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out12 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out13 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out14 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out15 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out2 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out3 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out4 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out5 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out6 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out7 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out8 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_pol0_out9 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_8192ch_core_1_sync_out : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pol0_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in10_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in11_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in12_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in13_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in14_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in15_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in2_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in3_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in4_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in5_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in6_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in7_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in8_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in9_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sync_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN pfb_fir_8192ch_core_bd_clk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of pol0_in0 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN0 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in0 : signal is "XIL_INTERFACENAME DATA.POL0_IN0, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in1 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN1 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in1 : signal is "XIL_INTERFACENAME DATA.POL0_IN1, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in10 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN10 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in10 : signal is "XIL_INTERFACENAME DATA.POL0_IN10, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in11 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN11 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in11 : signal is "XIL_INTERFACENAME DATA.POL0_IN11, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in12 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN12 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in12 : signal is "XIL_INTERFACENAME DATA.POL0_IN12, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in13 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN13 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in13 : signal is "XIL_INTERFACENAME DATA.POL0_IN13, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in14 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN14 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in14 : signal is "XIL_INTERFACENAME DATA.POL0_IN14, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in15 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN15 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in15 : signal is "XIL_INTERFACENAME DATA.POL0_IN15, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in2 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN2 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in2 : signal is "XIL_INTERFACENAME DATA.POL0_IN2, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in3 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN3 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in3 : signal is "XIL_INTERFACENAME DATA.POL0_IN3, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in4 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN4 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in4 : signal is "XIL_INTERFACENAME DATA.POL0_IN4, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in5 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN5 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in5 : signal is "XIL_INTERFACENAME DATA.POL0_IN5, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in6 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN6 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in6 : signal is "XIL_INTERFACENAME DATA.POL0_IN6, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in7 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN7 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in7 : signal is "XIL_INTERFACENAME DATA.POL0_IN7, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in8 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN8 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in8 : signal is "XIL_INTERFACENAME DATA.POL0_IN8, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_in9 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_IN9 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_in9 : signal is "XIL_INTERFACENAME DATA.POL0_IN9, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of pol0_out0 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT0 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out0 : signal is "XIL_INTERFACENAME DATA.POL0_OUT0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out1 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT1 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out1 : signal is "XIL_INTERFACENAME DATA.POL0_OUT1, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out10 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT10 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out10 : signal is "XIL_INTERFACENAME DATA.POL0_OUT10, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out11 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT11 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out11 : signal is "XIL_INTERFACENAME DATA.POL0_OUT11, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out12 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT12 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out12 : signal is "XIL_INTERFACENAME DATA.POL0_OUT12, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out13 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT13 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out13 : signal is "XIL_INTERFACENAME DATA.POL0_OUT13, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out14 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT14 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out14 : signal is "XIL_INTERFACENAME DATA.POL0_OUT14, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out15 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT15 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out15 : signal is "XIL_INTERFACENAME DATA.POL0_OUT15, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out2 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT2 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out2 : signal is "XIL_INTERFACENAME DATA.POL0_OUT2, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out3 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT3 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out3 : signal is "XIL_INTERFACENAME DATA.POL0_OUT3, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out4 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT4 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out4 : signal is "XIL_INTERFACENAME DATA.POL0_OUT4, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out5 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT5 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out5 : signal is "XIL_INTERFACENAME DATA.POL0_OUT5, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out6 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT6 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out6 : signal is "XIL_INTERFACENAME DATA.POL0_OUT6, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out7 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT7 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out7 : signal is "XIL_INTERFACENAME DATA.POL0_OUT7, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out8 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT8 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out8 : signal is "XIL_INTERFACENAME DATA.POL0_OUT8, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of pol0_out9 : signal is "xilinx.com:signal:data:1.0 DATA.POL0_OUT9 DATA";
  attribute X_INTERFACE_PARAMETER of pol0_out9 : signal is "XIL_INTERFACENAME DATA.POL0_OUT9, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 12} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 11} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of sync : signal is "xilinx.com:signal:data:1.0 DATA.SYNC DATA";
  attribute X_INTERFACE_PARAMETER of sync : signal is "XIL_INTERFACENAME DATA.SYNC, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of sync_out : signal is "xilinx.com:signal:data:1.0 DATA.SYNC_OUT DATA";
  attribute X_INTERFACE_PARAMETER of sync_out : signal is "XIL_INTERFACENAME DATA.SYNC_OUT, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
begin
  clk_1 <= clk;
  pol0_in0_1(7 downto 0) <= pol0_in0(7 downto 0);
  pol0_in10_1(7 downto 0) <= pol0_in10(7 downto 0);
  pol0_in11_1(7 downto 0) <= pol0_in11(7 downto 0);
  pol0_in12_1(7 downto 0) <= pol0_in12(7 downto 0);
  pol0_in13_1(7 downto 0) <= pol0_in13(7 downto 0);
  pol0_in14_1(7 downto 0) <= pol0_in14(7 downto 0);
  pol0_in15_1(7 downto 0) <= pol0_in15(7 downto 0);
  pol0_in1_1(7 downto 0) <= pol0_in1(7 downto 0);
  pol0_in2_1(7 downto 0) <= pol0_in2(7 downto 0);
  pol0_in3_1(7 downto 0) <= pol0_in3(7 downto 0);
  pol0_in4_1(7 downto 0) <= pol0_in4(7 downto 0);
  pol0_in5_1(7 downto 0) <= pol0_in5(7 downto 0);
  pol0_in6_1(7 downto 0) <= pol0_in6(7 downto 0);
  pol0_in7_1(7 downto 0) <= pol0_in7(7 downto 0);
  pol0_in8_1(7 downto 0) <= pol0_in8(7 downto 0);
  pol0_in9_1(7 downto 0) <= pol0_in9(7 downto 0);
  pol0_out0(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out0(11 downto 0);
  pol0_out1(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out1(11 downto 0);
  pol0_out10(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out10(11 downto 0);
  pol0_out11(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out11(11 downto 0);
  pol0_out12(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out12(11 downto 0);
  pol0_out13(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out13(11 downto 0);
  pol0_out14(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out14(11 downto 0);
  pol0_out15(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out15(11 downto 0);
  pol0_out2(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out2(11 downto 0);
  pol0_out3(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out3(11 downto 0);
  pol0_out4(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out4(11 downto 0);
  pol0_out5(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out5(11 downto 0);
  pol0_out6(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out6(11 downto 0);
  pol0_out7(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out7(11 downto 0);
  pol0_out8(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out8(11 downto 0);
  pol0_out9(11 downto 0) <= pfb_fir_8192ch_core_1_pol0_out9(11 downto 0);
  sync_1(31 downto 0) <= sync(31 downto 0);
  sync_out(0) <= pfb_fir_8192ch_core_1_sync_out(0);
pfb_fir_8192ch_core_1: component pfb_fir_8192ch_core_bd_pfb_fir_8192ch_core_1_0
     port map (
      clk => clk_1,
      pol0_in0(7 downto 0) => pol0_in0_1(7 downto 0),
      pol0_in1(7 downto 0) => pol0_in1_1(7 downto 0),
      pol0_in10(7 downto 0) => pol0_in10_1(7 downto 0),
      pol0_in11(7 downto 0) => pol0_in11_1(7 downto 0),
      pol0_in12(7 downto 0) => pol0_in12_1(7 downto 0),
      pol0_in13(7 downto 0) => pol0_in13_1(7 downto 0),
      pol0_in14(7 downto 0) => pol0_in14_1(7 downto 0),
      pol0_in15(7 downto 0) => pol0_in15_1(7 downto 0),
      pol0_in2(7 downto 0) => pol0_in2_1(7 downto 0),
      pol0_in3(7 downto 0) => pol0_in3_1(7 downto 0),
      pol0_in4(7 downto 0) => pol0_in4_1(7 downto 0),
      pol0_in5(7 downto 0) => pol0_in5_1(7 downto 0),
      pol0_in6(7 downto 0) => pol0_in6_1(7 downto 0),
      pol0_in7(7 downto 0) => pol0_in7_1(7 downto 0),
      pol0_in8(7 downto 0) => pol0_in8_1(7 downto 0),
      pol0_in9(7 downto 0) => pol0_in9_1(7 downto 0),
      pol0_out0(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out0(11 downto 0),
      pol0_out1(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out1(11 downto 0),
      pol0_out10(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out10(11 downto 0),
      pol0_out11(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out11(11 downto 0),
      pol0_out12(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out12(11 downto 0),
      pol0_out13(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out13(11 downto 0),
      pol0_out14(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out14(11 downto 0),
      pol0_out15(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out15(11 downto 0),
      pol0_out2(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out2(11 downto 0),
      pol0_out3(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out3(11 downto 0),
      pol0_out4(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out4(11 downto 0),
      pol0_out5(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out5(11 downto 0),
      pol0_out6(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out6(11 downto 0),
      pol0_out7(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out7(11 downto 0),
      pol0_out8(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out8(11 downto 0),
      pol0_out9(11 downto 0) => pfb_fir_8192ch_core_1_pol0_out9(11 downto 0),
      sync(31 downto 0) => sync_1(31 downto 0),
      sync_out(0) => pfb_fir_8192ch_core_1_sync_out(0)
    );
end STRUCTURE;
