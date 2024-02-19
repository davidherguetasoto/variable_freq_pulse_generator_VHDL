library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity variable_freq_clk_tb is
--  Port ( );
end variable_freq_clk_tb;

architecture Testbench of variable_freq_clk_tb is

    component variable_freq_clk is
    port(
        clk100mhz : in STD_LOGIC;
        reset : in STD_LOGIC;
        en:in std_logic;
        precharge: in std_logic_vector(19 downto 0);
        var_clk: out std_logic);
    end component;
    
 signal clk100mhz: std_logic;
 signal precharge: std_logic_vector(19 downto 0);
 signal reset:std_logic;
 signal var_clk:std_logic;
 signal enable: std_logic;
 
 constant Tclk: time:=1ns;

begin

    unit_variable_clock: variable_freq_clk
        port map(
            clk100mhz => clk100mhz,
            precharge => precharge,
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
        precharge<=(others=>'0');
        enable<='0';
        wait for 20ns;
        enable<='1';
        wait for 5ns;
        precharge<=std_logic_vector(to_unsigned(2,precharge'length));
        wait for 10ns;
        precharge<=std_logic_vector(to_unsigned(5,precharge'length));
        wait for 50ns;
        precharge<=std_logic_vector(to_unsigned(100,precharge'length));
        wait for 5000ns;
        precharge<=std_logic_vector(to_unsigned(1000,precharge'length));
        wait for 50000ns;
        precharge<=std_logic_vector(to_unsigned(10000,precharge'length));
        wait for 0.05ms;
        precharge<=std_logic_vector(to_unsigned(100000,precharge'length));
        wait for 0.5ms;
        precharge<=std_logic_vector(to_unsigned(1000000,precharge'length));
        wait for 5ms;
        precharge<=(others=>'0');
        wait for 5ns;
        enable<='0';
        wait;
    end process;

end Testbench;
