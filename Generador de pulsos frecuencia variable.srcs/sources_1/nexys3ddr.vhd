library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity nexys3ddr is
    port(   
        JB: out std_logic_vector(7 downto 0);
        reset: in std_logic;
        clk: in std_logic);
end nexys3ddr;

architecture RTL of nexys3ddr is

component pulse_generator is
    port(
        outputs: out std_logic_vector(7 downto 0);
        clk100mhz:in std_logic;
        reset:in std_logic);
end component;

begin

    unit_pulse_generator: pulse_generator
        port map(
            outputs => JB,
            reset => reset,
            clk100mhz => clk);

end RTL;
