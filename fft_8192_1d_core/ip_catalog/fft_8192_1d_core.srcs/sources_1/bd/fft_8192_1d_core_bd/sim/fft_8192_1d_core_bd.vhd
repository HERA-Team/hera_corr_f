--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1.1 (lin64) Build 2580384 Sat Jun 29 08:04:45 MDT 2019
--Date        : Thu Feb  4 14:31:44 2021
--Host        : acme1 running 64-bit Ubuntu 16.04.2 LTS
--Command     : generate_target fft_8192_1d_core_bd.bd
--Design      : fft_8192_1d_core_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fft_8192_1d_core_bd is
  port (
    clk : in STD_LOGIC;
    out0 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out1 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out2 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out3 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out4 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out5 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out6 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out7 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    overflow : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pol0_in0 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in10 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in11 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in12 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in13 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in14 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in15 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in2 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in3 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in4 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in5 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in6 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in7 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in8 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in9 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    shift : in STD_LOGIC_VECTOR ( 15 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of fft_8192_1d_core_bd : entity is "fft_8192_1d_core_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=fft_8192_1d_core_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=1,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SYSGEN,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of fft_8192_1d_core_bd : entity is "fft_8192_1d_core_bd.hwdef";
end fft_8192_1d_core_bd;

architecture STRUCTURE of fft_8192_1d_core_bd is
  component fft_8192_1d_core_bd_fft_8192_1d_core_1_0 is
  port (
    pol0_in0 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in10 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in11 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in12 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in13 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in14 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in15 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in2 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in3 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in4 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in5 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in6 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in7 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in8 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_in9 : in STD_LOGIC_VECTOR ( 17 downto 0 );
    shift : in STD_LOGIC_VECTOR ( 15 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    out0 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out1 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out2 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out3 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out4 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out5 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out6 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    out7 : out STD_LOGIC_VECTOR ( 35 downto 0 );
    overflow : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component fft_8192_1d_core_bd_fft_8192_1d_core_1_0;
  signal clk_1 : STD_LOGIC;
  signal fft_8192_1d_core_1_out0 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_out1 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_out2 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_out3 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_out4 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_out5 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_out6 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_out7 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1d_core_1_overflow : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal fft_8192_1d_core_1_sync_out : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pol0_in0_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in10_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in11_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in12_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in13_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in14_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in15_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in1_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in2_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in3_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in4_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in5_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in6_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in7_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in8_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pol0_in9_1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal shift_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal sync_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN fft_8192_1d_core_bd_clk, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000";
  attribute X_INTERFACE_INFO of out0 : signal is "xilinx.com:signal:data:1.0 DATA.OUT0 DATA";
  attribute X_INTERFACE_PARAMETER of out0 : signal is "XIL_INTERFACENAME DATA.OUT0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of out1 : signal is "xilinx.com:signal:data:1.0 DATA.OUT1 DATA";
  attribute X_INTERFACE_PARAMETER of out1 : signal is "XIL_INTERFACENAME DATA.OUT1, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of out2 : signal is "xilinx.com:signal:data:1.0 DATA.OUT2 DATA";
  attribute X_INTERFACE_PARAMETER of out2 : signal is "XIL_INTERFACENAME DATA.OUT2, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of out3 : signal is "xilinx.com:signal:data:1.0 DATA.OUT3 DATA";
  attribute X_INTERFACE_PARAMETER of out3 : signal is "XIL_INTERFACENAME DATA.OUT3, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of out4 : signal is "xilinx.com:signal:data:1.0 DATA.OUT4 DATA";
  attribute X_INTERFACE_PARAMETER of out4 : signal is "XIL_INTERFACENAME DATA.OUT4, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of out5 : signal is "xilinx.com:signal:data:1.0 DATA.OUT5 DATA";
  attribute X_INTERFACE_PARAMETER of out5 : signal is "XIL_INTERFACENAME DATA.OUT5, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of out6 : signal is "xilinx.com:signal:data:1.0 DATA.OUT6 DATA";
  attribute X_INTERFACE_PARAMETER of out6 : signal is "XIL_INTERFACENAME DATA.OUT6, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of out7 : signal is "xilinx.com:signal:data:1.0 DATA.OUT7 DATA";
  attribute X_INTERFACE_PARAMETER of out7 : signal is "XIL_INTERFACENAME DATA.OUT7, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 36} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of overflow : signal is "xilinx.com:signal:data:1.0 DATA.OVERFLOW DATA";
  attribute X_INTERFACE_PARAMETER of overflow : signal is "XIL_INTERFACENAME DATA.OVERFLOW, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 4} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
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
  attribute X_INTERFACE_INFO of shift : signal is "xilinx.com:signal:data:1.0 DATA.SHIFT DATA";
  attribute X_INTERFACE_PARAMETER of shift : signal is "XIL_INTERFACENAME DATA.SHIFT, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of sync : signal is "xilinx.com:signal:data:1.0 DATA.SYNC DATA";
  attribute X_INTERFACE_PARAMETER of sync : signal is "XIL_INTERFACENAME DATA.SYNC, LAYERED_METADATA undef";
  attribute X_INTERFACE_INFO of sync_out : signal is "xilinx.com:signal:data:1.0 DATA.SYNC_OUT DATA";
  attribute X_INTERFACE_PARAMETER of sync_out : signal is "XIL_INTERFACENAME DATA.SYNC_OUT, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
begin
  clk_1 <= clk;
  out0(35 downto 0) <= fft_8192_1d_core_1_out0(35 downto 0);
  out1(35 downto 0) <= fft_8192_1d_core_1_out1(35 downto 0);
  out2(35 downto 0) <= fft_8192_1d_core_1_out2(35 downto 0);
  out3(35 downto 0) <= fft_8192_1d_core_1_out3(35 downto 0);
  out4(35 downto 0) <= fft_8192_1d_core_1_out4(35 downto 0);
  out5(35 downto 0) <= fft_8192_1d_core_1_out5(35 downto 0);
  out6(35 downto 0) <= fft_8192_1d_core_1_out6(35 downto 0);
  out7(35 downto 0) <= fft_8192_1d_core_1_out7(35 downto 0);
  overflow(3 downto 0) <= fft_8192_1d_core_1_overflow(3 downto 0);
  pol0_in0_1(17 downto 0) <= pol0_in0(17 downto 0);
  pol0_in10_1(17 downto 0) <= pol0_in10(17 downto 0);
  pol0_in11_1(17 downto 0) <= pol0_in11(17 downto 0);
  pol0_in12_1(17 downto 0) <= pol0_in12(17 downto 0);
  pol0_in13_1(17 downto 0) <= pol0_in13(17 downto 0);
  pol0_in14_1(17 downto 0) <= pol0_in14(17 downto 0);
  pol0_in15_1(17 downto 0) <= pol0_in15(17 downto 0);
  pol0_in1_1(17 downto 0) <= pol0_in1(17 downto 0);
  pol0_in2_1(17 downto 0) <= pol0_in2(17 downto 0);
  pol0_in3_1(17 downto 0) <= pol0_in3(17 downto 0);
  pol0_in4_1(17 downto 0) <= pol0_in4(17 downto 0);
  pol0_in5_1(17 downto 0) <= pol0_in5(17 downto 0);
  pol0_in6_1(17 downto 0) <= pol0_in6(17 downto 0);
  pol0_in7_1(17 downto 0) <= pol0_in7(17 downto 0);
  pol0_in8_1(17 downto 0) <= pol0_in8(17 downto 0);
  pol0_in9_1(17 downto 0) <= pol0_in9(17 downto 0);
  shift_1(15 downto 0) <= shift(15 downto 0);
  sync_1(31 downto 0) <= sync(31 downto 0);
  sync_out(0) <= fft_8192_1d_core_1_sync_out(0);
fft_8192_1d_core_1: component fft_8192_1d_core_bd_fft_8192_1d_core_1_0
     port map (
      clk => clk_1,
      out0(35 downto 0) => fft_8192_1d_core_1_out0(35 downto 0),
      out1(35 downto 0) => fft_8192_1d_core_1_out1(35 downto 0),
      out2(35 downto 0) => fft_8192_1d_core_1_out2(35 downto 0),
      out3(35 downto 0) => fft_8192_1d_core_1_out3(35 downto 0),
      out4(35 downto 0) => fft_8192_1d_core_1_out4(35 downto 0),
      out5(35 downto 0) => fft_8192_1d_core_1_out5(35 downto 0),
      out6(35 downto 0) => fft_8192_1d_core_1_out6(35 downto 0),
      out7(35 downto 0) => fft_8192_1d_core_1_out7(35 downto 0),
      overflow(3 downto 0) => fft_8192_1d_core_1_overflow(3 downto 0),
      pol0_in0(17 downto 0) => pol0_in0_1(17 downto 0),
      pol0_in1(17 downto 0) => pol0_in1_1(17 downto 0),
      pol0_in10(17 downto 0) => pol0_in10_1(17 downto 0),
      pol0_in11(17 downto 0) => pol0_in11_1(17 downto 0),
      pol0_in12(17 downto 0) => pol0_in12_1(17 downto 0),
      pol0_in13(17 downto 0) => pol0_in13_1(17 downto 0),
      pol0_in14(17 downto 0) => pol0_in14_1(17 downto 0),
      pol0_in15(17 downto 0) => pol0_in15_1(17 downto 0),
      pol0_in2(17 downto 0) => pol0_in2_1(17 downto 0),
      pol0_in3(17 downto 0) => pol0_in3_1(17 downto 0),
      pol0_in4(17 downto 0) => pol0_in4_1(17 downto 0),
      pol0_in5(17 downto 0) => pol0_in5_1(17 downto 0),
      pol0_in6(17 downto 0) => pol0_in6_1(17 downto 0),
      pol0_in7(17 downto 0) => pol0_in7_1(17 downto 0),
      pol0_in8(17 downto 0) => pol0_in8_1(17 downto 0),
      pol0_in9(17 downto 0) => pol0_in9_1(17 downto 0),
      shift(15 downto 0) => shift_1(15 downto 0),
      sync(31 downto 0) => sync_1(31 downto 0),
      sync_out(0) => fft_8192_1d_core_1_sync_out(0)
    );
end STRUCTURE;
