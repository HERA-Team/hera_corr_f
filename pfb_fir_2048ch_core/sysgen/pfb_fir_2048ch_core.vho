  sysgen_dut : entity xil_defaultlib.pfb_fir_2048ch_core 
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
    clk => clk,
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
