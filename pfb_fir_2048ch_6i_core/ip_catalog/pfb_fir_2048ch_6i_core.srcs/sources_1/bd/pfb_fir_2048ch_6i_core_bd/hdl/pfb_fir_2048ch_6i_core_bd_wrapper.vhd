--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.1 (lin64) Build 1538259 Fri Apr  8 15:45:23 MDT 2016
--Date        : Fri Feb  9 14:47:43 2018
--Host        : acme1 running 64-bit Ubuntu 16.04.2 LTS
--Command     : generate_target pfb_fir_2048ch_6i_core_bd_wrapper.bd
--Design      : pfb_fir_2048ch_6i_core_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity pfb_fir_2048ch_6i_core_bd_wrapper is
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
    pol2_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol2_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol3_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol3_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol4_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol4_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol4_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol4_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol5_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol5_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end pfb_fir_2048ch_6i_core_bd_wrapper;

architecture STRUCTURE of pfb_fir_2048ch_6i_core_bd_wrapper is
  component pfb_fir_2048ch_6i_core_bd is
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
    pol2_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol2_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol2_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol3_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol3_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol3_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol4_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol4_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol4_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol4_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol5_in0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_in1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    pol5_out0 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    pol5_out1 : out STD_LOGIC_VECTOR ( 17 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component pfb_fir_2048ch_6i_core_bd;
begin
pfb_fir_2048ch_6i_core_bd_i: component pfb_fir_2048ch_6i_core_bd
     port map (
      clk => clk,
      pol0_in0(7 downto 0) => pol0_in0(7 downto 0),
      pol0_in1(7 downto 0) => pol0_in1(7 downto 0),
      pol0_out0(17 downto 0) => pol0_out0(17 downto 0),
      pol0_out1(17 downto 0) => pol0_out1(17 downto 0),
      pol1_in0(7 downto 0) => pol1_in0(7 downto 0),
      pol1_in1(7 downto 0) => pol1_in1(7 downto 0),
      pol1_out0(17 downto 0) => pol1_out0(17 downto 0),
      pol1_out1(17 downto 0) => pol1_out1(17 downto 0),
      pol2_in0(7 downto 0) => pol2_in0(7 downto 0),
      pol2_in1(7 downto 0) => pol2_in1(7 downto 0),
      pol2_out0(17 downto 0) => pol2_out0(17 downto 0),
      pol2_out1(17 downto 0) => pol2_out1(17 downto 0),
      pol3_in0(7 downto 0) => pol3_in0(7 downto 0),
      pol3_in1(7 downto 0) => pol3_in1(7 downto 0),
      pol3_out0(17 downto 0) => pol3_out0(17 downto 0),
      pol3_out1(17 downto 0) => pol3_out1(17 downto 0),
      pol4_in0(7 downto 0) => pol4_in0(7 downto 0),
      pol4_in1(7 downto 0) => pol4_in1(7 downto 0),
      pol4_out0(17 downto 0) => pol4_out0(17 downto 0),
      pol4_out1(17 downto 0) => pol4_out1(17 downto 0),
      pol5_in0(7 downto 0) => pol5_in0(7 downto 0),
      pol5_in1(7 downto 0) => pol5_in1(7 downto 0),
      pol5_out0(17 downto 0) => pol5_out0(17 downto 0),
      pol5_out1(17 downto 0) => pol5_out1(17 downto 0),
      sync(31 downto 0) => sync(31 downto 0),
      sync_out(0) => sync_out(0)
    );
end STRUCTURE;
