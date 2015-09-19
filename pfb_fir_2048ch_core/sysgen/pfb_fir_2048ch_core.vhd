-- Generated from Simulink block pfb_fir_2048ch_core/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x9 is
  port (
    c : in std_logic_vector( 36-1 downto 0 );
    re : out std_logic_vector( 18-1 downto 0 );
    im : out std_logic_vector( 18-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x9;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x9 is 
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 18-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 18-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  concat_y_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/c_to_ri1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri1 is
  port (
    c : in std_logic_vector( 36-1 downto 0 );
    re : out std_logic_vector( 18-1 downto 0 );
    im : out std_logic_vector( 18-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri1;
architecture structural of pfb_fir_2048ch_core_c_to_ri1 is 
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 18-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 18-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  concat_y_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/c_to_ri2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri2 is
  port (
    c : in std_logic_vector( 36-1 downto 0 );
    re : out std_logic_vector( 18-1 downto 0 );
    im : out std_logic_vector( 18-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri2;
architecture structural of pfb_fir_2048ch_core_c_to_ri2 is 
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 18-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 18-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  concat_y_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/c_to_ri3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri3 is
  port (
    c : in std_logic_vector( 36-1 downto 0 );
    re : out std_logic_vector( 18-1 downto 0 );
    im : out std_logic_vector( 18-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri3;
architecture structural of pfb_fir_2048ch_core_c_to_ri3 is 
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 18-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 18-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  concat_y_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => concat_y_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_coeffs
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in1_coeffs is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 );
    coeff : out std_logic_vector( 72-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in1_coeffs;
architecture structural of pfb_fir_2048ch_core_pol1_in1_coeffs is 
  signal rom1_data_net : std_logic_vector( 18-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 72-1 downto 0 );
  signal concat_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net_x0 : std_logic_vector( 72-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
  signal fan_delay1_q_net : std_logic_vector( 11-1 downto 0 );
  signal rom2_data_net : std_logic_vector( 18-1 downto 0 );
  signal fan_delay2_q_net : std_logic_vector( 11-1 downto 0 );
  signal rom3_data_net : std_logic_vector( 18-1 downto 0 );
  signal fan_delay3_q_net : std_logic_vector( 11-1 downto 0 );
  signal rom4_data_net : std_logic_vector( 18-1 downto 0 );
  signal fan_delay4_q_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= delay1_q_net;
  sync_out <= delay_q_net;
  coeff <= register_q_net;
  concat_y_net <= din;
  slice_y_net <= sync;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_97163502c0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    y => concat_y_net_x0
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    clr => '0',
    rst => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  delay : entity xil_defaultlib.pfb_fir_2048ch_core_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.pfb_fir_2048ch_core_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => concat_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  rom1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_0",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom1_data_net
  );
  rom2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_1",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay2_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom2_data_net
  );
  rom3 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_2",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay3_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom3_data_net
  );
  rom4 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_3",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay4_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom4_data_net
  );
  register_x0 : entity xil_defaultlib.pfb_fir_2048ch_core_xlregister 
  generic map (
    d_width => 72,
    init_value => b"000000000000000000000000000000000000000000000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => concat_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom1_data_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom2_data_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom3_data_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom4_data_net,
    output_port => reinterpret4_output_port_net
  );
  fan_delay1 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay1_q_net
  );
  fan_delay2 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay2_q_net
  );
  fan_delay3 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay3_q_net
  );
  fan_delay4 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay4_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_first_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x8 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x8;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x8 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  delay1_q_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => delay1_q_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => delay1_q_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_first_tap/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x6 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x6;
architecture structural of pfb_fir_2048ch_core_delay_bram_x6 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  delay1_q_net <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => delay1_q_net,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_first_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x12 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x12;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x12 is 
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_first_tap/sync_delay
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_sync_delay_x1 is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_2048ch_core_sync_delay_x1;
architecture structural of pfb_fir_2048ch_core_sync_delay_x1 is 
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 12-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= mux_y_net;
  delay_q_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_137e3f8e80 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_58808ed3e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_ba44aa7728 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_1",
    op_arith => xlUnsigned,
    op_width => 12
  )
  port map (
    rst => "0",
    clr => '0',
    load => delay_q_net,
    din => constant2_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_e8a53915bd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay_q_net,
    d1 => relational1_op_net,
    y => logical_y_net
  );
  mux : entity xil_defaultlib.sysgen_mux_f13193a3d4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => constant3_op_net,
    d0 => delay_q_net,
    d1 => relational_op_net,
    y => mux_y_net
  );
  relational : entity xil_defaultlib.sysgen_relational_679dc9d58f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => constant_op_net,
    b => counter_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_ac52a4661d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant1_op_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_first_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in1_first_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    coeffs : in std_logic_vector( 72-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 );
    coeff_out : out std_logic_vector( 54-1 downto 0 );
    taps_out : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in1_first_tap;
