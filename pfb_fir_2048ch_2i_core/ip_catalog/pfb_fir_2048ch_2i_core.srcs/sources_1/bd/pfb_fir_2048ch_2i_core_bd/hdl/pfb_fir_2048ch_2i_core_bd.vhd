--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.4 (lin64) Build 1071353 Tue Nov 18 16:47:07 MST 2014
--Date        : Fri Aug 21 15:22:09 2015
--Host        : simech1 running 64-bit Ubuntu 12.04.4 LTS
--Command     : generate_target pfb_fir_2048ch_2i_core_bd.bd
--Design      : pfb_fir_2048ch_2i_core_bd
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pfb_fir_2048ch_2i_core_bd is
  port (
    clk : in STD_LOGIC;
    pol0_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol1_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol1_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end pfb_fir_2048ch_2i_core_bd;

architecture STRUCTURE of pfb_fir_2048ch_2i_core_bd is
  component pfb_fir_2048ch_2i_core_bd_pfb_fir_2048ch_2i_core_1_0 is
  port (
    pol0_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol1_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clk : in STD_LOGIC;
    pol0_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol0_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol1_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol1_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component pfb_fir_2048ch_2i_core_bd_pfb_fir_2048ch_2i_core_1_0;
  signal clk_1 : STD_LOGIC;
  signal pfb_fir_2048ch_2i_core_1_pol0_out0 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pfb_fir_2048ch_2i_core_1_pol0_out1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pfb_fir_2048ch_2i_core_1_pol1_out0 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pfb_fir_2048ch_2i_core_1_pol1_out1 : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal pfb_fir_2048ch_2i_core_1_sync_out : STD_LOGIC_VECTOR ( 0 to 0 );
  signal pol0_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol0_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol1_in0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal pol1_in1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sync_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  clk_1 <= clk;
  pol0_in0_1(7 downto 0) <= pol0_in0(7 downto 0);
  pol0_in1_1(7 downto 0) <= pol0_in1(7 downto 0);
  pol0_out0(17 downto 0) <= pfb_fir_2048ch_2i_core_1_pol0_out0(17 downto 0);
  pol0_out1(17 downto 0) <= pfb_fir_2048ch_2i_core_1_pol0_out1(17 downto 0);
  pol1_in0_1(7 downto 0) <= pol1_in0(7 downto 0);
  pol1_in1_1(7 downto 0) <= pol1_in1(7 downto 0);
  pol1_out0(17 downto 0) <= pfb_fir_2048ch_2i_core_1_pol1_out0(17 downto 0);
  pol1_out1(17 downto 0) <= pfb_fir_2048ch_2i_core_1_pol1_out1(17 downto 0);
  sync_1(31 downto 0) <= sync(31 downto 0);
  sync_out(0) <= pfb_fir_2048ch_2i_core_1_sync_out(0);
pfb_fir_2048ch_2i_core_1: component pfb_fir_2048ch_2i_core_bd_pfb_fir_2048ch_2i_core_1_0
    port map (
      clk => clk_1,
      pol0_in0(7 downto 0) => pol0_in0_1(7 downto 0),
      pol0_in1(7 downto 0) => pol0_in1_1(7 downto 0),
      pol0_out0(17 downto 0) => pfb_fir_2048ch_2i_core_1_pol0_out0(17 downto 0),
      pol0_out1(17 downto 0) => pfb_fir_2048ch_2i_core_1_pol0_out1(17 downto 0),
      pol1_in0(7 downto 0) => pol1_in0_1(7 downto 0),
      pol1_in1(7 downto 0) => pol1_in1_1(7 downto 0),
      pol1_out0(17 downto 0) => pfb_fir_2048ch_2i_core_1_pol1_out0(17 downto 0),
      pol1_out1(17 downto 0) => pfb_fir_2048ch_2i_core_1_pol1_out1(17 downto 0),
      sync(31 downto 0) => sync_1(31 downto 0),
      sync_out(0) => pfb_fir_2048ch_2i_core_1_sync_out(0)
    );
end STRUCTURE;
