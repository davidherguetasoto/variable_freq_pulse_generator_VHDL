library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity variable_duty_cycle_clk_tb is
--  Port ( );
end variable_duty_cycle_clk_tb;

architecture Testbench of variable_duty_cycle_clk_tb is

    component variable_duty_cycle_clk is 
        port(
            clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_out : out STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC);
    end component;
    
    signal clk:std_logic;
    signal reset:std_logic;
    signal pulse_out:std_logic;
    signal up: std_logic;
    signal down: std_logic;
    
    constant Tclk:time:=1ns;
    
begin
    
    inst_duty_cycle_select:variable_duty_cycle_clk
    port map(
        clk_in => clk,
        reset => reset,
        pulse_out => pulse_out,
        up => up,
        down => down);
        
    process
    begin 
        clk<='1';
        wait for Tclk/2;
        clk<='0';
        wait for Tclk/2;
    end process;
    
    reset<='0', '1' after 5*Tclk;
    
    process
    begin
        up<='0';
        down<='0';
        wait for Tclk*20;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 30*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 15*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait;
    end process;

end Testbench;
