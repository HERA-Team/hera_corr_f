--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
--Date        : Sun Apr 29 13:31:03 2018
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
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in3 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in4 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in5 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in6 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in7 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in8 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in9 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in10 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in11 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in12 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in13 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in14 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in15 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC;
    pol0_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    pol0_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out2 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out3 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out4 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out5 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out6 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out7 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out8 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out9 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out10 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out11 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out12 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out13 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out14 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out15 : out STD_LOGIC_VECTOR ( 11 downto 0 )
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
