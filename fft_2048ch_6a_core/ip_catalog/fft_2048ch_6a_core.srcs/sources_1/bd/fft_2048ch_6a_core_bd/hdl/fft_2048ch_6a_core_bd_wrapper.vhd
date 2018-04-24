--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.4 (lin64) Build 1733598 Wed Dec 14 22:35:42 MST 2016
--Date        : Fri Feb 23 16:05:01 2018
--Host        : acme1 running 64-bit Ubuntu 16.04.2 LTS
--Command     : generate_target fft_2048ch_6a_core_bd_wrapper.bd
--Design      : fft_2048ch_6a_core_bd_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity fft_2048ch_6a_core_bd_wrapper is
  port (
    clk : in STD_LOGIC;
    out0 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out1 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out2 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out3 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out4 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out5 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    overflow : out STD_LOGIC_VECTOR ( 5 downto 0 );
    pol0_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol4_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol4_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    shift : in STD_LOGIC_VECTOR ( 15 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end fft_2048ch_6a_core_bd_wrapper;

architecture STRUCTURE of fft_2048ch_6a_core_bd_wrapper is
  component fft_2048ch_6a_core_bd is
  port (
    clk : in STD_LOGIC;
    out0 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out1 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out2 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out3 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out4 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    out5 : out STD_LOGIC_VECTOR ( 37 downto 0 );
    overflow : out STD_LOGIC_VECTOR ( 5 downto 0 );
    pol0_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol0_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol1_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol2_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol3_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol4_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol4_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_in0 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    pol5_in1 : in STD_LOGIC_VECTOR ( 11 downto 0 );
    shift : in STD_LOGIC_VECTOR ( 15 downto 0 );
    sync : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sync_out : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component fft_2048ch_6a_core_bd;
begin
fft_2048ch_6a_core_bd_i: component fft_2048ch_6a_core_bd
     port map (
      clk => clk,
      out0(37 downto 0) => out0(37 downto 0),
      out1(37 downto 0) => out1(37 downto 0),
      out2(37 downto 0) => out2(37 downto 0),
      out3(37 downto 0) => out3(37 downto 0),
      out4(37 downto 0) => out4(37 downto 0),
      out5(37 downto 0) => out5(37 downto 0),
      overflow(5 downto 0) => overflow(5 downto 0),
      pol0_in0(11 downto 0) => pol0_in0(11 downto 0),
      pol0_in1(11 downto 0) => pol0_in1(11 downto 0),
      pol1_in0(11 downto 0) => pol1_in0(11 downto 0),
      pol1_in1(11 downto 0) => pol1_in1(11 downto 0),
      pol2_in0(11 downto 0) => pol2_in0(11 downto 0),
      pol2_in1(11 downto 0) => pol2_in1(11 downto 0),
      pol3_in0(11 downto 0) => pol3_in0(11 downto 0),
      pol3_in1(11 downto 0) => pol3_in1(11 downto 0),
      pol4_in0(11 downto 0) => pol4_in0(11 downto 0),
      pol4_in1(11 downto 0) => pol4_in1(11 downto 0),
      pol5_in0(11 downto 0) => pol5_in0(11 downto 0),
      pol5_in1(11 downto 0) => pol5_in1(11 downto 0),
      shift(15 downto 0) => shift(15 downto 0),
      sync(31 downto 0) => sync(31 downto 0),
      sync_out(0) => sync_out(0)
    );
end STRUCTURE;
