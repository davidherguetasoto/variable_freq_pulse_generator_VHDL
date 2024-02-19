library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
--  Port ( );
end top_tb;

architecture Testbench of top_tb is

    component top is 
    port(
        input_buttons: in std_logic_vector(5 downto 0);
        reset : in STD_LOGIC;
        clk100mhz : in STD_LOGIC;
        freq_duty_selector : in STD_LOGIC;
        freq_selector_fixed_clk : in STD_LOGIC_VECTOR (7 downto 0);
        pulse_out : out STD_LOGIC;
        fixed_clk_out: out std_logic);
    end component;
    
    signal button_up:std_logic;
    signal button_down:std_logic;
    signal button_left:std_logic;
    signal button_right:std_logic;
    
    signal sw_freq_duty_selector: std_logic;
    signal sw_freq_selector: std_logic_vector(7 downto 0);
    
    signal clk:std_logic;
    signal reset: std_logic;
    
    signal pulse_out: std_logic;
    signal fixed_clk_out:std_logic;
    
    constant Tclk:time:=1ns;

begin
    
    inst_top: top port map(
        input_buttons(0) => button_up,
        input_buttons(1) => button_right,
        input_buttons(2) => button_down,
        input_buttons(3) => button_left,
        input_buttons(4)=> button_up,
        input_buttons(5) => button_down,
        reset => reset,
        clk100mhz => clk,
        freq_duty_selector => sw_freq_duty_selector,
        freq_selector_fixed_clk => sw_freq_selector,
        pulse_out => pulse_out,
        fixed_clk_out => fixed_clk_out);
        
     process
     begin
        clk<='1';
        wait for Tclk/2;
        clk<='0';
        wait for Tclk/2;
     end process;
     
     reset<= '0', '1' after 10ns;
     
     --TEST VARIABLE DUTY CYCLE CLK 
     process
     begin
        button_down<='0';
        button_up<='0';
        button_left<='0';
        button_right<='0';
        sw_freq_duty_selector<='0';
        sw_freq_selector<=(others=>'0');
        wait for 20ns;
        
        sw_freq_duty_selector<='1';
        sw_freq_selector<="00000001";
        wait for 5*Tclk;
        
        button_up<='1';
        wait for Tclk;
        button_up<='0';
        wait for 5*Tclk;
        button_up<='1';
        wait for Tclk;
        button_up<='0';
        wait for 20*Tclk;
        button_up<='1';
        wait for Tclk;
        button_up<='0';
        wait for 20*Tclk;
        button_up<='1';
        wait for Tclk;
        button_up<='0';
        wait for 20*Tclk;
        button_up<='1';
        wait for Tclk;
        button_up<='0';
        wait for 20*Tclk;
        sw_freq_selector<="00001000";
        button_down<='1';
        wait for 5*Tclk;
        button_down<='0';
        wait for 50*Tclk;
        button_down<='1';
        wait for 4*Tclk;
        button_down<='0';
        wait;
    end process;

end Testbench;
