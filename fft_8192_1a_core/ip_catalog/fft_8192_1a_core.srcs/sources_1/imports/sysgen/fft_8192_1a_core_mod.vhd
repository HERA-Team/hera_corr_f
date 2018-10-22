-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity fft_8192_1a_core_stub is
  port (
    pol0_in0 : in std_logic_vector( 12-1 downto 0 );
    pol0_in1 : in std_logic_vector( 12-1 downto 0 );
    pol0_in10 : in std_logic_vector( 12-1 downto 0 );
    pol0_in11 : in std_logic_vector( 12-1 downto 0 );
    pol0_in12 : in std_logic_vector( 12-1 downto 0 );
    pol0_in13 : in std_logic_vector( 12-1 downto 0 );
    pol0_in14 : in std_logic_vector( 12-1 downto 0 );
    pol0_in15 : in std_logic_vector( 12-1 downto 0 );
    pol0_in2 : in std_logic_vector( 12-1 downto 0 );
    pol0_in3 : in std_logic_vector( 12-1 downto 0 );
    pol0_in4 : in std_logic_vector( 12-1 downto 0 );
    pol0_in5 : in std_logic_vector( 12-1 downto 0 );
    pol0_in6 : in std_logic_vector( 12-1 downto 0 );
    pol0_in7 : in std_logic_vector( 12-1 downto 0 );
    pol0_in8 : in std_logic_vector( 12-1 downto 0 );
    pol0_in9 : in std_logic_vector( 12-1 downto 0 );
    shift : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 32-1 downto 0 );
    clk : in std_logic;
    out0 : out std_logic_vector( 36-1 downto 0 );
    out1 : out std_logic_vector( 36-1 downto 0 );
    out2 : out std_logic_vector( 36-1 downto 0 );
    out3 : out std_logic_vector( 36-1 downto 0 );
    out4 : out std_logic_vector( 36-1 downto 0 );
    out5 : out std_logic_vector( 36-1 downto 0 );
    out6 : out std_logic_vector( 36-1 downto 0 );
    out7 : out std_logic_vector( 36-1 downto 0 );
    overflow : out std_logic_vector( 4-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 )
  );
end fft_8192_1a_core_stub;
architecture structural of fft_8192_1a_core_stub is 
begin
  sysgen_dut : entity xil_defaultlib.fft_8192_1a_core_0 
  port map (
    pol0_in0 => pol0_in0,
    pol0_in1 => pol0_in1,
    pol0_in10 => pol0_in10,
    pol0_in11 => pol0_in11,
    pol0_in12 => pol0_in12,
    pol0_in13 => pol0_in13,
    pol0_in14 => pol0_in14,
    pol0_in15 => pol0_in15,
    pol0_in2 => pol0_in2,
    pol0_in3 => pol0_in3,
    pol0_in4 => pol0_in4,
    pol0_in5 => pol0_in5,
    pol0_in6 => pol0_in6,
    pol0_in7 => pol0_in7,
    pol0_in8 => pol0_in8,
    pol0_in9 => pol0_in9,
    shift => shift,
    sync => sync,
    clk => clk,
    out0 => out0,
    out1 => out1,
    out2 => out2,
    out3 => out3,
    out4 => out4,
    out5 => out5,
    out6 => out6,
    out7 => out7,
    overflow => overflow,
    sync_out => sync_out
  );
end structural;
