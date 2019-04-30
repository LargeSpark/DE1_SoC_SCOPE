set_global_assignment -entity "ADCV2" -library "lib_ADCV2" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "ADCV2" -library "lib_ADCV2" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "ADCV2" -library "lib_ADCV2" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_ADCV2" -name SPD_FILE [file join $::quartus(sip_path) "../ADCV2.spd"]
set_global_assignment -library "lib_ADCV2" -name MISC_FILE [file join $::quartus(sip_path) "../../ADCV2.qsys"]

set_global_assignment -library "lib_ADCV2" -name MISC_FILE [file join $::quartus(sip_path) "ADCV2.v"]
set_global_assignment -library "lib_ADCV2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_avalon_adv_adc.v"]
set_global_assignment -library "lib_ADCV2" -name MISC_FILE [file join $::quartus(sip_path) "submodules/ADCV2_adc_mega_0.v"]
