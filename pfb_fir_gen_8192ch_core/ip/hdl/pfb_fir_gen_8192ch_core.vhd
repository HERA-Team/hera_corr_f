-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x1 is
  port (
    in1 : in std_logic_vector( 12-1 downto 0 );
    in2 : in std_logic_vector( 12-1 downto 0 );
    in3 : in std_logic_vector( 12-1 downto 0 );
    in4 : in std_logic_vector( 12-1 downto 0 );
    in5 : in std_logic_vector( 12-1 downto 0 );
    in6 : in std_logic_vector( 12-1 downto 0 );
    in7 : in std_logic_vector( 12-1 downto 0 );
    in8 : in std_logic_vector( 12-1 downto 0 );
    in9 : in std_logic_vector( 12-1 downto 0 );
    in10 : in std_logic_vector( 12-1 downto 0 );
    in11 : in std_logic_vector( 12-1 downto 0 );
    in12 : in std_logic_vector( 12-1 downto 0 );
    bus_out : out std_logic_vector( 144-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x1;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x1 is 
  signal adder_s_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x9 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x1 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x4 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x10 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x6 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x5 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x3 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x2 : std_logic_vector( 12-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 144-1 downto 0 );
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x8 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x7 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 12-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  adder_s_net_x10 <= in1;
  adder_s_net_x6 <= in2;
  adder_s_net_x5 <= in3;
  adder_s_net_x4 <= in4;
  adder_s_net_x3 <= in5;
  adder_s_net_x2 <= in6;
  adder_s_net_x1 <= in7;
  adder_s_net_x9 <= in8;
  adder_s_net <= in9;
  adder_s_net_x0 <= in10;
  adder_s_net_x8 <= in11;
  adder_s_net_x7 <= in12;
  concatenate : entity xil_defaultlib.sysgen_concat_9721c7f765 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x10,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x6,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x5,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x4,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x3,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x2,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x1,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x9,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x0,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x8,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => adder_s_net_x7,
    output_port => reinterpret12_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv1 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv1;
architecture structural of pfb_fir_gen_8192ch_core_conv1 is 
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret12_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret12_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret12_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv10
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv10 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv10;
architecture structural of pfb_fir_gen_8192ch_core_conv10 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret3_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret3_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv11
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv11 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv11;
architecture structural of pfb_fir_gen_8192ch_core_conv11 is 
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret2_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret2_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv12
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv12 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv12;
architecture structural of pfb_fir_gen_8192ch_core_conv12 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret1_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret1_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv2 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv2;
architecture structural of pfb_fir_gen_8192ch_core_conv2 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret11_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret11_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret11_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv3 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv3;
architecture structural of pfb_fir_gen_8192ch_core_conv3 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret10_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret10_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret10_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv4 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv4;
architecture structural of pfb_fir_gen_8192ch_core_conv4 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret9_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret9_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret9_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv5
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv5 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv5;
architecture structural of pfb_fir_gen_8192ch_core_conv5 is 
  signal reinterpret8_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret8_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret8_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret8_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv6
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv6 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv6;
architecture structural of pfb_fir_gen_8192ch_core_conv6 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret7_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret7_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret7_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv7
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv7 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv7;
architecture structural of pfb_fir_gen_8192ch_core_conv7 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret6_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret6_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret6_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv8
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv8 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv8;
architecture structural of pfb_fir_gen_8192ch_core_conv8 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret5_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret5_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/conv9
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_conv9 is
  port (
    in_x0 : in std_logic_vector( 22-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_conv9;
architecture structural of pfb_fir_gen_8192ch_core_conv9 is 
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net : std_logic_vector( 23-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal tweak_op_y_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal force1_output_port_net : std_logic_vector( 23-1 downto 0 );
  signal force2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal almost_half_op_net : std_logic_vector( 20-1 downto 0 );
  signal bit_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= adder_s_net;
  reinterpret4_output_port_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_f9ce0e45ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => tweak_op_y_net,
    y => concat_y_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net,
    output_port => reinterpret_output_port_net
  );
  adder : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 20,
    a_width => 23,
    b_arith => xlUnsigned,
    b_bin_pt => 20,
    b_width => 20,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 24,
    core_name0 => "pfb_fir_gen_8192ch_core_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 24,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 11,
    s_width => 12
  )
  port map (
    clr => '0',
    en => "1",
    a => force1_output_port_net,
    b => force2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => adder_s_net
  );
  almost_half : entity xil_defaultlib.sysgen_constant_67bd5d6ad2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => almost_half_op_net
  );
  bit : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 22,
    y_width => 1
  )
  port map (
    x => reinterpret4_output_port_net,
    y => bit_y_net
  );
  force1 : entity xil_defaultlib.sysgen_reinterpret_83f290ffb0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => force1_output_port_net
  );
  force2 : entity xil_defaultlib.sysgen_reinterpret_b64aef9e9c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => almost_half_op_net,
    output_port => force2_output_port_net
  );
  tweak_op : entity xil_defaultlib.sysgen_logical_1622596c0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => bit_y_net,
    d1 => constant_op_net,
    y => tweak_op_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert/debus
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus is
  port (
    bus_in : in std_logic_vector( 264-1 downto 0 );
    msb_out12 : out std_logic_vector( 22-1 downto 0 );
    out11 : out std_logic_vector( 22-1 downto 0 );
    out10 : out std_logic_vector( 22-1 downto 0 );
    out9 : out std_logic_vector( 22-1 downto 0 );
    out8 : out std_logic_vector( 22-1 downto 0 );
    out7 : out std_logic_vector( 22-1 downto 0 );
    out6 : out std_logic_vector( 22-1 downto 0 );
    out5 : out std_logic_vector( 22-1 downto 0 );
    out4 : out std_logic_vector( 22-1 downto 0 );
    out3 : out std_logic_vector( 22-1 downto 0 );
    out2 : out std_logic_vector( 22-1 downto 0 );
    lsb_out1 : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus;
architecture structural of pfb_fir_gen_8192ch_core_debus is 
  signal slice8_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 264-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 22-1 downto 0 );
