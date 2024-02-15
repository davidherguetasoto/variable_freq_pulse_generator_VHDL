library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fixed_clks_tb is
--  Port ( );
end fixed_clks_tb;

architecture testbench of fixed_clks_tb is
    
    component fixed_clks is
        port(
        outputs: out std_logic_vector(7 downto 0);
        clk100mhz:in std_logic;
        reset:in std_logic);
    end component;
    
    signal clk100mhz: std_logic;
    signal outputs: std_logic_vector(7 downto 0);
    signal reset: std_logic;
    
    constant Tclk: time :=1ns;
begin
    unit_top: fixed_clks
        port map(
            clk100mhz=>clk100mhz,
            reset=>reset,
            outputs=>outputs);                     
    
    reset <= '1', '0' after 20ns;
    process
        begin
            clk100mhz<='1';
            wait for Tclk/2;
            clk100mhz<='0'; 
            wait for Tclk/2;
        end process;

end testbench;
