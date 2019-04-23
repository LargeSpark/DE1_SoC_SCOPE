set_global_assignment -entity "ADA" -library "lib_ADA" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "ADA" -library "lib_ADA" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "ADA" -library "lib_ADA" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_ADA" -name SPD_FILE [file join $::quartus(sip_path) "../ADA.spd"]
set_global_assignment -library "lib_ADA" -name MISC_FILE [file join $::quartus(sip_path) "../../ADA.qsys"]

set_global_assignment -library "lib_ADA" -name MISC_FILE [file join $::quartus(sip_path) "ADA.v"]
set_global_assignment -library "lib_ADA" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_avalon_adv_adc.v"]
set_global_assignment -library "lib_ADA" -name MISC_FILE [file join $::quartus(sip_path) "submodules/ADA_adc_mega_0.v"]
