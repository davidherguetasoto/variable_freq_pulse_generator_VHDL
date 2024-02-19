library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity nexys3ddr is
    port(   
        JB: out std_logic_vector(7 downto 0);
        reset: in std_logic;
        btnU: in std_logic;
        btnL: in std_logic;
        btnR: in std_logic;
        btnD: in std_logic;
        clk: in std_logic;
        sw: in std_logic_vector(15 downto 0);
        led: out std_logic_vector(15 downto 0));
end nexys3ddr;

architecture RTL of nexys3ddr is

    component top is
    Port ( input_buttons: in std_logic_vector(3 downto 0);
           reset : in STD_LOGIC;
           clk100mhz : in STD_LOGIC;
           freq_duty_selector : in STD_LOGIC;
           freq_selector_fixed_clk : in STD_LOGIC_VECTOR (7 downto 0);
           pulse_out : out STD_LOGIC);
    end component;
    
    signal not_reset: std_logic;
    
begin

    unit_top: top
        port map(
            input_buttons(0) => btnU,
            input_buttons(1) => btnR,
            input_buttons(2) => btnD,
            input_buttons(3) => btnL,
            reset => not_reset,
            clk100mhz => clk,
            freq_duty_selector => sw(0), 
            freq_selector_fixed_clk => sw(15 downto 8),
            pulse_out => JB(0));

    led<=sw;
    not_reset<= not reset;
    
end RTL;
