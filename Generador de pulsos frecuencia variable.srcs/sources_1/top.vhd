----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.02.2024 11:11:16
-- Design Name: 
-- Module Name: top - RTL
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( up : in STD_LOGIC;
           up100 : in STD_LOGIC;
           down : in STD_LOGIC;
           down100 : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk100mhz : in STD_LOGIC;
           freq_duty_selector : in STD_LOGIC;
           freq_selector_fixed_clk : in STD_LOGIC_VECTOR (7 downto 0);
           pulse_out : out STD_LOGIC);
end top;

architecture RTL of top is

    component debouncer is 
    port(
        CLK    : in std_logic;
	    btn_in	: in std_logic;
	    btn_out	: out std_logic;
	    reset: in std_logic);
	 end component;
	 
	 component edgedtctr is 
	 port(
	   CLK : in std_logic;       --Entrada del reloj 
       sync_in : in std_logic;   --Entrada síncrona 
       edge : out std_logic;     --Flanco de salida
       reset: in std_logic       --Señal de reset
     );
     end component;
     
     component synchrnzr is
     port(
        clk : in std_logic;
        async_in : in std_logic;
        sync_out : out std_logic;
        reset: in std_logic
     );
     end component;
     
     component fixed_clks is 
     port(
        clk100mhz:in std_logic;
        reset:in std_logic;
        clk100mhz_out:out std_logic;
        clk50mhz: out std_logic;
        clk25mhz: out std_logic;
        clk10mhz: out std_logic;
        clk1mhz: out std_logic;
        clk100kz: out std_logic;
        clk10kz: out std_logic;
        clk1khz:out std_logic 
     );
     end component;
     
     component freq_selector is
     port(
        up10 : in STD_LOGIC;
        up100 : in STD_LOGIC;
        down10 : in STD_LOGIC;
        down100 : in STD_LOGIC;
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        precharge : out STD_LOGIC_VECTOR (19 downto 0)
     );
     end component;
     
     component mux_2_1 is
     port(
        input : in STD_LOGIC_VECTOR (1 downto 0);
        input_select : in STD_LOGIC;
        output : out STD_LOGIC
     );
     end component;
     
     component one_hot_8bit_mux is
     port(
        input : in STD_LOGIC_VECTOR (7 downto 0);
        input_select : in STD_LOGIC_VECTOR (7 downto 0);
        output : out STD_LOGIC
        );
     end component;
     
     component variable_freq_clk is
     port(
        clk100mhz : in STD_LOGIC;
        reset : in STD_LOGIC;
        en: in std_logic;
        precharge: in std_logic_vector(19 downto 0);
        var_clk: out std_logic);
     end component;
     
     component variable_duty_cycle_clk is
     port(
        clk_in : in STD_LOGIC;
        reset : in STD_LOGIC;
        pulse_out : out STD_LOGIC;
        up : in STD_LOGIC;
        down : in STD_LOGIC
     );
     end component;
     
begin


end RTL;
