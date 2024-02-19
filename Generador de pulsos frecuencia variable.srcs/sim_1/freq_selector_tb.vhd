library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_selector_tb is
--  Port ( );
end freq_selector_tb;

architecture testbench of freq_selector_tb is

    component freq_selector is 
        port(
            up10 : in STD_LOGIC;
           up100 : in STD_LOGIC;
           down10 : in STD_LOGIC;
           down100 : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           precharge : out STD_LOGIC_VECTOR (19 downto 0));
        end component;

    signal up10: std_logic;
    signal up100: std_logic;
    signal down10:std_logic;
    signal down100:std_logic;
    signal clk:std_logic;
    signal reset:std_logic;
    signal precharge: std_logic_vector(19 downto 0);
    
    constant Tclk:time:=1ns;
    
begin
    
    inst_freq_selector: freq_selector
        port map(
            up10 => up10,
            up100 => up100,
            down10 => down10,
            down100 => down100,
            clk => clk,
            reset => reset,
            precharge => precharge);
            
      process
      begin
        clk<='1';
        wait for Tclk/2;
        clk<='0';
        wait for Tclk/2;
      end process;
      
      reset<='0', '1' after 5ns;
      
      process
      begin
        up10<='0';
        up100<='0';
        down10<='0';
        down100<='0';
        wait for 10ns;
        up10<='1';
        wait for 5*Tclk;
        up10<='0';
        down10<='1';
        wait for 5*Tclk;
        down10<='0';
        up10<='1';
        wait for 5*Tclk;
        up10<='0';
        down100<='1';
        wait for 5*Tclk;
        down100<='0';
        up100<='1';
        wait for 5*Tclk;
        up100<='0';
        down100<='1';
        --down10<='1';
        wait;   
     end process;

end testbench;
