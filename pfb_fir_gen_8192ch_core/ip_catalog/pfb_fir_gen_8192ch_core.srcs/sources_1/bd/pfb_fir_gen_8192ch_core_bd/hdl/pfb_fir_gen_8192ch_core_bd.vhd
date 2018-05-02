--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
--Date        : Sat Feb 10 10:35:02 2018
--Host        : acme1 running 64-bit Ubuntu 16.04.2 LTS
--Command     : generate_target pfb_fir_gen_8192ch_core_bd.bd
--Design      : pfb_fir_gen_8192ch_core_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pfb_fir_gen_8192ch_core_bd is
  port (
    clk : in STD_LOGIC;
    pol0_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol4_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol4_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol4_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol4_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of pfb_fir_gen_8192ch_core_bd : entity is "pfb_fir_gen_8192ch_core_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=pfb_fir_gen_8192ch_core_bd,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=1,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SYSGEN,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of pfb_fir_gen_8192ch_core_bd : entity is "pfb_fir_gen_8192ch_core_bd.hwdef";
end pfb_fir_gen_8192ch_core_bd;

architecture STRUCTURE of pfb_fir_gen_8192ch_core_bd is
  component pfb_fir_gen_8192ch_core_bd_pfb_fir_gen_8192ch_core_1_0 is
  port (
    pol0_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pol4_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol4_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    clk : in STD_LOGIC;
    pol0_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 );
    pol4_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_out0 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol4_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_out1 : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  end component pfb_fir_gen_8192ch_core_bd_pfb_fir_gen_8192ch_core_1_0;
  signal clk_1 : STD_LOGIC;
  signal pfb_fir_gen_8192ch_core_1_pol0_out0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol0_out1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol1_out0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol1_out1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol2_out0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol2_out1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol3_out0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol3_out1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol4_out0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol4_out1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol5_out0 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_pol5_out1 : STD_LOGIC_VECTOR ( 11 downto 0 );
  signal pfb_fir_gen_8192ch_core_1_sync_out : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pol0_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol1_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol1_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol2_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol2_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol3_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol3_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol4_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol4_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol5_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol5_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sync_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  clk_1 <= clk;
  pol0_in0_1(7 downto 0) <= pol0_in0(7 downto 0);
  pol0_in1_1(7 downto 0) <= pol0_in1(7 downto 0);
  pol0_out0(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol0_out0(11 downto 0);
  pol0_out1(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol0_out1(11 downto 0);
  pol1_in0_1(7 downto 0) <= pol1_in0(7 downto 0);
  pol1_in1_1(7 downto 0) <= pol1_in1(7 downto 0);
  pol1_out0(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol1_out0(11 downto 0);
  pol1_out1(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol1_out1(11 downto 0);
  pol2_in0_1(7 downto 0) <= pol2_in0(7 downto 0);
  pol2_in1_1(7 downto 0) <= pol2_in1(7 downto 0);
  pol2_out0(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol2_out0(11 downto 0);
  pol2_out1(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol2_out1(11 downto 0);
  pol3_in0_1(7 downto 0) <= pol3_in0(7 downto 0);
  pol3_in1_1(7 downto 0) <= pol3_in1(7 downto 0);
  pol3_out0(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol3_out0(11 downto 0);
  pol3_out1(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol3_out1(11 downto 0);
  pol4_in0_1(7 downto 0) <= pol4_in0(7 downto 0);
  pol4_in1_1(7 downto 0) <= pol4_in1(7 downto 0);
  pol4_out0(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol4_out0(11 downto 0);
  pol4_out1(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol4_out1(11 downto 0);
  pol5_in0_1(7 downto 0) <= pol5_in0(7 downto 0);
  pol5_in1_1(7 downto 0) <= pol5_in1(7 downto 0);
  pol5_out0(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol5_out0(11 downto 0);
  pol5_out1(11 downto 0) <= pfb_fir_gen_8192ch_core_1_pol5_out1(11 downto 0);
  sync_1(31 downto 0) <= sync(31 downto 0);
  sync_out(0) <= pfb_fir_gen_8192ch_core_1_sync_out(0);
pfb_fir_gen_8192ch_core_1: component pfb_fir_gen_8192ch_core_bd_pfb_fir_gen_8192ch_core_1_0
     port map (
      clk => clk_1,
      pol0_in0(7 downto 0) => pol0_in0_1(7 downto 0),
      pol0_in1(7 downto 0) => pol0_in1_1(7 downto 0),
      pol0_out0(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol0_out0(11 downto 0),
      pol0_out1(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol0_out1(11 downto 0),
      pol1_in0(7 downto 0) => pol1_in0_1(7 downto 0),
      pol1_in1(7 downto 0) => pol1_in1_1(7 downto 0),
      pol1_out0(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol1_out0(11 downto 0),
      pol1_out1(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol1_out1(11 downto 0),
      pol2_in0(7 downto 0) => pol2_in0_1(7 downto 0),
      pol2_in1(7 downto 0) => pol2_in1_1(7 downto 0),
      pol2_out0(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol2_out0(11 downto 0),
      pol2_out1(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol2_out1(11 downto 0),
      pol3_in0(7 downto 0) => pol3_in0_1(7 downto 0),
      pol3_in1(7 downto 0) => pol3_in1_1(7 downto 0),
      pol3_out0(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol3_out0(11 downto 0),
      pol3_out1(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol3_out1(11 downto 0),
      pol4_in0(7 downto 0) => pol4_in0_1(7 downto 0),
      pol4_in1(7 downto 0) => pol4_in1_1(7 downto 0),
      pol4_out0(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol4_out0(11 downto 0),
      pol4_out1(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol4_out1(11 downto 0),
      pol5_in0(7 downto 0) => pol5_in0_1(7 downto 0),
      pol5_in1(7 downto 0) => pol5_in1_1(7 downto 0),
      pol5_out0(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol5_out0(11 downto 0),
      pol5_out1(11 downto 0) => pfb_fir_gen_8192ch_core_1_pol5_out1(11 downto 0),
      sync(31 downto 0) => sync_1(31 downto 0),
      sync_out(0) => pfb_fir_gen_8192ch_core_1_sync_out(0)
    );
end STRUCTURE;
