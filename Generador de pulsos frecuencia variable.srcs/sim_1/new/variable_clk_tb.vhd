library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity variable_clk_tb is
--  Port ( );
end variable_clk_tb;

architecture Testbench of variable_clk_tb is

    component variable_clk is
    port(
        clk100mhz : in STD_LOGIC;
        up : in STD_LOGIC;
        up100: in std_logic;
        down : in STD_LOGIC;
        down100: in std_logic;
        reset : in STD_LOGIC;
        en:in std_logic;
        var_clk: out std_logic);
    end component;
    
 signal clk100mhz: std_logic;
 signal up:std_logic;
 signal up100:std_logic;
 signal down: std_logic;
 signal down100: std_logic;
 signal reset:std_logic;
 signal var_clk:std_logic;
 signal enable: std_logic;
 
 constant Tclk: time:=1ns;

begin

    unit_variable_clock: variable_clk
        port map(
            clk100mhz => clk100mhz,
            up => up,
            up100 => up100,
            down => down100,
            down100 => down100,
            reset => reset,
            en => enable,
            var_clk => var_clk);        
    
    reset<= '0', '1' after 10ns; 
    
    --clock generation   
    process
    begin
        clk100mhz<='1';
        wait for Tclk/2;
        clk100mhz<='0';
        wait for Tclk/2;
    end process;
    
    --input generation
    process    
    begin
        down<='0';
        down100<='0';
        up<='0';
        up100<='0';
        enable<='0';
        wait for 10ns;
        up100<='1';
        wait for Tclk*1000;
        up100<='0';
        enable<='1';
        wait for Tclk*10;
        down100<='1';
        wait for Tclk;
        down100<='0';
        wait for Tclk*5;
        up<='1';
        wait for Tclk;
        up<='0';
        wait for 100*Tclk;
        down<='1';
        wait for Tclk;
        down<='0';
        wait for 100*Tclk;
        up100<='1';
        wait for Tclk;
        up100<='0';
        wait for 1000*Tclk;
        down100<='1';
        wait for Tclk;
        down100<='0';
        enable<='0';  
        wait;
    end process;

end Testbench;
