VHDL description of a variable pulse generator.
The code describes a variable frequency or duty cycle pulse generator. The user can select which one use with the input freq_duty_selector.
If the variable duty cycle pulse is selected, the user can also choose the desired frequency of the pulsed train between a selection of fixed frequencies. 
The user can choose them with the freq_selector_fixed input.
The freq of the pulse train will be 1/10 of the selected input clk
If the variable frequency pulse train is selected, the user must activate the input freq_selector_fixed input(0) to enable the clock.

The generator has been designed for a 100mhz input clk.

The code has been implemented an tested on a Basys3 FPGA development board.

The source VHDL code is placed on the .src folder 