architecture structural of pfb_fir_2048ch_core_pol1_in1_first_tap is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 72-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net;
  sync_out <= mux_y_net;
  coeff_out <= slice1_y_net;
  taps_out <= concat_y_net;
  delay1_q_net <= din;
  delay_q_net <= sync;
  register_q_net <= coeffs;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x8 
  port map (
    c => delay1_q_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x6 
  port map (
    din => delay1_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x12 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net
  );
  sync_delay_x8 : entity xil_defaultlib.pfb_fir_2048ch_core_sync_delay_x1 
  port map (
    in_x0 => delay_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => mux_y_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 72,
    y_width => 18
  )
  port map (
    x => register_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 71,
    x_width => 72,
    y_width => 54
  )
  port map (
    x => register_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_last_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x6 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x6;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x6 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_last_tap/pfb_add_tree/adder_tree1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree1_x0 is
  port (
    sync : in std_logic_vector( 1-1 downto 0 );
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    sync_out : out std_logic_vector( 1-1 downto 0 );
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree1_x0;
architecture structural of pfb_fir_2048ch_core_adder_tree1_x0 is 
  signal sync_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  sync_out <= sync_delay_q_net;
  dout <= addr3_s_net;
  delay_q_net <= sync;
  reint0_1_output_port_net <= din1;
  reint1_1_output_port_net <= din2;
  reint2_1_output_port_net <= din3;
  reint3_1_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_1_output_port_net,
    b => reint1_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_1_output_port_net,
    b => reint3_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
  sync_delay_x8 : entity xil_defaultlib.sysgen_delay_980bcb2ade 
  port map (
    clr => '0',
    d => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => sync_delay_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_last_tap/pfb_add_tree/adder_tree2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree2_x1 is
  port (
    sync : in std_logic_vector( 1-1 downto 0 );
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree2_x1;
architecture structural of pfb_fir_2048ch_core_adder_tree2_x1 is 
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= addr3_s_net;
  delay_q_net <= sync;
  reint0_2_output_port_net <= din1;
  reint1_2_output_port_net <= din2;
  reint2_2_output_port_net <= din3;
  reint3_2_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_2_output_port_net,
    b => reint1_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_2_output_port_net,
    b => reint3_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_last_tap/pfb_add_tree/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x9 is
  port (
    re : in std_logic_vector( 18-1 downto 0 );
    im : in std_logic_vector( 18-1 downto 0 );
    c : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x9;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x9 is 
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
begin
  c <= concat_y_net;
  convert1_dout_net <= re;
  convert2_dout_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_08a0626b24 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert2_dout_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_last_tap/pfb_add_tree
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pfb_add_tree_x0 is
  port (
    din : in std_logic_vector( 208-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_2048ch_core_pfb_add_tree_x0;
architecture structural of pfb_fir_2048ch_core_pfb_add_tree_x0 is 
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 208-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal sync_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal addr3_s_net_x0 : std_logic_vector( 26-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
  signal slice0_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice0_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal scale1_op_net : std_logic_vector( 26-1 downto 0 );
  signal scale2_op_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= concat_y_net;
  sync_out <= delay1_q_net;
  concat_y_net_x0 <= din;
  delay_q_net <= sync;
  clk_net <= clk_1;
  ce_net <= ce_1;
  adder_tree1 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree1_x0 
  port map (
    sync => delay_q_net,
    din1 => reint0_1_output_port_net,
    din2 => reint1_1_output_port_net,
    din3 => reint2_1_output_port_net,
    din4 => reint3_1_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    sync_out => sync_delay_q_net,
    dout => addr3_s_net
  );
  adder_tree2 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree2_x1 
  port map (
    sync => delay_q_net,
    din1 => reint0_2_output_port_net,
    din2 => reint1_2_output_port_net,
    din3 => reint2_2_output_port_net,
    din4 => reint3_2_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x9 
  port map (
    re => convert1_dout_net,
    im => convert2_dout_net,
    c => concat_y_net
  );
  reint0_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_1_y_net,
    output_port => reint0_1_output_port_net
  );
  reint0_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_2_y_net,
    output_port => reint0_2_output_port_net
  );
  reint1_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_1_y_net,
    output_port => reint1_1_output_port_net
  );
  reint1_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_2_y_net,
    output_port => reint1_2_output_port_net
  );
  reint2_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_1_y_net,
    output_port => reint2_1_output_port_net
  );
  reint2_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_2_y_net,
    output_port => reint2_2_output_port_net
  );
  reint3_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_1_y_net,
    output_port => reint3_1_output_port_net
  );
  reint3_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_2_y_net,
    output_port => reint3_2_output_port_net
  );
  slice0_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 182,
    new_msb => 207,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_1_y_net
  );
  slice0_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 156,
    new_msb => 181,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_2_y_net
  );
  slice1_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 130,
    new_msb => 155,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_1_y_net
  );
  slice1_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 104,
    new_msb => 129,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_2_y_net
  );
  slice2_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 78,
    new_msb => 103,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_1_y_net
  );
  slice2_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 77,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_2_y_net
  );
  slice3_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 51,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_1_y_net
  );
  slice3_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 25,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_2_y_net
  );
  convert1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert_pipeline 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale1_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale2_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  delay1 : entity xil_defaultlib.pfb_fir_2048ch_core_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => sync_delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  scale1 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net,
    op => scale1_op_net
  );
  scale2 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net_x0,
    op => scale2_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_last_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x10 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x10;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x10 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_last_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in1_last_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    coeff : in std_logic_vector( 18-1 downto 0 );
    taps : in std_logic_vector( 156-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in1_last_tap;
architecture structural of pfb_fir_2048ch_core_pol1_in1_last_tap is 
  signal concat_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x2 : std_logic_vector( 156-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net : std_logic_vector( 208-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= concat_y_net_x0;
  sync_out <= delay1_q_net;
  ram_data_out_net <= din;
  mux_y_net <= sync;
  slice1_y_net <= coeff;
  concat_y_net_x2 <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x6 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  pfb_add_tree : entity xil_defaultlib.pfb_fir_2048ch_core_pfb_add_tree_x0 
  port map (
    din => concat_y_net,
    sync => delay_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x0,
    sync_out => delay1_q_net
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x10 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_77357e5dd5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net_x2,
    y => concat_y_net
  );
  delay : entity xil_defaultlib.pfb_fir_2048ch_core_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '1',
    d => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap2/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x5 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x5;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x5 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap2/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x4 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x4;
architecture structural of pfb_fir_2048ch_core_delay_bram_x4 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap2/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x8 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x8;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x8 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap2/sync_delay
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_sync_delay is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_2048ch_core_sync_delay;
architecture structural of pfb_fir_2048ch_core_sync_delay is 
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 12-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= mux_y_net_x0;
  mux_y_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_137e3f8e80 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_58808ed3e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_ba44aa7728 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_1",
    op_arith => xlUnsigned,
    op_width => 12
  )
  port map (
    rst => "0",
    clr => '0',
    load => mux_y_net,
    din => constant2_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_e8a53915bd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => mux_y_net,
    d1 => relational1_op_net,
    y => logical_y_net
  );
  mux : entity xil_defaultlib.sysgen_mux_f13193a3d4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => constant3_op_net,
    d0 => mux_y_net,
    d1 => relational_op_net,
    y => mux_y_net_x0
  );
  relational : entity xil_defaultlib.sysgen_relational_679dc9d58f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => constant_op_net,
    b => counter_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_ac52a4661d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant1_op_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in1_tap2 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    coeff : in std_logic_vector( 54-1 downto 0 );
    taps : in std_logic_vector( 52-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 );
    coeff_out : out std_logic_vector( 36-1 downto 0 );
    taps_out : out std_logic_vector( 104-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in1_tap2;
architecture structural of pfb_fir_2048ch_core_pol1_in1_tap2 is 
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 104-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  sync_out <= mux_y_net;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  mux_y_net_x0 <= sync;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x5 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x4 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x8 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  sync_delay_x8 : entity xil_defaultlib.pfb_fir_2048ch_core_sync_delay 
  port map (
    in_x0 => mux_y_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => mux_y_net
  );
  concat : entity xil_defaultlib.sysgen_concat_2e87715cf5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 54,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 53,
    x_width => 54,
    y_width => 36
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap3/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x7 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x7;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x7 is 
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap3/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x5 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x5;
architecture structural of pfb_fir_2048ch_core_delay_bram_x5 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap3/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x11 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x11;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x11 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap3/sync_delay
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_sync_delay_x0 is
  port (
    in_x0 : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out_x0 : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_2048ch_core_sync_delay_x0;
architecture structural of pfb_fir_2048ch_core_sync_delay_x0 is 
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant2_op_net : std_logic_vector( 12-1 downto 0 );
  signal constant3_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 12-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
begin
  out_x0 <= mux_y_net_x0;
  mux_y_net <= in_x0;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_137e3f8e80 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_58808ed3e6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant2 : entity xil_defaultlib.sysgen_constant_ba44aa7728 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant2_op_net
  );
  constant3 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant3_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_1",
    op_arith => xlUnsigned,
    op_width => 12
  )
  port map (
    rst => "0",
    clr => '0',
    load => mux_y_net,
    din => constant2_op_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_e8a53915bd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => mux_y_net,
    d1 => relational1_op_net,
    y => logical_y_net
  );
  mux : entity xil_defaultlib.sysgen_mux_f13193a3d4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => constant3_op_net,
    d0 => mux_y_net,
    d1 => relational_op_net,
    y => mux_y_net_x0
  );
  relational : entity xil_defaultlib.sysgen_relational_679dc9d58f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => constant_op_net,
    b => counter_op_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_ac52a4661d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant1_op_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in1_tap3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in1_tap3 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    coeff : in std_logic_vector( 36-1 downto 0 );
    taps : in std_logic_vector( 104-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 );
    coeff_out : out std_logic_vector( 18-1 downto 0 );
    taps_out : out std_logic_vector( 156-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in1_tap3;
architecture structural of pfb_fir_2048ch_core_pol1_in1_tap3 is 
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net : std_logic_vector( 104-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  sync_out <= mux_y_net;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  mux_y_net_x0 <= sync;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x7 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x5 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x11 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  sync_delay_x8 : entity xil_defaultlib.pfb_fir_2048ch_core_sync_delay_x0 
  port map (
    in_x0 => mux_y_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out_x0 => mux_y_net
  );
  concat : entity xil_defaultlib.sysgen_concat_909ec4ad55 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_coeffs
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in2_coeffs is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff : out std_logic_vector( 72-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in2_coeffs;
architecture structural of pfb_fir_2048ch_core_pol1_in2_coeffs is 
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal register_q_net : std_logic_vector( 72-1 downto 0 );
  signal concat_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net_x0 : std_logic_vector( 72-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal reinterpret4_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
  signal rom1_data_net : std_logic_vector( 18-1 downto 0 );
  signal fan_delay1_q_net : std_logic_vector( 11-1 downto 0 );
  signal rom2_data_net : std_logic_vector( 18-1 downto 0 );
  signal fan_delay2_q_net : std_logic_vector( 11-1 downto 0 );
  signal rom3_data_net : std_logic_vector( 18-1 downto 0 );
  signal fan_delay3_q_net : std_logic_vector( 11-1 downto 0 );
  signal rom4_data_net : std_logic_vector( 18-1 downto 0 );
  signal fan_delay4_q_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= delay1_q_net;
  coeff <= register_q_net;
  concat_y_net <= din;
  slice_y_net <= sync;
  clk_net <= clk_1;
  ce_net <= ce_1;
  concat : entity xil_defaultlib.sysgen_concat_97163502c0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret1_output_port_net,
    in1 => reinterpret2_output_port_net,
    in2 => reinterpret3_output_port_net,
    in3 => reinterpret4_output_port_net,
    y => concat_y_net_x0
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_free 
  generic map (
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    clr => '0',
    rst => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  delay1 : entity xil_defaultlib.pfb_fir_2048ch_core_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => concat_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  rom1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_5",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom1_data_net
  );
  rom2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_6",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay2_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom2_data_net
  );
  rom3 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_7",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay3_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom3_data_net
  );
  rom4 : entity xil_defaultlib.pfb_fir_2048ch_core_xlsprom 
  generic map (
    c_address_width => 11,
    c_width => 18,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_8",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => fan_delay4_q_net,
    clk => clk_net,
    ce => ce_net,
    data => rom4_data_net
  );
  register_x0 : entity xil_defaultlib.pfb_fir_2048ch_core_xlregister 
  generic map (
    d_width => 72,
    init_value => b"000000000000000000000000000000000000000000000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => concat_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom1_data_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom2_data_net,
    output_port => reinterpret2_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom3_data_net,
    output_port => reinterpret3_output_port_net
  );
  reinterpret4 : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => rom4_data_net,
    output_port => reinterpret4_output_port_net
  );
  fan_delay1 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay1_q_net
  );
  fan_delay2 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay2_q_net
  );
  fan_delay3 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay3_q_net
  );
  fan_delay4 : entity xil_defaultlib.sysgen_delay_15d7dfdf75 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d => counter_op_net,
    q => fan_delay4_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_first_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x15 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x15;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x15 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  delay1_q_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => delay1_q_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => delay1_q_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_first_tap/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x10 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x10;
