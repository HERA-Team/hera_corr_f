
################################################################
# This is a generated script based on design: fft_2048ch_6a_core_bd
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2014.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source fft_2048ch_6a_core_bd_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7k160tffg676-2


# CHANGE DESIGN NAME HERE
set design_name fft_2048ch_6a_core_bd

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set clk [ create_bd_port -dir I -type clk clk ]
  set out0 [ create_bd_port -dir O -from 35 -to 0 -type data out0 ]
  set out1 [ create_bd_port -dir O -from 35 -to 0 -type data out1 ]
  set out2 [ create_bd_port -dir O -from 35 -to 0 -type data out2 ]
  set out3 [ create_bd_port -dir O -from 35 -to 0 -type data out3 ]
  set out4 [ create_bd_port -dir O -from 35 -to 0 -type data out4 ]
  set out5 [ create_bd_port -dir O -from 35 -to 0 -type data out5 ]
  set overflow [ create_bd_port -dir O -from 5 -to 0 -type data overflow ]
  set pol0_in0 [ create_bd_port -dir I -from 17 -to 0 -type data pol0_in0 ]
  set pol0_in1 [ create_bd_port -dir I -from 17 -to 0 -type data pol0_in1 ]
  set pol1_in0 [ create_bd_port -dir I -from 17 -to 0 -type data pol1_in0 ]
  set pol1_in1 [ create_bd_port -dir I -from 17 -to 0 -type data pol1_in1 ]
  set pol2_in0 [ create_bd_port -dir I -from 17 -to 0 -type data pol2_in0 ]
  set pol2_in1 [ create_bd_port -dir I -from 17 -to 0 -type data pol2_in1 ]
  set pol3_in0 [ create_bd_port -dir I -from 17 -to 0 -type data pol3_in0 ]
  set pol3_in1 [ create_bd_port -dir I -from 17 -to 0 -type data pol3_in1 ]
  set pol4_in0 [ create_bd_port -dir I -from 17 -to 0 -type data pol4_in0 ]
  set pol4_in1 [ create_bd_port -dir I -from 17 -to 0 -type data pol4_in1 ]
  set pol5_in0 [ create_bd_port -dir I -from 17 -to 0 -type data pol5_in0 ]
  set pol5_in1 [ create_bd_port -dir I -from 17 -to 0 -type data pol5_in1 ]
  set shift [ create_bd_port -dir I -from 15 -to 0 -type data shift ]
  set sync [ create_bd_port -dir I -from 31 -to 0 -type data sync ]
  set sync_out [ create_bd_port -dir O -from 0 -to 0 -type data sync_out ]

  # Create instance: fft_2048ch_6a_core_1, and set properties
  set fft_2048ch_6a_core_1 [ create_bd_cell -type ip -vlnv User_Company:SysGen:fft_2048ch_6a_core:1.0 fft_2048ch_6a_core_1 ]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins fft_2048ch_6a_core_1/clk]
  connect_bd_net -net fft_2048ch_6a_core_1_out0 [get_bd_ports out0] [get_bd_pins fft_2048ch_6a_core_1/out0]
  connect_bd_net -net fft_2048ch_6a_core_1_out1 [get_bd_ports out1] [get_bd_pins fft_2048ch_6a_core_1/out1]
  connect_bd_net -net fft_2048ch_6a_core_1_out2 [get_bd_ports out2] [get_bd_pins fft_2048ch_6a_core_1/out2]
  connect_bd_net -net fft_2048ch_6a_core_1_out3 [get_bd_ports out3] [get_bd_pins fft_2048ch_6a_core_1/out3]
  connect_bd_net -net fft_2048ch_6a_core_1_out4 [get_bd_ports out4] [get_bd_pins fft_2048ch_6a_core_1/out4]
  connect_bd_net -net fft_2048ch_6a_core_1_out5 [get_bd_ports out5] [get_bd_pins fft_2048ch_6a_core_1/out5]
  connect_bd_net -net fft_2048ch_6a_core_1_overflow [get_bd_ports overflow] [get_bd_pins fft_2048ch_6a_core_1/overflow]
  connect_bd_net -net fft_2048ch_6a_core_1_sync_out [get_bd_ports sync_out] [get_bd_pins fft_2048ch_6a_core_1/sync_out]
  connect_bd_net -net pol0_in0_1 [get_bd_ports pol0_in0] [get_bd_pins fft_2048ch_6a_core_1/pol0_in0]
  connect_bd_net -net pol0_in1_1 [get_bd_ports pol0_in1] [get_bd_pins fft_2048ch_6a_core_1/pol0_in1]
  connect_bd_net -net pol1_in0_1 [get_bd_ports pol1_in0] [get_bd_pins fft_2048ch_6a_core_1/pol1_in0]
  connect_bd_net -net pol1_in1_1 [get_bd_ports pol1_in1] [get_bd_pins fft_2048ch_6a_core_1/pol1_in1]
  connect_bd_net -net pol2_in0_1 [get_bd_ports pol2_in0] [get_bd_pins fft_2048ch_6a_core_1/pol2_in0]
  connect_bd_net -net pol2_in1_1 [get_bd_ports pol2_in1] [get_bd_pins fft_2048ch_6a_core_1/pol2_in1]
  connect_bd_net -net pol3_in0_1 [get_bd_ports pol3_in0] [get_bd_pins fft_2048ch_6a_core_1/pol3_in0]
  connect_bd_net -net pol3_in1_1 [get_bd_ports pol3_in1] [get_bd_pins fft_2048ch_6a_core_1/pol3_in1]
  connect_bd_net -net pol4_in0_1 [get_bd_ports pol4_in0] [get_bd_pins fft_2048ch_6a_core_1/pol4_in0]
  connect_bd_net -net pol4_in1_1 [get_bd_ports pol4_in1] [get_bd_pins fft_2048ch_6a_core_1/pol4_in1]
  connect_bd_net -net pol5_in0_1 [get_bd_ports pol5_in0] [get_bd_pins fft_2048ch_6a_core_1/pol5_in0]
  connect_bd_net -net pol5_in1_1 [get_bd_ports pol5_in1] [get_bd_pins fft_2048ch_6a_core_1/pol5_in1]
  connect_bd_net -net shift_1 [get_bd_ports shift] [get_bd_pins fft_2048ch_6a_core_1/shift]
  connect_bd_net -net sync_1 [get_bd_ports sync] [get_bd_pins fft_2048ch_6a_core_1/sync]

  # Create address segments
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


