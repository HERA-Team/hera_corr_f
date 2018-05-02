-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity pfb_fir_gen_8192ch_core_stub is
  port (
    pol0_in0 : in std_logic_vector( 8-1 downto 0 );
    pol0_in1 : in std_logic_vector( 8-1 downto 0 );
    pol1_in0 : in std_logic_vector( 8-1 downto 0 );
    pol1_in1 : in std_logic_vector( 8-1 downto 0 );
    pol2_in0 : in std_logic_vector( 8-1 downto 0 );
    pol2_in1 : in std_logic_vector( 8-1 downto 0 );
    pol3_in0 : in std_logic_vector( 8-1 downto 0 );
    pol3_in1 : in std_logic_vector( 8-1 downto 0 );
    sync : in std_logic_vector( 32-1 downto 0 );
    pol4_in0 : in std_logic_vector( 8-1 downto 0 );
    pol5_in0 : in std_logic_vector( 8-1 downto 0 );
    pol4_in1 : in std_logic_vector( 8-1 downto 0 );
    pol5_in1 : in std_logic_vector( 8-1 downto 0 );
    clk : in std_logic;
    pol0_out0 : out std_logic_vector( 12-1 downto 0 );
    pol0_out1 : out std_logic_vector( 12-1 downto 0 );
    pol1_out0 : out std_logic_vector( 12-1 downto 0 );
    pol1_out1 : out std_logic_vector( 12-1 downto 0 );
    pol2_out0 : out std_logic_vector( 12-1 downto 0 );
    pol2_out1 : out std_logic_vector( 12-1 downto 0 );
    pol3_out0 : out std_logic_vector( 12-1 downto 0 );
    pol3_out1 : out std_logic_vector( 12-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 );
    pol4_out0 : out std_logic_vector( 12-1 downto 0 );
    pol5_out0 : out std_logic_vector( 12-1 downto 0 );
    pol4_out1 : out std_logic_vector( 12-1 downto 0 );
    pol5_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_stub;
architecture structural of pfb_fir_gen_8192ch_core_stub is 
begin
  sysgen_dut : entity xil_defaultlib.pfb_fir_gen_8192ch_core_0 
  port map (
    pol0_in0 => pol0_in0,
    pol0_in1 => pol0_in1,
    pol1_in0 => pol1_in0,
    pol1_in1 => pol1_in1,
    pol2_in0 => pol2_in0,
    pol2_in1 => pol2_in1,
    pol3_in0 => pol3_in0,
    pol3_in1 => pol3_in1,
    sync => sync,
    pol4_in0 => pol4_in0,
    pol5_in0 => pol5_in0,
    pol4_in1 => pol4_in1,
    pol5_in1 => pol5_in1,
    clk => clk,
    pol0_out0 => pol0_out0,
    pol0_out1 => pol0_out1,
    pol1_out0 => pol1_out0,
    pol1_out1 => pol1_out1,
    pol2_out0 => pol2_out0,
    pol2_out1 => pol2_out1,
    pol3_out0 => pol3_out0,
    pol3_out1 => pol3_out1,
    sync_out => sync_out,
    pol4_out0 => pol4_out0,
    pol5_out0 => pol5_out0,
    pol4_out1 => pol4_out1,
    pol5_out1 => pol5_out1
  );
end structural;
