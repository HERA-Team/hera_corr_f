  sysgen_dut : entity xil_defaultlib.fft_2048ch_6a_core 
  port map (
    pol0_in0 => pol0_in0,
    pol0_in1 => pol0_in1,
    pol1_in0 => pol1_in0,
    pol1_in1 => pol1_in1,
    pol2_in0 => pol2_in0,
    pol2_in1 => pol2_in1,
    pol3_in0 => pol3_in0,
    pol3_in1 => pol3_in1,
    pol4_in0 => pol4_in0,
    pol4_in1 => pol4_in1,
    pol5_in0 => pol5_in0,
    pol5_in1 => pol5_in1,
    shift => shift,
    sync => sync,
    clk => clk,
    out0 => out0,
    out1 => out1,
    out2 => out2,
    out3 => out3,
    out4 => out4,
    out5 => out5,
    overflow => overflow,
    sync_out => sync_out
  );
