set_property PACKAGE_PIN W5 [get_ports clk_100Mhz]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk_100Mhz]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]
	
set_property PACKAGE_PIN U18 [get_ports reset_time]						
	set_property IOSTANDARD LVCMOS33 [get_ports reset_time]

set_property PACKAGE_PIN V17 [get_ports {switch_ch[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {switch_ch[0]}]
set_property PACKAGE_PIN V16 [get_ports {switch_ch[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {switch_ch[1]}]
set_property PACKAGE_PIN W16 [get_ports {switch_ch[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {switch_ch[2]}]
set_property PACKAGE_PIN W17 [get_ports {switch_ch[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {switch_ch[3]}]
	
set_property PACKAGE_PIN J1 [get_ports {final_PWM}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {final_PWM}]