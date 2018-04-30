--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
--Date        : Sun Feb 25 13:09:35 2018
--Host        : acme1 running 64-bit Ubuntu 16.04.2 LTS
--Command     : generate_target fft_8192_1a_core_bd.bd
--Design      : fft_8192_1a_core_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fft_8192_1a_core_bd is
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
    pol0_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in10 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in11 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in12 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in13 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in14 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in15 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in2 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in3 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in4 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in5 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in6 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in7 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in8 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in9 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    shift : in STD_LOGIC_VECTOR ( 15 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of fft_8192_1a_core_bd : entity is "fft_8192_1a_core_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=fft_8192_1a_core_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=1,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SYSGEN,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of fft_8192_1a_core_bd : entity is "fft_8192_1a_core_bd.hwdef";
end fft_8192_1a_core_bd;

architecture STRUCTURE of fft_8192_1a_core_bd is
  component fft_8192_1a_core_bd_fft_8192_1a_core_1_0 is
  port (
    pol0_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in10 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in11 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in12 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in13 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in14 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in15 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in2 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in3 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in4 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in5 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in6 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in7 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in8 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in9 : in STD_LOGIC_VECTOR ( 11 downto 0 );
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
  end component fft_8192_1a_core_bd_fft_8192_1a_core_1_0;
  signal clk_1 : STD_LOGIC;
  signal fft_8192_1a_core_1_out0 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_out1 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_out2 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_out3 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_out4 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_out5 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_out6 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_out7 : STD_LOGIC_VECTOR ( 35 downto 0 );
  signal fft_8192_1a_core_1_overflow : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal fft_8192_1a_core_1_sync_out : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pol0_in0_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in10_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in11_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in12_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in13_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in14_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in15_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in1_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in2_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in3_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in4_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in5_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in6_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in7_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in8_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pol0_in9_1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal shift_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal sync_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  clk_1 <= clk;
  out0(35 downto 0) <= fft_8192_1a_core_1_out0(35 downto 0);
  out1(35 downto 0) <= fft_8192_1a_core_1_out1(35 downto 0);
  out2(35 downto 0) <= fft_8192_1a_core_1_out2(35 downto 0);
  out3(35 downto 0) <= fft_8192_1a_core_1_out3(35 downto 0);
  out4(35 downto 0) <= fft_8192_1a_core_1_out4(35 downto 0);
  out5(35 downto 0) <= fft_8192_1a_core_1_out5(35 downto 0);
  out6(35 downto 0) <= fft_8192_1a_core_1_out6(35 downto 0);
  out7(35 downto 0) <= fft_8192_1a_core_1_out7(35 downto 0);
  overflow(3 downto 0) <= fft_8192_1a_core_1_overflow(3 downto 0);
  pol0_in0_1(11 downto 0) <= pol0_in0(11 downto 0);
  pol0_in10_1(11 downto 0) <= pol0_in10(11 downto 0);
  pol0_in11_1(11 downto 0) <= pol0_in11(11 downto 0);
  pol0_in12_1(11 downto 0) <= pol0_in12(11 downto 0);
  pol0_in13_1(11 downto 0) <= pol0_in13(11 downto 0);
  pol0_in14_1(11 downto 0) <= pol0_in14(11 downto 0);
  pol0_in15_1(11 downto 0) <= pol0_in15(11 downto 0);
  pol0_in1_1(11 downto 0) <= pol0_in1(11 downto 0);
  pol0_in2_1(11 downto 0) <= pol0_in2(11 downto 0);
  pol0_in3_1(11 downto 0) <= pol0_in3(11 downto 0);
  pol0_in4_1(11 downto 0) <= pol0_in4(11 downto 0);
  pol0_in5_1(11 downto 0) <= pol0_in5(11 downto 0);
  pol0_in6_1(11 downto 0) <= pol0_in6(11 downto 0);
  pol0_in7_1(11 downto 0) <= pol0_in7(11 downto 0);
  pol0_in8_1(11 downto 0) <= pol0_in8(11 downto 0);
  pol0_in9_1(11 downto 0) <= pol0_in9(11 downto 0);
  shift_1(15 downto 0) <= shift(15 downto 0);
  sync_1(31 downto 0) <= sync(31 downto 0);
  sync_out(0) <= fft_8192_1a_core_1_sync_out(0);
fft_8192_1a_core_1: component fft_8192_1a_core_bd_fft_8192_1a_core_1_0
     port map (
      clk => clk_1,
      out0(35 downto 0) => fft_8192_1a_core_1_out0(35 downto 0),
      out1(35 downto 0) => fft_8192_1a_core_1_out1(35 downto 0),
      out2(35 downto 0) => fft_8192_1a_core_1_out2(35 downto 0),
      out3(35 downto 0) => fft_8192_1a_core_1_out3(35 downto 0),
      out4(35 downto 0) => fft_8192_1a_core_1_out4(35 downto 0),
      out5(35 downto 0) => fft_8192_1a_core_1_out5(35 downto 0),
      out6(35 downto 0) => fft_8192_1a_core_1_out6(35 downto 0),
      out7(35 downto 0) => fft_8192_1a_core_1_out7(35 downto 0),
      overflow(3 downto 0) => fft_8192_1a_core_1_overflow(3 downto 0),
      pol0_in0(11 downto 0) => pol0_in0_1(11 downto 0),
      pol0_in1(11 downto 0) => pol0_in1_1(11 downto 0),
      pol0_in10(11 downto 0) => pol0_in10_1(11 downto 0),
      pol0_in11(11 downto 0) => pol0_in11_1(11 downto 0),
      pol0_in12(11 downto 0) => pol0_in12_1(11 downto 0),
      pol0_in13(11 downto 0) => pol0_in13_1(11 downto 0),
      pol0_in14(11 downto 0) => pol0_in14_1(11 downto 0),
      pol0_in15(11 downto 0) => pol0_in15_1(11 downto 0),
      pol0_in2(11 downto 0) => pol0_in2_1(11 downto 0),
      pol0_in3(11 downto 0) => pol0_in3_1(11 downto 0),
      pol0_in4(11 downto 0) => pol0_in4_1(11 downto 0),
      pol0_in5(11 downto 0) => pol0_in5_1(11 downto 0),
      pol0_in6(11 downto 0) => pol0_in6_1(11 downto 0),
      pol0_in7(11 downto 0) => pol0_in7_1(11 downto 0),
      pol0_in8(11 downto 0) => pol0_in8_1(11 downto 0),
      pol0_in9(11 downto 0) => pol0_in9_1(11 downto 0),
      shift(15 downto 0) => shift_1(15 downto 0),
      sync(31 downto 0) => sync_1(31 downto 0),
      sync_out(0) => fft_8192_1a_core_1_sync_out(0)
    );
end STRUCTURE;