architecture structural of pfb_fir_2048ch_core_delay_bram_x10 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  delay1_q_net <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => delay1_q_net,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_first_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x19 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x19;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x19 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_first_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in2_first_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    coeffs : in std_logic_vector( 72-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 54-1 downto 0 );
    taps_out : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in2_first_tap;
architecture structural of pfb_fir_2048ch_core_pol1_in2_first_tap is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 72-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net;
  coeff_out <= slice1_y_net;
  taps_out <= concat_y_net;
  delay1_q_net <= din;
  delay_q_net <= sync;
  register_q_net <= coeffs;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x15 
  port map (
    c => delay1_q_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x10 
  port map (
    din => delay1_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x19 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 72,
    y_width => 18
  )
  port map (
    x => register_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 71,
    x_width => 72,
    y_width => 54
  )
  port map (
    x => register_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_last_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x14 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x14;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x14 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_last_tap/pfb_add_tree/adder_tree1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree1_x2 is
  port (
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree1_x2;
architecture structural of pfb_fir_2048ch_core_adder_tree1_x2 is 
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= addr3_s_net;
  reint0_1_output_port_net <= din1;
  reint1_1_output_port_net <= din2;
  reint2_1_output_port_net <= din3;
  reint3_1_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_1_output_port_net,
    b => reint1_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_1_output_port_net,
    b => reint3_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_last_tap/pfb_add_tree/adder_tree2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree2_x2 is
  port (
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree2_x2;
architecture structural of pfb_fir_2048ch_core_adder_tree2_x2 is 
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= addr3_s_net;
  reint0_2_output_port_net <= din1;
  reint1_2_output_port_net <= din2;
  reint2_2_output_port_net <= din3;
  reint3_2_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_2_output_port_net,
    b => reint1_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_2_output_port_net,
    b => reint3_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_last_tap/pfb_add_tree/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x18 is
  port (
    re : in std_logic_vector( 18-1 downto 0 );
    im : in std_logic_vector( 18-1 downto 0 );
    c : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x18;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x18 is 
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  c <= concat_y_net;
  convert1_dout_net <= re;
  convert2_dout_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_08a0626b24 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert2_dout_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_last_tap/pfb_add_tree
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pfb_add_tree_x2 is
  port (
    din : in std_logic_vector( 208-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_pfb_add_tree_x2;
architecture structural of pfb_fir_2048ch_core_pfb_add_tree_x2 is 
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 208-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal addr3_s_net_x0 : std_logic_vector( 26-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
  signal slice0_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice0_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal scale1_op_net : std_logic_vector( 26-1 downto 0 );
  signal scale2_op_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= concat_y_net;
  concat_y_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  adder_tree1 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree1_x2 
  port map (
    din1 => reint0_1_output_port_net,
    din2 => reint1_1_output_port_net,
    din3 => reint2_1_output_port_net,
    din4 => reint3_1_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net
  );
  adder_tree2 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree2_x2 
  port map (
    din1 => reint0_2_output_port_net,
    din2 => reint1_2_output_port_net,
    din3 => reint2_2_output_port_net,
    din4 => reint3_2_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x18 
  port map (
    re => convert1_dout_net,
    im => convert2_dout_net,
    c => concat_y_net
  );
  reint0_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_1_y_net,
    output_port => reint0_1_output_port_net
  );
  reint0_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_2_y_net,
    output_port => reint0_2_output_port_net
  );
  reint1_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_1_y_net,
    output_port => reint1_1_output_port_net
  );
  reint1_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_2_y_net,
    output_port => reint1_2_output_port_net
  );
  reint2_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_1_y_net,
    output_port => reint2_1_output_port_net
  );
  reint2_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_2_y_net,
    output_port => reint2_2_output_port_net
  );
  reint3_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_1_y_net,
    output_port => reint3_1_output_port_net
  );
  reint3_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_2_y_net,
    output_port => reint3_2_output_port_net
  );
  slice0_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 182,
    new_msb => 207,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_1_y_net
  );
  slice0_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 156,
    new_msb => 181,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_2_y_net
  );
  slice1_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 130,
    new_msb => 155,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_1_y_net
  );
  slice1_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 104,
    new_msb => 129,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_2_y_net
  );
  slice2_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 78,
    new_msb => 103,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_1_y_net
  );
  slice2_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 77,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_2_y_net
  );
  slice3_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 51,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_1_y_net
  );
  slice3_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 25,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_2_y_net
  );
  convert1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert_pipeline 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale1_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale2_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  scale1 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net,
    op => scale1_op_net
  );
  scale2 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net_x0,
    op => scale2_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_last_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x17 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x17;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x17 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_last_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in2_last_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 18-1 downto 0 );
    taps : in std_logic_vector( 156-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in2_last_tap;
architecture structural of pfb_fir_2048ch_core_pol1_in2_last_tap is 
  signal concat_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x2 : std_logic_vector( 156-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net : std_logic_vector( 208-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net_x2 <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x14 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  pfb_add_tree : entity xil_defaultlib.pfb_fir_2048ch_core_pfb_add_tree_x2 
  port map (
    din => concat_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x17 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_77357e5dd5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net_x2,
    y => concat_y_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap2/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x13 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x13;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x13 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap2/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x9 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x9;
architecture structural of pfb_fir_2048ch_core_delay_bram_x9 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap2/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x16 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x16;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x16 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in2_tap2 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 54-1 downto 0 );
    taps : in std_logic_vector( 52-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 36-1 downto 0 );
    taps_out : out std_logic_vector( 104-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in2_tap2;
architecture structural of pfb_fir_2048ch_core_pol1_in2_tap2 is 
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 104-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x13 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x9 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x16 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_2e87715cf5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 54,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 53,
    x_width => 54,
    y_width => 36
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap3/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x12 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x12;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x12 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap3/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x8 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x8;
architecture structural of pfb_fir_2048ch_core_delay_bram_x8 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap3/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x15 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x15;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x15 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol1_in2_tap3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol1_in2_tap3 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 36-1 downto 0 );
    taps : in std_logic_vector( 104-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 18-1 downto 0 );
    taps_out : out std_logic_vector( 156-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol1_in2_tap3;
architecture structural of pfb_fir_2048ch_core_pol1_in2_tap3 is 
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net : std_logic_vector( 104-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x12 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x8 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x15 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_909ec4ad55 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_first_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x11 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x11;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x11 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in1_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  pol2_in1_delay_q_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => pol2_in1_delay_q_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => pol2_in1_delay_q_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_first_tap/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x7 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x7;
architecture structural of pfb_fir_2048ch_core_delay_bram_x7 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal pol2_in1_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  pol2_in1_delay_q_net <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => pol2_in1_delay_q_net,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_first_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x14 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x14;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x14 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_first_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in1_first_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    coeffs : in std_logic_vector( 72-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 54-1 downto 0 );
    taps_out : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in1_first_tap;
architecture structural of pfb_fir_2048ch_core_pol2_in1_first_tap is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal pol2_in1_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 72-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net;
  coeff_out <= slice1_y_net;
  taps_out <= concat_y_net;
  pol2_in1_delay_q_net <= din;
  delay_q_net <= sync;
  register_q_net <= coeffs;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x11 
  port map (
    c => pol2_in1_delay_q_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x7 
  port map (
    din => pol2_in1_delay_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x14 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 72,
    y_width => 18
  )
  port map (
    x => register_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 71,
    x_width => 72,
    y_width => 54
  )
  port map (
    x => register_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_last_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x10 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x10;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x10 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_last_tap/pfb_add_tree/adder_tree1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree1_x1 is
  port (
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree1_x1;
architecture structural of pfb_fir_2048ch_core_adder_tree1_x1 is 
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= addr3_s_net;
  reint0_1_output_port_net <= din1;
  reint1_1_output_port_net <= din2;
  reint2_1_output_port_net <= din3;
  reint3_1_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_1_output_port_net,
    b => reint1_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_1_output_port_net,
    b => reint3_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_last_tap/pfb_add_tree/adder_tree2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree2_x0 is
  port (
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree2_x0;
architecture structural of pfb_fir_2048ch_core_adder_tree2_x0 is 
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= addr3_s_net;
  reint0_2_output_port_net <= din1;
  reint1_2_output_port_net <= din2;
  reint2_2_output_port_net <= din3;
  reint3_2_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_2_output_port_net,
    b => reint1_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_2_output_port_net,
    b => reint3_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_last_tap/pfb_add_tree/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x13 is
  port (
    re : in std_logic_vector( 18-1 downto 0 );
    im : in std_logic_vector( 18-1 downto 0 );
    c : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x13;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x13 is 
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  c <= concat_y_net;
  convert1_dout_net <= re;
  convert2_dout_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_08a0626b24 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert2_dout_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_last_tap/pfb_add_tree
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pfb_add_tree_x1 is
  port (
    din : in std_logic_vector( 208-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_pfb_add_tree_x1;
architecture structural of pfb_fir_2048ch_core_pfb_add_tree_x1 is 
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 208-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal addr3_s_net_x0 : std_logic_vector( 26-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
  signal slice0_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice0_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal scale1_op_net : std_logic_vector( 26-1 downto 0 );
  signal scale2_op_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= concat_y_net;
  concat_y_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  adder_tree1 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree1_x1 
  port map (
    din1 => reint0_1_output_port_net,
    din2 => reint1_1_output_port_net,
    din3 => reint2_1_output_port_net,
    din4 => reint3_1_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net
  );
  adder_tree2 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree2_x0 
  port map (
    din1 => reint0_2_output_port_net,
    din2 => reint1_2_output_port_net,
    din3 => reint2_2_output_port_net,
    din4 => reint3_2_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x13 
  port map (
    re => convert1_dout_net,
    im => convert2_dout_net,
    c => concat_y_net
  );
  reint0_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_1_y_net,
    output_port => reint0_1_output_port_net
  );
  reint0_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_2_y_net,
    output_port => reint0_2_output_port_net
  );
  reint1_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_1_y_net,
    output_port => reint1_1_output_port_net
  );
  reint1_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_2_y_net,
    output_port => reint1_2_output_port_net
  );
  reint2_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_1_y_net,
    output_port => reint2_1_output_port_net
  );
  reint2_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_2_y_net,
    output_port => reint2_2_output_port_net
  );
  reint3_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_1_y_net,
    output_port => reint3_1_output_port_net
  );
  reint3_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_2_y_net,
    output_port => reint3_2_output_port_net
  );
  slice0_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 182,
    new_msb => 207,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_1_y_net
  );
  slice0_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 156,
    new_msb => 181,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_2_y_net
  );
  slice1_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 130,
    new_msb => 155,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_1_y_net
  );
  slice1_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 104,
    new_msb => 129,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_2_y_net
  );
  slice2_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 78,
    new_msb => 103,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_1_y_net
  );
  slice2_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 77,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_2_y_net
  );
  slice3_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 51,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_1_y_net
  );
  slice3_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 25,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_2_y_net
  );
  convert1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert_pipeline 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale1_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale2_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  scale1 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net,
    op => scale1_op_net
  );
  scale2 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net_x0,
    op => scale2_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_last_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x4 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x4;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x4 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_last_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in1_last_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 18-1 downto 0 );
    taps : in std_logic_vector( 156-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in1_last_tap;
architecture structural of pfb_fir_2048ch_core_pol2_in1_last_tap is 
  signal concat_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x2 : std_logic_vector( 156-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net : std_logic_vector( 208-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net_x2 <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x10 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  pfb_add_tree : entity xil_defaultlib.pfb_fir_2048ch_core_pfb_add_tree_x1 
  port map (
    din => concat_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x4 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_77357e5dd5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net_x2,
    y => concat_y_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap2/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x2 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x2;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x2 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap2/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x1 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x1;
architecture structural of pfb_fir_2048ch_core_delay_bram_x1 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap2/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x3 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x3;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x3 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in1_tap2 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 54-1 downto 0 );
    taps : in std_logic_vector( 52-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 36-1 downto 0 );
    taps_out : out std_logic_vector( 104-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in1_tap2;
architecture structural of pfb_fir_2048ch_core_pol2_in1_tap2 is 
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 104-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x2 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x1 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x3 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_2e87715cf5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 54,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 53,
    x_width => 54,
    y_width => 36
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap3/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x1 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x1;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x1 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap3/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x0 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x0;
architecture structural of pfb_fir_2048ch_core_delay_bram_x0 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap3/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x2 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x2;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x2 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in1_tap3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in1_tap3 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 36-1 downto 0 );
    taps : in std_logic_vector( 104-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 18-1 downto 0 );
    taps_out : out std_logic_vector( 156-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in1_tap3;
architecture structural of pfb_fir_2048ch_core_pol2_in1_tap3 is 
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net : std_logic_vector( 104-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x1 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x0 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x2 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_909ec4ad55 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_first_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x0 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x0;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x0 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in2_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  pol2_in2_delay_q_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => pol2_in2_delay_q_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => pol2_in2_delay_q_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_first_tap/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram;
architecture structural of pfb_fir_2048ch_core_delay_bram is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal pol2_in2_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  pol2_in2_delay_q_net <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => pol2_in2_delay_q_net,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_first_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x0 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x0;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x0 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_first_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in2_first_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    sync : in std_logic_vector( 1-1 downto 0 );
    coeffs : in std_logic_vector( 72-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 54-1 downto 0 );
    taps_out : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in2_first_tap;
architecture structural of pfb_fir_2048ch_core_pol2_in2_first_tap is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal pol2_in2_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 72-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net;
  coeff_out <= slice1_y_net;
  taps_out <= concat_y_net;
  pol2_in2_delay_q_net <= din;
  delay_q_net <= sync;
  register_q_net <= coeffs;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x0 
  port map (
    c => pol2_in2_delay_q_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram 
  port map (
    din => pol2_in2_delay_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x0 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 72,
    y_width => 18
  )
  port map (
    x => register_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 71,
    x_width => 72,
    y_width => 54
  )
  port map (
    x => register_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_last_tap/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri;
architecture structural of pfb_fir_2048ch_core_c_to_ri is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_last_tap/pfb_add_tree/adder_tree1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree1 is
  port (
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree1;
architecture structural of pfb_fir_2048ch_core_adder_tree1 is 
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= addr3_s_net;
  reint0_1_output_port_net <= din1;
  reint1_1_output_port_net <= din2;
  reint2_1_output_port_net <= din3;
  reint3_1_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_1_output_port_net,
    b => reint1_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_1_output_port_net,
    b => reint3_1_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_last_tap/pfb_add_tree/adder_tree2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_adder_tree2 is
  port (
    din1 : in std_logic_vector( 26-1 downto 0 );
    din2 : in std_logic_vector( 26-1 downto 0 );
    din3 : in std_logic_vector( 26-1 downto 0 );
    din4 : in std_logic_vector( 26-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 26-1 downto 0 )
  );
end pfb_fir_2048ch_core_adder_tree2;
architecture structural of pfb_fir_2048ch_core_adder_tree2 is 
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr1_s_net : std_logic_vector( 26-1 downto 0 );
  signal addr2_s_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= addr3_s_net;
  reint0_2_output_port_net <= din1;
  reint1_2_output_port_net <= din2;
  reint2_2_output_port_net <= din3;
  reint3_2_output_port_net <= din4;
  clk_net <= clk_1;
  ce_net <= ce_1;
  addr1 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint0_2_output_port_net,
    b => reint1_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr1_s_net
  );
  addr2 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => reint2_2_output_port_net,
    b => reint3_2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addr2_s_net
  );
  addr3 : entity xil_defaultlib.pfb_fir_2048ch_core_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 24,
    a_width => 26,
    b_arith => xlSigned,
    b_bin_pt => 24,
    b_width => 26,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 27,
    core_name0 => "pfb_fir_2048ch_core_c_addsub_v12_0_0",
    extra_registers => 1,
    full_s_arith => 2,
    full_s_width => 27,
    latency => 2,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 24,
    s_width => 26
  )
  port map (
    clr => '0',
    en => "1",
    a => addr1_s_net,
    b => addr2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addr3_s_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_last_tap/pfb_add_tree/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c is
  port (
    re : in std_logic_vector( 18-1 downto 0 );
    im : in std_logic_vector( 18-1 downto 0 );
    c : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c;
architecture structural of pfb_fir_2048ch_core_ri_to_c is 
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  c <= concat_y_net;
  convert1_dout_net <= re;
  convert2_dout_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_08a0626b24 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert2_dout_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_5c55a80654 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert1_dout_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_last_tap/pfb_add_tree
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pfb_add_tree is
  port (
    din : in std_logic_vector( 208-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_pfb_add_tree;
architecture structural of pfb_fir_2048ch_core_pfb_add_tree is 
  signal concat_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 208-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal addr3_s_net : std_logic_vector( 26-1 downto 0 );
  signal reint0_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_1_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal addr3_s_net_x0 : std_logic_vector( 26-1 downto 0 );
  signal reint0_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint1_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint2_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reint3_2_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 18-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 18-1 downto 0 );
  signal slice0_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice0_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice1_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice2_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_1_y_net : std_logic_vector( 26-1 downto 0 );
  signal slice3_2_y_net : std_logic_vector( 26-1 downto 0 );
  signal scale1_op_net : std_logic_vector( 26-1 downto 0 );
  signal scale2_op_net : std_logic_vector( 26-1 downto 0 );
begin
  dout <= concat_y_net;
  concat_y_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  adder_tree1 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree1 
  port map (
    din1 => reint0_1_output_port_net,
    din2 => reint1_1_output_port_net,
    din3 => reint2_1_output_port_net,
    din4 => reint3_1_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net
  );
  adder_tree2 : entity xil_defaultlib.pfb_fir_2048ch_core_adder_tree2 
  port map (
    din1 => reint0_2_output_port_net,
    din2 => reint1_2_output_port_net,
    din3 => reint2_2_output_port_net,
    din4 => reint3_2_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => addr3_s_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c 
  port map (
    re => convert1_dout_net,
    im => convert2_dout_net,
    c => concat_y_net
  );
  reint0_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_1_y_net,
    output_port => reint0_1_output_port_net
  );
  reint0_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice0_2_y_net,
    output_port => reint0_2_output_port_net
  );
  reint1_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_1_y_net,
    output_port => reint1_1_output_port_net
  );
  reint1_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_2_y_net,
    output_port => reint1_2_output_port_net
  );
  reint2_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_1_y_net,
    output_port => reint2_1_output_port_net
  );
  reint2_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_2_y_net,
    output_port => reint2_2_output_port_net
  );
  reint3_1 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_1_y_net,
    output_port => reint3_1_output_port_net
  );
  reint3_2 : entity xil_defaultlib.sysgen_reinterpret_896b260686 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_2_y_net,
    output_port => reint3_2_output_port_net
  );
  slice0_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 182,
    new_msb => 207,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_1_y_net
  );
  slice0_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 156,
    new_msb => 181,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice0_2_y_net
  );
  slice1_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 130,
    new_msb => 155,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_1_y_net
  );
  slice1_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 104,
    new_msb => 129,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice1_2_y_net
  );
  slice2_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 78,
    new_msb => 103,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_1_y_net
  );
  slice2_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 52,
    new_msb => 77,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice2_2_y_net
  );
  slice3_1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 26,
    new_msb => 51,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_1_y_net
  );
  slice3_2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 25,
    x_width => 208,
    y_width => 26
  )
  port map (
    x => concat_y_net_x0,
    y => slice3_2_y_net
  );
  convert1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert_pipeline 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale1_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.pfb_fir_2048ch_core_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 25,
    din_width => 26,
    dout_arith => 2,
    dout_bin_pt => 17,
    dout_width => 18,
    latency => 2,
    overflow => xlWrap,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => scale2_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  scale1 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net,
    op => scale1_op_net
  );
  scale2 : entity xil_defaultlib.sysgen_scale_79e89edf7a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    ip => addr3_s_net_x0,
    op => scale2_op_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_last_tap/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x1 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x1;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x1 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_last_tap
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in2_last_tap is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 18-1 downto 0 );
    taps : in std_logic_vector( 156-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in2_last_tap;
architecture structural of pfb_fir_2048ch_core_pol2_in2_last_tap is 
  signal concat_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x2 : std_logic_vector( 156-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net : std_logic_vector( 208-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net_x2 <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  pfb_add_tree : entity xil_defaultlib.pfb_fir_2048ch_core_pfb_add_tree 
  port map (
    din => concat_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x1 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_77357e5dd5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net_x2,
    y => concat_y_net
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice1_y_net,
    output_port => reinterpret_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap2/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x4 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x4;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x4 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap2/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x3 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x3;
architecture structural of pfb_fir_2048ch_core_delay_bram_x3 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap2/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x7 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x7;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x7 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in2_tap2 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 54-1 downto 0 );
    taps : in std_logic_vector( 52-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 36-1 downto 0 );
    taps_out : out std_logic_vector( 104-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in2_tap2;
architecture structural of pfb_fir_2048ch_core_pol2_in2_tap2 is 
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 104-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x4 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x3 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x7 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_2e87715cf5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 54,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 53,
    x_width => 54,
    y_width => 36
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap3/c_to_ri
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_c_to_ri_x3 is
  port (
    c : in std_logic_vector( 16-1 downto 0 );
    re : out std_logic_vector( 8-1 downto 0 );
    im : out std_logic_vector( 8-1 downto 0 )
  );
end pfb_fir_2048ch_core_c_to_ri_x3;
architecture structural of pfb_fir_2048ch_core_c_to_ri_x3 is 
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice_im_y_net : std_logic_vector( 8-1 downto 0 );
  signal slice_re_y_net : std_logic_vector( 8-1 downto 0 );
begin
  re <= force_re_output_port_net;
  im <= force_im_output_port_net;
  ram_data_out_net <= c;
  force_im : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_im_y_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_cf5876b67a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_re_y_net,
    output_port => force_re_output_port_net
  );
  slice_im : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_im_y_net
  );
  slice_re : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 8,
    new_msb => 15,
    x_width => 16,
    y_width => 8
  )
  port map (
    x => ram_data_out_net,
    y => slice_re_y_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap3/delay_bram
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_delay_bram_x2 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_delay_bram_x2;
architecture structural of pfb_fir_2048ch_core_delay_bram_x2 is 
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
begin
  dout <= ram_data_out_net;
  ram_data_out_net_x0 <= din;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_796d58cc64 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.pfb_fir_2048ch_core_xlcounter_limit 
  generic map (
    cnt_15_0 => 2044,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "pfb_fir_2048ch_core_c_counter_binary_v12_0_0",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  ram : entity xil_defaultlib.pfb_fir_2048ch_core_xlspram 
  generic map (
    c_address_width => 11,
    c_width => 16,
    core_name0 => "pfb_fir_2048ch_core_blk_mem_gen_v8_2_4",
    latency => 2
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => ram_data_out_net_x0,
    we => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => ram_data_out_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap3/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x6 is
  port (
    re : in std_logic_vector( 26-1 downto 0 );
    im : in std_logic_vector( 26-1 downto 0 );
    c : out std_logic_vector( 52-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x6;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x6 is 
  signal concat_y_net : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 26-1 downto 0 );
begin
  c <= concat_y_net;
  mult1_p_net <= re;
  mult_p_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_83a6a34763 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret_output_port_net,
    in1 => reinterpret1_output_port_net,
    y => concat_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult1_p_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_892b7a27c5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mult_p_net,
    output_port => reinterpret1_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir/pol2_in2_tap3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pol2_in2_tap3 is
  port (
    din : in std_logic_vector( 16-1 downto 0 );
    coeff : in std_logic_vector( 36-1 downto 0 );
    taps : in std_logic_vector( 104-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 16-1 downto 0 );
    coeff_out : out std_logic_vector( 18-1 downto 0 );
    taps_out : out std_logic_vector( 156-1 downto 0 )
  );
end pfb_fir_2048ch_core_pol2_in2_tap3;
architecture structural of pfb_fir_2048ch_core_pol2_in2_tap3 is 
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net : std_logic_vector( 104-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 26-1 downto 0 );
  signal mult_p_net : std_logic_vector( 26-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal slice_y_net : std_logic_vector( 18-1 downto 0 );
begin
  dout <= ram_data_out_net_x0;
  coeff_out <= slice1_y_net_x0;
  taps_out <= concat_y_net_x0;
  ram_data_out_net <= din;
  slice1_y_net <= coeff;
  concat_y_net <= taps;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x3 
  port map (
    c => ram_data_out_net,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  delay_bram : entity xil_defaultlib.pfb_fir_2048ch_core_delay_bram_x2 
  port map (
    din => ram_data_out_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x6 
  port map (
    re => mult1_p_net,
    im => mult_p_net,
    c => concat_y_net_x1
  );
  concat : entity xil_defaultlib.sysgen_concat_909ec4ad55 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => concat_y_net_x1,
    in1 => concat_y_net,
    y => concat_y_net_x0
  );
  mult : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_im_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.sysgen_mult_9e52ce1662 
  port map (
    clr => '0',
    a => force_re_output_port_net,
    b => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    p => mult1_p_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b136dd5b0a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
  generic map (
    new_lsb => 18,
    new_msb => 35,
    x_width => 36,
    y_width => 18
  )
  port map (
    x => slice1_y_net,
    y => slice1_y_net_x0
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/pfb_fir
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_pfb_fir is
  port (
    sync : in std_logic_vector( 1-1 downto 0 );
    pol1_in1 : in std_logic_vector( 16-1 downto 0 );
    pol1_in2 : in std_logic_vector( 16-1 downto 0 );
    pol2_in1 : in std_logic_vector( 16-1 downto 0 );
    pol2_in2 : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    sync_out : out std_logic_vector( 1-1 downto 0 );
    pol1_out1 : out std_logic_vector( 36-1 downto 0 );
    pol1_out2 : out std_logic_vector( 36-1 downto 0 );
    pol2_out1 : out std_logic_vector( 36-1 downto 0 );
    pol2_out2 : out std_logic_vector( 36-1 downto 0 )
  );
end pfb_fir_2048ch_core_pfb_fir;
architecture structural of pfb_fir_2048ch_core_pfb_fir is 
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x15 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x8 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x12 : std_logic_vector( 36-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net_x4 : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net_x6 : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net_x5 : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net_x7 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal delay1_q_net_x1 : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 72-1 downto 0 );
  signal ram_data_out_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net_x1 : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 52-1 downto 0 );
  signal ram_data_out_net_x1 : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x2 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net : std_logic_vector( 104-1 downto 0 );
  signal delay1_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal register_q_net_x0 : std_logic_vector( 72-1 downto 0 );
  signal ram_data_out_net_x7 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x7 : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net_x14 : std_logic_vector( 52-1 downto 0 );
  signal ram_data_out_net_x9 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x9 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x17 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net_x8 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x8 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x16 : std_logic_vector( 104-1 downto 0 );
  signal ram_data_out_net_x10 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x10 : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net_x18 : std_logic_vector( 52-1 downto 0 );
  signal pol2_in1_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x4 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x4 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x10 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net_x3 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x3 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x9 : std_logic_vector( 104-1 downto 0 );
  signal ram_data_out_net_x5 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x5 : std_logic_vector( 54-1 downto 0 );
  signal concat_y_net_x11 : std_logic_vector( 52-1 downto 0 );
  signal pol2_in2_delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal ram_data_out_net_x2 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x2 : std_logic_vector( 18-1 downto 0 );
  signal concat_y_net_x3 : std_logic_vector( 156-1 downto 0 );
  signal ram_data_out_net_x6 : std_logic_vector( 16-1 downto 0 );
  signal slice1_y_net_x6 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x13 : std_logic_vector( 104-1 downto 0 );
begin
  sync_out <= delay1_q_net;
  pol1_out1 <= concat_y_net_x0;
  pol1_out2 <= concat_y_net_x15;
  pol2_out1 <= concat_y_net_x8;
  pol2_out2 <= concat_y_net_x12;
  slice_y_net <= sync;
  concat_y_net_x4 <= pol1_in1;
  concat_y_net_x6 <= pol1_in2;
  concat_y_net_x5 <= pol2_in1;
  concat_y_net_x7 <= pol2_in2;
  clk_net <= clk_1;
  ce_net <= ce_1;
  pol1_in1_coeffs : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in1_coeffs 
  port map (
    din => concat_y_net_x4,
    sync => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => delay1_q_net_x1,
    sync_out => delay_q_net_x0,
    coeff => register_q_net
  );
  pol1_in1_first_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in1_first_tap 
  port map (
    din => delay1_q_net_x1,
    sync => delay_q_net_x0,
    coeffs => register_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net,
    sync_out => mux_y_net_x0,
    coeff_out => slice1_y_net_x1,
    taps_out => concat_y_net_x1
  );
  pol1_in1_last_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in1_last_tap 
  port map (
    din => ram_data_out_net_x1,
    sync => mux_y_net,
    coeff => slice1_y_net_x0,
    taps => concat_y_net_x2,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x0,
    sync_out => delay1_q_net
  );
  pol1_in1_tap2 : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in1_tap2 
  port map (
    din => ram_data_out_net,
    sync => mux_y_net_x0,
    coeff => slice1_y_net_x1,
    taps => concat_y_net_x1,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x0,
    sync_out => mux_y_net_x1,
    coeff_out => slice1_y_net,
    taps_out => concat_y_net
  );
  pol1_in1_tap3 : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in1_tap3 
  port map (
    din => ram_data_out_net_x0,
    sync => mux_y_net_x1,
    coeff => slice1_y_net,
    taps => concat_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x1,
    sync_out => mux_y_net,
    coeff_out => slice1_y_net_x0,
    taps_out => concat_y_net_x2
  );
  pol1_in2_coeffs : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in2_coeffs 
  port map (
    din => concat_y_net_x6,
    sync => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => delay1_q_net_x0,
    coeff => register_q_net_x0
  );
  pol1_in2_first_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in2_first_tap 
  port map (
    din => delay1_q_net_x0,
    sync => delay_q_net_x0,
    coeffs => register_q_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x7,
    coeff_out => slice1_y_net_x7,
    taps_out => concat_y_net_x14
  );
  pol1_in2_last_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in2_last_tap 
  port map (
    din => ram_data_out_net_x9,
    coeff => slice1_y_net_x9,
    taps => concat_y_net_x17,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x15
  );
  pol1_in2_tap2 : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in2_tap2 
  port map (
    din => ram_data_out_net_x7,
    coeff => slice1_y_net_x7,
    taps => concat_y_net_x14,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x8,
    coeff_out => slice1_y_net_x8,
    taps_out => concat_y_net_x16
  );
  pol1_in2_tap3 : entity xil_defaultlib.pfb_fir_2048ch_core_pol1_in2_tap3 
  port map (
    din => ram_data_out_net_x8,
    coeff => slice1_y_net_x8,
    taps => concat_y_net_x16,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x9,
    coeff_out => slice1_y_net_x9,
    taps_out => concat_y_net_x17
  );
  pol2_in1_first_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in1_first_tap 
  port map (
    din => pol2_in1_delay_q_net,
    sync => delay_q_net_x0,
    coeffs => register_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x10,
    coeff_out => slice1_y_net_x10,
    taps_out => concat_y_net_x18
  );
  pol2_in1_last_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in1_last_tap 
  port map (
    din => ram_data_out_net_x4,
    coeff => slice1_y_net_x4,
    taps => concat_y_net_x10,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x8
  );
  pol2_in1_tap2 : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in1_tap2 
  port map (
    din => ram_data_out_net_x10,
    coeff => slice1_y_net_x10,
    taps => concat_y_net_x18,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x3,
    coeff_out => slice1_y_net_x3,
    taps_out => concat_y_net_x9
  );
  pol2_in1_tap3 : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in1_tap3 
  port map (
    din => ram_data_out_net_x3,
    coeff => slice1_y_net_x3,
    taps => concat_y_net_x9,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x4,
    coeff_out => slice1_y_net_x4,
    taps_out => concat_y_net_x10
  );
  pol2_in2_first_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in2_first_tap 
  port map (
    din => pol2_in2_delay_q_net,
    sync => delay_q_net_x0,
    coeffs => register_q_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x5,
    coeff_out => slice1_y_net_x5,
    taps_out => concat_y_net_x11
  );
  pol2_in2_last_tap : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in2_last_tap 
  port map (
    din => ram_data_out_net_x2,
    coeff => slice1_y_net_x2,
    taps => concat_y_net_x3,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => concat_y_net_x12
  );
  pol2_in2_tap2 : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in2_tap2 
  port map (
    din => ram_data_out_net_x5,
    coeff => slice1_y_net_x5,
    taps => concat_y_net_x11,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x6,
    coeff_out => slice1_y_net_x6,
    taps_out => concat_y_net_x13
  );
  pol2_in2_tap3 : entity xil_defaultlib.pfb_fir_2048ch_core_pol2_in2_tap3 
  port map (
    din => ram_data_out_net_x6,
    coeff => slice1_y_net_x6,
    taps => concat_y_net_x13,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => ram_data_out_net_x2,
    coeff_out => slice1_y_net_x2,
    taps_out => concat_y_net_x3
  );
  pol2_in1_delay : entity xil_defaultlib.pfb_fir_2048ch_core_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => concat_y_net_x5,
    clk => clk_net,
    ce => ce_net,
    q => pol2_in1_delay_q_net
  );
  pol2_in2_delay : entity xil_defaultlib.pfb_fir_2048ch_core_xldelay 
  generic map (
    latency => 4,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '1',
    d => concat_y_net_x7,
    clk => clk_net,
    ce => ce_net,
    q => pol2_in2_delay_q_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/ri_to_c
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c_x5 is
  port (
    re : in std_logic_vector( 8-1 downto 0 );
    im : in std_logic_vector( 8-1 downto 0 );
    c : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c_x5;
architecture structural of pfb_fir_2048ch_core_ri_to_c_x5 is 
  signal concat_y_net : std_logic_vector( 16-1 downto 0 );
  signal pol0_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in0_net : std_logic_vector( 8-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
begin
  c <= concat_y_net;
  pol0_in0_net <= re;
  pol1_in0_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_a2bee75304 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol1_in0_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol0_in0_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/ri_to_c1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c1 is
  port (
    re : in std_logic_vector( 8-1 downto 0 );
    im : in std_logic_vector( 8-1 downto 0 );
    c : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c1;
architecture structural of pfb_fir_2048ch_core_ri_to_c1 is 
  signal concat_y_net : std_logic_vector( 16-1 downto 0 );
  signal pol2_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in0_net : std_logic_vector( 8-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
begin
  c <= concat_y_net;
  pol2_in0_net <= re;
  pol3_in0_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_a2bee75304 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol3_in0_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol2_in0_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/ri_to_c2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c2 is
  port (
    re : in std_logic_vector( 8-1 downto 0 );
    im : in std_logic_vector( 8-1 downto 0 );
    c : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c2;
architecture structural of pfb_fir_2048ch_core_ri_to_c2 is 
  signal concat_y_net : std_logic_vector( 16-1 downto 0 );
  signal pol0_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in1_net : std_logic_vector( 8-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
begin
  c <= concat_y_net;
  pol0_in1_net <= re;
  pol1_in1_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_a2bee75304 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol1_in1_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol0_in1_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core/ri_to_c3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_ri_to_c3 is
  port (
    re : in std_logic_vector( 8-1 downto 0 );
    im : in std_logic_vector( 8-1 downto 0 );
    c : out std_logic_vector( 16-1 downto 0 )
  );
end pfb_fir_2048ch_core_ri_to_c3;
architecture structural of pfb_fir_2048ch_core_ri_to_c3 is 
  signal concat_y_net : std_logic_vector( 16-1 downto 0 );
  signal pol2_in1_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in1_net : std_logic_vector( 8-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 8-1 downto 0 );
begin
  c <= concat_y_net;
  pol2_in1_net <= re;
  pol3_in1_net <= im;
  concat : entity xil_defaultlib.sysgen_concat_a2bee75304 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => force_re_output_port_net,
    in1 => force_im_output_port_net,
    y => concat_y_net
  );
  force_im : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol3_in1_net,
    output_port => force_im_output_port_net
  );
  force_re : entity xil_defaultlib.sysgen_reinterpret_c6fd8e2c25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => pol2_in1_net,
    output_port => force_re_output_port_net
  );
end structural;
-- Generated from Simulink block pfb_fir_2048ch_core_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core_struct is
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
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    pol0_out0 : out std_logic_vector( 18-1 downto 0 );
    pol0_out1 : out std_logic_vector( 18-1 downto 0 );
    pol1_out0 : out std_logic_vector( 18-1 downto 0 );
    pol1_out1 : out std_logic_vector( 18-1 downto 0 );
    pol2_out0 : out std_logic_vector( 18-1 downto 0 );
    pol2_out1 : out std_logic_vector( 18-1 downto 0 );
    pol3_out0 : out std_logic_vector( 18-1 downto 0 );
    pol3_out1 : out std_logic_vector( 18-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_2048ch_core_struct;
architecture structural of pfb_fir_2048ch_core_struct is 
  signal pol0_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol0_in1_net : std_logic_vector( 8-1 downto 0 );
  signal force_re_output_port_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal force_re_output_port_net_x2 : std_logic_vector( 18-1 downto 0 );
  signal pol1_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol1_in1_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net_x0 : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net_x1 : std_logic_vector( 18-1 downto 0 );
  signal pol2_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol2_in1_net : std_logic_vector( 8-1 downto 0 );
  signal force_re_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_re_output_port_net_x1 : std_logic_vector( 18-1 downto 0 );
  signal pol3_in0_net : std_logic_vector( 8-1 downto 0 );
  signal pol3_in1_net : std_logic_vector( 8-1 downto 0 );
  signal force_im_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal force_im_output_port_net_x2 : std_logic_vector( 18-1 downto 0 );
  signal sync_net : std_logic_vector( 32-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal concat_y_net_x6 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x4 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x5 : std_logic_vector( 36-1 downto 0 );
  signal concat_y_net_x3 : std_logic_vector( 36-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net_x1 : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal concat_y_net_x2 : std_logic_vector( 16-1 downto 0 );
begin
  pol0_in0_net <= pol0_in0;
  pol0_in1_net <= pol0_in1;
  pol0_out0 <= force_re_output_port_net_x0;
  pol0_out1 <= force_re_output_port_net_x2;
  pol1_in0_net <= pol1_in0;
  pol1_in1_net <= pol1_in1;
  pol1_out0 <= force_im_output_port_net_x0;
  pol1_out1 <= force_im_output_port_net_x1;
  pol2_in0_net <= pol2_in0;
  pol2_in1_net <= pol2_in1;
  pol2_out0 <= force_re_output_port_net;
  pol2_out1 <= force_re_output_port_net_x1;
  pol3_in0_net <= pol3_in0;
  pol3_in1_net <= pol3_in1;
  pol3_out0 <= force_im_output_port_net;
  pol3_out1 <= force_im_output_port_net_x2;
  sync_net <= sync;
  sync_out <= delay1_q_net;
  clk_net <= clk_1;
  ce_net <= ce_1;
  c_to_ri : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri_x9 
  port map (
    c => concat_y_net_x6,
    re => force_re_output_port_net_x0,
    im => force_im_output_port_net_x0
  );
  c_to_ri1 : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri1 
  port map (
    c => concat_y_net_x4,
    re => force_re_output_port_net,
    im => force_im_output_port_net
  );
  c_to_ri2 : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri2 
  port map (
    c => concat_y_net_x5,
    re => force_re_output_port_net_x2,
    im => force_im_output_port_net_x1
  );
  c_to_ri3 : entity xil_defaultlib.pfb_fir_2048ch_core_c_to_ri3 
  port map (
    c => concat_y_net_x3,
    re => force_re_output_port_net_x1,
    im => force_im_output_port_net_x2
  );
  pfb_fir : entity xil_defaultlib.pfb_fir_2048ch_core_pfb_fir 
  port map (
    sync => slice_y_net,
    pol1_in1 => concat_y_net,
    pol1_in2 => concat_y_net_x1,
    pol2_in1 => concat_y_net_x0,
    pol2_in2 => concat_y_net_x2,
    clk_1 => clk_net,
    ce_1 => ce_net,
    sync_out => delay1_q_net,
    pol1_out1 => concat_y_net_x6,
    pol1_out2 => concat_y_net_x5,
    pol2_out1 => concat_y_net_x4,
    pol2_out2 => concat_y_net_x3
  );
  ri_to_c : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c_x5 
  port map (
    re => pol0_in0_net,
    im => pol1_in0_net,
    c => concat_y_net
  );
  ri_to_c1 : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c1 
  port map (
    re => pol2_in0_net,
    im => pol3_in0_net,
    c => concat_y_net_x0
  );
  ri_to_c2 : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c2 
  port map (
    re => pol0_in1_net,
    im => pol1_in1_net,
    c => concat_y_net_x1
  );
  ri_to_c3 : entity xil_defaultlib.pfb_fir_2048ch_core_ri_to_c3 
  port map (
    re => pol2_in1_net,
    im => pol3_in1_net,
    c => concat_y_net_x2
  );
  slice : entity xil_defaultlib.pfb_fir_2048ch_core_xlslice 
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
entity pfb_fir_2048ch_core_default_clock_driver is
  port (
    pfb_fir_2048ch_core_sysclk : in std_logic;
    pfb_fir_2048ch_core_sysce : in std_logic;
    pfb_fir_2048ch_core_sysclr : in std_logic;
    pfb_fir_2048ch_core_clk1 : out std_logic;
    pfb_fir_2048ch_core_ce1 : out std_logic
  );
end pfb_fir_2048ch_core_default_clock_driver;
architecture structural of pfb_fir_2048ch_core_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => pfb_fir_2048ch_core_sysclk,
    sysce => pfb_fir_2048ch_core_sysce,
    sysclr => pfb_fir_2048ch_core_sysclr,
    clk => pfb_fir_2048ch_core_clk1,
    ce => pfb_fir_2048ch_core_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity pfb_fir_2048ch_core is
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
    clk : in std_logic;
    pol0_out0 : out std_logic_vector( 18-1 downto 0 );
    pol0_out1 : out std_logic_vector( 18-1 downto 0 );
    pol1_out0 : out std_logic_vector( 18-1 downto 0 );
    pol1_out1 : out std_logic_vector( 18-1 downto 0 );
    pol2_out0 : out std_logic_vector( 18-1 downto 0 );
    pol2_out1 : out std_logic_vector( 18-1 downto 0 );
    pol3_out0 : out std_logic_vector( 18-1 downto 0 );
    pol3_out1 : out std_logic_vector( 18-1 downto 0 );
    sync_out : out std_logic_vector( 1-1 downto 0 )
  );
end pfb_fir_2048ch_core;
architecture structural of pfb_fir_2048ch_core is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "pfb_fir_2048ch_core,sysgen_core_2014_4,{,compilation=IP Catalog,block_icon_display=Default,family=kintex7,part=xc7k160t,speed=-2,package=ffg676,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,clock_loc=,testbench=0,interface_doc=0,ce_clr=0,clock_period=5,system_simulink_period=1,simulation_time=10,addsub=24,concat=38,constant=60,convert=8,counter=26,delay=30,logical=12,mult=32,mux=12,register=2,reinterpret=144,relational=24,scale=8,slice=97,spram=12,sprom=8,}";
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
begin
  pfb_fir_2048ch_core_default_clock_driver : entity xil_defaultlib.pfb_fir_2048ch_core_default_clock_driver 
  port map (
    pfb_fir_2048ch_core_sysclk => clk,
    pfb_fir_2048ch_core_sysce => '1',
    pfb_fir_2048ch_core_sysclr => '0',
    pfb_fir_2048ch_core_clk1 => clk_1_net,
    pfb_fir_2048ch_core_ce1 => ce_1_net
  );
  pfb_fir_2048ch_core_struct : entity xil_defaultlib.pfb_fir_2048ch_core_struct 
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
    sync_out => sync_out
  );
end structural;