begin
  msb_out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 21,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 22,
    new_msb => 43,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 242,
    new_msb => 263,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 220,
    new_msb => 241,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 198,
    new_msb => 219,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 176,
    new_msb => 197,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 154,
    new_msb => 175,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 132,
    new_msb => 153,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 110,
    new_msb => 131,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 88,
    new_msb => 109,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 66,
    new_msb => 87,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 44,
    new_msb => 65,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_convert
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bus_convert is
  port (
    din : in std_logic_vector( 264-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 144-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bus_convert;
architecture structural of pfb_fir_gen_8192ch_core_bus_convert is 
  signal concatenate_y_net : std_logic_vector( 144-1 downto 0 );
  signal concatenate_y_net_x0 : std_logic_vector( 264-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal adder_s_net : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x3 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x4 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x5 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x6 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x7 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x8 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x9 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x10 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x1 : std_logic_vector( 12-1 downto 0 );
  signal adder_s_net_x2 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 22-1 downto 0 );
begin
  dout <= concatenate_y_net;
  concatenate_y_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x1 
  port map (
    in1 => adder_s_net,
    in2 => adder_s_net_x3,
    in3 => adder_s_net_x4,
    in4 => adder_s_net_x5,
    in5 => adder_s_net_x6,
    in6 => adder_s_net_x7,
    in7 => adder_s_net_x8,
    in8 => adder_s_net_x9,
    in9 => adder_s_net_x10,
    in10 => adder_s_net_x0,
    in11 => adder_s_net_x1,
    in12 => adder_s_net_x2,
    bus_out => concatenate_y_net
  );
  conv1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv1 
  port map (
    in_x0 => reinterpret12_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net
  );
  conv10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv10 
  port map (
    in_x0 => reinterpret3_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x0
  );
  conv11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv11 
  port map (
    in_x0 => reinterpret2_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x1
  );
  conv12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv12 
  port map (
    in_x0 => reinterpret1_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x2
  );
  conv2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv2 
  port map (
    in_x0 => reinterpret11_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x3
  );
  conv3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv3 
  port map (
    in_x0 => reinterpret10_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x4
  );
  conv4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv4 
  port map (
    in_x0 => reinterpret9_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x5
  );
  conv5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv5 
  port map (
    in_x0 => reinterpret8_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x6
  );
  conv6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv6 
  port map (
    in_x0 => reinterpret7_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x7
  );
  conv7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv7 
  port map (
    in_x0 => reinterpret6_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x8
  );
  conv8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv8 
  port map (
    in_x0 => reinterpret5_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x9
  );
  conv9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_conv9 
  port map (
    in_x0 => reinterpret4_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => adder_s_net_x10
  );
  debus : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus 
  port map (
    bus_in => concatenate_y_net_x0,
    msb_out12 => reinterpret12_output_port_net,
    out11 => reinterpret11_output_port_net,
    out10 => reinterpret10_output_port_net,
    out9 => reinterpret9_output_port_net,
    out8 => reinterpret8_output_port_net,
    out7 => reinterpret7_output_port_net,
    out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_create
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bus_create is
  port (
    in1 : in std_logic_vector( 8-1 downto 0 );
    in2 : in std_logic_vector( 8-1 downto 0 );
    in3 : in std_logic_vector( 8-1 downto 0 );
    in4 : in std_logic_vector( 8-1 downto 0 );
    in5 : in std_logic_vector( 8-1 downto 0 );
    in6 : in std_logic_vector( 8-1 downto 0 );
    in7 : in std_logic_vector( 8-1 downto 0 );
    in8 : in std_logic_vector( 8-1 downto 0 );
    in9 : in std_logic_vector( 8-1 downto 0 );
    in10 : in std_logic_vector( 8-1 downto 0 );
    in11 : in std_logic_vector( 8-1 downto 0 );
    in12 : in std_logic_vector( 8-1 downto 0 );
    bus_out : out std_logic_vector( 96-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bus_create;
architecture structural of pfb_fir_gen_8192ch_core_bus_create is 
  signal concatenate_y_net : std_logic_vector( 96-1 downto 0 );
  signal pol0_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol4_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol5_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol0_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol4_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol5_in1_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 8-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  pol0_in0_net <= in1;
  pol1_in0_net <= in2;
  pol2_in0_net <= in3;
  pol3_in0_net <= in4;
  pol4_in0_net <= in5;
  pol5_in0_net <= in6;
  pol0_in1_net <= in7;
  pol1_in1_net <= in8;
  pol2_in1_net <= in9;
  pol3_in1_net <= in10;
  pol4_in1_net <= in11;
  pol5_in1_net <= in12;
  concatenate : entity xil_defaultlib.sysgen_concat_0794bf055a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol0_in0_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol1_in0_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol2_in0_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol3_in0_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol4_in0_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol5_in0_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol0_in1_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol1_in1_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol2_in1_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol3_in1_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol4_in1_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_0ff4fd1cd8 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol5_in1_net,
    output_port => reinterpret12_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_expand
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bus_expand is
  port (
    bus_in : in std_logic_vector( 144-1 downto 0 );
    msb_out12 : out std_logic_vector( 12-1 downto 0 );
    out11 : out std_logic_vector( 12-1 downto 0 );
    out10 : out std_logic_vector( 12-1 downto 0 );
    out9 : out std_logic_vector( 12-1 downto 0 );
    out8 : out std_logic_vector( 12-1 downto 0 );
    out7 : out std_logic_vector( 12-1 downto 0 );
    out6 : out std_logic_vector( 12-1 downto 0 );
    out5 : out std_logic_vector( 12-1 downto 0 );
    out4 : out std_logic_vector( 12-1 downto 0 );
    out3 : out std_logic_vector( 12-1 downto 0 );
    out2 : out std_logic_vector( 12-1 downto 0 );
    lsb_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bus_expand;
architecture structural of pfb_fir_gen_8192ch_core_bus_expand is 
  signal reinterpret12_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 144-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 12-1 downto 0 );
begin
  msb_out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 11,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 23,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 132,
    new_msb => 143,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 120,
    new_msb => 131,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 108,
    new_msb => 119,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 96,
    new_msb => 107,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 84,
    new_msb => 95,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 72,
    new_msb => 83,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 60,
    new_msb => 71,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 48,
    new_msb => 59,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 47,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 35,
    x_width => 144,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_scale/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x2 is
  port (
    in1 : in std_logic_vector( 22-1 downto 0 );
    in2 : in std_logic_vector( 22-1 downto 0 );
    in3 : in std_logic_vector( 22-1 downto 0 );
    in4 : in std_logic_vector( 22-1 downto 0 );
    in5 : in std_logic_vector( 22-1 downto 0 );
    in6 : in std_logic_vector( 22-1 downto 0 );
    in7 : in std_logic_vector( 22-1 downto 0 );
    in8 : in std_logic_vector( 22-1 downto 0 );
    in9 : in std_logic_vector( 22-1 downto 0 );
    in10 : in std_logic_vector( 22-1 downto 0 );
    in11 : in std_logic_vector( 22-1 downto 0 );
    in12 : in std_logic_vector( 22-1 downto 0 );
    bus_out : out std_logic_vector( 264-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x2;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x2 is 
  signal concatenate_y_net : std_logic_vector( 264-1 downto 0 );
  signal scale1_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale2_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale3_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale4_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale5_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale6_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale7_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale8_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale9_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale10_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale11_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale12_op_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 22-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  scale1_op_net <= in1;
  scale2_op_net <= in2;
  scale3_op_net <= in3;
  scale4_op_net <= in4;
  scale5_op_net <= in5;
  scale6_op_net <= in6;
  scale7_op_net <= in7;
  scale8_op_net <= in8;
  scale9_op_net <= in9;
  scale10_op_net <= in10;
  scale11_op_net <= in11;
  scale12_op_net <= in12;
  concatenate : entity xil_defaultlib.sysgen_concat_ae21264f3f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale1_op_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale2_op_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale3_op_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale4_op_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale5_op_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale6_op_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale7_op_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale8_op_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale9_op_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale10_op_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale11_op_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => scale12_op_net,
    output_port => reinterpret12_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_scale/debus
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_x0 is
  port (
    bus_in : in std_logic_vector( 264-1 downto 0 );
    msb_out12 : out std_logic_vector( 22-1 downto 0 );
    out11 : out std_logic_vector( 22-1 downto 0 );
    out10 : out std_logic_vector( 22-1 downto 0 );
    out9 : out std_logic_vector( 22-1 downto 0 );
    out8 : out std_logic_vector( 22-1 downto 0 );
    out7 : out std_logic_vector( 22-1 downto 0 );
    out6 : out std_logic_vector( 22-1 downto 0 );
    out5 : out std_logic_vector( 22-1 downto 0 );
    out4 : out std_logic_vector( 22-1 downto 0 );
    out3 : out std_logic_vector( 22-1 downto 0 );
    out2 : out std_logic_vector( 22-1 downto 0 );
    lsb_out1 : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_x0;
architecture structural of pfb_fir_gen_8192ch_core_debus_x0 is 
  signal reinterpret12_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 264-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 22-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 22-1 downto 0 );
begin
  msb_out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 21,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 22,
    new_msb => 43,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 242,
    new_msb => 263,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 220,
    new_msb => 241,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 198,
    new_msb => 219,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 176,
    new_msb => 197,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 154,
    new_msb => 175,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 132,
    new_msb => 153,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 110,
    new_msb => 131,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 88,
    new_msb => 109,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 66,
    new_msb => 87,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 44,
    new_msb => 65,
    x_width => 264,
    y_width => 22
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_0768604b5b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/bus_scale
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bus_scale is
  port (
    din : in std_logic_vector( 264-1 downto 0 );
    dout : out std_logic_vector( 264-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bus_scale;
architecture structural of pfb_fir_gen_8192ch_core_bus_scale is 
  signal concatenate_y_net_x0 : std_logic_vector( 264-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 264-1 downto 0 );
  signal scale1_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale2_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale3_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale4_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale5_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale6_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale7_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale8_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale9_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale10_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale11_op_net : std_logic_vector( 22-1 downto 0 );
  signal scale12_op_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 22-1 downto 0 );
begin
  dout <= concatenate_y_net_x0;
  concatenate_y_net <= din;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x2 
  port map (
    in1 => scale1_op_net,
    in2 => scale2_op_net,
    in3 => scale3_op_net,
    in4 => scale4_op_net,
    in5 => scale5_op_net,
    in6 => scale6_op_net,
    in7 => scale7_op_net,
    in8 => scale8_op_net,
    in9 => scale9_op_net,
    in10 => scale10_op_net,
    in11 => scale11_op_net,
    in12 => scale12_op_net,
    bus_out => concatenate_y_net_x0
  );
  debus : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_x0 
  port map (
    bus_in => concatenate_y_net,
    msb_out12 => reinterpret12_output_port_net,
    out11 => reinterpret11_output_port_net,
    out10 => reinterpret10_output_port_net,
    out9 => reinterpret9_output_port_net,
    out8 => reinterpret8_output_port_net,
    out7 => reinterpret7_output_port_net,
    out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
  scale1 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret12_output_port_net,
    op => scale1_op_net
  );
  scale2 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret11_output_port_net,
    op => scale2_op_net
  );
  scale3 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret10_output_port_net,
    op => scale3_op_net
  );
  scale4 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret9_output_port_net,
    op => scale4_op_net
  );
  scale5 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret8_output_port_net,
    op => scale5_op_net
  );
  scale6 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret7_output_port_net,
    op => scale6_op_net
  );
  scale7 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret6_output_port_net,
    op => scale7_op_net
  );
  scale8 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret5_output_port_net,
    op => scale8_op_net
  );
  scale9 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret4_output_port_net,
    op => scale9_op_net
  );
  scale10 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret3_output_port_net,
    op => scale10_op_net
  );
  scale11 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret2_output_port_net,
    op => scale11_op_net
  );
  scale12 : entity xil_defaultlib.sysgen_scale_28178ed4cb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => reinterpret1_output_port_net,
    op => scale12_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/coeff_munge/join
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_join is
  port (
    in1 : in std_logic_vector( 12-1 downto 0 );
    in7 : in std_logic_vector( 12-1 downto 0 );
    in13 : in std_logic_vector( 12-1 downto 0 );
    in19 : in std_logic_vector( 12-1 downto 0 );
    in25 : in std_logic_vector( 12-1 downto 0 );
    in31 : in std_logic_vector( 12-1 downto 0 );
    in37 : in std_logic_vector( 12-1 downto 0 );
    in43 : in std_logic_vector( 12-1 downto 0 );
    bus_out : out std_logic_vector( 576-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_join;
architecture structural of pfb_fir_gen_8192ch_core_join is 
  signal concatenate_y_net : std_logic_vector( 576-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret33_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret34_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret35_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret36_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret37_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret38_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret39_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret40_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret41_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret42_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret43_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret44_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret45_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret46_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret47_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret48_output_port_net : std_logic_vector( 12-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  reinterpret2_output_port_net <= in1;
  reinterpret1_output_port_net <= in7;
  reinterpret4_output_port_net_x0 <= in13;
  reinterpret3_output_port_net <= in19;
  reinterpret6_output_port_net_x0 <= in25;
  reinterpret5_output_port_net_x0 <= in31;
  reinterpret8_output_port_net_x0 <= in37;
  reinterpret7_output_port_net_x0 <= in43;
  concatenate : entity xil_defaultlib.sysgen_concat_0d8a4dca4b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net_x0,
    in1 => reinterpret2_output_port_net_x0,
    in2 => reinterpret3_output_port_net_x0,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    in12 => reinterpret13_output_port_net,
    in13 => reinterpret14_output_port_net,
    in14 => reinterpret15_output_port_net,
    in15 => reinterpret16_output_port_net,
    in16 => reinterpret17_output_port_net,
    in17 => reinterpret18_output_port_net,
    in18 => reinterpret19_output_port_net,
    in19 => reinterpret20_output_port_net,
    in20 => reinterpret21_output_port_net,
    in21 => reinterpret22_output_port_net,
    in22 => reinterpret23_output_port_net,
    in23 => reinterpret24_output_port_net,
    in24 => reinterpret25_output_port_net,
    in25 => reinterpret26_output_port_net,
    in26 => reinterpret27_output_port_net,
    in27 => reinterpret28_output_port_net,
    in28 => reinterpret29_output_port_net,
    in29 => reinterpret30_output_port_net,
    in30 => reinterpret31_output_port_net,
    in31 => reinterpret32_output_port_net,
    in32 => reinterpret33_output_port_net,
    in33 => reinterpret34_output_port_net,
    in34 => reinterpret35_output_port_net,
    in35 => reinterpret36_output_port_net,
    in36 => reinterpret37_output_port_net,
    in37 => reinterpret38_output_port_net,
    in38 => reinterpret39_output_port_net,
    in39 => reinterpret40_output_port_net,
    in40 => reinterpret41_output_port_net,
    in41 => reinterpret42_output_port_net,
    in42 => reinterpret43_output_port_net,
    in43 => reinterpret44_output_port_net,
    in44 => reinterpret45_output_port_net,
    in45 => reinterpret46_output_port_net,
    in46 => reinterpret47_output_port_net,
    in47 => reinterpret48_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret1_output_port_net_x0
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret2_output_port_net_x0
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret3_output_port_net_x0
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret12_output_port_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net_x0,
    output_port => reinterpret13_output_port_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net_x0,
    output_port => reinterpret14_output_port_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net_x0,
    output_port => reinterpret15_output_port_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net_x0,
    output_port => reinterpret16_output_port_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net_x0,
    output_port => reinterpret17_output_port_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net_x0,
    output_port => reinterpret18_output_port_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret19_output_port_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret20_output_port_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret21_output_port_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret22_output_port_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret23_output_port_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret24_output_port_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret6_output_port_net_x0,
    output_port => reinterpret25_output_port_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret6_output_port_net_x0,
    output_port => reinterpret26_output_port_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret6_output_port_net_x0,
    output_port => reinterpret27_output_port_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret6_output_port_net_x0,
    output_port => reinterpret28_output_port_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret6_output_port_net_x0,
    output_port => reinterpret29_output_port_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret6_output_port_net_x0,
    output_port => reinterpret30_output_port_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net_x0,
    output_port => reinterpret31_output_port_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net_x0,
    output_port => reinterpret32_output_port_net
  );
  reinterpret33 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net_x0,
    output_port => reinterpret33_output_port_net
  );
  reinterpret34 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net_x0,
    output_port => reinterpret34_output_port_net
  );
  reinterpret35 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net_x0,
    output_port => reinterpret35_output_port_net
  );
  reinterpret36 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret5_output_port_net_x0,
    output_port => reinterpret36_output_port_net
  );
  reinterpret37 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret8_output_port_net_x0,
    output_port => reinterpret37_output_port_net
  );
  reinterpret38 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret8_output_port_net_x0,
    output_port => reinterpret38_output_port_net
  );
  reinterpret39 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret8_output_port_net_x0,
    output_port => reinterpret39_output_port_net
  );
  reinterpret40 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret8_output_port_net_x0,
    output_port => reinterpret40_output_port_net
  );
  reinterpret41 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret8_output_port_net_x0,
    output_port => reinterpret41_output_port_net
  );
  reinterpret42 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret8_output_port_net_x0,
    output_port => reinterpret42_output_port_net
  );
  reinterpret43 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret7_output_port_net_x0,
    output_port => reinterpret43_output_port_net
  );
  reinterpret44 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret7_output_port_net_x0,
    output_port => reinterpret44_output_port_net
  );
  reinterpret45 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret7_output_port_net_x0,
    output_port => reinterpret45_output_port_net
  );
  reinterpret46 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret7_output_port_net_x0,
    output_port => reinterpret46_output_port_net
  );
  reinterpret47 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret7_output_port_net_x0,
    output_port => reinterpret47_output_port_net
  );
  reinterpret48 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret7_output_port_net_x0,
    output_port => reinterpret48_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/coeff_munge/split
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_split is
  port (
    bus_in : in std_logic_vector( 96-1 downto 0 );
    msb_out8 : out std_logic_vector( 12-1 downto 0 );
    out7 : out std_logic_vector( 12-1 downto 0 );
    out6 : out std_logic_vector( 12-1 downto 0 );
    out5 : out std_logic_vector( 12-1 downto 0 );
    out4 : out std_logic_vector( 12-1 downto 0 );
    out3 : out std_logic_vector( 12-1 downto 0 );
    out2 : out std_logic_vector( 12-1 downto 0 );
    lsb_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_split;
architecture structural of pfb_fir_gen_8192ch_core_split is 
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 96-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 12-1 downto 0 );
begin
  msb_out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  reinterpret_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 11,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 23,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice2_y_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 84,
    new_msb => 95,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 72,
    new_msb => 83,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 60,
    new_msb => 71,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 48,
    new_msb => 59,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 47,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 35,
    x_width => 96,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/coeff_munge
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_coeff_munge is
  port (
    din : in std_logic_vector( 96-1 downto 0 );
    dout : out std_logic_vector( 576-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_coeff_munge;
architecture structural of pfb_fir_gen_8192ch_core_coeff_munge is 
  signal reinterpret_out_output_port_net : std_logic_vector( 576-1 downto 0 );
  signal concat_y_net : std_logic_vector( 96-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 576-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 96-1 downto 0 );
begin
  dout <= reinterpret_out_output_port_net;
  concat_y_net <= din;
  join : entity xil_defaultlib.pfb_fir_gen_8192ch_core_join 
  port map (
    in1 => reinterpret2_output_port_net,
    in7 => reinterpret1_output_port_net,
    in13 => reinterpret4_output_port_net,
    in19 => reinterpret3_output_port_net,
    in25 => reinterpret6_output_port_net,
    in31 => reinterpret5_output_port_net,
    in37 => reinterpret8_output_port_net,
    in43 => reinterpret7_output_port_net,
    bus_out => concatenate_y_net
  );
  split : entity xil_defaultlib.pfb_fir_gen_8192ch_core_split 
  port map (
    bus_in => reinterpret_output_port_net,
    msb_out8 => reinterpret8_output_port_net,
    out7 => reinterpret7_output_port_net,
    out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
  reinterpret_out : entity xil_defaultlib.sysgen_reinterpret_bd1dc971fe 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concatenate_y_net,
    output_port => reinterpret_out_output_port_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_930e14df41 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concat_y_net,
    output_port => reinterpret_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/a_expand
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_a_expand is
  port (
    bus_in : in std_logic_vector( 48-1 downto 0 );
    msb_out4 : out std_logic_vector( 12-1 downto 0 );
    out3 : out std_logic_vector( 12-1 downto 0 );
    out2 : out std_logic_vector( 12-1 downto 0 );
    lsb_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_a_expand;
architecture structural of pfb_fir_gen_8192ch_core_a_expand is 
  signal slice4_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 48-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 12-1 downto 0 );
begin
  msb_out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 11,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 23,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 47,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 35,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/b_expand
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_b_expand is
  port (
    bus_in : in std_logic_vector( 48-1 downto 0 );
    msb_out4 : out std_logic_vector( 12-1 downto 0 );
    out3 : out std_logic_vector( 12-1 downto 0 );
    out2 : out std_logic_vector( 12-1 downto 0 );
    lsb_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_b_expand;
architecture structural of pfb_fir_gen_8192ch_core_b_expand is 
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret_out_output_port_net : std_logic_vector( 48-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 12-1 downto 0 );
begin
  msb_out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  reinterpret_out_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 11,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_out_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 23,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_out_output_port_net,
    y => slice2_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 47,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_out_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 35,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_out_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/munge/join
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_join_x0 is
  port (
    in1 : in std_logic_vector( 12-1 downto 0 );
    in2 : in std_logic_vector( 12-1 downto 0 );
    in3 : in std_logic_vector( 12-1 downto 0 );
    in4 : in std_logic_vector( 12-1 downto 0 );
    bus_out : out std_logic_vector( 48-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_join_x0;
architecture structural of pfb_fir_gen_8192ch_core_join_x0 is 
  signal concatenate_y_net : std_logic_vector( 48-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  reinterpret2_output_port_net <= in1;
  reinterpret1_output_port_net <= in2;
  reinterpret4_output_port_net_x0 <= in3;
  reinterpret3_output_port_net <= in4;
  concatenate : entity xil_defaultlib.sysgen_concat_bebb31f338 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net_x0,
    in1 => reinterpret2_output_port_net_x0,
    in2 => reinterpret3_output_port_net_x0,
    in3 => reinterpret4_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret2_output_port_net,
    output_port => reinterpret1_output_port_net_x0
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret1_output_port_net,
    output_port => reinterpret2_output_port_net_x0
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret4_output_port_net_x0,
    output_port => reinterpret3_output_port_net_x0
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => reinterpret3_output_port_net,
    output_port => reinterpret4_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/munge/split
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_split_x0 is
  port (
    bus_in : in std_logic_vector( 48-1 downto 0 );
    msb_out4 : out std_logic_vector( 12-1 downto 0 );
    out3 : out std_logic_vector( 12-1 downto 0 );
    out2 : out std_logic_vector( 12-1 downto 0 );
    lsb_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_split_x0;
architecture structural of pfb_fir_gen_8192ch_core_split_x0 is 
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 48-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 12-1 downto 0 );
begin
  msb_out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  reinterpret_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 11,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 23,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice2_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 47,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 35,
    x_width => 48,
    y_width => 12
  )
  port map (
    x => reinterpret_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_802d6b9b33 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/munge
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_munge is
  port (
    din : in std_logic_vector( 48-1 downto 0 );
    dout : out std_logic_vector( 48-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_munge;
architecture structural of pfb_fir_gen_8192ch_core_munge is 
  signal reinterpret_out_output_port_net : std_logic_vector( 48-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 48-1 downto 0 );
  signal concatenate_y_net_x0 : std_logic_vector( 48-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 48-1 downto 0 );
begin
  dout <= reinterpret_out_output_port_net;
  concatenate_y_net <= din;
  join : entity xil_defaultlib.pfb_fir_gen_8192ch_core_join_x0 
  port map (
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret1_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret3_output_port_net,
    bus_out => concatenate_y_net_x0
  );
  split : entity xil_defaultlib.pfb_fir_gen_8192ch_core_split_x0 
  port map (
    bus_in => reinterpret_output_port_net,
    msb_out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
  reinterpret_out : entity xil_defaultlib.sysgen_reinterpret_f0389a70e2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concatenate_y_net_x0,
    output_port => reinterpret_out_output_port_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_f0389a70e2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => concatenate_y_net,
    output_port => reinterpret_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/A_bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_a_bussify_x0 is
  port (
    in1 : in std_logic_vector( 3-1 downto 0 );
    in2 : in std_logic_vector( 9-1 downto 0 );
    in3 : in std_logic_vector( 9-1 downto 0 );
    in4 : in std_logic_vector( 9-1 downto 0 );
    in5 : in std_logic_vector( 9-1 downto 0 );
    in6 : in std_logic_vector( 9-1 downto 0 );
    bus_out : out std_logic_vector( 48-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_a_bussify_x0;
architecture structural of pfb_fir_gen_8192ch_core_a_bussify_x0 is 
  signal concatenate_y_net : std_logic_vector( 48-1 downto 0 );
  signal bram0_douta_net : std_logic_vector( 3-1 downto 0 );
  signal bram1_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram2_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram3_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram4_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram5_douta_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 3-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 9-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  bram0_douta_net <= in1;
  bram1_douta_net <= in2;
  bram2_douta_net <= in3;
  bram3_douta_net <= in4;
  bram4_douta_net <= in5;
  bram5_douta_net <= in6;
  concatenate : entity xil_defaultlib.sysgen_concat_1d00915a51 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_19ab038221 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram0_douta_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram1_douta_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram2_douta_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram3_douta_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram4_douta_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram5_douta_net,
    output_port => reinterpret6_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/B_bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_b_bussify is
  port (
    in1 : in std_logic_vector( 3-1 downto 0 );
    in2 : in std_logic_vector( 9-1 downto 0 );
    in3 : in std_logic_vector( 9-1 downto 0 );
    in4 : in std_logic_vector( 9-1 downto 0 );
    in5 : in std_logic_vector( 9-1 downto 0 );
    in6 : in std_logic_vector( 9-1 downto 0 );
    bus_out : out std_logic_vector( 48-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_b_bussify;
architecture structural of pfb_fir_gen_8192ch_core_b_bussify is 
  signal concatenate_y_net : std_logic_vector( 48-1 downto 0 );
  signal bram0_doutb_net : std_logic_vector( 3-1 downto 0 );
  signal bram1_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram2_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram3_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram4_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram5_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 3-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 9-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  bram0_doutb_net <= in1;
  bram1_doutb_net <= in2;
  bram2_doutb_net <= in3;
  bram3_doutb_net <= in4;
  bram4_doutb_net <= in5;
  bram5_doutb_net <= in6;
  concatenate : entity xil_defaultlib.sysgen_concat_1d00915a51 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_19ab038221 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram0_doutb_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram1_doutb_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram2_doutb_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram3_doutb_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram4_doutb_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram5_doutb_net,
    output_port => reinterpret6_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/debus_addra
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_addra is
  port (
    bus_in : in std_logic_vector( 78-1 downto 0 );
    msb_out6 : out std_logic_vector( 13-1 downto 0 );
    out5 : out std_logic_vector( 13-1 downto 0 );
    out4 : out std_logic_vector( 13-1 downto 0 );
    out3 : out std_logic_vector( 13-1 downto 0 );
    out2 : out std_logic_vector( 13-1 downto 0 );
    lsb_out1 : out std_logic_vector( 13-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_addra;
architecture structural of pfb_fir_gen_8192ch_core_debus_addra is 
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 78-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 13-1 downto 0 );
begin
  msb_out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 12,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 13,
    new_msb => 25,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 65,
    new_msb => 77,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 64,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 39,
    new_msb => 51,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 38,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/debus_addrb
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_addrb is
  port (
    bus_in : in std_logic_vector( 78-1 downto 0 );
    msb_out6 : out std_logic_vector( 13-1 downto 0 );
    out5 : out std_logic_vector( 13-1 downto 0 );
    out4 : out std_logic_vector( 13-1 downto 0 );
    out3 : out std_logic_vector( 13-1 downto 0 );
    out2 : out std_logic_vector( 13-1 downto 0 );
    lsb_out1 : out std_logic_vector( 13-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_addrb;
architecture structural of pfb_fir_gen_8192ch_core_debus_addrb is 
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 78-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 13-1 downto 0 );
begin
  msb_out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 12,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 13,
    new_msb => 25,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 65,
    new_msb => 77,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 64,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 39,
    new_msb => 51,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 38,
    x_width => 78,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/debus_dina
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_dina is
  port (
    bus_in : in std_logic_vector( 48-1 downto 0 );
    msb_out6 : out std_logic_vector( 3-1 downto 0 );
    out5 : out std_logic_vector( 9-1 downto 0 );
    out4 : out std_logic_vector( 9-1 downto 0 );
    out3 : out std_logic_vector( 9-1 downto 0 );
    out2 : out std_logic_vector( 9-1 downto 0 );
    lsb_out1 : out std_logic_vector( 9-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_dina;
architecture structural of pfb_fir_gen_8192ch_core_debus_dina is 
  signal reinterpret6_output_port_net : std_logic_vector( 3-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal ddina_q_net : std_logic_vector( 48-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 3-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 9-1 downto 0 );
begin
  msb_out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  ddina_q_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 8,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 17,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice2_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 45,
    new_msb => 47,
    x_width => 48,
    y_width => 3
  )
  port map (
    x => ddina_q_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_19ab038221 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 44,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 27,
    new_msb => 35,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 26,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/debus_dinb
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_dinb is
  port (
    bus_in : in std_logic_vector( 48-1 downto 0 );
    msb_out6 : out std_logic_vector( 3-1 downto 0 );
    out5 : out std_logic_vector( 9-1 downto 0 );
    out4 : out std_logic_vector( 9-1 downto 0 );
    out3 : out std_logic_vector( 9-1 downto 0 );
    out2 : out std_logic_vector( 9-1 downto 0 );
    lsb_out1 : out std_logic_vector( 9-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_dinb;
architecture structural of pfb_fir_gen_8192ch_core_debus_dinb is 
  signal reinterpret6_output_port_net : std_logic_vector( 3-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal ddinb_q_net : std_logic_vector( 48-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 3-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 9-1 downto 0 );
begin
  msb_out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  ddinb_q_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 8,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 17,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice2_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 45,
    new_msb => 47,
    x_width => 48,
    y_width => 3
  )
  port map (
    x => ddinb_q_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_19ab038221 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 44,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 27,
    new_msb => 35,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 26,
    x_width => 48,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/debus_wea
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_wea_x0 is
  port (
    bus_in : in std_logic_vector( 6-1 downto 0 );
    msb_out6 : out std_logic_vector( 1-1 downto 0 );
    out5 : out std_logic_vector( 1-1 downto 0 );
    out4 : out std_logic_vector( 1-1 downto 0 );
    out3 : out std_logic_vector( 1-1 downto 0 );
    out2 : out std_logic_vector( 1-1 downto 0 );
    lsb_out1 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_wea_x0;
architecture structural of pfb_fir_gen_8192ch_core_debus_wea_x0 is 
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 6-1 downto 0 );
begin
  msb_out6 <= slice6_y_net;
  out5 <= slice5_y_net;
  out4 <= slice4_y_net;
  out3 <= slice3_y_net;
  out2 <= slice2_y_net;
  lsb_out1 <= slice1_y_net;
  concatenate_y_net <= bus_in;
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 1,
    new_msb => 1,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 5,
    new_msb => 5,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 4,
    new_msb => 4,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 3,
    new_msb => 3,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 2,
    new_msb => 2,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/debus_web
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_web_x0 is
  port (
    bus_in : in std_logic_vector( 6-1 downto 0 );
    msb_out6 : out std_logic_vector( 1-1 downto 0 );
    out5 : out std_logic_vector( 1-1 downto 0 );
    out4 : out std_logic_vector( 1-1 downto 0 );
    out3 : out std_logic_vector( 1-1 downto 0 );
    out2 : out std_logic_vector( 1-1 downto 0 );
    lsb_out1 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_web_x0;
architecture structural of pfb_fir_gen_8192ch_core_debus_web_x0 is 
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 6-1 downto 0 );
begin
  msb_out6 <= slice6_y_net;
  out5 <= slice5_y_net;
  out4 <= slice4_y_net;
  out3 <= slice3_y_net;
  out2 <= slice2_y_net;
  lsb_out1 <= slice1_y_net;
  concatenate_y_net <= bus_in;
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 1,
    new_msb => 1,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 5,
    new_msb => 5,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 4,
    new_msb => 4,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 3,
    new_msb => 3,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 2,
    new_msb => 2,
    x_width => 6,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_addra/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x6 is
  port (
    in1 : in std_logic_vector( 13-1 downto 0 );
    in2 : in std_logic_vector( 13-1 downto 0 );
    in3 : in std_logic_vector( 13-1 downto 0 );
    in4 : in std_logic_vector( 13-1 downto 0 );
    in5 : in std_logic_vector( 13-1 downto 0 );
    in6 : in std_logic_vector( 13-1 downto 0 );
    bus_out : out std_logic_vector( 78-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x6;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x6 is 
  signal concatenate_y_net : std_logic_vector( 78-1 downto 0 );
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  din0_0_q_net <= in1;
  din0_1_q_net <= in2;
  din0_2_q_net <= in3;
  din0_3_q_net <= in4;
  din0_4_q_net <= in5;
  din0_5_q_net <= in6;
  concatenate : entity xil_defaultlib.sysgen_concat_8c54dd038a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_0_q_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_1_q_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_2_q_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_3_q_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_4_q_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_5_q_net,
    output_port => reinterpret6_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_addra
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_addra is
  port (
    in_x0 : in std_logic_vector( 13-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 78-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_addra;
architecture structural of pfb_fir_gen_8192ch_core_rep_addra is 
  signal concatenate_y_net : std_logic_vector( 78-1 downto 0 );
  signal counter_op_net : std_logic_vector( 13-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  counter_op_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x6 
  port map (
    in1 => din0_0_q_net,
    in2 => din0_1_q_net,
    in3 => din0_2_q_net,
    in4 => din0_3_q_net,
    in5 => din0_4_q_net,
    in6 => din0_5_q_net,
    bus_out => concatenate_y_net
  );
  din0_0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_0_q_net
  );
  din0_1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_1_q_net
  );
  din0_2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_2_q_net
  );
  din0_3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_3_q_net
  );
  din0_4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_4_q_net
  );
  din0_5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_5_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_addrb/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x5 is
  port (
    in1 : in std_logic_vector( 13-1 downto 0 );
    in2 : in std_logic_vector( 13-1 downto 0 );
    in3 : in std_logic_vector( 13-1 downto 0 );
    in4 : in std_logic_vector( 13-1 downto 0 );
    in5 : in std_logic_vector( 13-1 downto 0 );
    in6 : in std_logic_vector( 13-1 downto 0 );
    bus_out : out std_logic_vector( 78-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x5;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x5 is 
  signal concatenate_y_net : std_logic_vector( 78-1 downto 0 );
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  din0_0_q_net <= in1;
  din0_1_q_net <= in2;
  din0_2_q_net <= in3;
  din0_3_q_net <= in4;
  din0_4_q_net <= in5;
  din0_5_q_net <= in6;
  concatenate : entity xil_defaultlib.sysgen_concat_8c54dd038a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_0_q_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_1_q_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_2_q_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_3_q_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_4_q_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_5_q_net,
    output_port => reinterpret6_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_addrb
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_addrb is
  port (
    in_x0 : in std_logic_vector( 13-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 78-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_addrb;
architecture structural of pfb_fir_gen_8192ch_core_rep_addrb is 
  signal concatenate_y_net : std_logic_vector( 78-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 13-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  inverter_op_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x5 
  port map (
    in1 => din0_0_q_net,
    in2 => din0_1_q_net,
    in3 => din0_2_q_net,
    in4 => din0_3_q_net,
    in5 => din0_4_q_net,
    in6 => din0_5_q_net,
    bus_out => concatenate_y_net
  );
  din0_0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_0_q_net
  );
  din0_1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_1_q_net
  );
  din0_2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_2_q_net
  );
  din0_3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_3_q_net
  );
  din0_4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_4_q_net
  );
  din0_5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_5_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_wea/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x3 is
  port (
    in1 : in std_logic_vector( 1-1 downto 0 );
    bus_out : out std_logic_vector( 6-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x3;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x3 is 
  signal concatenate_y_net : std_logic_vector( 6-1 downto 0 );
  signal rom_we_op_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 1-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  rom_we_op_net <= in1;
  concatenate : entity xil_defaultlib.sysgen_concat_e7f1d8b729 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret6_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_wea
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_wea is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    out_x0 : out std_logic_vector( 6-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_wea;
architecture structural of pfb_fir_gen_8192ch_core_rep_wea is 
  signal concatenate_y_net : std_logic_vector( 6-1 downto 0 );
  signal rom_we_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  rom_we_op_net <= in_x0;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x3 
  port map (
    in1 => rom_we_op_net,
    bus_out => concatenate_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_web/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x4 is
  port (
    in1 : in std_logic_vector( 1-1 downto 0 );
    bus_out : out std_logic_vector( 6-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x4;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x4 is 
  signal concatenate_y_net : std_logic_vector( 6-1 downto 0 );
  signal rom_we_op_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 1-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  rom_we_op_net <= in1;
  concatenate : entity xil_defaultlib.sysgen_concat_e7f1d8b729 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom_we_op_net,
    output_port => reinterpret6_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom/rep_web
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_web is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    out_x0 : out std_logic_vector( 6-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_web;
architecture structural of pfb_fir_gen_8192ch_core_rep_web is 
  signal concatenate_y_net : std_logic_vector( 6-1 downto 0 );
  signal rom_we_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  rom_we_op_net <= in_x0;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x4 
  port map (
    in1 => rom_we_op_net,
    bus_out => concatenate_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen/rom
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rom is
  port (
    addra : in std_logic_vector( 13-1 downto 0 );
    dina : in std_logic_vector( 48-1 downto 0 );
    wea : in std_logic_vector( 1-1 downto 0 );
    addrb : in std_logic_vector( 13-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    a : out std_logic_vector( 48-1 downto 0 );
    b : out std_logic_vector( 48-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rom;
architecture structural of pfb_fir_gen_8192ch_core_rom is 
  signal concatenate_y_net : std_logic_vector( 48-1 downto 0 );
  signal concatenate_y_net_x0 : std_logic_vector( 48-1 downto 0 );
  signal counter_op_net : std_logic_vector( 13-1 downto 0 );
  signal rom_din_op_net : std_logic_vector( 48-1 downto 0 );
  signal rom_we_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 13-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal bram0_douta_net : std_logic_vector( 3-1 downto 0 );
  signal bram1_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram2_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram3_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram4_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram5_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram0_doutb_net : std_logic_vector( 3-1 downto 0 );
  signal bram1_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram2_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram3_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram4_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram5_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net_x1 : std_logic_vector( 78-1 downto 0 );
  signal reinterpret6_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net_x2 : std_logic_vector( 78-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 3-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal ddina_q_net : std_logic_vector( 48-1 downto 0 );
  signal reinterpret6_output_port_net_x0 : std_logic_vector( 3-1 downto 0 );
  signal reinterpret5_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal ddinb_q_net : std_logic_vector( 48-1 downto 0 );
  signal slice6_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net_x3 : std_logic_vector( 6-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net_x4 : std_logic_vector( 6-1 downto 0 );
begin
  a <= concatenate_y_net;
  b <= concatenate_y_net_x0;
  counter_op_net <= addra;
  rom_din_op_net <= dina;
  rom_we_op_net <= wea;
  inverter_op_net <= addrb;
  clk_net <= clk_1;
  ce_net <= ce_1;
  a_bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_a_bussify_x0 
  port map (
    in1 => bram0_douta_net,
    in2 => bram1_douta_net,
    in3 => bram2_douta_net,
    in4 => bram3_douta_net,
    in5 => bram4_douta_net,
    in6 => bram5_douta_net,
    bus_out => concatenate_y_net
  );
  b_bussify_x0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_b_bussify 
  port map (
    in1 => bram0_doutb_net,
    in2 => bram1_doutb_net,
    in3 => bram2_doutb_net,
    in4 => bram3_doutb_net,
    in5 => bram4_doutb_net,
    in6 => bram5_doutb_net,
    bus_out => concatenate_y_net_x0
  );
  debus_addra : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_addra 
  port map (
    bus_in => concatenate_y_net_x1,
    msb_out6 => reinterpret6_output_port_net_x1,
    out5 => reinterpret5_output_port_net_x1,
    out4 => reinterpret4_output_port_net_x1,
    out3 => reinterpret3_output_port_net_x1,
    out2 => reinterpret2_output_port_net_x1,
    lsb_out1 => reinterpret1_output_port_net_x1
  );
  debus_addrb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_addrb 
  port map (
    bus_in => concatenate_y_net_x2,
    msb_out6 => reinterpret6_output_port_net_x2,
    out5 => reinterpret5_output_port_net_x2,
    out4 => reinterpret4_output_port_net_x2,
    out3 => reinterpret3_output_port_net_x2,
    out2 => reinterpret2_output_port_net_x2,
    lsb_out1 => reinterpret1_output_port_net_x2
  );
  debus_dina : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_dina 
  port map (
    bus_in => ddina_q_net,
    msb_out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net_x0,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net_x0
  );
  debus_dinb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_dinb 
  port map (
    bus_in => ddinb_q_net,
    msb_out6 => reinterpret6_output_port_net_x0,
    out5 => reinterpret5_output_port_net_x0,
    out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net_x0,
    out2 => reinterpret2_output_port_net_x0,
    lsb_out1 => reinterpret1_output_port_net
  );
  debus_wea : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_wea_x0 
  port map (
    bus_in => concatenate_y_net_x3,
    msb_out6 => slice6_y_net_x0,
    out5 => slice5_y_net_x0,
    out4 => slice4_y_net_x0,
    out3 => slice3_y_net_x0,
    out2 => slice2_y_net_x0,
    lsb_out1 => slice1_y_net_x0
  );
  debus_web : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_web_x0 
  port map (
    bus_in => concatenate_y_net_x4,
    msb_out6 => slice6_y_net,
    out5 => slice5_y_net,
    out4 => slice4_y_net,
    out3 => slice3_y_net,
    out2 => slice2_y_net,
    lsb_out1 => slice1_y_net
  );
  rep_addra : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_addra 
  port map (
    in_x0 => counter_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => concatenate_y_net_x1
  );
  rep_addrb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_addrb 
  port map (
    in_x0 => inverter_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => concatenate_y_net_x2
  );
  rep_wea : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_wea 
  port map (
    in_x0 => rom_we_op_net,
    out_x0 => concatenate_y_net_x3
  );
  rep_web : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_web 
  port map (
    in_x0 => rom_we_op_net,
    out_x0 => concatenate_y_net_x4
  );
  ddina : entity xil_defaultlib.sysgen_delay_20d2bfeafe 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => rom_din_op_net,
    q => ddina_q_net
  );
  ddinb : entity xil_defaultlib.sysgen_delay_20d2bfeafe 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => rom_din_op_net,
    q => ddinb_q_net
  );
  bram0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 3,
    c_width_b => 3,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i0",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret6_output_port_net_x1,
    dina => reinterpret6_output_port_net,
    wea => slice6_y_net_x0,
    addrb => reinterpret6_output_port_net_x2,
    dinb => reinterpret6_output_port_net_x0,
    web => slice6_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram0_douta_net,
    doutb => bram0_doutb_net
  );
  bram1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i1",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret5_output_port_net_x1,
    dina => reinterpret5_output_port_net,
    wea => slice5_y_net_x0,
    addrb => reinterpret5_output_port_net_x2,
    dinb => reinterpret5_output_port_net_x0,
    web => slice5_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram1_douta_net,
    doutb => bram1_doutb_net
  );
  bram2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i2",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret4_output_port_net_x1,
    dina => reinterpret4_output_port_net_x0,
    wea => slice4_y_net_x0,
    addrb => reinterpret4_output_port_net_x2,
    dinb => reinterpret4_output_port_net,
    web => slice4_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram2_douta_net,
    doutb => bram2_doutb_net
  );
  bram3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i3",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret3_output_port_net_x1,
    dina => reinterpret3_output_port_net,
    wea => slice3_y_net_x0,
    addrb => reinterpret3_output_port_net_x2,
    dinb => reinterpret3_output_port_net_x0,
    web => slice3_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram3_douta_net,
    doutb => bram3_doutb_net
  );
  bram4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i4",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret2_output_port_net_x1,
    dina => reinterpret2_output_port_net,
    wea => slice2_y_net_x0,
    addrb => reinterpret2_output_port_net_x2,
    dinb => reinterpret2_output_port_net_x0,
    web => slice2_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram4_douta_net,
    doutb => bram4_doutb_net
  );
  bram5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i5",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret1_output_port_net_x1,
    dina => reinterpret1_output_port_net_x0,
    wea => slice1_y_net_x0,
    addrb => reinterpret1_output_port_net_x2,
    dinb => reinterpret1_output_port_net,
    web => slice1_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram5_douta_net,
    doutb => bram5_doutb_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_coeff_gen
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_pfb_fir_coeff_gen is
  port (
    sync : in std_logic_vector( 1-1 downto 0 );
    din : in std_logic_vector( 96-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    sync_out : out std_logic_vector( 1-1 downto 0 );
    dout : out std_logic_vector( 96-1 downto 0 );
    coeffs : out std_logic_vector( 96-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_pfb_fir_coeff_gen;
architecture structural of pfb_fir_gen_8192ch_core_pfb_fir_coeff_gen is 
  signal sync_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal din_delay_q_net : std_logic_vector( 96-1 downto 0 );
  signal concat_y_net : std_logic_vector( 96-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net_x1 : std_logic_vector( 96-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net_x1 : std_logic_vector( 12-1 downto 0 );
  signal concatenate_y_net_x0 : std_logic_vector( 48-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret_out_output_port_net : std_logic_vector( 48-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 48-1 downto 0 );
  signal counter_op_net : std_logic_vector( 13-1 downto 0 );
  signal rom_din_op_net : std_logic_vector( 48-1 downto 0 );
  signal rom_we_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 13-1 downto 0 );
  signal zero_op_net : std_logic_vector( 13-1 downto 0 );
  signal first_op_net : std_logic_vector( 1-1 downto 0 );
  signal dfirst_q_net : std_logic_vector( 1-1 downto 0 );
  signal d0_q_net : std_logic_vector( 12-1 downto 0 );
  signal d1_q_net : std_logic_vector( 12-1 downto 0 );
  signal d2_q_net : std_logic_vector( 12-1 downto 0 );
  signal d3_q_net : std_logic_vector( 12-1 downto 0 );
  signal mux0_y_net : std_logic_vector( 12-1 downto 0 );
  signal d5_q_net : std_logic_vector( 12-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 12-1 downto 0 );
  signal d7_q_net : std_logic_vector( 12-1 downto 0 );
  signal d4_q_net : std_logic_vector( 12-1 downto 0 );
  signal const0_op_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret0_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal d6_q_net : std_logic_vector( 12-1 downto 0 );
  signal const1_op_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
begin
  sync_out <= sync_delay_q_net;
  dout <= din_delay_q_net;
  coeffs <= concat_y_net;
  slice_y_net <= sync;
  concatenate_y_net_x1 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  a_expand : entity xil_defaultlib.pfb_fir_gen_8192ch_core_a_expand 
  port map (
    bus_in => concatenate_y_net_x0,
    msb_out4 => reinterpret4_output_port_net_x0,
    out3 => reinterpret3_output_port_net_x0,
    out2 => reinterpret2_output_port_net_x0,
    lsb_out1 => reinterpret1_output_port_net_x1
  );
  b_expand : entity xil_defaultlib.pfb_fir_gen_8192ch_core_b_expand 
  port map (
    bus_in => reinterpret_out_output_port_net,
    msb_out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net_x0
  );
  munge : entity xil_defaultlib.pfb_fir_gen_8192ch_core_munge 
  port map (
    din => concatenate_y_net,
    dout => reinterpret_out_output_port_net
  );
  rom : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rom 
  port map (
    addra => counter_op_net,
    dina => rom_din_op_net,
    wea => rom_we_op_net,
    addrb => inverter_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    a => concatenate_y_net_x0,
    b => concatenate_y_net
  );
  sync_delay : entity xil_defaultlib.sysgen_delay_ece41cf9e5 
  port map (
    clr => '0',
    d => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    q => sync_delay_q_net
  );
  din_delay : entity xil_defaultlib.sysgen_delay_8040d165b2 
  port map (
    clr => '0',
    d => concatenate_y_net_x1,
    clk => clk_net,
    ce => ce_net,
    q => din_delay_q_net
  );
  counter : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_gen_8192ch_core_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 13
  )
  port map (
    en => "1",
    clr => '0',
    rst => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_d9e6ecdb15 
  port map (
    clr => '0',
    ip => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  rom_din : entity xil_defaultlib.sysgen_constant_9b54f17301 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => rom_din_op_net
  );
  rom_we : entity xil_defaultlib.sysgen_constant_d3e8a31320 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => rom_we_op_net
  );
  zero : entity xil_defaultlib.sysgen_constant_2d5618c22b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => zero_op_net
  );
  first : entity xil_defaultlib.sysgen_relational_43ca462a6e 
  port map (
    clr => '0',
    a => zero_op_net,
    b => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    op => first_op_net
  );
  dfirst : entity xil_defaultlib.sysgen_delay_489e406ed3 
  port map (
    clr => '0',
    d => first_op_net,
    clk => clk_net,
    ce => ce_net,
    q => dfirst_q_net
  );
  concat : entity xil_defaultlib.sysgen_concat_c590e39e5e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => d0_q_net,
    in1 => d1_q_net,
    in2 => d2_q_net,
    in3 => d3_q_net,
    in4 => mux0_y_net,
    in5 => d5_q_net,
    in6 => mux1_y_net,
    in7 => d7_q_net,
    y => concat_y_net
  );
  d0 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret4_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d0_q_net
  );
  d1 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret3_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d2 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret2_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  d3 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret1_output_port_net_x1,
    clk => clk_net,
    ce => ce_net,
    q => d3_q_net
  );
  d4 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret4_output_port_net,
    clk => clk_net,
    ce => ce_net,
    q => d4_q_net
  );
  const0 : entity xil_defaultlib.sysgen_constant_3303531a28 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => const0_op_net
  );
  reinterpret0 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => const0_op_net,
    output_port => reinterpret0_output_port_net
  );
  mux0 : entity xil_defaultlib.sysgen_mux_f944845b36 
  port map (
    clr => '0',
    sel => dfirst_q_net,
    d0 => d4_q_net,
    d1 => reinterpret0_output_port_net,
    clk => clk_net,
    ce => ce_net,
    y => mux0_y_net
  );
  d5 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret3_output_port_net,
    clk => clk_net,
    ce => ce_net,
    q => d5_q_net
  );
  d6 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    q => d6_q_net
  );
  const1 : entity xil_defaultlib.sysgen_constant_c6ce6cb153 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => const1_op_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_a5c3ea8b1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => const1_op_net,
    output_port => reinterpret1_output_port_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_f944845b36 
  port map (
    clr => '0',
    sel => dfirst_q_net,
    d0 => d6_q_net,
    d1 => reinterpret1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    y => mux1_y_net
  );
  d7 : entity xil_defaultlib.sysgen_delay_940dee9fb3 
  port map (
    clr => '0',
    d => reinterpret1_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d7_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree0 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree0;
architecture structural of pfb_fir_gen_8192ch_core_add_tree0 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret12_output_port_net <= din1;
  reinterpret12_output_port_net_x0 <= din2;
  reinterpret12_output_port_net_x1 <= din3;
  reinterpret12_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret12_output_port_net,
    b => reinterpret12_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret12_output_port_net_x1,
    b => reinterpret12_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree1 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree1;
architecture structural of pfb_fir_gen_8192ch_core_add_tree1 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret11_output_port_net <= din1;
  reinterpret11_output_port_net_x0 <= din2;
  reinterpret11_output_port_net_x1 <= din3;
  reinterpret11_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret11_output_port_net,
    b => reinterpret11_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret11_output_port_net_x1,
    b => reinterpret11_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree10
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree10 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree10;
architecture structural of pfb_fir_gen_8192ch_core_add_tree10 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret2_output_port_net <= din1;
  reinterpret2_output_port_net_x0 <= din2;
  reinterpret2_output_port_net_x1 <= din3;
  reinterpret2_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret2_output_port_net,
    b => reinterpret2_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret2_output_port_net_x1,
    b => reinterpret2_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree11
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree11 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree11;
architecture structural of pfb_fir_gen_8192ch_core_add_tree11 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret1_output_port_net <= din1;
  reinterpret1_output_port_net_x0 <= din2;
  reinterpret1_output_port_net_x1 <= din3;
  reinterpret1_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret1_output_port_net,
    b => reinterpret1_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret1_output_port_net_x1,
    b => reinterpret1_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree2 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree2;
architecture structural of pfb_fir_gen_8192ch_core_add_tree2 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret10_output_port_net <= din1;
  reinterpret10_output_port_net_x0 <= din2;
  reinterpret10_output_port_net_x1 <= din3;
  reinterpret10_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret10_output_port_net,
    b => reinterpret10_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret10_output_port_net_x1,
    b => reinterpret10_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree3 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree3;
architecture structural of pfb_fir_gen_8192ch_core_add_tree3 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret9_output_port_net <= din1;
  reinterpret9_output_port_net_x0 <= din2;
  reinterpret9_output_port_net_x1 <= din3;
  reinterpret9_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret9_output_port_net,
    b => reinterpret9_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret9_output_port_net_x1,
    b => reinterpret9_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree4 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree4;
architecture structural of pfb_fir_gen_8192ch_core_add_tree4 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret8_output_port_net <= din1;
  reinterpret8_output_port_net_x0 <= din2;
  reinterpret8_output_port_net_x1 <= din3;
  reinterpret8_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret8_output_port_net,
    b => reinterpret8_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret8_output_port_net_x1,
    b => reinterpret8_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree5
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree5 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree5;
architecture structural of pfb_fir_gen_8192ch_core_add_tree5 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret7_output_port_net <= din1;
  reinterpret7_output_port_net_x0 <= din2;
  reinterpret7_output_port_net_x1 <= din3;
  reinterpret7_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret7_output_port_net,
    b => reinterpret7_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret7_output_port_net_x1,
    b => reinterpret7_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree6
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree6 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree6;
architecture structural of pfb_fir_gen_8192ch_core_add_tree6 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret6_output_port_net <= din1;
  reinterpret6_output_port_net_x0 <= din2;
  reinterpret6_output_port_net_x1 <= din3;
  reinterpret6_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret6_output_port_net,
    b => reinterpret6_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret6_output_port_net_x1,
    b => reinterpret6_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree7
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree7 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree7;
architecture structural of pfb_fir_gen_8192ch_core_add_tree7 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret5_output_port_net <= din1;
  reinterpret5_output_port_net_x0 <= din2;
  reinterpret5_output_port_net_x1 <= din3;
  reinterpret5_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret5_output_port_net,
    b => reinterpret5_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret5_output_port_net_x1,
    b => reinterpret5_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree8
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree8 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree8;
architecture structural of pfb_fir_gen_8192ch_core_add_tree8 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret4_output_port_net <= din1;
  reinterpret4_output_port_net_x0 <= din2;
  reinterpret4_output_port_net_x1 <= din3;
  reinterpret4_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret4_output_port_net,
    b => reinterpret4_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret4_output_port_net_x1,
    b => reinterpret4_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/add_tree9
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_add_tree9 is
  port (
    din1 : in std_logic_vector( 20-1 downto 0 );
    din2 : in std_logic_vector( 20-1 downto 0 );
    din3 : in std_logic_vector( 20-1 downto 0 );
    din4 : in std_logic_vector( 20-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 22-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_add_tree9;
architecture structural of pfb_fir_gen_8192ch_core_add_tree9 is 
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 21-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 21-1 downto 0 );
begin
  dout <= addr3_s_net;
  reinterpret3_output_port_net <= din1;
  reinterpret3_output_port_net_x0 <= din2;
  reinterpret3_output_port_net_x1 <= din3;
  reinterpret3_output_port_net_x2 <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret3_output_port_net,
    b => reinterpret3_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.sysgen_addsub_58bab92111 
  port map (
    clr => '0',
    a => reinterpret3_output_port_net_x1,
    b => reinterpret3_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.sysgen_addsub_0947bbd0e7 
  port map (
    clr => '0',
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/d_bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_d_bussify is
  port (
    in1 : in std_logic_vector( 22-1 downto 0 );
    in2 : in std_logic_vector( 22-1 downto 0 );
    in3 : in std_logic_vector( 22-1 downto 0 );
    in4 : in std_logic_vector( 22-1 downto 0 );
    in5 : in std_logic_vector( 22-1 downto 0 );
    in6 : in std_logic_vector( 22-1 downto 0 );
    in7 : in std_logic_vector( 22-1 downto 0 );
    in8 : in std_logic_vector( 22-1 downto 0 );
    in9 : in std_logic_vector( 22-1 downto 0 );
    in10 : in std_logic_vector( 22-1 downto 0 );
    in11 : in std_logic_vector( 22-1 downto 0 );
    in12 : in std_logic_vector( 22-1 downto 0 );
    bus_out : out std_logic_vector( 264-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_d_bussify;
architecture structural of pfb_fir_gen_8192ch_core_d_bussify is 
  signal concatenate_y_net : std_logic_vector( 264-1 downto 0 );
  signal addr3_s_net_x4 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x3 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x0 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x10 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x9 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x8 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x7 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x6 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x5 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x2 : std_logic_vector( 22-1 downto 0 );
  signal addr3_s_net_x1 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 22-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  addr3_s_net_x4 <= in1;
  addr3_s_net_x3 <= in2;
  addr3_s_net <= in3;
  addr3_s_net_x0 <= in4;
  addr3_s_net_x10 <= in5;
  addr3_s_net_x9 <= in6;
  addr3_s_net_x8 <= in7;
  addr3_s_net_x7 <= in8;
  addr3_s_net_x6 <= in9;
  addr3_s_net_x5 <= in10;
  addr3_s_net_x2 <= in11;
  addr3_s_net_x1 <= in12;
  concatenate : entity xil_defaultlib.sysgen_concat_ae21264f3f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x4,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x3,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x0,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x10,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x9,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x8,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x7,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x6,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x5,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x2,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_2a2609a1b7 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => addr3_s_net_x1,
    output_port => reinterpret12_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/expand0
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_expand0 is
  port (
    bus_in : in std_logic_vector( 240-1 downto 0 );
    msb_out12 : out std_logic_vector( 20-1 downto 0 );
    out11 : out std_logic_vector( 20-1 downto 0 );
    out10 : out std_logic_vector( 20-1 downto 0 );
    out9 : out std_logic_vector( 20-1 downto 0 );
    out8 : out std_logic_vector( 20-1 downto 0 );
    out7 : out std_logic_vector( 20-1 downto 0 );
    out6 : out std_logic_vector( 20-1 downto 0 );
    out5 : out std_logic_vector( 20-1 downto 0 );
    out4 : out std_logic_vector( 20-1 downto 0 );
    out3 : out std_logic_vector( 20-1 downto 0 );
    out2 : out std_logic_vector( 20-1 downto 0 );
    lsb_out1 : out std_logic_vector( 20-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_expand0;
architecture structural of pfb_fir_gen_8192ch_core_expand0 is 
  signal reinterpret12_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 20-1 downto 0 );
begin
  msb_out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net_x0;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  reinterpret4_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 19,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 20,
    new_msb => 39,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice2_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 220,
    new_msb => 239,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 200,
    new_msb => 219,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 180,
    new_msb => 199,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 160,
    new_msb => 179,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 140,
    new_msb => 159,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 120,
    new_msb => 139,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 100,
    new_msb => 119,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 80,
    new_msb => 99,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 60,
    new_msb => 79,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net_x0
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 40,
    new_msb => 59,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret4_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/expand1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_expand1 is
  port (
    bus_in : in std_logic_vector( 240-1 downto 0 );
    msb_out12 : out std_logic_vector( 20-1 downto 0 );
    out11 : out std_logic_vector( 20-1 downto 0 );
    out10 : out std_logic_vector( 20-1 downto 0 );
    out9 : out std_logic_vector( 20-1 downto 0 );
    out8 : out std_logic_vector( 20-1 downto 0 );
    out7 : out std_logic_vector( 20-1 downto 0 );
    out6 : out std_logic_vector( 20-1 downto 0 );
    out5 : out std_logic_vector( 20-1 downto 0 );
    out4 : out std_logic_vector( 20-1 downto 0 );
    out3 : out std_logic_vector( 20-1 downto 0 );
    out2 : out std_logic_vector( 20-1 downto 0 );
    lsb_out1 : out std_logic_vector( 20-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_expand1;
architecture structural of pfb_fir_gen_8192ch_core_expand1 is 
  signal reinterpret12_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 20-1 downto 0 );
begin
  msb_out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net_x0;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  reinterpret3_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 19,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 20,
    new_msb => 39,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice2_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 220,
    new_msb => 239,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 200,
    new_msb => 219,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 180,
    new_msb => 199,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 160,
    new_msb => 179,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 140,
    new_msb => 159,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 120,
    new_msb => 139,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 100,
    new_msb => 119,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 80,
    new_msb => 99,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 60,
    new_msb => 79,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 40,
    new_msb => 59,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret3_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/expand2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_expand2 is
  port (
    bus_in : in std_logic_vector( 240-1 downto 0 );
    msb_out12 : out std_logic_vector( 20-1 downto 0 );
    out11 : out std_logic_vector( 20-1 downto 0 );
    out10 : out std_logic_vector( 20-1 downto 0 );
    out9 : out std_logic_vector( 20-1 downto 0 );
    out8 : out std_logic_vector( 20-1 downto 0 );
    out7 : out std_logic_vector( 20-1 downto 0 );
    out6 : out std_logic_vector( 20-1 downto 0 );
    out5 : out std_logic_vector( 20-1 downto 0 );
    out4 : out std_logic_vector( 20-1 downto 0 );
    out3 : out std_logic_vector( 20-1 downto 0 );
    out2 : out std_logic_vector( 20-1 downto 0 );
    lsb_out1 : out std_logic_vector( 20-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_expand2;
architecture structural of pfb_fir_gen_8192ch_core_expand2 is 
  signal reinterpret12_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 20-1 downto 0 );
begin
  msb_out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net_x0;
  lsb_out1 <= reinterpret1_output_port_net;
  reinterpret2_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net_x0
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 19,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 20,
    new_msb => 39,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice2_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 220,
    new_msb => 239,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 200,
    new_msb => 219,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 180,
    new_msb => 199,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 160,
    new_msb => 179,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 140,
    new_msb => 159,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 120,
    new_msb => 139,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 100,
    new_msb => 119,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 80,
    new_msb => 99,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 60,
    new_msb => 79,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 40,
    new_msb => 59,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret2_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree/expand3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_expand3 is
  port (
    bus_in : in std_logic_vector( 240-1 downto 0 );
    msb_out12 : out std_logic_vector( 20-1 downto 0 );
    out11 : out std_logic_vector( 20-1 downto 0 );
    out10 : out std_logic_vector( 20-1 downto 0 );
    out9 : out std_logic_vector( 20-1 downto 0 );
    out8 : out std_logic_vector( 20-1 downto 0 );
    out7 : out std_logic_vector( 20-1 downto 0 );
    out6 : out std_logic_vector( 20-1 downto 0 );
    out5 : out std_logic_vector( 20-1 downto 0 );
    out4 : out std_logic_vector( 20-1 downto 0 );
    out3 : out std_logic_vector( 20-1 downto 0 );
    out2 : out std_logic_vector( 20-1 downto 0 );
    lsb_out1 : out std_logic_vector( 20-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_expand3;
architecture structural of pfb_fir_gen_8192ch_core_expand3 is 
  signal slice1_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 20-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 240-1 downto 0 );
begin
  msb_out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net_x0;
  reinterpret1_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net_x0
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 19,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 20,
    new_msb => 39,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice2_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 220,
    new_msb => 239,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 200,
    new_msb => 219,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 180,
    new_msb => 199,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 160,
    new_msb => 179,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 140,
    new_msb => 159,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 120,
    new_msb => 139,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 100,
    new_msb => 119,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 80,
    new_msb => 99,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 60,
    new_msb => 79,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 40,
    new_msb => 59,
    x_width => 240,
    y_width => 20
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_891e24d6d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_adder_tree
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bus_adder_tree is
  port (
    d0 : in std_logic_vector( 240-1 downto 0 );
    d1 : in std_logic_vector( 240-1 downto 0 );
    d2 : in std_logic_vector( 240-1 downto 0 );
    d3 : in std_logic_vector( 240-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 264-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bus_adder_tree;
architecture structural of pfb_fir_gen_8192ch_core_bus_adder_tree is 
  signal concatenate_y_net : std_logic_vector( 264-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr3_s_net_x9 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret12_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x5 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret11_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x10 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret2_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net_x3 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net : std_logic_vector( 22-1 downto 0 );
  signal reinterpret1_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net_x3 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x0 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret10_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x1 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret9_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x2 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret8_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x3 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret7_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x4 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret6_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x6 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret5_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x7 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret4_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net_x3 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
  signal addr3_s_net_x8 : std_logic_vector( 22-1 downto 0 );
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net_x3 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net_x1 : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 20-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  reinterpret4_output_port_net <= d0;
  reinterpret3_output_port_net <= d1;
  reinterpret2_output_port_net <= d2;
  reinterpret1_output_port_net <= d3;
  clk_net <= clk_1;
  ce_net <= ce_1;
  add_tree0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree0 
  port map (
    din1 => reinterpret12_output_port_net_x1,
    din2 => reinterpret12_output_port_net_x2,
    din3 => reinterpret12_output_port_net,
    din4 => reinterpret12_output_port_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x9
  );
  add_tree1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree1 
  port map (
    din1 => reinterpret11_output_port_net_x1,
    din2 => reinterpret11_output_port_net_x2,
    din3 => reinterpret11_output_port_net,
    din4 => reinterpret11_output_port_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x5
  );
  add_tree10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree10 
  port map (
    din1 => reinterpret2_output_port_net_x1,
    din2 => reinterpret2_output_port_net_x3,
    din3 => reinterpret2_output_port_net_x0,
    din4 => reinterpret2_output_port_net_x2,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x10
  );
  add_tree11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree11 
  port map (
    din1 => reinterpret1_output_port_net_x2,
    din2 => reinterpret1_output_port_net_x3,
    din3 => reinterpret1_output_port_net_x0,
    din4 => reinterpret1_output_port_net_x1,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net
  );
  add_tree2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree2 
  port map (
    din1 => reinterpret10_output_port_net_x1,
    din2 => reinterpret10_output_port_net_x2,
    din3 => reinterpret10_output_port_net,
    din4 => reinterpret10_output_port_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x0
  );
  add_tree3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree3 
  port map (
    din1 => reinterpret9_output_port_net_x2,
    din2 => reinterpret9_output_port_net_x0,
    din3 => reinterpret9_output_port_net_x1,
    din4 => reinterpret9_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x1
  );
  add_tree4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree4 
  port map (
    din1 => reinterpret8_output_port_net_x2,
    din2 => reinterpret8_output_port_net_x0,
    din3 => reinterpret8_output_port_net_x1,
    din4 => reinterpret8_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x2
  );
  add_tree5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree5 
  port map (
    din1 => reinterpret7_output_port_net_x2,
    din2 => reinterpret7_output_port_net_x0,
    din3 => reinterpret7_output_port_net_x1,
    din4 => reinterpret7_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x3
  );
  add_tree6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree6 
  port map (
    din1 => reinterpret6_output_port_net_x2,
    din2 => reinterpret6_output_port_net_x0,
    din3 => reinterpret6_output_port_net_x1,
    din4 => reinterpret6_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x4
  );
  add_tree7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree7 
  port map (
    din1 => reinterpret5_output_port_net_x2,
    din2 => reinterpret5_output_port_net_x0,
    din3 => reinterpret5_output_port_net_x1,
    din4 => reinterpret5_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x6
  );
  add_tree8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree8 
  port map (
    din1 => reinterpret4_output_port_net_x2,
    din2 => reinterpret4_output_port_net_x3,
    din3 => reinterpret4_output_port_net_x1,
    din4 => reinterpret4_output_port_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x7
  );
  add_tree9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_add_tree9 
  port map (
    din1 => reinterpret3_output_port_net_x2,
    din2 => reinterpret3_output_port_net_x3,
    din3 => reinterpret3_output_port_net_x1,
    din4 => reinterpret3_output_port_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x8
  );
  d_bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_d_bussify 
  port map (
    in1 => addr3_s_net_x9,
    in2 => addr3_s_net_x5,
    in3 => addr3_s_net_x0,
    in4 => addr3_s_net_x1,
    in5 => addr3_s_net_x2,
    in6 => addr3_s_net_x3,
    in7 => addr3_s_net_x4,
    in8 => addr3_s_net_x6,
    in9 => addr3_s_net_x7,
    in10 => addr3_s_net_x8,
    in11 => addr3_s_net_x10,
    in12 => addr3_s_net,
    bus_out => concatenate_y_net
  );
  expand0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_expand0 
  port map (
    bus_in => reinterpret4_output_port_net,
    msb_out12 => reinterpret12_output_port_net_x1,
    out11 => reinterpret11_output_port_net_x1,
    out10 => reinterpret10_output_port_net_x1,
    out9 => reinterpret9_output_port_net_x2,
    out8 => reinterpret8_output_port_net_x2,
    out7 => reinterpret7_output_port_net_x2,
    out6 => reinterpret6_output_port_net_x2,
    out5 => reinterpret5_output_port_net_x2,
    out4 => reinterpret4_output_port_net_x2,
    out3 => reinterpret3_output_port_net_x2,
    out2 => reinterpret2_output_port_net_x1,
    lsb_out1 => reinterpret1_output_port_net_x2
  );
  expand1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_expand1 
  port map (
    bus_in => reinterpret3_output_port_net,
    msb_out12 => reinterpret12_output_port_net_x2,
    out11 => reinterpret11_output_port_net_x2,
    out10 => reinterpret10_output_port_net_x2,
    out9 => reinterpret9_output_port_net_x0,
    out8 => reinterpret8_output_port_net_x0,
    out7 => reinterpret7_output_port_net_x0,
    out6 => reinterpret6_output_port_net_x0,
    out5 => reinterpret5_output_port_net_x0,
    out4 => reinterpret4_output_port_net_x3,
    out3 => reinterpret3_output_port_net_x3,
    out2 => reinterpret2_output_port_net_x3,
    lsb_out1 => reinterpret1_output_port_net_x3
  );
  expand2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_expand2 
  port map (
    bus_in => reinterpret2_output_port_net,
    msb_out12 => reinterpret12_output_port_net,
    out11 => reinterpret11_output_port_net,
    out10 => reinterpret10_output_port_net,
    out9 => reinterpret9_output_port_net_x1,
    out8 => reinterpret8_output_port_net_x1,
    out7 => reinterpret7_output_port_net_x1,
    out6 => reinterpret6_output_port_net_x1,
    out5 => reinterpret5_output_port_net_x1,
    out4 => reinterpret4_output_port_net_x1,
    out3 => reinterpret3_output_port_net_x1,
    out2 => reinterpret2_output_port_net_x0,
    lsb_out1 => reinterpret1_output_port_net_x0
  );
  expand3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_expand3 
  port map (
    bus_in => reinterpret1_output_port_net,
    msb_out12 => reinterpret12_output_port_net_x0,
    out11 => reinterpret11_output_port_net_x0,
    out10 => reinterpret10_output_port_net_x0,
    out9 => reinterpret9_output_port_net,
    out8 => reinterpret8_output_port_net,
    out7 => reinterpret7_output_port_net,
    out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net_x0,
    out3 => reinterpret3_output_port_net_x0,
    out2 => reinterpret2_output_port_net_x2,
    lsb_out1 => reinterpret1_output_port_net_x1
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult/a*b_bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_a_b_bussify is
  port (
    in1 : in std_logic_vector( 20-1 downto 0 );
    in2 : in std_logic_vector( 20-1 downto 0 );
    in3 : in std_logic_vector( 20-1 downto 0 );
    in4 : in std_logic_vector( 20-1 downto 0 );
    in5 : in std_logic_vector( 20-1 downto 0 );
    in6 : in std_logic_vector( 20-1 downto 0 );
    in7 : in std_logic_vector( 20-1 downto 0 );
    in8 : in std_logic_vector( 20-1 downto 0 );
    in9 : in std_logic_vector( 20-1 downto 0 );
    in10 : in std_logic_vector( 20-1 downto 0 );
    in11 : in std_logic_vector( 20-1 downto 0 );
    in12 : in std_logic_vector( 20-1 downto 0 );
    in13 : in std_logic_vector( 20-1 downto 0 );
    in14 : in std_logic_vector( 20-1 downto 0 );
    in15 : in std_logic_vector( 20-1 downto 0 );
    in16 : in std_logic_vector( 20-1 downto 0 );
    in17 : in std_logic_vector( 20-1 downto 0 );
    in18 : in std_logic_vector( 20-1 downto 0 );
    in19 : in std_logic_vector( 20-1 downto 0 );
    in20 : in std_logic_vector( 20-1 downto 0 );
    in21 : in std_logic_vector( 20-1 downto 0 );
    in22 : in std_logic_vector( 20-1 downto 0 );
    in23 : in std_logic_vector( 20-1 downto 0 );
    in24 : in std_logic_vector( 20-1 downto 0 );
    in25 : in std_logic_vector( 20-1 downto 0 );
    in26 : in std_logic_vector( 20-1 downto 0 );
    in27 : in std_logic_vector( 20-1 downto 0 );
    in28 : in std_logic_vector( 20-1 downto 0 );
    in29 : in std_logic_vector( 20-1 downto 0 );
    in30 : in std_logic_vector( 20-1 downto 0 );
    in31 : in std_logic_vector( 20-1 downto 0 );
    in32 : in std_logic_vector( 20-1 downto 0 );
    in33 : in std_logic_vector( 20-1 downto 0 );
    in34 : in std_logic_vector( 20-1 downto 0 );
    in35 : in std_logic_vector( 20-1 downto 0 );
    in36 : in std_logic_vector( 20-1 downto 0 );
    in37 : in std_logic_vector( 20-1 downto 0 );
    in38 : in std_logic_vector( 20-1 downto 0 );
    in39 : in std_logic_vector( 20-1 downto 0 );
    in40 : in std_logic_vector( 20-1 downto 0 );
    in41 : in std_logic_vector( 20-1 downto 0 );
    in42 : in std_logic_vector( 20-1 downto 0 );
    in43 : in std_logic_vector( 20-1 downto 0 );
    in44 : in std_logic_vector( 20-1 downto 0 );
    in45 : in std_logic_vector( 20-1 downto 0 );
    in46 : in std_logic_vector( 20-1 downto 0 );
    in47 : in std_logic_vector( 20-1 downto 0 );
    in48 : in std_logic_vector( 20-1 downto 0 );
    bus_out : out std_logic_vector( 960-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_a_b_bussify;
architecture structural of pfb_fir_gen_8192ch_core_a_b_bussify is 
  signal concatenate_y_net : std_logic_vector( 960-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult3_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult4_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult5_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult6_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult7_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult8_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult9_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult10_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult11_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult12_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult13_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult14_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult15_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult16_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult33_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult17_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult18_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult19_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult20_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult21_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult22_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult23_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult24_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult25_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult26_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult27_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult28_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult29_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult30_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult31_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult32_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult34_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult35_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult36_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult37_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult38_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult39_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult40_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult41_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult42_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult43_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult44_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult45_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult46_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult47_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult48_p_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret33_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret34_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret35_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret36_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret37_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret38_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret39_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret40_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret41_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret42_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret43_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret44_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret45_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret46_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret47_output_port_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret48_output_port_net : std_logic_vector( 20-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  mult1_p_net <= in1;
  mult2_p_net <= in2;
  mult3_p_net <= in3;
  mult4_p_net <= in4;
  mult5_p_net <= in5;
  mult6_p_net <= in6;
  mult7_p_net <= in7;
  mult8_p_net <= in8;
  mult9_p_net <= in9;
  mult10_p_net <= in10;
  mult11_p_net <= in11;
  mult12_p_net <= in12;
  mult13_p_net <= in13;
  mult14_p_net <= in14;
  mult15_p_net <= in15;
  mult16_p_net <= in16;
  mult17_p_net <= in17;
  mult18_p_net <= in18;
  mult19_p_net <= in19;
  mult20_p_net <= in20;
  mult21_p_net <= in21;
  mult22_p_net <= in22;
  mult23_p_net <= in23;
  mult24_p_net <= in24;
  mult25_p_net <= in25;
  mult26_p_net <= in26;
  mult27_p_net <= in27;
  mult28_p_net <= in28;
  mult29_p_net <= in29;
  mult30_p_net <= in30;
  mult31_p_net <= in31;
  mult32_p_net <= in32;
  mult33_p_net <= in33;
  mult34_p_net <= in34;
  mult35_p_net <= in35;
  mult36_p_net <= in36;
  mult37_p_net <= in37;
  mult38_p_net <= in38;
  mult39_p_net <= in39;
  mult40_p_net <= in40;
  mult41_p_net <= in41;
  mult42_p_net <= in42;
  mult43_p_net <= in43;
  mult44_p_net <= in44;
  mult45_p_net <= in45;
  mult46_p_net <= in46;
  mult47_p_net <= in47;
  mult48_p_net <= in48;
  concatenate : entity xil_defaultlib.sysgen_concat_dbad0efd95 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    in12 => reinterpret13_output_port_net,
    in13 => reinterpret14_output_port_net,
    in14 => reinterpret15_output_port_net,
    in15 => reinterpret16_output_port_net,
    in16 => reinterpret17_output_port_net,
    in17 => reinterpret18_output_port_net,
    in18 => reinterpret19_output_port_net,
    in19 => reinterpret20_output_port_net,
    in20 => reinterpret21_output_port_net,
    in21 => reinterpret22_output_port_net,
    in22 => reinterpret23_output_port_net,
    in23 => reinterpret24_output_port_net,
    in24 => reinterpret25_output_port_net,
    in25 => reinterpret26_output_port_net,
    in26 => reinterpret27_output_port_net,
    in27 => reinterpret28_output_port_net,
    in28 => reinterpret29_output_port_net,
    in29 => reinterpret30_output_port_net,
    in30 => reinterpret31_output_port_net,
    in31 => reinterpret32_output_port_net,
    in32 => reinterpret33_output_port_net,
    in33 => reinterpret34_output_port_net,
    in34 => reinterpret35_output_port_net,
    in35 => reinterpret36_output_port_net,
    in36 => reinterpret37_output_port_net,
    in37 => reinterpret38_output_port_net,
    in38 => reinterpret39_output_port_net,
    in39 => reinterpret40_output_port_net,
    in40 => reinterpret41_output_port_net,
    in41 => reinterpret42_output_port_net,
    in42 => reinterpret43_output_port_net,
    in43 => reinterpret44_output_port_net,
    in44 => reinterpret45_output_port_net,
    in45 => reinterpret46_output_port_net,
    in46 => reinterpret47_output_port_net,
    in47 => reinterpret48_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult2_p_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult3_p_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult4_p_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult5_p_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult6_p_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult7_p_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult8_p_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult9_p_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult10_p_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult11_p_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult12_p_net,
    output_port => reinterpret12_output_port_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult13_p_net,
    output_port => reinterpret13_output_port_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult14_p_net,
    output_port => reinterpret14_output_port_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult15_p_net,
    output_port => reinterpret15_output_port_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult16_p_net,
    output_port => reinterpret16_output_port_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult17_p_net,
    output_port => reinterpret17_output_port_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult18_p_net,
    output_port => reinterpret18_output_port_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult19_p_net,
    output_port => reinterpret19_output_port_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult20_p_net,
    output_port => reinterpret20_output_port_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult21_p_net,
    output_port => reinterpret21_output_port_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult22_p_net,
    output_port => reinterpret22_output_port_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult23_p_net,
    output_port => reinterpret23_output_port_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult24_p_net,
    output_port => reinterpret24_output_port_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult25_p_net,
    output_port => reinterpret25_output_port_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult26_p_net,
    output_port => reinterpret26_output_port_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult27_p_net,
    output_port => reinterpret27_output_port_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult28_p_net,
    output_port => reinterpret28_output_port_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult29_p_net,
    output_port => reinterpret29_output_port_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult30_p_net,
    output_port => reinterpret30_output_port_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult31_p_net,
    output_port => reinterpret31_output_port_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult32_p_net,
    output_port => reinterpret32_output_port_net
  );
  reinterpret33 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult33_p_net,
    output_port => reinterpret33_output_port_net
  );
  reinterpret34 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult34_p_net,
    output_port => reinterpret34_output_port_net
  );
  reinterpret35 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult35_p_net,
    output_port => reinterpret35_output_port_net
  );
  reinterpret36 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult36_p_net,
    output_port => reinterpret36_output_port_net
  );
  reinterpret37 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult37_p_net,
    output_port => reinterpret37_output_port_net
  );
  reinterpret38 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult38_p_net,
    output_port => reinterpret38_output_port_net
  );
  reinterpret39 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult39_p_net,
    output_port => reinterpret39_output_port_net
  );
  reinterpret40 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult40_p_net,
    output_port => reinterpret40_output_port_net
  );
  reinterpret41 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult41_p_net,
    output_port => reinterpret41_output_port_net
  );
  reinterpret42 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult42_p_net,
    output_port => reinterpret42_output_port_net
  );
  reinterpret43 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult43_p_net,
    output_port => reinterpret43_output_port_net
  );
  reinterpret44 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult44_p_net,
    output_port => reinterpret44_output_port_net
  );
  reinterpret45 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult45_p_net,
    output_port => reinterpret45_output_port_net
  );
  reinterpret46 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult46_p_net,
    output_port => reinterpret46_output_port_net
  );
  reinterpret47 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult47_p_net,
    output_port => reinterpret47_output_port_net
  );
  reinterpret48 : entity xil_defaultlib.sysgen_reinterpret_ba2391f6c1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult48_p_net,
    output_port => reinterpret48_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult/a_debus
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_a_debus is
  port (
    bus_in : in std_logic_vector( 384-1 downto 0 );
    msb_out48 : out std_logic_vector( 8-1 downto 0 );
    out47 : out std_logic_vector( 8-1 downto 0 );
    out46 : out std_logic_vector( 8-1 downto 0 );
    out45 : out std_logic_vector( 8-1 downto 0 );
    out44 : out std_logic_vector( 8-1 downto 0 );
    out43 : out std_logic_vector( 8-1 downto 0 );
    out42 : out std_logic_vector( 8-1 downto 0 );
    out41 : out std_logic_vector( 8-1 downto 0 );
    out40 : out std_logic_vector( 8-1 downto 0 );
    out39 : out std_logic_vector( 8-1 downto 0 );
    out38 : out std_logic_vector( 8-1 downto 0 );
    out37 : out std_logic_vector( 8-1 downto 0 );
    out36 : out std_logic_vector( 8-1 downto 0 );
    out35 : out std_logic_vector( 8-1 downto 0 );
    out34 : out std_logic_vector( 8-1 downto 0 );
    out33 : out std_logic_vector( 8-1 downto 0 );
    out32 : out std_logic_vector( 8-1 downto 0 );
    out31 : out std_logic_vector( 8-1 downto 0 );
    out30 : out std_logic_vector( 8-1 downto 0 );
    out29 : out std_logic_vector( 8-1 downto 0 );
    out28 : out std_logic_vector( 8-1 downto 0 );
    out27 : out std_logic_vector( 8-1 downto 0 );
    out26 : out std_logic_vector( 8-1 downto 0 );
    out25 : out std_logic_vector( 8-1 downto 0 );
    out24 : out std_logic_vector( 8-1 downto 0 );
    out23 : out std_logic_vector( 8-1 downto 0 );
    out22 : out std_logic_vector( 8-1 downto 0 );
    out21 : out std_logic_vector( 8-1 downto 0 );
    out20 : out std_logic_vector( 8-1 downto 0 );
    out19 : out std_logic_vector( 8-1 downto 0 );
    out18 : out std_logic_vector( 8-1 downto 0 );
    out17 : out std_logic_vector( 8-1 downto 0 );
    out16 : out std_logic_vector( 8-1 downto 0 );
    out15 : out std_logic_vector( 8-1 downto 0 );
    out14 : out std_logic_vector( 8-1 downto 0 );
    out13 : out std_logic_vector( 8-1 downto 0 );
    out12 : out std_logic_vector( 8-1 downto 0 );
    out11 : out std_logic_vector( 8-1 downto 0 );
    out10 : out std_logic_vector( 8-1 downto 0 );
    out9 : out std_logic_vector( 8-1 downto 0 );
    out8 : out std_logic_vector( 8-1 downto 0 );
    out7 : out std_logic_vector( 8-1 downto 0 );
    out6 : out std_logic_vector( 8-1 downto 0 );
    out5 : out std_logic_vector( 8-1 downto 0 );
    out4 : out std_logic_vector( 8-1 downto 0 );
    out3 : out std_logic_vector( 8-1 downto 0 );
    out2 : out std_logic_vector( 8-1 downto 0 );
    lsb_out1 : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_a_debus;
architecture structural of pfb_fir_gen_8192ch_core_a_debus is 
  signal reinterpret48_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret47_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 384-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice48_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice47_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice46_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice45_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice44_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice43_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice42_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice41_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice40_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice39_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice38_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice37_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice36_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice35_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice34_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice33_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice32_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret46_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret45_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret44_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret43_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret42_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret41_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret40_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret39_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret38_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret37_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret36_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret35_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret34_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret33_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 8-1 downto 0 );
begin
  msb_out48 <= reinterpret48_output_port_net;
  out47 <= reinterpret47_output_port_net;
  out46 <= reinterpret46_output_port_net;
  out45 <= reinterpret45_output_port_net;
  out44 <= reinterpret44_output_port_net;
  out43 <= reinterpret43_output_port_net;
  out42 <= reinterpret42_output_port_net;
  out41 <= reinterpret41_output_port_net;
  out40 <= reinterpret40_output_port_net;
  out39 <= reinterpret39_output_port_net;
  out38 <= reinterpret38_output_port_net;
  out37 <= reinterpret37_output_port_net;
  out36 <= reinterpret36_output_port_net;
  out35 <= reinterpret35_output_port_net;
  out34 <= reinterpret34_output_port_net;
  out33 <= reinterpret33_output_port_net;
  out32 <= reinterpret32_output_port_net;
  out31 <= reinterpret31_output_port_net;
  out30 <= reinterpret30_output_port_net;
  out29 <= reinterpret29_output_port_net;
  out28 <= reinterpret28_output_port_net;
  out27 <= reinterpret27_output_port_net;
  out26 <= reinterpret26_output_port_net;
  out25 <= reinterpret25_output_port_net;
  out24 <= reinterpret24_output_port_net;
  out23 <= reinterpret23_output_port_net;
  out22 <= reinterpret22_output_port_net;
  out21 <= reinterpret21_output_port_net;
  out20 <= reinterpret20_output_port_net;
  out19 <= reinterpret19_output_port_net;
  out18 <= reinterpret18_output_port_net;
  out17 <= reinterpret17_output_port_net;
  out16 <= reinterpret16_output_port_net;
  out15 <= reinterpret15_output_port_net;
  out14 <= reinterpret14_output_port_net;
  out13 <= reinterpret13_output_port_net;
  out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net_x0;
  reinterpret1_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net_x0
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice2_y_net
  );
  slice48 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 376,
    new_msb => 383,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice48_y_net
  );
  reinterpret48 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice48_y_net,
    output_port => reinterpret48_output_port_net
  );
  slice47 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 368,
    new_msb => 375,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice47_y_net
  );
  reinterpret47 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice47_y_net,
    output_port => reinterpret47_output_port_net
  );
  slice46 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 360,
    new_msb => 367,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice46_y_net
  );
  reinterpret46 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice46_y_net,
    output_port => reinterpret46_output_port_net
  );
  slice45 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 352,
    new_msb => 359,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice45_y_net
  );
  reinterpret45 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice45_y_net,
    output_port => reinterpret45_output_port_net
  );
  slice44 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 344,
    new_msb => 351,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice44_y_net
  );
  reinterpret44 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice44_y_net,
    output_port => reinterpret44_output_port_net
  );
  slice43 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 336,
    new_msb => 343,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice43_y_net
  );
  reinterpret43 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice43_y_net,
    output_port => reinterpret43_output_port_net
  );
  slice42 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 328,
    new_msb => 335,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice42_y_net
  );
  reinterpret42 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice42_y_net,
    output_port => reinterpret42_output_port_net
  );
  slice41 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 320,
    new_msb => 327,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice41_y_net
  );
  reinterpret41 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice41_y_net,
    output_port => reinterpret41_output_port_net
  );
  slice40 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 312,
    new_msb => 319,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice40_y_net
  );
  reinterpret40 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice40_y_net,
    output_port => reinterpret40_output_port_net
  );
  slice39 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 304,
    new_msb => 311,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice39_y_net
  );
  reinterpret39 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice39_y_net,
    output_port => reinterpret39_output_port_net
  );
  slice38 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 296,
    new_msb => 303,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice38_y_net
  );
  reinterpret38 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice38_y_net,
    output_port => reinterpret38_output_port_net
  );
  slice37 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 288,
    new_msb => 295,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice37_y_net
  );
  reinterpret37 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice37_y_net,
    output_port => reinterpret37_output_port_net
  );
  slice36 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 280,
    new_msb => 287,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice36_y_net
  );
  reinterpret36 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice36_y_net,
    output_port => reinterpret36_output_port_net
  );
  slice35 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 272,
    new_msb => 279,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice35_y_net
  );
  reinterpret35 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice35_y_net,
    output_port => reinterpret35_output_port_net
  );
  slice34 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 264,
    new_msb => 271,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice34_y_net
  );
  reinterpret34 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice34_y_net,
    output_port => reinterpret34_output_port_net
  );
  slice33 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 256,
    new_msb => 263,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice33_y_net
  );
  reinterpret33 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice33_y_net,
    output_port => reinterpret33_output_port_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 248,
    new_msb => 255,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice32_y_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice32_y_net,
    output_port => reinterpret32_output_port_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 240,
    new_msb => 247,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice31_y_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice31_y_net,
    output_port => reinterpret31_output_port_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 232,
    new_msb => 239,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice30_y_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice30_y_net,
    output_port => reinterpret30_output_port_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 224,
    new_msb => 231,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice29_y_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice29_y_net,
    output_port => reinterpret29_output_port_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 216,
    new_msb => 223,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice28_y_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice28_y_net,
    output_port => reinterpret28_output_port_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 208,
    new_msb => 215,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice27_y_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice27_y_net,
    output_port => reinterpret27_output_port_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 200,
    new_msb => 207,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice26_y_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice26_y_net,
    output_port => reinterpret26_output_port_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 192,
    new_msb => 199,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice25_y_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice25_y_net,
    output_port => reinterpret25_output_port_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 184,
    new_msb => 191,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice24_y_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice24_y_net,
    output_port => reinterpret24_output_port_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 176,
    new_msb => 183,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice23_y_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice23_y_net,
    output_port => reinterpret23_output_port_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 168,
    new_msb => 175,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice22_y_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice22_y_net,
    output_port => reinterpret22_output_port_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 160,
    new_msb => 167,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice21_y_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice21_y_net,
    output_port => reinterpret21_output_port_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 152,
    new_msb => 159,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice20_y_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice20_y_net,
    output_port => reinterpret20_output_port_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 144,
    new_msb => 151,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice19_y_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice19_y_net,
    output_port => reinterpret19_output_port_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 136,
    new_msb => 143,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice18_y_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice18_y_net,
    output_port => reinterpret18_output_port_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 128,
    new_msb => 135,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice17_y_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice17_y_net,
    output_port => reinterpret17_output_port_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 120,
    new_msb => 127,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice16_y_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice16_y_net,
    output_port => reinterpret16_output_port_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 112,
    new_msb => 119,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice15_y_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice15_y_net,
    output_port => reinterpret15_output_port_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 104,
    new_msb => 111,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice14_y_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice14_y_net,
    output_port => reinterpret14_output_port_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 96,
    new_msb => 103,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice13_y_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice13_y_net,
    output_port => reinterpret13_output_port_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 88,
    new_msb => 95,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 80,
    new_msb => 87,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 72,
    new_msb => 79,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 64,
    new_msb => 71,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 56,
    new_msb => 63,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 48,
    new_msb => 55,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 40,
    new_msb => 47,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 32,
    new_msb => 39,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 31,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 23,
    x_width => 384,
    y_width => 8
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_706e5defe0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult/b_debus
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_b_debus is
  port (
    bus_in : in std_logic_vector( 576-1 downto 0 );
    msb_out48 : out std_logic_vector( 12-1 downto 0 );
    out47 : out std_logic_vector( 12-1 downto 0 );
    out46 : out std_logic_vector( 12-1 downto 0 );
    out45 : out std_logic_vector( 12-1 downto 0 );
    out44 : out std_logic_vector( 12-1 downto 0 );
    out43 : out std_logic_vector( 12-1 downto 0 );
    out42 : out std_logic_vector( 12-1 downto 0 );
    out41 : out std_logic_vector( 12-1 downto 0 );
    out40 : out std_logic_vector( 12-1 downto 0 );
    out39 : out std_logic_vector( 12-1 downto 0 );
    out38 : out std_logic_vector( 12-1 downto 0 );
    out37 : out std_logic_vector( 12-1 downto 0 );
    out36 : out std_logic_vector( 12-1 downto 0 );
    out35 : out std_logic_vector( 12-1 downto 0 );
    out34 : out std_logic_vector( 12-1 downto 0 );
    out33 : out std_logic_vector( 12-1 downto 0 );
    out32 : out std_logic_vector( 12-1 downto 0 );
    out31 : out std_logic_vector( 12-1 downto 0 );
    out30 : out std_logic_vector( 12-1 downto 0 );
    out29 : out std_logic_vector( 12-1 downto 0 );
    out28 : out std_logic_vector( 12-1 downto 0 );
    out27 : out std_logic_vector( 12-1 downto 0 );
    out26 : out std_logic_vector( 12-1 downto 0 );
    out25 : out std_logic_vector( 12-1 downto 0 );
    out24 : out std_logic_vector( 12-1 downto 0 );
    out23 : out std_logic_vector( 12-1 downto 0 );
    out22 : out std_logic_vector( 12-1 downto 0 );
    out21 : out std_logic_vector( 12-1 downto 0 );
    out20 : out std_logic_vector( 12-1 downto 0 );
    out19 : out std_logic_vector( 12-1 downto 0 );
    out18 : out std_logic_vector( 12-1 downto 0 );
    out17 : out std_logic_vector( 12-1 downto 0 );
    out16 : out std_logic_vector( 12-1 downto 0 );
    out15 : out std_logic_vector( 12-1 downto 0 );
    out14 : out std_logic_vector( 12-1 downto 0 );
    out13 : out std_logic_vector( 12-1 downto 0 );
    out12 : out std_logic_vector( 12-1 downto 0 );
    out11 : out std_logic_vector( 12-1 downto 0 );
    out10 : out std_logic_vector( 12-1 downto 0 );
    out9 : out std_logic_vector( 12-1 downto 0 );
    out8 : out std_logic_vector( 12-1 downto 0 );
    out7 : out std_logic_vector( 12-1 downto 0 );
    out6 : out std_logic_vector( 12-1 downto 0 );
    out5 : out std_logic_vector( 12-1 downto 0 );
    out4 : out std_logic_vector( 12-1 downto 0 );
    out3 : out std_logic_vector( 12-1 downto 0 );
    out2 : out std_logic_vector( 12-1 downto 0 );
    lsb_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_b_debus;
architecture structural of pfb_fir_gen_8192ch_core_b_debus is 
  signal reinterpret48_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret46_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret45_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret44_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret43_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret42_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret41_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret40_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret39_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret38_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret37_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret36_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret35_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret34_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret33_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 576-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice48_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice47_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice46_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice45_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice44_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice43_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice42_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice41_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice40_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice39_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice38_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice37_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice36_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice35_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice34_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice33_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice32_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 12-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret47_output_port_net : std_logic_vector( 12-1 downto 0 );
begin
  msb_out48 <= reinterpret48_output_port_net;
  out47 <= reinterpret47_output_port_net;
  out46 <= reinterpret46_output_port_net;
  out45 <= reinterpret45_output_port_net;
  out44 <= reinterpret44_output_port_net;
  out43 <= reinterpret43_output_port_net;
  out42 <= reinterpret42_output_port_net;
  out41 <= reinterpret41_output_port_net;
  out40 <= reinterpret40_output_port_net;
  out39 <= reinterpret39_output_port_net;
  out38 <= reinterpret38_output_port_net;
  out37 <= reinterpret37_output_port_net;
  out36 <= reinterpret36_output_port_net;
  out35 <= reinterpret35_output_port_net;
  out34 <= reinterpret34_output_port_net;
  out33 <= reinterpret33_output_port_net;
  out32 <= reinterpret32_output_port_net;
  out31 <= reinterpret31_output_port_net;
  out30 <= reinterpret30_output_port_net;
  out29 <= reinterpret29_output_port_net;
  out28 <= reinterpret28_output_port_net;
  out27 <= reinterpret27_output_port_net;
  out26 <= reinterpret26_output_port_net;
  out25 <= reinterpret25_output_port_net;
  out24 <= reinterpret24_output_port_net;
  out23 <= reinterpret23_output_port_net;
  out22 <= reinterpret22_output_port_net;
  out21 <= reinterpret21_output_port_net;
  out20 <= reinterpret20_output_port_net;
  out19 <= reinterpret19_output_port_net;
  out18 <= reinterpret18_output_port_net;
  out17 <= reinterpret17_output_port_net;
  out16 <= reinterpret16_output_port_net;
  out15 <= reinterpret15_output_port_net;
  out14 <= reinterpret14_output_port_net;
  out13 <= reinterpret13_output_port_net;
  out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net_x0;
  reinterpret1_output_port_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net_x0
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 11,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 23,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice2_y_net
  );
  slice48 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 564,
    new_msb => 575,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice48_y_net
  );
  reinterpret48 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice48_y_net,
    output_port => reinterpret48_output_port_net
  );
  slice47 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 552,
    new_msb => 563,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice47_y_net
  );
  reinterpret47 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice47_y_net,
    output_port => reinterpret47_output_port_net
  );
  slice46 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 540,
    new_msb => 551,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice46_y_net
  );
  reinterpret46 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice46_y_net,
    output_port => reinterpret46_output_port_net
  );
  slice45 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 528,
    new_msb => 539,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice45_y_net
  );
  reinterpret45 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice45_y_net,
    output_port => reinterpret45_output_port_net
  );
  slice44 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 516,
    new_msb => 527,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice44_y_net
  );
  reinterpret44 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice44_y_net,
    output_port => reinterpret44_output_port_net
  );
  slice43 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 504,
    new_msb => 515,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice43_y_net
  );
  reinterpret43 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice43_y_net,
    output_port => reinterpret43_output_port_net
  );
  slice42 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 492,
    new_msb => 503,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice42_y_net
  );
  reinterpret42 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice42_y_net,
    output_port => reinterpret42_output_port_net
  );
  slice41 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 480,
    new_msb => 491,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice41_y_net
  );
  reinterpret41 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice41_y_net,
    output_port => reinterpret41_output_port_net
  );
  slice40 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 468,
    new_msb => 479,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice40_y_net
  );
  reinterpret40 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice40_y_net,
    output_port => reinterpret40_output_port_net
  );
  slice39 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 456,
    new_msb => 467,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice39_y_net
  );
  reinterpret39 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice39_y_net,
    output_port => reinterpret39_output_port_net
  );
  slice38 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 444,
    new_msb => 455,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice38_y_net
  );
  reinterpret38 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice38_y_net,
    output_port => reinterpret38_output_port_net
  );
  slice37 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 432,
    new_msb => 443,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice37_y_net
  );
  reinterpret37 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice37_y_net,
    output_port => reinterpret37_output_port_net
  );
  slice36 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 420,
    new_msb => 431,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice36_y_net
  );
  reinterpret36 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice36_y_net,
    output_port => reinterpret36_output_port_net
  );
  slice35 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 408,
    new_msb => 419,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice35_y_net
  );
  reinterpret35 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice35_y_net,
    output_port => reinterpret35_output_port_net
  );
  slice34 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 396,
    new_msb => 407,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice34_y_net
  );
  reinterpret34 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice34_y_net,
    output_port => reinterpret34_output_port_net
  );
  slice33 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 384,
    new_msb => 395,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice33_y_net
  );
  reinterpret33 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice33_y_net,
    output_port => reinterpret33_output_port_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 372,
    new_msb => 383,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice32_y_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice32_y_net,
    output_port => reinterpret32_output_port_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 360,
    new_msb => 371,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice31_y_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice31_y_net,
    output_port => reinterpret31_output_port_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 348,
    new_msb => 359,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice30_y_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice30_y_net,
    output_port => reinterpret30_output_port_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 336,
    new_msb => 347,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice29_y_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice29_y_net,
    output_port => reinterpret29_output_port_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 324,
    new_msb => 335,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice28_y_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice28_y_net,
    output_port => reinterpret28_output_port_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 312,
    new_msb => 323,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice27_y_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice27_y_net,
    output_port => reinterpret27_output_port_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 300,
    new_msb => 311,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice26_y_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice26_y_net,
    output_port => reinterpret26_output_port_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 288,
    new_msb => 299,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice25_y_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice25_y_net,
    output_port => reinterpret25_output_port_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 276,
    new_msb => 287,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice24_y_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice24_y_net,
    output_port => reinterpret24_output_port_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 264,
    new_msb => 275,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice23_y_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice23_y_net,
    output_port => reinterpret23_output_port_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 252,
    new_msb => 263,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice22_y_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice22_y_net,
    output_port => reinterpret22_output_port_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 240,
    new_msb => 251,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice21_y_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice21_y_net,
    output_port => reinterpret21_output_port_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 228,
    new_msb => 239,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice20_y_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice20_y_net,
    output_port => reinterpret20_output_port_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 216,
    new_msb => 227,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice19_y_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice19_y_net,
    output_port => reinterpret19_output_port_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 204,
    new_msb => 215,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice18_y_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice18_y_net,
    output_port => reinterpret18_output_port_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 192,
    new_msb => 203,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice17_y_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice17_y_net,
    output_port => reinterpret17_output_port_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 180,
    new_msb => 191,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice16_y_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice16_y_net,
    output_port => reinterpret16_output_port_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 168,
    new_msb => 179,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice15_y_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice15_y_net,
    output_port => reinterpret15_output_port_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 156,
    new_msb => 167,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice14_y_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice14_y_net,
    output_port => reinterpret14_output_port_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 144,
    new_msb => 155,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice13_y_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice13_y_net,
    output_port => reinterpret13_output_port_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 132,
    new_msb => 143,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 120,
    new_msb => 131,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 108,
    new_msb => 119,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 96,
    new_msb => 107,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 84,
    new_msb => 95,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 72,
    new_msb => 83,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 60,
    new_msb => 71,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 48,
    new_msb => 59,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 47,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 35,
    x_width => 576,
    y_width => 12
  )
  port map (
    x => reinterpret1_output_port_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_6ebd96f229 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult/repa/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x0 is
  port (
    in1 : in std_logic_vector( 384-1 downto 0 );
    bus_out : out std_logic_vector( 384-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x0;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x0 is 
  signal reinterpret1_output_port_net : std_logic_vector( 384-1 downto 0 );
  signal mult_din_y_net : std_logic_vector( 384-1 downto 0 );
begin
  bus_out <= reinterpret1_output_port_net;
  mult_din_y_net <= in1;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_9136cf18dd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_din_y_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult/repa
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_repa is
  port (
    in_x0 : in std_logic_vector( 384-1 downto 0 );
    out_x0 : out std_logic_vector( 384-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_repa;
architecture structural of pfb_fir_gen_8192ch_core_repa is 
  signal reinterpret1_output_port_net : std_logic_vector( 384-1 downto 0 );
  signal mult_din_y_net : std_logic_vector( 384-1 downto 0 );
begin
  out_x0 <= reinterpret1_output_port_net;
  mult_din_y_net <= in_x0;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x0 
  port map (
    in1 => mult_din_y_net,
    bus_out => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult/repb/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify is
  port (
    in1 : in std_logic_vector( 576-1 downto 0 );
    bus_out : out std_logic_vector( 576-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify;
architecture structural of pfb_fir_gen_8192ch_core_bussify is 
  signal reinterpret1_output_port_net : std_logic_vector( 576-1 downto 0 );
  signal dcoeffs_q_net : std_logic_vector( 576-1 downto 0 );
begin
  bus_out <= reinterpret1_output_port_net;
  dcoeffs_q_net <= in1;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_bd1dc971fe 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => dcoeffs_q_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult/repb
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_repb is
  port (
    in_x0 : in std_logic_vector( 576-1 downto 0 );
    out_x0 : out std_logic_vector( 576-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_repb;
architecture structural of pfb_fir_gen_8192ch_core_repb is 
  signal reinterpret1_output_port_net : std_logic_vector( 576-1 downto 0 );
  signal dcoeffs_q_net : std_logic_vector( 576-1 downto 0 );
begin
  out_x0 <= reinterpret1_output_port_net;
  dcoeffs_q_net <= in_x0;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify 
  port map (
    in1 => dcoeffs_q_net,
    bus_out => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/bus_mult
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bus_mult is
  port (
    a : in std_logic_vector( 384-1 downto 0 );
    b : in std_logic_vector( 576-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    a_b : out std_logic_vector( 960-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bus_mult;
architecture structural of pfb_fir_gen_8192ch_core_bus_mult is 
  signal concatenate_y_net : std_logic_vector( 960-1 downto 0 );
  signal mult_din_y_net : std_logic_vector( 384-1 downto 0 );
  signal dcoeffs_q_net : std_logic_vector( 576-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal mult1_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult3_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult4_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult5_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult6_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult7_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult8_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult9_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult10_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult11_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult12_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult13_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult14_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult15_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult16_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult17_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult34_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult18_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult19_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult20_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult21_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult22_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult23_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult24_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult25_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult26_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult27_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult28_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult29_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult30_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult31_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult32_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult33_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult35_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult36_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult37_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult38_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult39_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult40_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult41_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult42_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult43_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult44_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult45_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult46_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult47_p_net : std_logic_vector( 20-1 downto 0 );
  signal mult48_p_net : std_logic_vector( 20-1 downto 0 );
  signal reinterpret48_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret47_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret46_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret45_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret44_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret43_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret42_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret41_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret40_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret39_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret38_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret37_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret36_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret35_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret34_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret33_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret32_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret31_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret30_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret9_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret8_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret7_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret6_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret5_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 384-1 downto 0 );
  signal reinterpret48_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret47_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret46_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret45_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret44_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret43_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret42_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret41_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret40_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret39_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret38_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret37_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret36_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret35_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret34_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret33_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret15_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret29_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret28_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret27_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret26_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret25_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret24_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret23_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret22_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret21_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret20_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret19_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret18_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret17_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret16_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret14_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret13_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret12_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret11_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret10_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net_x2 : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net_x1 : std_logic_vector( 576-1 downto 0 );
begin
  a_b <= concatenate_y_net;
  mult_din_y_net <= a;
  dcoeffs_q_net <= b;
  clk_net <= clk_1;
  ce_net <= ce_1;
  a_b_bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_a_b_bussify 
  port map (
    in1 => mult1_p_net,
    in2 => mult2_p_net,
    in3 => mult3_p_net,
    in4 => mult4_p_net,
    in5 => mult5_p_net,
    in6 => mult6_p_net,
    in7 => mult7_p_net,
    in8 => mult8_p_net,
    in9 => mult9_p_net,
    in10 => mult10_p_net,
    in11 => mult11_p_net,
    in12 => mult12_p_net,
    in13 => mult13_p_net,
    in14 => mult14_p_net,
    in15 => mult15_p_net,
    in16 => mult16_p_net,
    in17 => mult17_p_net,
    in18 => mult18_p_net,
    in19 => mult19_p_net,
    in20 => mult20_p_net,
    in21 => mult21_p_net,
    in22 => mult22_p_net,
    in23 => mult23_p_net,
    in24 => mult24_p_net,
    in25 => mult25_p_net,
    in26 => mult26_p_net,
    in27 => mult27_p_net,
    in28 => mult28_p_net,
    in29 => mult29_p_net,
    in30 => mult30_p_net,
    in31 => mult31_p_net,
    in32 => mult32_p_net,
    in33 => mult33_p_net,
    in34 => mult34_p_net,
    in35 => mult35_p_net,
    in36 => mult36_p_net,
    in37 => mult37_p_net,
    in38 => mult38_p_net,
    in39 => mult39_p_net,
    in40 => mult40_p_net,
    in41 => mult41_p_net,
    in42 => mult42_p_net,
    in43 => mult43_p_net,
    in44 => mult44_p_net,
    in45 => mult45_p_net,
    in46 => mult46_p_net,
    in47 => mult47_p_net,
    in48 => mult48_p_net,
    bus_out => concatenate_y_net
  );
  a_debus : entity xil_defaultlib.pfb_fir_gen_8192ch_core_a_debus 
  port map (
    bus_in => reinterpret1_output_port_net_x0,
    msb_out48 => reinterpret48_output_port_net_x0,
    out47 => reinterpret47_output_port_net_x0,
    out46 => reinterpret46_output_port_net_x0,
    out45 => reinterpret45_output_port_net_x0,
    out44 => reinterpret44_output_port_net_x0,
    out43 => reinterpret43_output_port_net_x0,
    out42 => reinterpret42_output_port_net_x0,
    out41 => reinterpret41_output_port_net_x0,
    out40 => reinterpret40_output_port_net_x0,
    out39 => reinterpret39_output_port_net_x0,
    out38 => reinterpret38_output_port_net_x0,
    out37 => reinterpret37_output_port_net_x0,
    out36 => reinterpret36_output_port_net_x0,
    out35 => reinterpret35_output_port_net_x0,
    out34 => reinterpret34_output_port_net_x0,
    out33 => reinterpret33_output_port_net_x0,
    out32 => reinterpret32_output_port_net_x0,
    out31 => reinterpret31_output_port_net_x0,
    out30 => reinterpret30_output_port_net_x0,
    out29 => reinterpret29_output_port_net,
    out28 => reinterpret28_output_port_net,
    out27 => reinterpret27_output_port_net,
    out26 => reinterpret26_output_port_net,
    out25 => reinterpret25_output_port_net,
    out24 => reinterpret24_output_port_net,
    out23 => reinterpret23_output_port_net,
    out22 => reinterpret22_output_port_net,
    out21 => reinterpret21_output_port_net,
    out20 => reinterpret20_output_port_net,
    out19 => reinterpret19_output_port_net,
    out18 => reinterpret18_output_port_net,
    out17 => reinterpret17_output_port_net,
    out16 => reinterpret16_output_port_net,
    out15 => reinterpret15_output_port_net,
    out14 => reinterpret14_output_port_net,
    out13 => reinterpret13_output_port_net,
    out12 => reinterpret12_output_port_net,
    out11 => reinterpret11_output_port_net,
    out10 => reinterpret10_output_port_net,
    out9 => reinterpret9_output_port_net_x0,
    out8 => reinterpret8_output_port_net_x0,
    out7 => reinterpret7_output_port_net_x0,
    out6 => reinterpret6_output_port_net_x0,
    out5 => reinterpret5_output_port_net_x0,
    out4 => reinterpret4_output_port_net_x0,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
  b_debus : entity xil_defaultlib.pfb_fir_gen_8192ch_core_b_debus 
  port map (
    bus_in => reinterpret1_output_port_net_x1,
    msb_out48 => reinterpret48_output_port_net,
    out47 => reinterpret47_output_port_net,
    out46 => reinterpret46_output_port_net,
    out45 => reinterpret45_output_port_net,
    out44 => reinterpret44_output_port_net,
    out43 => reinterpret43_output_port_net,
    out42 => reinterpret42_output_port_net,
    out41 => reinterpret41_output_port_net,
    out40 => reinterpret40_output_port_net,
    out39 => reinterpret39_output_port_net,
    out38 => reinterpret38_output_port_net,
    out37 => reinterpret37_output_port_net,
    out36 => reinterpret36_output_port_net,
    out35 => reinterpret35_output_port_net,
    out34 => reinterpret34_output_port_net,
    out33 => reinterpret33_output_port_net,
    out32 => reinterpret32_output_port_net,
    out31 => reinterpret31_output_port_net,
    out30 => reinterpret30_output_port_net,
    out29 => reinterpret29_output_port_net_x0,
    out28 => reinterpret28_output_port_net_x0,
    out27 => reinterpret27_output_port_net_x0,
    out26 => reinterpret26_output_port_net_x0,
    out25 => reinterpret25_output_port_net_x0,
    out24 => reinterpret24_output_port_net_x0,
    out23 => reinterpret23_output_port_net_x0,
    out22 => reinterpret22_output_port_net_x0,
    out21 => reinterpret21_output_port_net_x0,
    out20 => reinterpret20_output_port_net_x0,
    out19 => reinterpret19_output_port_net_x0,
    out18 => reinterpret18_output_port_net_x0,
    out17 => reinterpret17_output_port_net_x0,
    out16 => reinterpret16_output_port_net_x0,
    out15 => reinterpret15_output_port_net_x0,
    out14 => reinterpret14_output_port_net_x0,
    out13 => reinterpret13_output_port_net_x0,
    out12 => reinterpret12_output_port_net_x0,
    out11 => reinterpret11_output_port_net_x0,
    out10 => reinterpret10_output_port_net_x0,
    out9 => reinterpret9_output_port_net,
    out8 => reinterpret8_output_port_net,
    out7 => reinterpret7_output_port_net,
    out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net_x0,
    out2 => reinterpret2_output_port_net_x0,
    lsb_out1 => reinterpret1_output_port_net_x2
  );
  repa : entity xil_defaultlib.pfb_fir_gen_8192ch_core_repa 
  port map (
    in_x0 => mult_din_y_net,
    out_x0 => reinterpret1_output_port_net_x0
  );
  repb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_repb 
  port map (
    in_x0 => dcoeffs_q_net,
    out_x0 => reinterpret1_output_port_net_x1
  );
  mult1 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret48_output_port_net_x0,
    b => reinterpret48_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret47_output_port_net_x0,
    b => reinterpret47_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult2_p_net
  );
  mult3 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret46_output_port_net_x0,
    b => reinterpret46_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult3_p_net
  );
  mult4 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret45_output_port_net_x0,
    b => reinterpret45_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult4_p_net
  );
  mult5 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret44_output_port_net_x0,
    b => reinterpret44_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult5_p_net
  );
  mult6 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret43_output_port_net_x0,
    b => reinterpret43_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult6_p_net
  );
  mult7 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret42_output_port_net_x0,
    b => reinterpret42_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult7_p_net
  );
  mult8 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret41_output_port_net_x0,
    b => reinterpret41_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult8_p_net
  );
  mult9 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret40_output_port_net_x0,
    b => reinterpret40_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult9_p_net
  );
  mult10 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret39_output_port_net_x0,
    b => reinterpret39_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult10_p_net
  );
  mult11 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret38_output_port_net_x0,
    b => reinterpret38_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult11_p_net
  );
  mult12 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret37_output_port_net_x0,
    b => reinterpret37_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult12_p_net
  );
  mult13 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret36_output_port_net_x0,
    b => reinterpret36_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult13_p_net
  );
  mult14 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret35_output_port_net_x0,
    b => reinterpret35_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult14_p_net
  );
  mult15 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret34_output_port_net_x0,
    b => reinterpret34_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult15_p_net
  );
  mult16 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret33_output_port_net_x0,
    b => reinterpret33_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult16_p_net
  );
  mult17 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret32_output_port_net_x0,
    b => reinterpret32_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult17_p_net
  );
  mult18 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret31_output_port_net_x0,
    b => reinterpret31_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult18_p_net
  );
  mult19 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret30_output_port_net_x0,
    b => reinterpret30_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult19_p_net
  );
  mult20 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret29_output_port_net,
    b => reinterpret29_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult20_p_net
  );
  mult21 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret28_output_port_net,
    b => reinterpret28_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult21_p_net
  );
  mult22 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret27_output_port_net,
    b => reinterpret27_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult22_p_net
  );
  mult23 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret26_output_port_net,
    b => reinterpret26_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult23_p_net
  );
  mult24 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret25_output_port_net,
    b => reinterpret25_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult24_p_net
  );
  mult25 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret24_output_port_net,
    b => reinterpret24_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult25_p_net
  );
  mult26 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret23_output_port_net,
    b => reinterpret23_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult26_p_net
  );
  mult27 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret22_output_port_net,
    b => reinterpret22_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult27_p_net
  );
  mult28 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret21_output_port_net,
    b => reinterpret21_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult28_p_net
  );
  mult29 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret20_output_port_net,
    b => reinterpret20_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult29_p_net
  );
  mult30 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret19_output_port_net,
    b => reinterpret19_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult30_p_net
  );
  mult31 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret18_output_port_net,
    b => reinterpret18_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult31_p_net
  );
  mult32 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret17_output_port_net,
    b => reinterpret17_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult32_p_net
  );
  mult33 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret16_output_port_net,
    b => reinterpret16_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult33_p_net
  );
  mult34 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret15_output_port_net,
    b => reinterpret15_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult34_p_net
  );
  mult35 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret14_output_port_net,
    b => reinterpret14_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult35_p_net
  );
  mult36 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret13_output_port_net,
    b => reinterpret13_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult36_p_net
  );
  mult37 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret12_output_port_net,
    b => reinterpret12_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult37_p_net
  );
  mult38 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret11_output_port_net,
    b => reinterpret11_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult38_p_net
  );
  mult39 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret10_output_port_net,
    b => reinterpret10_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult39_p_net
  );
  mult40 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret9_output_port_net_x0,
    b => reinterpret9_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult40_p_net
  );
  mult41 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret8_output_port_net_x0,
    b => reinterpret8_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult41_p_net
  );
  mult42 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret7_output_port_net_x0,
    b => reinterpret7_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult42_p_net
  );
  mult43 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret6_output_port_net_x0,
    b => reinterpret6_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult43_p_net
  );
  mult44 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret5_output_port_net_x0,
    b => reinterpret5_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult44_p_net
  );
  mult45 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret4_output_port_net_x0,
    b => reinterpret4_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult45_p_net
  );
  mult46 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret3_output_port_net,
    b => reinterpret3_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult46_p_net
  );
  mult47 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret2_output_port_net,
    b => reinterpret2_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    p => mult47_p_net
  );
  mult48 : entity xil_defaultlib.sysgen_mult_d2df7fc9d7 
  port map (
    clr => '0',
    a => reinterpret1_output_port_net,
    b => reinterpret1_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    p => mult48_p_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/sync_delay
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_sync_delay is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_sync_delay;
architecture structural of pfb_fir_gen_8192ch_core_sync_delay is 
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal sync_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 15-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 15-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 15-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 15-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= mux_y_net;
  sync_delay_q_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_2f66bd23b0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_790cd6bb1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_6c0c197109 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_gen_8192ch_core_c_counter_binary_v12_0_i1",
    op_arith => xlUnsigned,
    op_width => 15
  )
  port map (
    rst => "0",
    clr => '0',
    load => sync_delay_q_net,
    din => constant2_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_67610fd88a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => sync_delay_q_net,
    d1 => relational1_op_net,
    y => logical_y_net
  );
  mux : entity xil_defaultlib.sysgen_mux_3b10ce9056 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => constant3_op_net,
    d0 => sync_delay_q_net,
    d1 => relational_op_net,
    y => mux_y_net
  );
  relational : entity xil_defaultlib.sysgen_relational_33a9567d95 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => constant_op_net,
    b => counter_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_82cfa8d90a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant1_op_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/A_bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_a_bussify is
  port (
    in1 : in std_logic_vector( 9-1 downto 0 );
    in2 : in std_logic_vector( 9-1 downto 0 );
    in3 : in std_logic_vector( 9-1 downto 0 );
    in4 : in std_logic_vector( 9-1 downto 0 );
    in5 : in std_logic_vector( 9-1 downto 0 );
    in6 : in std_logic_vector( 9-1 downto 0 );
    in7 : in std_logic_vector( 9-1 downto 0 );
    in8 : in std_logic_vector( 9-1 downto 0 );
    in9 : in std_logic_vector( 9-1 downto 0 );
    in10 : in std_logic_vector( 9-1 downto 0 );
    in11 : in std_logic_vector( 9-1 downto 0 );
    in12 : in std_logic_vector( 9-1 downto 0 );
    in13 : in std_logic_vector( 9-1 downto 0 );
    in14 : in std_logic_vector( 9-1 downto 0 );
    in15 : in std_logic_vector( 9-1 downto 0 );
    in16 : in std_logic_vector( 9-1 downto 0 );
    in17 : in std_logic_vector( 9-1 downto 0 );
    in18 : in std_logic_vector( 9-1 downto 0 );
    in19 : in std_logic_vector( 9-1 downto 0 );
    in20 : in std_logic_vector( 9-1 downto 0 );
    in21 : in std_logic_vector( 9-1 downto 0 );
    in22 : in std_logic_vector( 9-1 downto 0 );
    in23 : in std_logic_vector( 9-1 downto 0 );
    in24 : in std_logic_vector( 9-1 downto 0 );
    in25 : in std_logic_vector( 9-1 downto 0 );
    in26 : in std_logic_vector( 9-1 downto 0 );
    in27 : in std_logic_vector( 9-1 downto 0 );
    in28 : in std_logic_vector( 9-1 downto 0 );
    in29 : in std_logic_vector( 9-1 downto 0 );
    in30 : in std_logic_vector( 9-1 downto 0 );
    in31 : in std_logic_vector( 9-1 downto 0 );
    in32 : in std_logic_vector( 9-1 downto 0 );
    bus_out : out std_logic_vector( 288-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_a_bussify;
architecture structural of pfb_fir_gen_8192ch_core_a_bussify is 
  signal concatenate_y_net : std_logic_vector( 288-1 downto 0 );
  signal bram0_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram1_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram2_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram3_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram4_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram5_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram6_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram7_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram8_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram9_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram10_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram11_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram12_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram13_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram14_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram15_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram16_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram17_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram18_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram19_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram20_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram21_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram22_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram23_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram24_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram25_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram26_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram27_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram28_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram29_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram30_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram31_douta_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 9-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  bram0_douta_net <= in1;
  bram1_douta_net <= in2;
  bram2_douta_net <= in3;
  bram3_douta_net <= in4;
  bram4_douta_net <= in5;
  bram5_douta_net <= in6;
  bram6_douta_net <= in7;
  bram7_douta_net <= in8;
  bram8_douta_net <= in9;
  bram9_douta_net <= in10;
  bram10_douta_net <= in11;
  bram11_douta_net <= in12;
  bram12_douta_net <= in13;
  bram13_douta_net <= in14;
  bram14_douta_net <= in15;
  bram15_douta_net <= in16;
  bram16_douta_net <= in17;
  bram17_douta_net <= in18;
  bram18_douta_net <= in19;
  bram19_douta_net <= in20;
  bram20_douta_net <= in21;
  bram21_douta_net <= in22;
  bram22_douta_net <= in23;
  bram23_douta_net <= in24;
  bram24_douta_net <= in25;
  bram25_douta_net <= in26;
  bram26_douta_net <= in27;
  bram27_douta_net <= in28;
  bram28_douta_net <= in29;
  bram29_douta_net <= in30;
  bram30_douta_net <= in31;
  bram31_douta_net <= in32;
  concatenate : entity xil_defaultlib.sysgen_concat_5310d2d622 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    in12 => reinterpret13_output_port_net,
    in13 => reinterpret14_output_port_net,
    in14 => reinterpret15_output_port_net,
    in15 => reinterpret16_output_port_net,
    in16 => reinterpret17_output_port_net,
    in17 => reinterpret18_output_port_net,
    in18 => reinterpret19_output_port_net,
    in19 => reinterpret20_output_port_net,
    in20 => reinterpret21_output_port_net,
    in21 => reinterpret22_output_port_net,
    in22 => reinterpret23_output_port_net,
    in23 => reinterpret24_output_port_net,
    in24 => reinterpret25_output_port_net,
    in25 => reinterpret26_output_port_net,
    in26 => reinterpret27_output_port_net,
    in27 => reinterpret28_output_port_net,
    in28 => reinterpret29_output_port_net,
    in29 => reinterpret30_output_port_net,
    in30 => reinterpret31_output_port_net,
    in31 => reinterpret32_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram0_douta_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram1_douta_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram2_douta_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram3_douta_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram4_douta_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram5_douta_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram6_douta_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram7_douta_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram8_douta_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram9_douta_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram10_douta_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram11_douta_net,
    output_port => reinterpret12_output_port_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram12_douta_net,
    output_port => reinterpret13_output_port_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram13_douta_net,
    output_port => reinterpret14_output_port_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram14_douta_net,
    output_port => reinterpret15_output_port_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram15_douta_net,
    output_port => reinterpret16_output_port_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram16_douta_net,
    output_port => reinterpret17_output_port_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram17_douta_net,
    output_port => reinterpret18_output_port_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram18_douta_net,
    output_port => reinterpret19_output_port_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram19_douta_net,
    output_port => reinterpret20_output_port_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram20_douta_net,
    output_port => reinterpret21_output_port_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram21_douta_net,
    output_port => reinterpret22_output_port_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram22_douta_net,
    output_port => reinterpret23_output_port_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram23_douta_net,
    output_port => reinterpret24_output_port_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram24_douta_net,
    output_port => reinterpret25_output_port_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram25_douta_net,
    output_port => reinterpret26_output_port_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram26_douta_net,
    output_port => reinterpret27_output_port_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram27_douta_net,
    output_port => reinterpret28_output_port_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram28_douta_net,
    output_port => reinterpret29_output_port_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram29_douta_net,
    output_port => reinterpret30_output_port_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram30_douta_net,
    output_port => reinterpret31_output_port_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => bram31_douta_net,
    output_port => reinterpret32_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/debus_addra
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_addra_x0 is
  port (
    bus_in : in std_logic_vector( 416-1 downto 0 );
    msb_out32 : out std_logic_vector( 13-1 downto 0 );
    out31 : out std_logic_vector( 13-1 downto 0 );
    out30 : out std_logic_vector( 13-1 downto 0 );
    out29 : out std_logic_vector( 13-1 downto 0 );
    out28 : out std_logic_vector( 13-1 downto 0 );
    out27 : out std_logic_vector( 13-1 downto 0 );
    out26 : out std_logic_vector( 13-1 downto 0 );
    out25 : out std_logic_vector( 13-1 downto 0 );
    out24 : out std_logic_vector( 13-1 downto 0 );
    out23 : out std_logic_vector( 13-1 downto 0 );
    out22 : out std_logic_vector( 13-1 downto 0 );
    out21 : out std_logic_vector( 13-1 downto 0 );
    out20 : out std_logic_vector( 13-1 downto 0 );
    out19 : out std_logic_vector( 13-1 downto 0 );
    out18 : out std_logic_vector( 13-1 downto 0 );
    out17 : out std_logic_vector( 13-1 downto 0 );
    out16 : out std_logic_vector( 13-1 downto 0 );
    out15 : out std_logic_vector( 13-1 downto 0 );
    out14 : out std_logic_vector( 13-1 downto 0 );
    out13 : out std_logic_vector( 13-1 downto 0 );
    out12 : out std_logic_vector( 13-1 downto 0 );
    out11 : out std_logic_vector( 13-1 downto 0 );
    out10 : out std_logic_vector( 13-1 downto 0 );
    out9 : out std_logic_vector( 13-1 downto 0 );
    out8 : out std_logic_vector( 13-1 downto 0 );
    out7 : out std_logic_vector( 13-1 downto 0 );
    out6 : out std_logic_vector( 13-1 downto 0 );
    out5 : out std_logic_vector( 13-1 downto 0 );
    out4 : out std_logic_vector( 13-1 downto 0 );
    out3 : out std_logic_vector( 13-1 downto 0 );
    out2 : out std_logic_vector( 13-1 downto 0 );
    lsb_out1 : out std_logic_vector( 13-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_addra_x0;
architecture structural of pfb_fir_gen_8192ch_core_debus_addra_x0 is 
  signal reinterpret32_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 416-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice32_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 13-1 downto 0 );
begin
  msb_out32 <= reinterpret32_output_port_net;
  out31 <= reinterpret31_output_port_net;
  out30 <= reinterpret30_output_port_net;
  out29 <= reinterpret29_output_port_net;
  out28 <= reinterpret28_output_port_net;
  out27 <= reinterpret27_output_port_net;
  out26 <= reinterpret26_output_port_net;
  out25 <= reinterpret25_output_port_net;
  out24 <= reinterpret24_output_port_net;
  out23 <= reinterpret23_output_port_net;
  out22 <= reinterpret22_output_port_net;
  out21 <= reinterpret21_output_port_net;
  out20 <= reinterpret20_output_port_net;
  out19 <= reinterpret19_output_port_net;
  out18 <= reinterpret18_output_port_net;
  out17 <= reinterpret17_output_port_net;
  out16 <= reinterpret16_output_port_net;
  out15 <= reinterpret15_output_port_net;
  out14 <= reinterpret14_output_port_net;
  out13 <= reinterpret13_output_port_net;
  out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 12,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 13,
    new_msb => 25,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 403,
    new_msb => 415,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice32_y_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice32_y_net,
    output_port => reinterpret32_output_port_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 390,
    new_msb => 402,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice31_y_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice31_y_net,
    output_port => reinterpret31_output_port_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 377,
    new_msb => 389,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice30_y_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice30_y_net,
    output_port => reinterpret30_output_port_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 364,
    new_msb => 376,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice29_y_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice29_y_net,
    output_port => reinterpret29_output_port_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 351,
    new_msb => 363,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice28_y_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice28_y_net,
    output_port => reinterpret28_output_port_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 338,
    new_msb => 350,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice27_y_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice27_y_net,
    output_port => reinterpret27_output_port_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 325,
    new_msb => 337,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice26_y_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice26_y_net,
    output_port => reinterpret26_output_port_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 312,
    new_msb => 324,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice25_y_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice25_y_net,
    output_port => reinterpret25_output_port_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 299,
    new_msb => 311,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice24_y_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice24_y_net,
    output_port => reinterpret24_output_port_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 286,
    new_msb => 298,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice23_y_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice23_y_net,
    output_port => reinterpret23_output_port_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 273,
    new_msb => 285,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice22_y_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice22_y_net,
    output_port => reinterpret22_output_port_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 260,
    new_msb => 272,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice21_y_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice21_y_net,
    output_port => reinterpret21_output_port_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 247,
    new_msb => 259,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice20_y_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice20_y_net,
    output_port => reinterpret20_output_port_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 234,
    new_msb => 246,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice19_y_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice19_y_net,
    output_port => reinterpret19_output_port_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 221,
    new_msb => 233,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice18_y_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice18_y_net,
    output_port => reinterpret18_output_port_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 208,
    new_msb => 220,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice17_y_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice17_y_net,
    output_port => reinterpret17_output_port_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 195,
    new_msb => 207,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice16_y_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice16_y_net,
    output_port => reinterpret16_output_port_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 182,
    new_msb => 194,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice15_y_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice15_y_net,
    output_port => reinterpret15_output_port_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 169,
    new_msb => 181,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice14_y_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice14_y_net,
    output_port => reinterpret14_output_port_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 156,
    new_msb => 168,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice13_y_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice13_y_net,
    output_port => reinterpret13_output_port_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 143,
    new_msb => 155,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 130,
    new_msb => 142,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 117,
    new_msb => 129,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 104,
    new_msb => 116,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 91,
    new_msb => 103,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 78,
    new_msb => 90,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 65,
    new_msb => 77,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 64,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 39,
    new_msb => 51,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 38,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/debus_addrb
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_addrb_x0 is
  port (
    bus_in : in std_logic_vector( 416-1 downto 0 );
    msb_out32 : out std_logic_vector( 13-1 downto 0 );
    out31 : out std_logic_vector( 13-1 downto 0 );
    out30 : out std_logic_vector( 13-1 downto 0 );
    out29 : out std_logic_vector( 13-1 downto 0 );
    out28 : out std_logic_vector( 13-1 downto 0 );
    out27 : out std_logic_vector( 13-1 downto 0 );
    out26 : out std_logic_vector( 13-1 downto 0 );
    out25 : out std_logic_vector( 13-1 downto 0 );
    out24 : out std_logic_vector( 13-1 downto 0 );
    out23 : out std_logic_vector( 13-1 downto 0 );
    out22 : out std_logic_vector( 13-1 downto 0 );
    out21 : out std_logic_vector( 13-1 downto 0 );
    out20 : out std_logic_vector( 13-1 downto 0 );
    out19 : out std_logic_vector( 13-1 downto 0 );
    out18 : out std_logic_vector( 13-1 downto 0 );
    out17 : out std_logic_vector( 13-1 downto 0 );
    out16 : out std_logic_vector( 13-1 downto 0 );
    out15 : out std_logic_vector( 13-1 downto 0 );
    out14 : out std_logic_vector( 13-1 downto 0 );
    out13 : out std_logic_vector( 13-1 downto 0 );
    out12 : out std_logic_vector( 13-1 downto 0 );
    out11 : out std_logic_vector( 13-1 downto 0 );
    out10 : out std_logic_vector( 13-1 downto 0 );
    out9 : out std_logic_vector( 13-1 downto 0 );
    out8 : out std_logic_vector( 13-1 downto 0 );
    out7 : out std_logic_vector( 13-1 downto 0 );
    out6 : out std_logic_vector( 13-1 downto 0 );
    out5 : out std_logic_vector( 13-1 downto 0 );
    out4 : out std_logic_vector( 13-1 downto 0 );
    out3 : out std_logic_vector( 13-1 downto 0 );
    out2 : out std_logic_vector( 13-1 downto 0 );
    lsb_out1 : out std_logic_vector( 13-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_addrb_x0;
architecture structural of pfb_fir_gen_8192ch_core_debus_addrb_x0 is 
  signal reinterpret32_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 416-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice32_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 13-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 13-1 downto 0 );
begin
  msb_out32 <= reinterpret32_output_port_net;
  out31 <= reinterpret31_output_port_net;
  out30 <= reinterpret30_output_port_net;
  out29 <= reinterpret29_output_port_net;
  out28 <= reinterpret28_output_port_net;
  out27 <= reinterpret27_output_port_net;
  out26 <= reinterpret26_output_port_net;
  out25 <= reinterpret25_output_port_net;
  out24 <= reinterpret24_output_port_net;
  out23 <= reinterpret23_output_port_net;
  out22 <= reinterpret22_output_port_net;
  out21 <= reinterpret21_output_port_net;
  out20 <= reinterpret20_output_port_net;
  out19 <= reinterpret19_output_port_net;
  out18 <= reinterpret18_output_port_net;
  out17 <= reinterpret17_output_port_net;
  out16 <= reinterpret16_output_port_net;
  out15 <= reinterpret15_output_port_net;
  out14 <= reinterpret14_output_port_net;
  out13 <= reinterpret13_output_port_net;
  out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 12,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 13,
    new_msb => 25,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 403,
    new_msb => 415,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice32_y_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice32_y_net,
    output_port => reinterpret32_output_port_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 390,
    new_msb => 402,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice31_y_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice31_y_net,
    output_port => reinterpret31_output_port_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 377,
    new_msb => 389,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice30_y_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice30_y_net,
    output_port => reinterpret30_output_port_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 364,
    new_msb => 376,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice29_y_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice29_y_net,
    output_port => reinterpret29_output_port_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 351,
    new_msb => 363,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice28_y_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice28_y_net,
    output_port => reinterpret28_output_port_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 338,
    new_msb => 350,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice27_y_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice27_y_net,
    output_port => reinterpret27_output_port_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 325,
    new_msb => 337,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice26_y_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice26_y_net,
    output_port => reinterpret26_output_port_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 312,
    new_msb => 324,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice25_y_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice25_y_net,
    output_port => reinterpret25_output_port_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 299,
    new_msb => 311,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice24_y_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice24_y_net,
    output_port => reinterpret24_output_port_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 286,
    new_msb => 298,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice23_y_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice23_y_net,
    output_port => reinterpret23_output_port_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 273,
    new_msb => 285,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice22_y_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice22_y_net,
    output_port => reinterpret22_output_port_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 260,
    new_msb => 272,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice21_y_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice21_y_net,
    output_port => reinterpret21_output_port_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 247,
    new_msb => 259,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice20_y_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice20_y_net,
    output_port => reinterpret20_output_port_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 234,
    new_msb => 246,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice19_y_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice19_y_net,
    output_port => reinterpret19_output_port_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 221,
    new_msb => 233,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice18_y_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice18_y_net,
    output_port => reinterpret18_output_port_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 208,
    new_msb => 220,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice17_y_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice17_y_net,
    output_port => reinterpret17_output_port_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 195,
    new_msb => 207,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice16_y_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice16_y_net,
    output_port => reinterpret16_output_port_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 182,
    new_msb => 194,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice15_y_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice15_y_net,
    output_port => reinterpret15_output_port_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 169,
    new_msb => 181,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice14_y_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice14_y_net,
    output_port => reinterpret14_output_port_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 156,
    new_msb => 168,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice13_y_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice13_y_net,
    output_port => reinterpret13_output_port_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 143,
    new_msb => 155,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 130,
    new_msb => 142,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 117,
    new_msb => 129,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 104,
    new_msb => 116,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 91,
    new_msb => 103,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 78,
    new_msb => 90,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 65,
    new_msb => 77,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 64,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 39,
    new_msb => 51,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 38,
    x_width => 416,
    y_width => 13
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/debus_dina
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_dina_x0 is
  port (
    bus_in : in std_logic_vector( 288-1 downto 0 );
    msb_out32 : out std_logic_vector( 9-1 downto 0 );
    out31 : out std_logic_vector( 9-1 downto 0 );
    out30 : out std_logic_vector( 9-1 downto 0 );
    out29 : out std_logic_vector( 9-1 downto 0 );
    out28 : out std_logic_vector( 9-1 downto 0 );
    out27 : out std_logic_vector( 9-1 downto 0 );
    out26 : out std_logic_vector( 9-1 downto 0 );
    out25 : out std_logic_vector( 9-1 downto 0 );
    out24 : out std_logic_vector( 9-1 downto 0 );
    out23 : out std_logic_vector( 9-1 downto 0 );
    out22 : out std_logic_vector( 9-1 downto 0 );
    out21 : out std_logic_vector( 9-1 downto 0 );
    out20 : out std_logic_vector( 9-1 downto 0 );
    out19 : out std_logic_vector( 9-1 downto 0 );
    out18 : out std_logic_vector( 9-1 downto 0 );
    out17 : out std_logic_vector( 9-1 downto 0 );
    out16 : out std_logic_vector( 9-1 downto 0 );
    out15 : out std_logic_vector( 9-1 downto 0 );
    out14 : out std_logic_vector( 9-1 downto 0 );
    out13 : out std_logic_vector( 9-1 downto 0 );
    out12 : out std_logic_vector( 9-1 downto 0 );
    out11 : out std_logic_vector( 9-1 downto 0 );
    out10 : out std_logic_vector( 9-1 downto 0 );
    out9 : out std_logic_vector( 9-1 downto 0 );
    out8 : out std_logic_vector( 9-1 downto 0 );
    out7 : out std_logic_vector( 9-1 downto 0 );
    out6 : out std_logic_vector( 9-1 downto 0 );
    out5 : out std_logic_vector( 9-1 downto 0 );
    out4 : out std_logic_vector( 9-1 downto 0 );
    out3 : out std_logic_vector( 9-1 downto 0 );
    out2 : out std_logic_vector( 9-1 downto 0 );
    lsb_out1 : out std_logic_vector( 9-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_dina_x0;
architecture structural of pfb_fir_gen_8192ch_core_debus_dina_x0 is 
  signal reinterpret32_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal ddina_q_net : std_logic_vector( 288-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice32_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 9-1 downto 0 );
begin
  msb_out32 <= reinterpret32_output_port_net;
  out31 <= reinterpret31_output_port_net;
  out30 <= reinterpret30_output_port_net;
  out29 <= reinterpret29_output_port_net;
  out28 <= reinterpret28_output_port_net;
  out27 <= reinterpret27_output_port_net;
  out26 <= reinterpret26_output_port_net;
  out25 <= reinterpret25_output_port_net;
  out24 <= reinterpret24_output_port_net;
  out23 <= reinterpret23_output_port_net;
  out22 <= reinterpret22_output_port_net;
  out21 <= reinterpret21_output_port_net;
  out20 <= reinterpret20_output_port_net;
  out19 <= reinterpret19_output_port_net;
  out18 <= reinterpret18_output_port_net;
  out17 <= reinterpret17_output_port_net;
  out16 <= reinterpret16_output_port_net;
  out15 <= reinterpret15_output_port_net;
  out14 <= reinterpret14_output_port_net;
  out13 <= reinterpret13_output_port_net;
  out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  ddina_q_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 8,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 17,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice2_y_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 279,
    new_msb => 287,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice32_y_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice32_y_net,
    output_port => reinterpret32_output_port_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 270,
    new_msb => 278,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice31_y_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice31_y_net,
    output_port => reinterpret31_output_port_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 261,
    new_msb => 269,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice30_y_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice30_y_net,
    output_port => reinterpret30_output_port_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 252,
    new_msb => 260,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice29_y_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice29_y_net,
    output_port => reinterpret29_output_port_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 243,
    new_msb => 251,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice28_y_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice28_y_net,
    output_port => reinterpret28_output_port_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 234,
    new_msb => 242,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice27_y_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice27_y_net,
    output_port => reinterpret27_output_port_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 225,
    new_msb => 233,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice26_y_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice26_y_net,
    output_port => reinterpret26_output_port_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 216,
    new_msb => 224,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice25_y_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice25_y_net,
    output_port => reinterpret25_output_port_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 207,
    new_msb => 215,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice24_y_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice24_y_net,
    output_port => reinterpret24_output_port_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 198,
    new_msb => 206,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice23_y_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice23_y_net,
    output_port => reinterpret23_output_port_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 189,
    new_msb => 197,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice22_y_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice22_y_net,
    output_port => reinterpret22_output_port_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 180,
    new_msb => 188,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice21_y_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice21_y_net,
    output_port => reinterpret21_output_port_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 171,
    new_msb => 179,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice20_y_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice20_y_net,
    output_port => reinterpret20_output_port_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 162,
    new_msb => 170,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice19_y_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice19_y_net,
    output_port => reinterpret19_output_port_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 153,
    new_msb => 161,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice18_y_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice18_y_net,
    output_port => reinterpret18_output_port_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 144,
    new_msb => 152,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice17_y_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice17_y_net,
    output_port => reinterpret17_output_port_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 135,
    new_msb => 143,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice16_y_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice16_y_net,
    output_port => reinterpret16_output_port_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 126,
    new_msb => 134,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice15_y_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice15_y_net,
    output_port => reinterpret15_output_port_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 117,
    new_msb => 125,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice14_y_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice14_y_net,
    output_port => reinterpret14_output_port_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 108,
    new_msb => 116,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice13_y_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice13_y_net,
    output_port => reinterpret13_output_port_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 99,
    new_msb => 107,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 90,
    new_msb => 98,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 81,
    new_msb => 89,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 72,
    new_msb => 80,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 63,
    new_msb => 71,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 54,
    new_msb => 62,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 45,
    new_msb => 53,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 44,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 27,
    new_msb => 35,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 26,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddina_q_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/debus_dinb
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_dinb_x0 is
  port (
    bus_in : in std_logic_vector( 288-1 downto 0 );
    msb_out32 : out std_logic_vector( 9-1 downto 0 );
    out31 : out std_logic_vector( 9-1 downto 0 );
    out30 : out std_logic_vector( 9-1 downto 0 );
    out29 : out std_logic_vector( 9-1 downto 0 );
    out28 : out std_logic_vector( 9-1 downto 0 );
    out27 : out std_logic_vector( 9-1 downto 0 );
    out26 : out std_logic_vector( 9-1 downto 0 );
    out25 : out std_logic_vector( 9-1 downto 0 );
    out24 : out std_logic_vector( 9-1 downto 0 );
    out23 : out std_logic_vector( 9-1 downto 0 );
    out22 : out std_logic_vector( 9-1 downto 0 );
    out21 : out std_logic_vector( 9-1 downto 0 );
    out20 : out std_logic_vector( 9-1 downto 0 );
    out19 : out std_logic_vector( 9-1 downto 0 );
    out18 : out std_logic_vector( 9-1 downto 0 );
    out17 : out std_logic_vector( 9-1 downto 0 );
    out16 : out std_logic_vector( 9-1 downto 0 );
    out15 : out std_logic_vector( 9-1 downto 0 );
    out14 : out std_logic_vector( 9-1 downto 0 );
    out13 : out std_logic_vector( 9-1 downto 0 );
    out12 : out std_logic_vector( 9-1 downto 0 );
    out11 : out std_logic_vector( 9-1 downto 0 );
    out10 : out std_logic_vector( 9-1 downto 0 );
    out9 : out std_logic_vector( 9-1 downto 0 );
    out8 : out std_logic_vector( 9-1 downto 0 );
    out7 : out std_logic_vector( 9-1 downto 0 );
    out6 : out std_logic_vector( 9-1 downto 0 );
    out5 : out std_logic_vector( 9-1 downto 0 );
    out4 : out std_logic_vector( 9-1 downto 0 );
    out3 : out std_logic_vector( 9-1 downto 0 );
    out2 : out std_logic_vector( 9-1 downto 0 );
    lsb_out1 : out std_logic_vector( 9-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_dinb_x0;
architecture structural of pfb_fir_gen_8192ch_core_debus_dinb_x0 is 
  signal reinterpret32_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal ddinb_q_net : std_logic_vector( 288-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice32_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 9-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 9-1 downto 0 );
begin
  msb_out32 <= reinterpret32_output_port_net;
  out31 <= reinterpret31_output_port_net;
  out30 <= reinterpret30_output_port_net;
  out29 <= reinterpret29_output_port_net;
  out28 <= reinterpret28_output_port_net;
  out27 <= reinterpret27_output_port_net;
  out26 <= reinterpret26_output_port_net;
  out25 <= reinterpret25_output_port_net;
  out24 <= reinterpret24_output_port_net;
  out23 <= reinterpret23_output_port_net;
  out22 <= reinterpret22_output_port_net;
  out21 <= reinterpret21_output_port_net;
  out20 <= reinterpret20_output_port_net;
  out19 <= reinterpret19_output_port_net;
  out18 <= reinterpret18_output_port_net;
  out17 <= reinterpret17_output_port_net;
  out16 <= reinterpret16_output_port_net;
  out15 <= reinterpret15_output_port_net;
  out14 <= reinterpret14_output_port_net;
  out13 <= reinterpret13_output_port_net;
  out12 <= reinterpret12_output_port_net;
  out11 <= reinterpret11_output_port_net;
  out10 <= reinterpret10_output_port_net;
  out9 <= reinterpret9_output_port_net;
  out8 <= reinterpret8_output_port_net;
  out7 <= reinterpret7_output_port_net;
  out6 <= reinterpret6_output_port_net;
  out5 <= reinterpret5_output_port_net;
  out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  ddinb_q_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 8,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 17,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice2_y_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 279,
    new_msb => 287,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice32_y_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice32_y_net,
    output_port => reinterpret32_output_port_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 270,
    new_msb => 278,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice31_y_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice31_y_net,
    output_port => reinterpret31_output_port_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 261,
    new_msb => 269,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice30_y_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice30_y_net,
    output_port => reinterpret30_output_port_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 252,
    new_msb => 260,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice29_y_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice29_y_net,
    output_port => reinterpret29_output_port_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 243,
    new_msb => 251,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice28_y_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice28_y_net,
    output_port => reinterpret28_output_port_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 234,
    new_msb => 242,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice27_y_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice27_y_net,
    output_port => reinterpret27_output_port_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 225,
    new_msb => 233,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice26_y_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice26_y_net,
    output_port => reinterpret26_output_port_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 216,
    new_msb => 224,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice25_y_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice25_y_net,
    output_port => reinterpret25_output_port_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 207,
    new_msb => 215,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice24_y_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice24_y_net,
    output_port => reinterpret24_output_port_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 198,
    new_msb => 206,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice23_y_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice23_y_net,
    output_port => reinterpret23_output_port_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 189,
    new_msb => 197,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice22_y_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice22_y_net,
    output_port => reinterpret22_output_port_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 180,
    new_msb => 188,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice21_y_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice21_y_net,
    output_port => reinterpret21_output_port_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 171,
    new_msb => 179,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice20_y_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice20_y_net,
    output_port => reinterpret20_output_port_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 162,
    new_msb => 170,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice19_y_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice19_y_net,
    output_port => reinterpret19_output_port_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 153,
    new_msb => 161,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice18_y_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice18_y_net,
    output_port => reinterpret18_output_port_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 144,
    new_msb => 152,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice17_y_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice17_y_net,
    output_port => reinterpret17_output_port_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 135,
    new_msb => 143,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice16_y_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice16_y_net,
    output_port => reinterpret16_output_port_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 126,
    new_msb => 134,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice15_y_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice15_y_net,
    output_port => reinterpret15_output_port_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 117,
    new_msb => 125,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice14_y_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice14_y_net,
    output_port => reinterpret14_output_port_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 108,
    new_msb => 116,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice13_y_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice13_y_net,
    output_port => reinterpret13_output_port_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 99,
    new_msb => 107,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice12_y_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice12_y_net,
    output_port => reinterpret12_output_port_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 90,
    new_msb => 98,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice11_y_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice11_y_net,
    output_port => reinterpret11_output_port_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 81,
    new_msb => 89,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice10_y_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice10_y_net,
    output_port => reinterpret10_output_port_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 72,
    new_msb => 80,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice9_y_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice9_y_net,
    output_port => reinterpret9_output_port_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 63,
    new_msb => 71,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice8_y_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice8_y_net,
    output_port => reinterpret8_output_port_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 54,
    new_msb => 62,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice7_y_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice7_y_net,
    output_port => reinterpret7_output_port_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 45,
    new_msb => 53,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice6_y_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice6_y_net,
    output_port => reinterpret6_output_port_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 36,
    new_msb => 44,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice5_y_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice5_y_net,
    output_port => reinterpret5_output_port_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 27,
    new_msb => 35,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 26,
    x_width => 288,
    y_width => 9
  )
  port map (
    x => ddinb_q_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cae42ad461 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/debus_wea
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_wea is
  port (
    bus_in : in std_logic_vector( 32-1 downto 0 );
    msb_out32 : out std_logic_vector( 1-1 downto 0 );
    out31 : out std_logic_vector( 1-1 downto 0 );
    out30 : out std_logic_vector( 1-1 downto 0 );
    out29 : out std_logic_vector( 1-1 downto 0 );
    out28 : out std_logic_vector( 1-1 downto 0 );
    out27 : out std_logic_vector( 1-1 downto 0 );
    out26 : out std_logic_vector( 1-1 downto 0 );
    out25 : out std_logic_vector( 1-1 downto 0 );
    out24 : out std_logic_vector( 1-1 downto 0 );
    out23 : out std_logic_vector( 1-1 downto 0 );
    out22 : out std_logic_vector( 1-1 downto 0 );
    out21 : out std_logic_vector( 1-1 downto 0 );
    out20 : out std_logic_vector( 1-1 downto 0 );
    out19 : out std_logic_vector( 1-1 downto 0 );
    out18 : out std_logic_vector( 1-1 downto 0 );
    out17 : out std_logic_vector( 1-1 downto 0 );
    out16 : out std_logic_vector( 1-1 downto 0 );
    out15 : out std_logic_vector( 1-1 downto 0 );
    out14 : out std_logic_vector( 1-1 downto 0 );
    out13 : out std_logic_vector( 1-1 downto 0 );
    out12 : out std_logic_vector( 1-1 downto 0 );
    out11 : out std_logic_vector( 1-1 downto 0 );
    out10 : out std_logic_vector( 1-1 downto 0 );
    out9 : out std_logic_vector( 1-1 downto 0 );
    out8 : out std_logic_vector( 1-1 downto 0 );
    out7 : out std_logic_vector( 1-1 downto 0 );
    out6 : out std_logic_vector( 1-1 downto 0 );
    out5 : out std_logic_vector( 1-1 downto 0 );
    out4 : out std_logic_vector( 1-1 downto 0 );
    out3 : out std_logic_vector( 1-1 downto 0 );
    out2 : out std_logic_vector( 1-1 downto 0 );
    lsb_out1 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_wea;
architecture structural of pfb_fir_gen_8192ch_core_debus_wea is 
  signal slice32_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 32-1 downto 0 );
begin
  msb_out32 <= slice32_y_net;
  out31 <= slice31_y_net;
  out30 <= slice30_y_net;
  out29 <= slice29_y_net;
  out28 <= slice28_y_net;
  out27 <= slice27_y_net;
  out26 <= slice26_y_net;
  out25 <= slice25_y_net;
  out24 <= slice24_y_net;
  out23 <= slice23_y_net;
  out22 <= slice22_y_net;
  out21 <= slice21_y_net;
  out20 <= slice20_y_net;
  out19 <= slice19_y_net;
  out18 <= slice18_y_net;
  out17 <= slice17_y_net;
  out16 <= slice16_y_net;
  out15 <= slice15_y_net;
  out14 <= slice14_y_net;
  out13 <= slice13_y_net;
  out12 <= slice12_y_net;
  out11 <= slice11_y_net;
  out10 <= slice10_y_net;
  out9 <= slice9_y_net;
  out8 <= slice8_y_net;
  out7 <= slice7_y_net;
  out6 <= slice6_y_net;
  out5 <= slice5_y_net;
  out4 <= slice4_y_net;
  out3 <= slice3_y_net;
  out2 <= slice2_y_net;
  lsb_out1 <= slice1_y_net;
  concatenate_y_net <= bus_in;
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 1,
    new_msb => 1,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 31,
    new_msb => 31,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice32_y_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 30,
    new_msb => 30,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice31_y_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 29,
    new_msb => 29,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice30_y_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 28,
    new_msb => 28,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice29_y_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 27,
    new_msb => 27,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice28_y_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 26,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice27_y_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 25,
    new_msb => 25,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice26_y_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 24,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice25_y_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 23,
    new_msb => 23,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice24_y_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 22,
    new_msb => 22,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice23_y_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 21,
    new_msb => 21,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice22_y_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 20,
    new_msb => 20,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice21_y_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 19,
    new_msb => 19,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice20_y_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 18,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice19_y_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 17,
    new_msb => 17,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice18_y_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 16,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice17_y_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 15,
    new_msb => 15,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice16_y_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice15_y_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 13,
    new_msb => 13,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice14_y_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 12,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice13_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 11,
    new_msb => 11,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice12_y_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 10,
    new_msb => 10,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice11_y_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 9,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice10_y_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice9_y_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 7,
    new_msb => 7,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice8_y_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 6,
    new_msb => 6,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice7_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 5,
    new_msb => 5,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 4,
    new_msb => 4,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 3,
    new_msb => 3,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 2,
    new_msb => 2,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/debus_web
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_debus_web is
  port (
    bus_in : in std_logic_vector( 32-1 downto 0 );
    msb_out32 : out std_logic_vector( 1-1 downto 0 );
    out31 : out std_logic_vector( 1-1 downto 0 );
    out30 : out std_logic_vector( 1-1 downto 0 );
    out29 : out std_logic_vector( 1-1 downto 0 );
    out28 : out std_logic_vector( 1-1 downto 0 );
    out27 : out std_logic_vector( 1-1 downto 0 );
    out26 : out std_logic_vector( 1-1 downto 0 );
    out25 : out std_logic_vector( 1-1 downto 0 );
    out24 : out std_logic_vector( 1-1 downto 0 );
    out23 : out std_logic_vector( 1-1 downto 0 );
    out22 : out std_logic_vector( 1-1 downto 0 );
    out21 : out std_logic_vector( 1-1 downto 0 );
    out20 : out std_logic_vector( 1-1 downto 0 );
    out19 : out std_logic_vector( 1-1 downto 0 );
    out18 : out std_logic_vector( 1-1 downto 0 );
    out17 : out std_logic_vector( 1-1 downto 0 );
    out16 : out std_logic_vector( 1-1 downto 0 );
    out15 : out std_logic_vector( 1-1 downto 0 );
    out14 : out std_logic_vector( 1-1 downto 0 );
    out13 : out std_logic_vector( 1-1 downto 0 );
    out12 : out std_logic_vector( 1-1 downto 0 );
    out11 : out std_logic_vector( 1-1 downto 0 );
    out10 : out std_logic_vector( 1-1 downto 0 );
    out9 : out std_logic_vector( 1-1 downto 0 );
    out8 : out std_logic_vector( 1-1 downto 0 );
    out7 : out std_logic_vector( 1-1 downto 0 );
    out6 : out std_logic_vector( 1-1 downto 0 );
    out5 : out std_logic_vector( 1-1 downto 0 );
    out4 : out std_logic_vector( 1-1 downto 0 );
    out3 : out std_logic_vector( 1-1 downto 0 );
    out2 : out std_logic_vector( 1-1 downto 0 );
    lsb_out1 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_debus_web;
architecture structural of pfb_fir_gen_8192ch_core_debus_web is 
  signal slice32_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 32-1 downto 0 );
begin
  msb_out32 <= slice32_y_net;
  out31 <= slice31_y_net;
  out30 <= slice30_y_net;
  out29 <= slice29_y_net;
  out28 <= slice28_y_net;
  out27 <= slice27_y_net;
  out26 <= slice26_y_net;
  out25 <= slice25_y_net;
  out24 <= slice24_y_net;
  out23 <= slice23_y_net;
  out22 <= slice22_y_net;
  out21 <= slice21_y_net;
  out20 <= slice20_y_net;
  out19 <= slice19_y_net;
  out18 <= slice18_y_net;
  out17 <= slice17_y_net;
  out16 <= slice16_y_net;
  out15 <= slice15_y_net;
  out14 <= slice14_y_net;
  out13 <= slice13_y_net;
  out12 <= slice12_y_net;
  out11 <= slice11_y_net;
  out10 <= slice10_y_net;
  out9 <= slice9_y_net;
  out8 <= slice8_y_net;
  out7 <= slice7_y_net;
  out6 <= slice6_y_net;
  out5 <= slice5_y_net;
  out4 <= slice4_y_net;
  out3 <= slice3_y_net;
  out2 <= slice2_y_net;
  lsb_out1 <= slice1_y_net;
  concatenate_y_net <= bus_in;
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 1,
    new_msb => 1,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice32 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 31,
    new_msb => 31,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice32_y_net
  );
  slice31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 30,
    new_msb => 30,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice31_y_net
  );
  slice30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 29,
    new_msb => 29,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice30_y_net
  );
  slice29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 28,
    new_msb => 28,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice29_y_net
  );
  slice28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 27,
    new_msb => 27,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice28_y_net
  );
  slice27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 26,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice27_y_net
  );
  slice26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 25,
    new_msb => 25,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice26_y_net
  );
  slice25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 24,
    new_msb => 24,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice25_y_net
  );
  slice24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 23,
    new_msb => 23,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice24_y_net
  );
  slice23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 22,
    new_msb => 22,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice23_y_net
  );
  slice22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 21,
    new_msb => 21,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice22_y_net
  );
  slice21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 20,
    new_msb => 20,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice21_y_net
  );
  slice20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 19,
    new_msb => 19,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice20_y_net
  );
  slice19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 18,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice19_y_net
  );
  slice18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 17,
    new_msb => 17,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice18_y_net
  );
  slice17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 16,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice17_y_net
  );
  slice16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 15,
    new_msb => 15,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice16_y_net
  );
  slice15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 14,
    new_msb => 14,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice15_y_net
  );
  slice14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 13,
    new_msb => 13,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice14_y_net
  );
  slice13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 12,
    new_msb => 12,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice13_y_net
  );
  slice12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 11,
    new_msb => 11,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice12_y_net
  );
  slice11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 10,
    new_msb => 10,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice11_y_net
  );
  slice10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 9,
    new_msb => 9,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice10_y_net
  );
  slice9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 8,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice9_y_net
  );
  slice8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 7,
    new_msb => 7,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice8_y_net
  );
  slice7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 6,
    new_msb => 6,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice7_y_net
  );
  slice6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 5,
    new_msb => 5,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice6_y_net
  );
  slice5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 4,
    new_msb => 4,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice5_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 3,
    new_msb => 3,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 2,
    new_msb => 2,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_addra/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x10 is
  port (
    in1 : in std_logic_vector( 13-1 downto 0 );
    in2 : in std_logic_vector( 13-1 downto 0 );
    in3 : in std_logic_vector( 13-1 downto 0 );
    in4 : in std_logic_vector( 13-1 downto 0 );
    in5 : in std_logic_vector( 13-1 downto 0 );
    in6 : in std_logic_vector( 13-1 downto 0 );
    in7 : in std_logic_vector( 13-1 downto 0 );
    in8 : in std_logic_vector( 13-1 downto 0 );
    in9 : in std_logic_vector( 13-1 downto 0 );
    in10 : in std_logic_vector( 13-1 downto 0 );
    in11 : in std_logic_vector( 13-1 downto 0 );
    in12 : in std_logic_vector( 13-1 downto 0 );
    in13 : in std_logic_vector( 13-1 downto 0 );
    in14 : in std_logic_vector( 13-1 downto 0 );
    in15 : in std_logic_vector( 13-1 downto 0 );
    in16 : in std_logic_vector( 13-1 downto 0 );
    in17 : in std_logic_vector( 13-1 downto 0 );
    in18 : in std_logic_vector( 13-1 downto 0 );
    in19 : in std_logic_vector( 13-1 downto 0 );
    in20 : in std_logic_vector( 13-1 downto 0 );
    in21 : in std_logic_vector( 13-1 downto 0 );
    in22 : in std_logic_vector( 13-1 downto 0 );
    in23 : in std_logic_vector( 13-1 downto 0 );
    in24 : in std_logic_vector( 13-1 downto 0 );
    in25 : in std_logic_vector( 13-1 downto 0 );
    in26 : in std_logic_vector( 13-1 downto 0 );
    in27 : in std_logic_vector( 13-1 downto 0 );
    in28 : in std_logic_vector( 13-1 downto 0 );
    in29 : in std_logic_vector( 13-1 downto 0 );
    in30 : in std_logic_vector( 13-1 downto 0 );
    in31 : in std_logic_vector( 13-1 downto 0 );
    in32 : in std_logic_vector( 13-1 downto 0 );
    bus_out : out std_logic_vector( 416-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x10;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x10 is 
  signal concatenate_y_net : std_logic_vector( 416-1 downto 0 );
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_6_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_7_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_8_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_9_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_10_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_11_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_12_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_13_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_14_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_15_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_16_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_17_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_18_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_19_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_20_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_21_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_22_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_23_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_24_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_25_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_26_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_27_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_28_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_29_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_30_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_31_q_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 13-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  din0_0_q_net <= in1;
  din0_1_q_net <= in2;
  din0_2_q_net <= in3;
  din0_3_q_net <= in4;
  din0_4_q_net <= in5;
  din0_5_q_net <= in6;
  din0_6_q_net <= in7;
  din0_7_q_net <= in8;
  din0_8_q_net <= in9;
  din0_9_q_net <= in10;
  din0_10_q_net <= in11;
  din0_11_q_net <= in12;
  din0_12_q_net <= in13;
  din0_13_q_net <= in14;
  din0_14_q_net <= in15;
  din0_15_q_net <= in16;
  din0_16_q_net <= in17;
  din0_17_q_net <= in18;
  din0_18_q_net <= in19;
  din0_19_q_net <= in20;
  din0_20_q_net <= in21;
  din0_21_q_net <= in22;
  din0_22_q_net <= in23;
  din0_23_q_net <= in24;
  din0_24_q_net <= in25;
  din0_25_q_net <= in26;
  din0_26_q_net <= in27;
  din0_27_q_net <= in28;
  din0_28_q_net <= in29;
  din0_29_q_net <= in30;
  din0_30_q_net <= in31;
  din0_31_q_net <= in32;
  concatenate : entity xil_defaultlib.sysgen_concat_4e7b466dbb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    in12 => reinterpret13_output_port_net,
    in13 => reinterpret14_output_port_net,
    in14 => reinterpret15_output_port_net,
    in15 => reinterpret16_output_port_net,
    in16 => reinterpret17_output_port_net,
    in17 => reinterpret18_output_port_net,
    in18 => reinterpret19_output_port_net,
    in19 => reinterpret20_output_port_net,
    in20 => reinterpret21_output_port_net,
    in21 => reinterpret22_output_port_net,
    in22 => reinterpret23_output_port_net,
    in23 => reinterpret24_output_port_net,
    in24 => reinterpret25_output_port_net,
    in25 => reinterpret26_output_port_net,
    in26 => reinterpret27_output_port_net,
    in27 => reinterpret28_output_port_net,
    in28 => reinterpret29_output_port_net,
    in29 => reinterpret30_output_port_net,
    in30 => reinterpret31_output_port_net,
    in31 => reinterpret32_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_0_q_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_1_q_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_2_q_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_3_q_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_4_q_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_5_q_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_6_q_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_7_q_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_8_q_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_9_q_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_10_q_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_11_q_net,
    output_port => reinterpret12_output_port_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_12_q_net,
    output_port => reinterpret13_output_port_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_13_q_net,
    output_port => reinterpret14_output_port_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_14_q_net,
    output_port => reinterpret15_output_port_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_15_q_net,
    output_port => reinterpret16_output_port_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_16_q_net,
    output_port => reinterpret17_output_port_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_17_q_net,
    output_port => reinterpret18_output_port_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_18_q_net,
    output_port => reinterpret19_output_port_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_19_q_net,
    output_port => reinterpret20_output_port_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_20_q_net,
    output_port => reinterpret21_output_port_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_21_q_net,
    output_port => reinterpret22_output_port_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_22_q_net,
    output_port => reinterpret23_output_port_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_23_q_net,
    output_port => reinterpret24_output_port_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_24_q_net,
    output_port => reinterpret25_output_port_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_25_q_net,
    output_port => reinterpret26_output_port_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_26_q_net,
    output_port => reinterpret27_output_port_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_27_q_net,
    output_port => reinterpret28_output_port_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_28_q_net,
    output_port => reinterpret29_output_port_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_29_q_net,
    output_port => reinterpret30_output_port_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_30_q_net,
    output_port => reinterpret31_output_port_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_31_q_net,
    output_port => reinterpret32_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_addra
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_addra_x0 is
  port (
    in_x0 : in std_logic_vector( 13-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 416-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_addra_x0;
architecture structural of pfb_fir_gen_8192ch_core_rep_addra_x0 is 
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_6_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_7_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_8_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_9_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_10_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_11_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_12_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_13_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_14_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_15_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_16_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_17_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_18_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_19_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_20_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_21_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_22_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_23_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_24_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_25_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_26_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_27_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_28_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_29_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_30_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_31_q_net : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 416-1 downto 0 );
  signal counter_op_net : std_logic_vector( 13-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  counter_op_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x10 
  port map (
    in1 => din0_0_q_net,
    in2 => din0_1_q_net,
    in3 => din0_2_q_net,
    in4 => din0_3_q_net,
    in5 => din0_4_q_net,
    in6 => din0_5_q_net,
    in7 => din0_6_q_net,
    in8 => din0_7_q_net,
    in9 => din0_8_q_net,
    in10 => din0_9_q_net,
    in11 => din0_10_q_net,
    in12 => din0_11_q_net,
    in13 => din0_12_q_net,
    in14 => din0_13_q_net,
    in15 => din0_14_q_net,
    in16 => din0_15_q_net,
    in17 => din0_16_q_net,
    in18 => din0_17_q_net,
    in19 => din0_18_q_net,
    in20 => din0_19_q_net,
    in21 => din0_20_q_net,
    in22 => din0_21_q_net,
    in23 => din0_22_q_net,
    in24 => din0_23_q_net,
    in25 => din0_24_q_net,
    in26 => din0_25_q_net,
    in27 => din0_26_q_net,
    in28 => din0_27_q_net,
    in29 => din0_28_q_net,
    in30 => din0_29_q_net,
    in31 => din0_30_q_net,
    in32 => din0_31_q_net,
    bus_out => concatenate_y_net
  );
  din0_0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_0_q_net
  );
  din0_1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_1_q_net
  );
  din0_2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_2_q_net
  );
  din0_3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_3_q_net
  );
  din0_4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_4_q_net
  );
  din0_5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_5_q_net
  );
  din0_6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_6_q_net
  );
  din0_7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_7_q_net
  );
  din0_8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_8_q_net
  );
  din0_9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_9_q_net
  );
  din0_10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_10_q_net
  );
  din0_11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_11_q_net
  );
  din0_12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_12_q_net
  );
  din0_13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_13_q_net
  );
  din0_14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_14_q_net
  );
  din0_15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_15_q_net
  );
  din0_16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_16_q_net
  );
  din0_17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_17_q_net
  );
  din0_18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_18_q_net
  );
  din0_19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_19_q_net
  );
  din0_20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_20_q_net
  );
  din0_21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_21_q_net
  );
  din0_22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_22_q_net
  );
  din0_23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_23_q_net
  );
  din0_24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_24_q_net
  );
  din0_25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_25_q_net
  );
  din0_26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_26_q_net
  );
  din0_27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_27_q_net
  );
  din0_28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_28_q_net
  );
  din0_29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_29_q_net
  );
  din0_30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_30_q_net
  );
  din0_31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_31_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_addrb/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x8 is
  port (
    in1 : in std_logic_vector( 13-1 downto 0 );
    in2 : in std_logic_vector( 13-1 downto 0 );
    in3 : in std_logic_vector( 13-1 downto 0 );
    in4 : in std_logic_vector( 13-1 downto 0 );
    in5 : in std_logic_vector( 13-1 downto 0 );
    in6 : in std_logic_vector( 13-1 downto 0 );
    in7 : in std_logic_vector( 13-1 downto 0 );
    in8 : in std_logic_vector( 13-1 downto 0 );
    in9 : in std_logic_vector( 13-1 downto 0 );
    in10 : in std_logic_vector( 13-1 downto 0 );
    in11 : in std_logic_vector( 13-1 downto 0 );
    in12 : in std_logic_vector( 13-1 downto 0 );
    in13 : in std_logic_vector( 13-1 downto 0 );
    in14 : in std_logic_vector( 13-1 downto 0 );
    in15 : in std_logic_vector( 13-1 downto 0 );
    in16 : in std_logic_vector( 13-1 downto 0 );
    in17 : in std_logic_vector( 13-1 downto 0 );
    in18 : in std_logic_vector( 13-1 downto 0 );
    in19 : in std_logic_vector( 13-1 downto 0 );
    in20 : in std_logic_vector( 13-1 downto 0 );
    in21 : in std_logic_vector( 13-1 downto 0 );
    in22 : in std_logic_vector( 13-1 downto 0 );
    in23 : in std_logic_vector( 13-1 downto 0 );
    in24 : in std_logic_vector( 13-1 downto 0 );
    in25 : in std_logic_vector( 13-1 downto 0 );
    in26 : in std_logic_vector( 13-1 downto 0 );
    in27 : in std_logic_vector( 13-1 downto 0 );
    in28 : in std_logic_vector( 13-1 downto 0 );
    in29 : in std_logic_vector( 13-1 downto 0 );
    in30 : in std_logic_vector( 13-1 downto 0 );
    in31 : in std_logic_vector( 13-1 downto 0 );
    in32 : in std_logic_vector( 13-1 downto 0 );
    bus_out : out std_logic_vector( 416-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x8;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x8 is 
  signal concatenate_y_net : std_logic_vector( 416-1 downto 0 );
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_6_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_7_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_8_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_9_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_10_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_11_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_12_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_13_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_14_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_15_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_16_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_17_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_18_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_19_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_20_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_21_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_22_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_23_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_24_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_25_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_26_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_27_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_28_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_29_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_30_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_31_q_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 13-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  din0_0_q_net <= in1;
  din0_1_q_net <= in2;
  din0_2_q_net <= in3;
  din0_3_q_net <= in4;
  din0_4_q_net <= in5;
  din0_5_q_net <= in6;
  din0_6_q_net <= in7;
  din0_7_q_net <= in8;
  din0_8_q_net <= in9;
  din0_9_q_net <= in10;
  din0_10_q_net <= in11;
  din0_11_q_net <= in12;
  din0_12_q_net <= in13;
  din0_13_q_net <= in14;
  din0_14_q_net <= in15;
  din0_15_q_net <= in16;
  din0_16_q_net <= in17;
  din0_17_q_net <= in18;
  din0_18_q_net <= in19;
  din0_19_q_net <= in20;
  din0_20_q_net <= in21;
  din0_21_q_net <= in22;
  din0_22_q_net <= in23;
  din0_23_q_net <= in24;
  din0_24_q_net <= in25;
  din0_25_q_net <= in26;
  din0_26_q_net <= in27;
  din0_27_q_net <= in28;
  din0_28_q_net <= in29;
  din0_29_q_net <= in30;
  din0_30_q_net <= in31;
  din0_31_q_net <= in32;
  concatenate : entity xil_defaultlib.sysgen_concat_4e7b466dbb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    in12 => reinterpret13_output_port_net,
    in13 => reinterpret14_output_port_net,
    in14 => reinterpret15_output_port_net,
    in15 => reinterpret16_output_port_net,
    in16 => reinterpret17_output_port_net,
    in17 => reinterpret18_output_port_net,
    in18 => reinterpret19_output_port_net,
    in19 => reinterpret20_output_port_net,
    in20 => reinterpret21_output_port_net,
    in21 => reinterpret22_output_port_net,
    in22 => reinterpret23_output_port_net,
    in23 => reinterpret24_output_port_net,
    in24 => reinterpret25_output_port_net,
    in25 => reinterpret26_output_port_net,
    in26 => reinterpret27_output_port_net,
    in27 => reinterpret28_output_port_net,
    in28 => reinterpret29_output_port_net,
    in29 => reinterpret30_output_port_net,
    in30 => reinterpret31_output_port_net,
    in31 => reinterpret32_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_0_q_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_1_q_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_2_q_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_3_q_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_4_q_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_5_q_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_6_q_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_7_q_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_8_q_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_9_q_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_10_q_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_11_q_net,
    output_port => reinterpret12_output_port_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_12_q_net,
    output_port => reinterpret13_output_port_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_13_q_net,
    output_port => reinterpret14_output_port_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_14_q_net,
    output_port => reinterpret15_output_port_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_15_q_net,
    output_port => reinterpret16_output_port_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_16_q_net,
    output_port => reinterpret17_output_port_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_17_q_net,
    output_port => reinterpret18_output_port_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_18_q_net,
    output_port => reinterpret19_output_port_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_19_q_net,
    output_port => reinterpret20_output_port_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_20_q_net,
    output_port => reinterpret21_output_port_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_21_q_net,
    output_port => reinterpret22_output_port_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_22_q_net,
    output_port => reinterpret23_output_port_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_23_q_net,
    output_port => reinterpret24_output_port_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_24_q_net,
    output_port => reinterpret25_output_port_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_25_q_net,
    output_port => reinterpret26_output_port_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_26_q_net,
    output_port => reinterpret27_output_port_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_27_q_net,
    output_port => reinterpret28_output_port_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_28_q_net,
    output_port => reinterpret29_output_port_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_29_q_net,
    output_port => reinterpret30_output_port_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_30_q_net,
    output_port => reinterpret31_output_port_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_589df029ea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_31_q_net,
    output_port => reinterpret32_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_addrb
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_addrb_x0 is
  port (
    in_x0 : in std_logic_vector( 13-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 416-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_addrb_x0;
architecture structural of pfb_fir_gen_8192ch_core_rep_addrb_x0 is 
  signal concatenate_y_net : std_logic_vector( 416-1 downto 0 );
  signal daddr_q_net : std_logic_vector( 13-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal din0_0_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_6_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_7_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_8_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_9_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_10_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_11_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_12_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_13_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_14_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_15_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_16_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_17_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_18_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_19_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_20_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_21_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_22_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_23_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_24_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_25_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_26_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_27_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_28_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_29_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_30_q_net : std_logic_vector( 13-1 downto 0 );
  signal din0_31_q_net : std_logic_vector( 13-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  daddr_q_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x8 
  port map (
    in1 => din0_0_q_net,
    in2 => din0_1_q_net,
    in3 => din0_2_q_net,
    in4 => din0_3_q_net,
    in5 => din0_4_q_net,
    in6 => din0_5_q_net,
    in7 => din0_6_q_net,
    in8 => din0_7_q_net,
    in9 => din0_8_q_net,
    in10 => din0_9_q_net,
    in11 => din0_10_q_net,
    in12 => din0_11_q_net,
    in13 => din0_12_q_net,
    in14 => din0_13_q_net,
    in15 => din0_14_q_net,
    in16 => din0_15_q_net,
    in17 => din0_16_q_net,
    in18 => din0_17_q_net,
    in19 => din0_18_q_net,
    in20 => din0_19_q_net,
    in21 => din0_20_q_net,
    in22 => din0_21_q_net,
    in23 => din0_22_q_net,
    in24 => din0_23_q_net,
    in25 => din0_24_q_net,
    in26 => din0_25_q_net,
    in27 => din0_26_q_net,
    in28 => din0_27_q_net,
    in29 => din0_28_q_net,
    in30 => din0_29_q_net,
    in31 => din0_30_q_net,
    in32 => din0_31_q_net,
    bus_out => concatenate_y_net
  );
  din0_0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_0_q_net
  );
  din0_1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_1_q_net
  );
  din0_2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_2_q_net
  );
  din0_3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_3_q_net
  );
  din0_4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_4_q_net
  );
  din0_5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_5_q_net
  );
  din0_6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_6_q_net
  );
  din0_7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_7_q_net
  );
  din0_8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_8_q_net
  );
  din0_9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_9_q_net
  );
  din0_10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_10_q_net
  );
  din0_11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_11_q_net
  );
  din0_12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_12_q_net
  );
  din0_13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_13_q_net
  );
  din0_14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_14_q_net
  );
  din0_15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_15_q_net
  );
  din0_16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_16_q_net
  );
  din0_17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_17_q_net
  );
  din0_18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_18_q_net
  );
  din0_19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_19_q_net
  );
  din0_20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_20_q_net
  );
  din0_21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_21_q_net
  );
  din0_22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_22_q_net
  );
  din0_23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_23_q_net
  );
  din0_24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_24_q_net
  );
  din0_25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_25_q_net
  );
  din0_26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_26_q_net
  );
  din0_27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_27_q_net
  );
  din0_28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_28_q_net
  );
  din0_29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_29_q_net
  );
  din0_30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_30_q_net
  );
  din0_31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 13
  )
  port map (
    en => '1',
    rst => '1',
    d => daddr_q_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_31_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_wea/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x9 is
  port (
    in1 : in std_logic_vector( 1-1 downto 0 );
    bus_out : out std_logic_vector( 32-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x9;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x9 is 
  signal concatenate_y_net : std_logic_vector( 32-1 downto 0 );
  signal never_op_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 1-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  never_op_net <= in1;
  concatenate : entity xil_defaultlib.sysgen_concat_f70b01a276 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    in12 => reinterpret13_output_port_net,
    in13 => reinterpret14_output_port_net,
    in14 => reinterpret15_output_port_net,
    in15 => reinterpret16_output_port_net,
    in16 => reinterpret17_output_port_net,
    in17 => reinterpret18_output_port_net,
    in18 => reinterpret19_output_port_net,
    in19 => reinterpret20_output_port_net,
    in20 => reinterpret21_output_port_net,
    in21 => reinterpret22_output_port_net,
    in22 => reinterpret23_output_port_net,
    in23 => reinterpret24_output_port_net,
    in24 => reinterpret25_output_port_net,
    in25 => reinterpret26_output_port_net,
    in26 => reinterpret27_output_port_net,
    in27 => reinterpret28_output_port_net,
    in28 => reinterpret29_output_port_net,
    in29 => reinterpret30_output_port_net,
    in30 => reinterpret31_output_port_net,
    in31 => reinterpret32_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret12_output_port_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret13_output_port_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret14_output_port_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret15_output_port_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret16_output_port_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret17_output_port_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret18_output_port_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret19_output_port_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret20_output_port_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret21_output_port_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret22_output_port_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret23_output_port_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret24_output_port_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret25_output_port_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret26_output_port_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret27_output_port_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret28_output_port_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret29_output_port_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret30_output_port_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret31_output_port_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => never_op_net,
    output_port => reinterpret32_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_wea
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_wea_x0 is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    out_x0 : out std_logic_vector( 32-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_wea_x0;
architecture structural of pfb_fir_gen_8192ch_core_rep_wea_x0 is 
  signal concatenate_y_net : std_logic_vector( 32-1 downto 0 );
  signal never_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  never_op_net <= in_x0;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x9 
  port map (
    in1 => never_op_net,
    bus_out => concatenate_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_web/bussify
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_bussify_x7 is
  port (
    in1 : in std_logic_vector( 1-1 downto 0 );
    in2 : in std_logic_vector( 1-1 downto 0 );
    in3 : in std_logic_vector( 1-1 downto 0 );
    in4 : in std_logic_vector( 1-1 downto 0 );
    in5 : in std_logic_vector( 1-1 downto 0 );
    in6 : in std_logic_vector( 1-1 downto 0 );
    in7 : in std_logic_vector( 1-1 downto 0 );
    in8 : in std_logic_vector( 1-1 downto 0 );
    in9 : in std_logic_vector( 1-1 downto 0 );
    in10 : in std_logic_vector( 1-1 downto 0 );
    in11 : in std_logic_vector( 1-1 downto 0 );
    in12 : in std_logic_vector( 1-1 downto 0 );
    in13 : in std_logic_vector( 1-1 downto 0 );
    in14 : in std_logic_vector( 1-1 downto 0 );
    in15 : in std_logic_vector( 1-1 downto 0 );
    in16 : in std_logic_vector( 1-1 downto 0 );
    in17 : in std_logic_vector( 1-1 downto 0 );
    in18 : in std_logic_vector( 1-1 downto 0 );
    in19 : in std_logic_vector( 1-1 downto 0 );
    in20 : in std_logic_vector( 1-1 downto 0 );
    in21 : in std_logic_vector( 1-1 downto 0 );
    in22 : in std_logic_vector( 1-1 downto 0 );
    in23 : in std_logic_vector( 1-1 downto 0 );
    in24 : in std_logic_vector( 1-1 downto 0 );
    in25 : in std_logic_vector( 1-1 downto 0 );
    in26 : in std_logic_vector( 1-1 downto 0 );
    in27 : in std_logic_vector( 1-1 downto 0 );
    in28 : in std_logic_vector( 1-1 downto 0 );
    in29 : in std_logic_vector( 1-1 downto 0 );
    in30 : in std_logic_vector( 1-1 downto 0 );
    in31 : in std_logic_vector( 1-1 downto 0 );
    in32 : in std_logic_vector( 1-1 downto 0 );
    bus_out : out std_logic_vector( 32-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_bussify_x7;
architecture structural of pfb_fir_gen_8192ch_core_bussify_x7 is 
  signal concatenate_y_net : std_logic_vector( 32-1 downto 0 );
  signal din0_0_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_6_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_7_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_8_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_9_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_10_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_11_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_12_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_13_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_14_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_15_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_16_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_17_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_18_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_19_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_20_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_21_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_22_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_23_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_24_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_25_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_26_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_27_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_28_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_29_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_30_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_31_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 1-1 downto 0 );
begin
  bus_out <= concatenate_y_net;
  din0_0_q_net <= in1;
  din0_1_q_net <= in2;
  din0_2_q_net <= in3;
  din0_3_q_net <= in4;
  din0_4_q_net <= in5;
  din0_5_q_net <= in6;
  din0_6_q_net <= in7;
  din0_7_q_net <= in8;
  din0_8_q_net <= in9;
  din0_9_q_net <= in10;
  din0_10_q_net <= in11;
  din0_11_q_net <= in12;
  din0_12_q_net <= in13;
  din0_13_q_net <= in14;
  din0_14_q_net <= in15;
  din0_15_q_net <= in16;
  din0_16_q_net <= in17;
  din0_17_q_net <= in18;
  din0_18_q_net <= in19;
  din0_19_q_net <= in20;
  din0_20_q_net <= in21;
  din0_21_q_net <= in22;
  din0_22_q_net <= in23;
  din0_23_q_net <= in24;
  din0_24_q_net <= in25;
  din0_25_q_net <= in26;
  din0_26_q_net <= in27;
  din0_27_q_net <= in28;
  din0_28_q_net <= in29;
  din0_29_q_net <= in30;
  din0_30_q_net <= in31;
  din0_31_q_net <= in32;
  concatenate : entity xil_defaultlib.sysgen_concat_f70b01a276 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    in4 => reinterpret5_output_port_net,
    in5 => reinterpret6_output_port_net,
    in6 => reinterpret7_output_port_net,
    in7 => reinterpret8_output_port_net,
    in8 => reinterpret9_output_port_net,
    in9 => reinterpret10_output_port_net,
    in10 => reinterpret11_output_port_net,
    in11 => reinterpret12_output_port_net,
    in12 => reinterpret13_output_port_net,
    in13 => reinterpret14_output_port_net,
    in14 => reinterpret15_output_port_net,
    in15 => reinterpret16_output_port_net,
    in16 => reinterpret17_output_port_net,
    in17 => reinterpret18_output_port_net,
    in18 => reinterpret19_output_port_net,
    in19 => reinterpret20_output_port_net,
    in20 => reinterpret21_output_port_net,
    in21 => reinterpret22_output_port_net,
    in22 => reinterpret23_output_port_net,
    in23 => reinterpret24_output_port_net,
    in24 => reinterpret25_output_port_net,
    in25 => reinterpret26_output_port_net,
    in26 => reinterpret27_output_port_net,
    in27 => reinterpret28_output_port_net,
    in28 => reinterpret29_output_port_net,
    in29 => reinterpret30_output_port_net,
    in30 => reinterpret31_output_port_net,
    in31 => reinterpret32_output_port_net,
    y => concatenate_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_0_q_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_1_q_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_2_q_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_3_q_net,
    output_port => reinterpret4_output_port_net
  );
  reinterpret5 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_4_q_net,
    output_port => reinterpret5_output_port_net
  );
  reinterpret6 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_5_q_net,
    output_port => reinterpret6_output_port_net
  );
  reinterpret7 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_6_q_net,
    output_port => reinterpret7_output_port_net
  );
  reinterpret8 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_7_q_net,
    output_port => reinterpret8_output_port_net
  );
  reinterpret9 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_8_q_net,
    output_port => reinterpret9_output_port_net
  );
  reinterpret10 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_9_q_net,
    output_port => reinterpret10_output_port_net
  );
  reinterpret11 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_10_q_net,
    output_port => reinterpret11_output_port_net
  );
  reinterpret12 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_11_q_net,
    output_port => reinterpret12_output_port_net
  );
  reinterpret13 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_12_q_net,
    output_port => reinterpret13_output_port_net
  );
  reinterpret14 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_13_q_net,
    output_port => reinterpret14_output_port_net
  );
  reinterpret15 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_14_q_net,
    output_port => reinterpret15_output_port_net
  );
  reinterpret16 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_15_q_net,
    output_port => reinterpret16_output_port_net
  );
  reinterpret17 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_16_q_net,
    output_port => reinterpret17_output_port_net
  );
  reinterpret18 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_17_q_net,
    output_port => reinterpret18_output_port_net
  );
  reinterpret19 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_18_q_net,
    output_port => reinterpret19_output_port_net
  );
  reinterpret20 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_19_q_net,
    output_port => reinterpret20_output_port_net
  );
  reinterpret21 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_20_q_net,
    output_port => reinterpret21_output_port_net
  );
  reinterpret22 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_21_q_net,
    output_port => reinterpret22_output_port_net
  );
  reinterpret23 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_22_q_net,
    output_port => reinterpret23_output_port_net
  );
  reinterpret24 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_23_q_net,
    output_port => reinterpret24_output_port_net
  );
  reinterpret25 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_24_q_net,
    output_port => reinterpret25_output_port_net
  );
  reinterpret26 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_25_q_net,
    output_port => reinterpret26_output_port_net
  );
  reinterpret27 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_26_q_net,
    output_port => reinterpret27_output_port_net
  );
  reinterpret28 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_27_q_net,
    output_port => reinterpret28_output_port_net
  );
  reinterpret29 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_28_q_net,
    output_port => reinterpret29_output_port_net
  );
  reinterpret30 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_29_q_net,
    output_port => reinterpret30_output_port_net
  );
  reinterpret31 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_30_q_net,
    output_port => reinterpret31_output_port_net
  );
  reinterpret32 : entity xil_defaultlib.sysgen_reinterpret_de738bcfff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => din0_31_q_net,
    output_port => reinterpret32_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays/rep_web
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_rep_web_x0 is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 32-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_rep_web_x0;
architecture structural of pfb_fir_gen_8192ch_core_rep_web_x0 is 
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal din0_0_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_1_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_2_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_3_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_4_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_5_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_6_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_7_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_8_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_9_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_10_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_11_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_12_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_13_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_14_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_15_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_16_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_17_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_18_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_19_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_20_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_21_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_22_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_23_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_24_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_25_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_26_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_27_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_28_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_29_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_30_q_net : std_logic_vector( 1-1 downto 0 );
  signal din0_31_q_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 32-1 downto 0 );
  signal always_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= concatenate_y_net;
  always_op_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bussify_x7 
  port map (
    in1 => din0_0_q_net,
    in2 => din0_1_q_net,
    in3 => din0_2_q_net,
    in4 => din0_3_q_net,
    in5 => din0_4_q_net,
    in6 => din0_5_q_net,
    in7 => din0_6_q_net,
    in8 => din0_7_q_net,
    in9 => din0_8_q_net,
    in10 => din0_9_q_net,
    in11 => din0_10_q_net,
    in12 => din0_11_q_net,
    in13 => din0_12_q_net,
    in14 => din0_13_q_net,
    in15 => din0_14_q_net,
    in16 => din0_15_q_net,
    in17 => din0_16_q_net,
    in18 => din0_17_q_net,
    in19 => din0_18_q_net,
    in20 => din0_19_q_net,
    in21 => din0_20_q_net,
    in22 => din0_21_q_net,
    in23 => din0_22_q_net,
    in24 => din0_23_q_net,
    in25 => din0_24_q_net,
    in26 => din0_25_q_net,
    in27 => din0_26_q_net,
    in28 => din0_27_q_net,
    in29 => din0_28_q_net,
    in30 => din0_29_q_net,
    in31 => din0_30_q_net,
    in32 => din0_31_q_net,
    bus_out => concatenate_y_net
  );
  din0_0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_0_q_net
  );
  din0_1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_1_q_net
  );
  din0_2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_2_q_net
  );
  din0_3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_3_q_net
  );
  din0_4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_4_q_net
  );
  din0_5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_5_q_net
  );
  din0_6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_6_q_net
  );
  din0_7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_7_q_net
  );
  din0_8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_8_q_net
  );
  din0_9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_9_q_net
  );
  din0_10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_10_q_net
  );
  din0_11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_11_q_net
  );
  din0_12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_12_q_net
  );
  din0_13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_13_q_net
  );
  din0_14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_14_q_net
  );
  din0_15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_15_q_net
  );
  din0_16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_16_q_net
  );
  din0_17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_17_q_net
  );
  din0_18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_18_q_net
  );
  din0_19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_19_q_net
  );
  din0_20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_20_q_net
  );
  din0_21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_21_q_net
  );
  din0_22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_22_q_net
  );
  din0_23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_23_q_net
  );
  din0_24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_24_q_net
  );
  din0_25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_25_q_net
  );
  din0_26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_26_q_net
  );
  din0_27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_27_q_net
  );
  din0_28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_28_q_net
  );
  din0_29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_29_q_net
  );
  din0_30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_30_q_net
  );
  din0_31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => always_op_net,
    clk => clk_net,
    ce => ce_net,
    q => din0_31_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_delays
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_tap_delays is
  port (
    addra : in std_logic_vector( 13-1 downto 0 );
    dina : in std_logic_vector( 288-1 downto 0 );
    wea : in std_logic_vector( 1-1 downto 0 );
    addrb : in std_logic_vector( 13-1 downto 0 );
    web : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    a : out std_logic_vector( 288-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_tap_delays;
architecture structural of pfb_fir_gen_8192ch_core_tap_delays is 
  signal concatenate_y_net_x4 : std_logic_vector( 288-1 downto 0 );
  signal counter_op_net : std_logic_vector( 13-1 downto 0 );
  signal bram_din_y_net : std_logic_vector( 288-1 downto 0 );
  signal never_op_net : std_logic_vector( 1-1 downto 0 );
  signal daddr_q_net : std_logic_vector( 13-1 downto 0 );
  signal always_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal reinterpret15_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal bram0_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram1_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram2_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram3_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram4_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram5_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram6_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram7_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram8_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram9_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram10_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram11_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram12_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram13_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram14_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram15_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram16_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram17_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram18_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram19_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram20_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram21_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram22_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram23_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram24_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram25_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram26_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram27_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram28_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram29_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram30_douta_net : std_logic_vector( 9-1 downto 0 );
  signal bram31_douta_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret32_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret31_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret30_output_port_net_x0 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret29_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret28_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret27_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret26_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret25_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret24_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret23_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret22_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret21_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret20_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret19_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret18_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret17_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret16_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret15_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret14_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret13_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret9_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret8_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret7_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 416-1 downto 0 );
  signal reinterpret15_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret32_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret31_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret30_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret29_output_port_net_x0 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret28_output_port_net_x0 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret27_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret26_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret25_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret24_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret23_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret22_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret21_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret20_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret19_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret18_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret17_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret16_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret14_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret13_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret12_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret11_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret10_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret9_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret8_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret7_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret6_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret5_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret4_output_port_net_x2 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret3_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret2_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal reinterpret1_output_port_net_x1 : std_logic_vector( 13-1 downto 0 );
  signal concatenate_y_net_x0 : std_logic_vector( 416-1 downto 0 );
  signal reinterpret32_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret31_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret30_output_port_net_x1 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret29_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret28_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret27_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret26_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret25_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret24_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret23_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret22_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret21_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret20_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret19_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret18_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret17_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret16_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret15_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret14_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret13_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret12_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret11_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret10_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net_x2 : std_logic_vector( 9-1 downto 0 );
  signal ddina_q_net : std_logic_vector( 288-1 downto 0 );
  signal slice15_y_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret32_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret31_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret30_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret29_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret28_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret27_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret26_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret25_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret24_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret23_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret22_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret21_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret20_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret19_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret18_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret17_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret16_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret14_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret13_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret12_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret11_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret10_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret9_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret8_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret7_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret6_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret5_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 9-1 downto 0 );
  signal reinterpret2_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal reinterpret1_output_port_net_x0 : std_logic_vector( 9-1 downto 0 );
  signal ddinb_q_net : std_logic_vector( 288-1 downto 0 );
  signal slice32_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice31_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice30_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice29_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice28_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice27_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice26_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice25_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice24_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice23_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice22_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice21_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice20_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice19_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice18_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice17_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice16_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice15_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice14_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice13_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice12_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice11_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice10_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net_x1 : std_logic_vector( 32-1 downto 0 );
  signal slice32_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice31_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice30_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice29_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice28_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice27_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice26_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice25_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice24_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice23_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice22_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice21_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice20_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice19_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice18_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice17_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice16_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice14_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice13_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice12_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice11_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice10_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice9_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice8_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice7_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice6_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice5_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net_x2 : std_logic_vector( 32-1 downto 0 );
  signal bram0_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram1_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram2_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram3_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram4_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram5_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram6_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram7_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram8_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram9_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram10_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram11_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram12_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram13_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram14_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram15_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram16_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram17_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram18_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram19_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram20_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram21_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram22_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram23_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram24_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram25_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram26_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram27_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram28_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram29_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram30_doutb_net : std_logic_vector( 9-1 downto 0 );
  signal bram31_doutb_net : std_logic_vector( 9-1 downto 0 );
