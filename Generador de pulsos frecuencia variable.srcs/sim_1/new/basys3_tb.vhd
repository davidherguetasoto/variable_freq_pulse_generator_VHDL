library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity basys3_tb is
--  Port ( );
end basys3_tb;

architecture Testbench of basys3_tb is

    component basys3 is 
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
   end component;
   
   signal JB: std_logic_vector(7 downto 0);
   signal clk:std_logic;
   signal reset: std_logic;
   signal btnU:std_logic;
   signal btnD:std_logic;
   signal btnL:std_logic;
   signal btnR:std_logic;
   signal sw:std_logic_vector(15 downto 0);
   
   constant Tclk:time:=1ns;

begin
    
    inst_basys3:basys3 port map(
        JB => JB,
        clk => clk,
        reset => reset,
        sw => sw,
        led => open,
        btnU => btnU,
        btnD => btnD,
        btnL => btnL,
        btnR => btnR);
    
    reset <= '1','0' after 10ns;
    
    process
    begin 
        clk<='0';
        wait for Tclk/2;
        clk<='1';
        wait for Tclk/2;
    end process;
    
    process
    begin
        btnD<='0';
        btnL<='0';
        btnR<='0';
        btnU<='0';
        sw<= (others=>'0');
        wait for 20ns;
        
        sw(0)<='1';
        sw(8)<='1';
        wait for 5*Tclk;
        btnU<='1';
        wait for 1000ns;
        btnU<='0';
        wait for 100*Tclk;
        btnU<='1';
        wait for 1000ns;
        btnU<='0';
        wait for 100*Tclk;
        btnU<='1';
        wait for 1000ns;
        btnU<='0';
        wait for 100*Tclk;
        btnU<='1';
        wait for 1000ns;
        btnU<='0';
        wait for 100*Tclk;
        wait;
    end process;

end Testbench;