begin
  a <= concatenate_y_net_x4;
  counter_op_net <= addra;
  bram_din_y_net <= dina;
  never_op_net <= wea;
  daddr_q_net <= addrb;
  always_op_net <= web;
  clk_net <= clk_1;
  ce_net <= ce_1;
  a_bussify : entity xil_defaultlib.pfb_fir_gen_8192ch_core_a_bussify 
  port map (
    in1 => bram0_douta_net,
    in2 => bram1_douta_net,
    in3 => bram2_douta_net,
    in4 => bram3_douta_net,
    in5 => bram4_douta_net,
    in6 => bram5_douta_net,
    in7 => bram6_douta_net,
    in8 => bram7_douta_net,
    in9 => bram8_douta_net,
    in10 => bram9_douta_net,
    in11 => bram10_douta_net,
    in12 => bram11_douta_net,
    in13 => bram12_douta_net,
    in14 => bram13_douta_net,
    in15 => bram14_douta_net,
    in16 => bram15_douta_net,
    in17 => bram16_douta_net,
    in18 => bram17_douta_net,
    in19 => bram18_douta_net,
    in20 => bram19_douta_net,
    in21 => bram20_douta_net,
    in22 => bram21_douta_net,
    in23 => bram22_douta_net,
    in24 => bram23_douta_net,
    in25 => bram24_douta_net,
    in26 => bram25_douta_net,
    in27 => bram26_douta_net,
    in28 => bram27_douta_net,
    in29 => bram28_douta_net,
    in30 => bram29_douta_net,
    in31 => bram30_douta_net,
    in32 => bram31_douta_net,
    bus_out => concatenate_y_net_x4
  );
  debus_addra : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_addra_x0 
  port map (
    bus_in => concatenate_y_net,
    msb_out32 => reinterpret32_output_port_net_x1,
    out31 => reinterpret31_output_port_net_x1,
    out30 => reinterpret30_output_port_net_x0,
    out29 => reinterpret29_output_port_net_x1,
    out28 => reinterpret28_output_port_net_x1,
    out27 => reinterpret27_output_port_net,
    out26 => reinterpret26_output_port_net,
    out25 => reinterpret25_output_port_net,
    out24 => reinterpret24_output_port_net,
    out23 => reinterpret23_output_port_net,
    out22 => reinterpret22_output_port_net,
    out21 => reinterpret21_output_port_net,
    out20 => reinterpret20_output_port_net,
    out19 => reinterpret19_output_port_net,
    out18 => reinterpret18_output_port_net,
    out17 => reinterpret17_output_port_net,
    out16 => reinterpret16_output_port_net,
    out15 => reinterpret15_output_port_net,
    out14 => reinterpret14_output_port_net,
    out13 => reinterpret13_output_port_net,
    out12 => reinterpret12_output_port_net,
    out11 => reinterpret11_output_port_net,
    out10 => reinterpret10_output_port_net,
    out9 => reinterpret9_output_port_net_x1,
    out8 => reinterpret8_output_port_net_x1,
    out7 => reinterpret7_output_port_net_x1,
    out6 => reinterpret6_output_port_net_x1,
    out5 => reinterpret5_output_port_net_x1,
    out4 => reinterpret4_output_port_net_x1,
    out3 => reinterpret3_output_port_net_x0,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
  debus_addrb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_addrb_x0 
  port map (
    bus_in => concatenate_y_net_x0,
    msb_out32 => reinterpret32_output_port_net_x2,
    out31 => reinterpret31_output_port_net_x2,
    out30 => reinterpret30_output_port_net_x2,
    out29 => reinterpret29_output_port_net_x0,
    out28 => reinterpret28_output_port_net_x0,
    out27 => reinterpret27_output_port_net_x1,
    out26 => reinterpret26_output_port_net_x1,
    out25 => reinterpret25_output_port_net_x1,
    out24 => reinterpret24_output_port_net_x1,
    out23 => reinterpret23_output_port_net_x1,
    out22 => reinterpret22_output_port_net_x1,
    out21 => reinterpret21_output_port_net_x1,
    out20 => reinterpret20_output_port_net_x1,
    out19 => reinterpret19_output_port_net_x1,
    out18 => reinterpret18_output_port_net_x1,
    out17 => reinterpret17_output_port_net_x1,
    out16 => reinterpret16_output_port_net_x1,
    out15 => reinterpret15_output_port_net_x1,
    out14 => reinterpret14_output_port_net_x1,
    out13 => reinterpret13_output_port_net_x1,
    out12 => reinterpret12_output_port_net_x1,
    out11 => reinterpret11_output_port_net_x1,
    out10 => reinterpret10_output_port_net_x1,
    out9 => reinterpret9_output_port_net_x2,
    out8 => reinterpret8_output_port_net_x2,
    out7 => reinterpret7_output_port_net_x2,
    out6 => reinterpret6_output_port_net_x2,
    out5 => reinterpret5_output_port_net_x2,
    out4 => reinterpret4_output_port_net_x2,
    out3 => reinterpret3_output_port_net_x1,
    out2 => reinterpret2_output_port_net_x1,
    lsb_out1 => reinterpret1_output_port_net_x1
  );
  debus_dina : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_dina_x0 
  port map (
    bus_in => ddina_q_net,
    msb_out32 => reinterpret32_output_port_net_x0,
    out31 => reinterpret31_output_port_net_x0,
    out30 => reinterpret30_output_port_net_x1,
    out29 => reinterpret29_output_port_net_x2,
    out28 => reinterpret28_output_port_net_x2,
    out27 => reinterpret27_output_port_net_x2,
    out26 => reinterpret26_output_port_net_x2,
    out25 => reinterpret25_output_port_net_x2,
    out24 => reinterpret24_output_port_net_x2,
    out23 => reinterpret23_output_port_net_x2,
    out22 => reinterpret22_output_port_net_x2,
    out21 => reinterpret21_output_port_net_x2,
    out20 => reinterpret20_output_port_net_x2,
    out19 => reinterpret19_output_port_net_x2,
    out18 => reinterpret18_output_port_net_x2,
    out17 => reinterpret17_output_port_net_x2,
    out16 => reinterpret16_output_port_net_x2,
    out15 => reinterpret15_output_port_net_x2,
    out14 => reinterpret14_output_port_net_x2,
    out13 => reinterpret13_output_port_net_x2,
    out12 => reinterpret12_output_port_net_x2,
    out11 => reinterpret11_output_port_net_x2,
    out10 => reinterpret10_output_port_net_x2,
    out9 => reinterpret9_output_port_net,
    out8 => reinterpret8_output_port_net,
    out7 => reinterpret7_output_port_net,
    out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net_x0,
    out3 => reinterpret3_output_port_net_x2,
    out2 => reinterpret2_output_port_net_x2,
    lsb_out1 => reinterpret1_output_port_net_x2
  );
  debus_dinb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_dinb_x0 
  port map (
    bus_in => ddinb_q_net,
    msb_out32 => reinterpret32_output_port_net,
    out31 => reinterpret31_output_port_net,
    out30 => reinterpret30_output_port_net,
    out29 => reinterpret29_output_port_net,
    out28 => reinterpret28_output_port_net,
    out27 => reinterpret27_output_port_net_x0,
    out26 => reinterpret26_output_port_net_x0,
    out25 => reinterpret25_output_port_net_x0,
    out24 => reinterpret24_output_port_net_x0,
    out23 => reinterpret23_output_port_net_x0,
    out22 => reinterpret22_output_port_net_x0,
    out21 => reinterpret21_output_port_net_x0,
    out20 => reinterpret20_output_port_net_x0,
    out19 => reinterpret19_output_port_net_x0,
    out18 => reinterpret18_output_port_net_x0,
    out17 => reinterpret17_output_port_net_x0,
    out16 => reinterpret16_output_port_net_x0,
    out15 => reinterpret15_output_port_net_x0,
    out14 => reinterpret14_output_port_net_x0,
    out13 => reinterpret13_output_port_net_x0,
    out12 => reinterpret12_output_port_net_x0,
    out11 => reinterpret11_output_port_net_x0,
    out10 => reinterpret10_output_port_net_x0,
    out9 => reinterpret9_output_port_net_x0,
    out8 => reinterpret8_output_port_net_x0,
    out7 => reinterpret7_output_port_net_x0,
    out6 => reinterpret6_output_port_net_x0,
    out5 => reinterpret5_output_port_net_x0,
    out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net_x0,
    lsb_out1 => reinterpret1_output_port_net_x0
  );
  debus_wea : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_wea 
  port map (
    bus_in => concatenate_y_net_x1,
    msb_out32 => slice32_y_net_x0,
    out31 => slice31_y_net_x0,
    out30 => slice30_y_net_x0,
    out29 => slice29_y_net_x0,
    out28 => slice28_y_net_x0,
    out27 => slice27_y_net_x0,
    out26 => slice26_y_net_x0,
    out25 => slice25_y_net_x0,
    out24 => slice24_y_net_x0,
    out23 => slice23_y_net_x0,
    out22 => slice22_y_net_x0,
    out21 => slice21_y_net_x0,
    out20 => slice20_y_net_x0,
    out19 => slice19_y_net_x0,
    out18 => slice18_y_net_x0,
    out17 => slice17_y_net_x0,
    out16 => slice16_y_net_x0,
    out15 => slice15_y_net_x0,
    out14 => slice14_y_net_x0,
    out13 => slice13_y_net_x0,
    out12 => slice12_y_net_x0,
    out11 => slice11_y_net_x0,
    out10 => slice10_y_net_x0,
    out9 => slice9_y_net_x0,
    out8 => slice8_y_net_x0,
    out7 => slice7_y_net_x0,
    out6 => slice6_y_net_x0,
    out5 => slice5_y_net_x0,
    out4 => slice4_y_net_x0,
    out3 => slice3_y_net_x0,
    out2 => slice2_y_net_x0,
    lsb_out1 => slice1_y_net_x0
  );
  debus_web : entity xil_defaultlib.pfb_fir_gen_8192ch_core_debus_web 
  port map (
    bus_in => concatenate_y_net_x2,
    msb_out32 => slice32_y_net,
    out31 => slice31_y_net,
    out30 => slice30_y_net,
    out29 => slice29_y_net,
    out28 => slice28_y_net,
    out27 => slice27_y_net,
    out26 => slice26_y_net,
    out25 => slice25_y_net,
    out24 => slice24_y_net,
    out23 => slice23_y_net,
    out22 => slice22_y_net,
    out21 => slice21_y_net,
    out20 => slice20_y_net,
    out19 => slice19_y_net,
    out18 => slice18_y_net,
    out17 => slice17_y_net,
    out16 => slice16_y_net,
    out15 => slice15_y_net,
    out14 => slice14_y_net,
    out13 => slice13_y_net,
    out12 => slice12_y_net,
    out11 => slice11_y_net,
    out10 => slice10_y_net,
    out9 => slice9_y_net,
    out8 => slice8_y_net,
    out7 => slice7_y_net,
    out6 => slice6_y_net,
    out5 => slice5_y_net,
    out4 => slice4_y_net,
    out3 => slice3_y_net,
    out2 => slice2_y_net,
    lsb_out1 => slice1_y_net
  );
  rep_addra : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_addra_x0 
  port map (
    in_x0 => counter_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => concatenate_y_net
  );
  rep_addrb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_addrb_x0 
  port map (
    in_x0 => daddr_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => concatenate_y_net_x0
  );
  rep_wea : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_wea_x0 
  port map (
    in_x0 => never_op_net,
    out_x0 => concatenate_y_net_x1
  );
  rep_web : entity xil_defaultlib.pfb_fir_gen_8192ch_core_rep_web_x0 
  port map (
    in_x0 => always_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => concatenate_y_net_x2
  );
  ddina : entity xil_defaultlib.sysgen_delay_d5c823701b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => bram_din_y_net,
    q => ddina_q_net
  );
  ddinb : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 288
  )
  port map (
    en => '1',
    rst => '1',
    d => bram_din_y_net,
    clk => clk_net,
    ce => ce_net,
    q => ddinb_q_net
  );
  bram0 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret32_output_port_net_x1,
    dina => reinterpret32_output_port_net_x0,
    wea => slice32_y_net_x0,
    addrb => reinterpret32_output_port_net_x2,
    dinb => reinterpret32_output_port_net,
    web => slice32_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram0_douta_net,
    doutb => bram0_doutb_net
  );
  bram1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret31_output_port_net_x1,
    dina => reinterpret31_output_port_net_x0,
    wea => slice31_y_net_x0,
    addrb => reinterpret31_output_port_net_x2,
    dinb => reinterpret31_output_port_net,
    web => slice31_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram1_douta_net,
    doutb => bram1_doutb_net
  );
  bram2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret30_output_port_net_x0,
    dina => reinterpret30_output_port_net_x1,
    wea => slice30_y_net_x0,
    addrb => reinterpret30_output_port_net_x2,
    dinb => reinterpret30_output_port_net,
    web => slice30_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram2_douta_net,
    doutb => bram2_doutb_net
  );
  bram3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret29_output_port_net_x1,
    dina => reinterpret29_output_port_net_x2,
    wea => slice29_y_net_x0,
    addrb => reinterpret29_output_port_net_x0,
    dinb => reinterpret29_output_port_net,
    web => slice29_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram3_douta_net,
    doutb => bram3_doutb_net
  );
  bram4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret28_output_port_net_x1,
    dina => reinterpret28_output_port_net_x2,
    wea => slice28_y_net_x0,
    addrb => reinterpret28_output_port_net_x0,
    dinb => reinterpret28_output_port_net,
    web => slice28_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram4_douta_net,
    doutb => bram4_doutb_net
  );
  bram5 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret27_output_port_net,
    dina => reinterpret27_output_port_net_x2,
    wea => slice27_y_net_x0,
    addrb => reinterpret27_output_port_net_x1,
    dinb => reinterpret27_output_port_net_x0,
    web => slice27_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram5_douta_net,
    doutb => bram5_doutb_net
  );
  bram6 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret26_output_port_net,
    dina => reinterpret26_output_port_net_x2,
    wea => slice26_y_net_x0,
    addrb => reinterpret26_output_port_net_x1,
    dinb => reinterpret26_output_port_net_x0,
    web => slice26_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram6_douta_net,
    doutb => bram6_doutb_net
  );
  bram7 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret25_output_port_net,
    dina => reinterpret25_output_port_net_x2,
    wea => slice25_y_net_x0,
    addrb => reinterpret25_output_port_net_x1,
    dinb => reinterpret25_output_port_net_x0,
    web => slice25_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram7_douta_net,
    doutb => bram7_doutb_net
  );
  bram8 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret24_output_port_net,
    dina => reinterpret24_output_port_net_x2,
    wea => slice24_y_net_x0,
    addrb => reinterpret24_output_port_net_x1,
    dinb => reinterpret24_output_port_net_x0,
    web => slice24_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram8_douta_net,
    doutb => bram8_doutb_net
  );
  bram9 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret23_output_port_net,
    dina => reinterpret23_output_port_net_x2,
    wea => slice23_y_net_x0,
    addrb => reinterpret23_output_port_net_x1,
    dinb => reinterpret23_output_port_net_x0,
    web => slice23_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram9_douta_net,
    doutb => bram9_doutb_net
  );
  bram10 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret22_output_port_net,
    dina => reinterpret22_output_port_net_x2,
    wea => slice22_y_net_x0,
    addrb => reinterpret22_output_port_net_x1,
    dinb => reinterpret22_output_port_net_x0,
    web => slice22_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram10_douta_net,
    doutb => bram10_doutb_net
  );
  bram11 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret21_output_port_net,
    dina => reinterpret21_output_port_net_x2,
    wea => slice21_y_net_x0,
    addrb => reinterpret21_output_port_net_x1,
    dinb => reinterpret21_output_port_net_x0,
    web => slice21_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram11_douta_net,
    doutb => bram11_doutb_net
  );
  bram12 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret20_output_port_net,
    dina => reinterpret20_output_port_net_x2,
    wea => slice20_y_net_x0,
    addrb => reinterpret20_output_port_net_x1,
    dinb => reinterpret20_output_port_net_x0,
    web => slice20_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram12_douta_net,
    doutb => bram12_doutb_net
  );
  bram13 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret19_output_port_net,
    dina => reinterpret19_output_port_net_x2,
    wea => slice19_y_net_x0,
    addrb => reinterpret19_output_port_net_x1,
    dinb => reinterpret19_output_port_net_x0,
    web => slice19_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram13_douta_net,
    doutb => bram13_doutb_net
  );
  bram14 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret18_output_port_net,
    dina => reinterpret18_output_port_net_x2,
    wea => slice18_y_net_x0,
    addrb => reinterpret18_output_port_net_x1,
    dinb => reinterpret18_output_port_net_x0,
    web => slice18_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram14_douta_net,
    doutb => bram14_doutb_net
  );
  bram15 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret17_output_port_net,
    dina => reinterpret17_output_port_net_x2,
    wea => slice17_y_net_x0,
    addrb => reinterpret17_output_port_net_x1,
    dinb => reinterpret17_output_port_net_x0,
    web => slice17_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram15_douta_net,
    doutb => bram15_doutb_net
  );
  bram16 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret16_output_port_net,
    dina => reinterpret16_output_port_net_x2,
    wea => slice16_y_net_x0,
    addrb => reinterpret16_output_port_net_x1,
    dinb => reinterpret16_output_port_net_x0,
    web => slice16_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram16_douta_net,
    doutb => bram16_doutb_net
  );
  bram17 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret15_output_port_net,
    dina => reinterpret15_output_port_net_x2,
    wea => slice15_y_net_x0,
    addrb => reinterpret15_output_port_net_x1,
    dinb => reinterpret15_output_port_net_x0,
    web => slice15_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram17_douta_net,
    doutb => bram17_doutb_net
  );
  bram18 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret14_output_port_net,
    dina => reinterpret14_output_port_net_x2,
    wea => slice14_y_net_x0,
    addrb => reinterpret14_output_port_net_x1,
    dinb => reinterpret14_output_port_net_x0,
    web => slice14_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram18_douta_net,
    doutb => bram18_doutb_net
  );
  bram19 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret13_output_port_net,
    dina => reinterpret13_output_port_net_x2,
    wea => slice13_y_net_x0,
    addrb => reinterpret13_output_port_net_x1,
    dinb => reinterpret13_output_port_net_x0,
    web => slice13_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram19_douta_net,
    doutb => bram19_doutb_net
  );
  bram20 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret12_output_port_net,
    dina => reinterpret12_output_port_net_x2,
    wea => slice12_y_net_x0,
    addrb => reinterpret12_output_port_net_x1,
    dinb => reinterpret12_output_port_net_x0,
    web => slice12_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram20_douta_net,
    doutb => bram20_doutb_net
  );
  bram21 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret11_output_port_net,
    dina => reinterpret11_output_port_net_x2,
    wea => slice11_y_net_x0,
    addrb => reinterpret11_output_port_net_x1,
    dinb => reinterpret11_output_port_net_x0,
    web => slice11_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram21_douta_net,
    doutb => bram21_doutb_net
  );
  bram22 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret10_output_port_net,
    dina => reinterpret10_output_port_net_x2,
    wea => slice10_y_net_x0,
    addrb => reinterpret10_output_port_net_x1,
    dinb => reinterpret10_output_port_net_x0,
    web => slice10_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram22_douta_net,
    doutb => bram22_doutb_net
  );
  bram23 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret9_output_port_net_x1,
    dina => reinterpret9_output_port_net,
    wea => slice9_y_net_x0,
    addrb => reinterpret9_output_port_net_x2,
    dinb => reinterpret9_output_port_net_x0,
    web => slice9_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram23_douta_net,
    doutb => bram23_doutb_net
  );
  bram24 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret8_output_port_net_x1,
    dina => reinterpret8_output_port_net,
    wea => slice8_y_net_x0,
    addrb => reinterpret8_output_port_net_x2,
    dinb => reinterpret8_output_port_net_x0,
    web => slice8_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram24_douta_net,
    doutb => bram24_doutb_net
  );
  bram25 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret7_output_port_net_x1,
    dina => reinterpret7_output_port_net,
    wea => slice7_y_net_x0,
    addrb => reinterpret7_output_port_net_x2,
    dinb => reinterpret7_output_port_net_x0,
    web => slice7_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram25_douta_net,
    doutb => bram25_doutb_net
  );
  bram26 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret6_output_port_net_x1,
    dina => reinterpret6_output_port_net,
    wea => slice6_y_net_x0,
    addrb => reinterpret6_output_port_net_x2,
    dinb => reinterpret6_output_port_net_x0,
    web => slice6_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram26_douta_net,
    doutb => bram26_doutb_net
  );
  bram27 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret5_output_port_net_x1,
    dina => reinterpret5_output_port_net,
    wea => slice5_y_net_x0,
    addrb => reinterpret5_output_port_net_x2,
    dinb => reinterpret5_output_port_net_x0,
    web => slice5_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram27_douta_net,
    doutb => bram27_doutb_net
  );
  bram28 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret4_output_port_net_x1,
    dina => reinterpret4_output_port_net_x0,
    wea => slice4_y_net_x0,
    addrb => reinterpret4_output_port_net_x2,
    dinb => reinterpret4_output_port_net,
    web => slice4_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram28_douta_net,
    doutb => bram28_doutb_net
  );
  bram29 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret3_output_port_net_x0,
    dina => reinterpret3_output_port_net_x2,
    wea => slice3_y_net_x0,
    addrb => reinterpret3_output_port_net_x1,
    dinb => reinterpret3_output_port_net,
    web => slice3_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram29_douta_net,
    doutb => bram29_doutb_net
  );
  bram30 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret2_output_port_net,
    dina => reinterpret2_output_port_net_x2,
    wea => slice2_y_net_x0,
    addrb => reinterpret2_output_port_net_x1,
    dinb => reinterpret2_output_port_net_x0,
    web => slice2_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram30_douta_net,
    doutb => bram30_doutb_net
  );
  bram31 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xldpram 
  generic map (
    c_address_width_a => 13,
    c_address_width_b => 13,
    c_width_a => 9,
    c_width_b => 9,
    core_name0 => "pfb_fir_gen_8192ch_core_blk_mem_gen_v8_3_i6",
    latency => 3
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret1_output_port_net,
    dina => reinterpret1_output_port_net_x2,
    wea => slice1_y_net_x0,
    addrb => reinterpret1_output_port_net_x1,
    dinb => reinterpret1_output_port_net_x0,
    web => slice1_y_net,
    a_clk => clk_net,
    a_ce => ce_net,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => bram31_douta_net,
    doutb => bram31_doutb_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps/tap_split
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_tap_split is
  port (
    bus_in : in std_logic_vector( 960-1 downto 0 );
    msb_out4 : out std_logic_vector( 240-1 downto 0 );
    out3 : out std_logic_vector( 240-1 downto 0 );
    out2 : out std_logic_vector( 240-1 downto 0 );
    lsb_out1 : out std_logic_vector( 240-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_tap_split;
architecture structural of pfb_fir_gen_8192ch_core_tap_split is 
  signal reinterpret4_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 960-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 240-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 240-1 downto 0 );
  signal slice4_y_net : std_logic_vector( 240-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 240-1 downto 0 );
begin
  msb_out4 <= reinterpret4_output_port_net;
  out3 <= reinterpret3_output_port_net;
  out2 <= reinterpret2_output_port_net;
  lsb_out1 <= reinterpret1_output_port_net;
  concatenate_y_net <= bus_in;
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_48461e7c26 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_48461e7c26 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 239,
    x_width => 960,
    y_width => 240
  )
  port map (
    x => concatenate_y_net,
    y => slice1_y_net
  );
  slice2 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 240,
    new_msb => 479,
    x_width => 960,
    y_width => 240
  )
  port map (
    x => concatenate_y_net,
    y => slice2_y_net
  );
  slice4 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 720,
    new_msb => 959,
    x_width => 960,
    y_width => 240
  )
  port map (
    x => concatenate_y_net,
    y => slice4_y_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_48461e7c26 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice4_y_net,
    output_port => reinterpret4_output_port_net
  );
  slice3 : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 480,
    new_msb => 719,
    x_width => 960,
    y_width => 240
  )
  port map (
    x => concatenate_y_net,
    y => slice3_y_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_48461e7c26 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic/pfb_fir_taps
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_pfb_fir_taps is
  port (
    sync : in std_logic_vector( 1-1 downto 0 );
    din : in std_logic_vector( 96-1 downto 0 );
    coeffs : in std_logic_vector( 576-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    sync_out : out std_logic_vector( 1-1 downto 0 );
    dout : out std_logic_vector( 264-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_pfb_fir_taps;
architecture structural of pfb_fir_gen_8192ch_core_pfb_fir_taps is 
  signal dsync2_q_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net_x1 : std_logic_vector( 264-1 downto 0 );
  signal sync_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal din_delay_q_net : std_logic_vector( 96-1 downto 0 );
  signal reinterpret_out_output_port_net : std_logic_vector( 576-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal reinterpret4_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 240-1 downto 0 );
  signal concatenate_y_net_x2 : std_logic_vector( 960-1 downto 0 );
  signal mult_din_y_net : std_logic_vector( 384-1 downto 0 );
  signal dcoeffs_q_net : std_logic_vector( 576-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal concatenate_y_net_x0 : std_logic_vector( 288-1 downto 0 );
  signal counter_op_net : std_logic_vector( 13-1 downto 0 );
  signal bram_din_y_net : std_logic_vector( 288-1 downto 0 );
  signal never_op_net : std_logic_vector( 1-1 downto 0 );
  signal daddr_q_net : std_logic_vector( 13-1 downto 0 );
  signal always_op_net : std_logic_vector( 1-1 downto 0 );
  signal dsync0_q_net : std_logic_vector( 1-1 downto 0 );
  signal dsync1_q_net : std_logic_vector( 1-1 downto 0 );
  signal ddin_q_net : std_logic_vector( 96-1 downto 0 );
  signal youngest_y_net : std_logic_vector( 192-1 downto 0 );
begin
  sync_out <= dsync2_q_net;
  dout <= concatenate_y_net_x1;
  sync_delay_q_net <= sync;
  din_delay_q_net <= din;
  reinterpret_out_output_port_net <= coeffs;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bus_adder_tree : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bus_adder_tree 
  port map (
    d0 => reinterpret4_output_port_net,
    d1 => reinterpret3_output_port_net,
    d2 => reinterpret2_output_port_net,
    d3 => reinterpret1_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => concatenate_y_net_x1
  );
  bus_mult : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bus_mult 
  port map (
    a => mult_din_y_net,
    b => dcoeffs_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    a_b => concatenate_y_net_x2
  );
  sync_delay : entity xil_defaultlib.pfb_fir_gen_8192ch_core_sync_delay 
  port map (
    in_x0 => sync_delay_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => mux_y_net
  );
  tap_delays : entity xil_defaultlib.pfb_fir_gen_8192ch_core_tap_delays 
  port map (
    addra => counter_op_net,
    dina => bram_din_y_net,
    wea => never_op_net,
    addrb => daddr_q_net,
    web => always_op_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    a => concatenate_y_net_x0
  );
  tap_split : entity xil_defaultlib.pfb_fir_gen_8192ch_core_tap_split 
  port map (
    bus_in => concatenate_y_net_x2,
    msb_out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
  dsync0 : entity xil_defaultlib.sysgen_delay_35a14d04ed 
  port map (
    clr => '0',
    d => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    q => dsync0_q_net
  );
  dsync1 : entity xil_defaultlib.sysgen_delay_489e406ed3 
  port map (
    clr => '0',
    d => dsync0_q_net,
    clk => clk_net,
    ce => ce_net,
    q => dsync1_q_net
  );
  dsync2 : entity xil_defaultlib.sysgen_delay_396fc86b3c 
  port map (
    clr => '0',
    d => dsync1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => dsync2_q_net
  );
  ddin : entity xil_defaultlib.sysgen_delay_a8c9ebe95d 
  port map (
    clr => '0',
    d => din_delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => ddin_q_net
  );
  dcoeffs : entity xil_defaultlib.sysgen_delay_4c1b734799 
  port map (
    clr => '0',
    d => reinterpret_out_output_port_net,
    clk => clk_net,
    ce => ce_net,
    q => dcoeffs_q_net
  );
  youngest : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 96,
    new_msb => 287,
    x_width => 288,
    y_width => 192
  )
  port map (
    x => concatenate_y_net_x0,
    y => youngest_y_net
  );
  bram_din : entity xil_defaultlib.sysgen_concat_ec851040a3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => ddin_q_net,
    in1 => youngest_y_net,
    y => bram_din_y_net
  );
  mult_din : entity xil_defaultlib.sysgen_concat_de34bdc417 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => ddin_q_net,
    in1 => concatenate_y_net_x0,
    y => mult_din_y_net
  );
  counter : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_gen_8192ch_core_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 13
  )
  port map (
    en => "1",
    clr => '0',
    rst => sync_delay_q_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  daddr : entity xil_defaultlib.sysgen_delay_489a0c55ec 
  port map (
    clr => '0',
    d => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => daddr_q_net
  );
  never : entity xil_defaultlib.sysgen_constant_d3e8a31320 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => never_op_net
  );
  always : entity xil_defaultlib.sysgen_constant_28ba7ecacc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => always_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core/pfb_fir_generic
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_pfb_fir_generic is
  port (
    sync : in std_logic_vector( 1-1 downto 0 );
    pol0_in0 : in std_logic_vector( 8-1 downto 0 );
    pol0_in1 : in std_logic_vector( 8-1 downto 0 );
    pol1_in0 : in std_logic_vector( 8-1 downto 0 );
    pol1_in1 : in std_logic_vector( 8-1 downto 0 );
    pol2_in0 : in std_logic_vector( 8-1 downto 0 );
    pol2_in1 : in std_logic_vector( 8-1 downto 0 );
    pol3_in0 : in std_logic_vector( 8-1 downto 0 );
    pol3_in1 : in std_logic_vector( 8-1 downto 0 );
    pol4_in0 : in std_logic_vector( 8-1 downto 0 );
    pol4_in1 : in std_logic_vector( 8-1 downto 0 );
    pol5_in0 : in std_logic_vector( 8-1 downto 0 );
    pol5_in1 : in std_logic_vector( 8-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    sync_out : out std_logic_vector( 1-1 downto 0 );
    pol0_out0 : out std_logic_vector( 12-1 downto 0 );
    pol0_out1 : out std_logic_vector( 12-1 downto 0 );
    pol1_out0 : out std_logic_vector( 12-1 downto 0 );
    pol1_out1 : out std_logic_vector( 12-1 downto 0 );
    pol2_out0 : out std_logic_vector( 12-1 downto 0 );
    pol2_out1 : out std_logic_vector( 12-1 downto 0 );
    pol3_out0 : out std_logic_vector( 12-1 downto 0 );
    pol3_out1 : out std_logic_vector( 12-1 downto 0 );
    pol4_out0 : out std_logic_vector( 12-1 downto 0 );
    pol4_out1 : out std_logic_vector( 12-1 downto 0 );
    pol5_out0 : out std_logic_vector( 12-1 downto 0 );
    pol5_out1 : out std_logic_vector( 12-1 downto 0 )
  );
end pfb_fir_gen_8192ch_core_pfb_fir_generic;
architecture structural of pfb_fir_gen_8192ch_core_pfb_fir_generic is 
  signal sync_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal pol0_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol0_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol4_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol4_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol5_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol5_in1_net : std_logic_vector( 8-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concatenate_y_net_x0 : std_logic_vector( 144-1 downto 0 );
  signal concatenate_y_net_x2 : std_logic_vector( 264-1 downto 0 );
  signal concatenate_y_net : std_logic_vector( 96-1 downto 0 );
  signal concatenate_y_net_x1 : std_logic_vector( 264-1 downto 0 );
  signal reinterpret_out_output_port_net : std_logic_vector( 576-1 downto 0 );
  signal concat_y_net : std_logic_vector( 96-1 downto 0 );
  signal sync_delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal din_delay_q_net : std_logic_vector( 96-1 downto 0 );
  signal dsync2_q_net : std_logic_vector( 1-1 downto 0 );
begin
  sync_out <= sync_delay_q_net;
  pol0_out0 <= reinterpret12_output_port_net;
  pol0_out1 <= reinterpret6_output_port_net;
  pol1_out0 <= reinterpret11_output_port_net;
  pol1_out1 <= reinterpret5_output_port_net;
  pol2_out0 <= reinterpret10_output_port_net;
  pol2_out1 <= reinterpret4_output_port_net;
  pol3_out0 <= reinterpret9_output_port_net;
  pol3_out1 <= reinterpret3_output_port_net;
  pol4_out0 <= reinterpret8_output_port_net;
  pol4_out1 <= reinterpret2_output_port_net;
  pol5_out0 <= reinterpret7_output_port_net;
  pol5_out1 <= reinterpret1_output_port_net;
  slice_y_net <= sync;
  pol0_in0_net <= pol0_in0;
  pol0_in1_net <= pol0_in1;
  pol1_in0_net <= pol1_in0;
  pol1_in1_net <= pol1_in1;
  pol2_in0_net <= pol2_in0;
  pol2_in1_net <= pol2_in1;
  pol3_in0_net <= pol3_in0;
  pol3_in1_net <= pol3_in1;
  pol4_in0_net <= pol4_in0;
  pol4_in1_net <= pol4_in1;
  pol5_in0_net <= pol5_in0;
  pol5_in1_net <= pol5_in1;
  clk_net <= clk_1;
  ce_net <= ce_1;
  bus_convert : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bus_convert 
  port map (
    din => concatenate_y_net_x2,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concatenate_y_net_x0
  );
  bus_create : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bus_create 
  port map (
    in1 => pol0_in0_net,
    in2 => pol1_in0_net,
    in3 => pol2_in0_net,
    in4 => pol3_in0_net,
    in5 => pol4_in0_net,
    in6 => pol5_in0_net,
    in7 => pol0_in1_net,
    in8 => pol1_in1_net,
    in9 => pol2_in1_net,
    in10 => pol3_in1_net,
    in11 => pol4_in1_net,
    in12 => pol5_in1_net,
    bus_out => concatenate_y_net
  );
  bus_expand : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bus_expand 
  port map (
    bus_in => concatenate_y_net_x0,
    msb_out12 => reinterpret12_output_port_net,
    out11 => reinterpret11_output_port_net,
    out10 => reinterpret10_output_port_net,
    out9 => reinterpret9_output_port_net,
    out8 => reinterpret8_output_port_net,
    out7 => reinterpret7_output_port_net,
    out6 => reinterpret6_output_port_net,
    out5 => reinterpret5_output_port_net,
    out4 => reinterpret4_output_port_net,
    out3 => reinterpret3_output_port_net,
    out2 => reinterpret2_output_port_net,
    lsb_out1 => reinterpret1_output_port_net
  );
  bus_scale : entity xil_defaultlib.pfb_fir_gen_8192ch_core_bus_scale 
  port map (
    din => concatenate_y_net_x1,
    dout => concatenate_y_net_x2
  );
  coeff_munge : entity xil_defaultlib.pfb_fir_gen_8192ch_core_coeff_munge 
  port map (
    din => concat_y_net,
    dout => reinterpret_out_output_port_net
  );
  pfb_fir_coeff_gen : entity xil_defaultlib.pfb_fir_gen_8192ch_core_pfb_fir_coeff_gen 
  port map (
    sync => slice_y_net,
    din => concatenate_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    sync_out => sync_delay_q_net_x0,
    dout => din_delay_q_net,
    coeffs => concat_y_net
  );
  pfb_fir_taps : entity xil_defaultlib.pfb_fir_gen_8192ch_core_pfb_fir_taps 
  port map (
    sync => sync_delay_q_net_x0,
    din => din_delay_q_net,
    coeffs => reinterpret_out_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    sync_out => dsync2_q_net,
    dout => concatenate_y_net_x1
  );
  sync_delay : entity xil_defaultlib.sysgen_delay_67511bd5b4 
  port map (
    clr => '0',
    d => dsync2_q_net,
    clk => clk_net,
    ce => ce_net,
    q => sync_delay_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_gen_8192ch_core_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_struct is
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
    clk_1 : in std_logic;
    ce_1 : in std_logic;
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
end pfb_fir_gen_8192ch_core_struct;
architecture structural of pfb_fir_gen_8192ch_core_struct is 
  signal pol0_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol0_in1_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret12_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret6_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal pol1_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in1_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret11_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret5_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal pol2_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in1_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret10_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal pol3_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in1_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret9_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal sync_net : std_logic_vector( 32-1 downto 0 );
  signal sync_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal pol4_in0_net : std_logic_vector( 8-1 downto 0 );
  signal reinterpret8_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret7_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 12-1 downto 0 );
  signal pol5_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol4_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol5_in1_net : std_logic_vector( 8-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
begin
  pol0_in0_net <= pol0_in0;
  pol0_in1_net <= pol0_in1;
  pol0_out0 <= reinterpret12_output_port_net;
  pol0_out1 <= reinterpret6_output_port_net;
  pol1_in0_net <= pol1_in0;
  pol1_in1_net <= pol1_in1;
  pol1_out0 <= reinterpret11_output_port_net;
  pol1_out1 <= reinterpret5_output_port_net;
  pol2_in0_net <= pol2_in0;
  pol2_in1_net <= pol2_in1;
  pol2_out0 <= reinterpret10_output_port_net;
  pol2_out1 <= reinterpret4_output_port_net;
  pol3_in0_net <= pol3_in0;
  pol3_in1_net <= pol3_in1;
  pol3_out0 <= reinterpret9_output_port_net;
  pol3_out1 <= reinterpret3_output_port_net;
  sync_net <= sync;
  sync_out <= sync_delay_q_net;
  pol4_in0_net <= pol4_in0;
  pol4_out0 <= reinterpret8_output_port_net;
  pol5_out0 <= reinterpret7_output_port_net;
  pol4_out1 <= reinterpret2_output_port_net;
  pol5_out1 <= reinterpret1_output_port_net;
  pol5_in0_net <= pol5_in0;
  pol4_in1_net <= pol4_in1;
  pol5_in1_net <= pol5_in1;
  clk_net <= clk_1;
  ce_net <= ce_1;
  pfb_fir_generic : entity xil_defaultlib.pfb_fir_gen_8192ch_core_pfb_fir_generic 
  port map (
    sync => slice_y_net,
    pol0_in0 => pol0_in0_net,
    pol0_in1 => pol0_in1_net,
    pol1_in0 => pol1_in0_net,
    pol1_in1 => pol1_in1_net,
    pol2_in0 => pol2_in0_net,
    pol2_in1 => pol2_in1_net,
    pol3_in0 => pol3_in0_net,
    pol3_in1 => pol3_in1_net,
    pol4_in0 => pol4_in0_net,
    pol4_in1 => pol4_in1_net,
    pol5_in0 => pol5_in0_net,
    pol5_in1 => pol5_in1_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    sync_out => sync_delay_q_net,
    pol0_out0 => reinterpret12_output_port_net,
    pol0_out1 => reinterpret6_output_port_net,
    pol1_out0 => reinterpret11_output_port_net,
    pol1_out1 => reinterpret5_output_port_net,
    pol2_out0 => reinterpret10_output_port_net,
    pol2_out1 => reinterpret4_output_port_net,
    pol3_out0 => reinterpret9_output_port_net,
    pol3_out1 => reinterpret3_output_port_net,
    pol4_out0 => reinterpret8_output_port_net,
    pol4_out1 => reinterpret2_output_port_net,
    pol5_out0 => reinterpret7_output_port_net,
    pol5_out1 => reinterpret1_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_gen_8192ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => sync_net,
    y => slice_y_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core_default_clock_driver is
  port (
    pfb_fir_gen_8192ch_core_sysclk : in std_logic;
    pfb_fir_gen_8192ch_core_sysce : in std_logic;
    pfb_fir_gen_8192ch_core_sysclr : in std_logic;
    pfb_fir_gen_8192ch_core_clk1 : out std_logic;
    pfb_fir_gen_8192ch_core_ce1 : out std_logic
  );
end pfb_fir_gen_8192ch_core_default_clock_driver;
architecture structural of pfb_fir_gen_8192ch_core_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => pfb_fir_gen_8192ch_core_sysclk,
    sysce => pfb_fir_gen_8192ch_core_sysce,
    sysclr => pfb_fir_gen_8192ch_core_sysclr,
    clk => pfb_fir_gen_8192ch_core_clk1,
    ce => pfb_fir_gen_8192ch_core_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_gen_8192ch_core is
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
end pfb_fir_gen_8192ch_core;
architecture structural of pfb_fir_gen_8192ch_core is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "pfb_fir_gen_8192ch_core,sysgen_core_2016_4,{,compilation=IP Catalog,block_icon_display=Default,family=kintex7,part=xc7k160t,speed=-2,package=ffg676,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=5,system_simulink_period=1,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=10,addsub=48,concat=34,constant=36,counter=3,delay=142,dpram=38,inv=1,logical=13,mult=48,mux=3,reinterpret=776,relational=3,scale=12,slice=446,}";
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
begin
  pfb_fir_gen_8192ch_core_default_clock_driver : entity xil_defaultlib.pfb_fir_gen_8192ch_core_default_clock_driver 
  port map (
    pfb_fir_gen_8192ch_core_sysclk => clk,
    pfb_fir_gen_8192ch_core_sysce => '1',
    pfb_fir_gen_8192ch_core_sysclr => '0',
    pfb_fir_gen_8192ch_core_clk1 => clk_1_net,
    pfb_fir_gen_8192ch_core_ce1 => ce_1_net
  );
  pfb_fir_gen_8192ch_core_struct : entity xil_defaultlib.pfb_fir_gen_8192ch_core_struct 
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
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
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
