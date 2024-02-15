library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity variable_clk is
    Port ( clk100mhz : in STD_LOGIC;
           up : in STD_LOGIC;
           up100: in std_logic;
           down : in STD_LOGIC;
           down100: in std_logic;
           reset : in STD_LOGIC;
           en: in std_logic;
           precharge: in std_logic_vector(19 downto 0);
           var_clk: out std_logic);
end variable_clk;

architecture Behavioral of variable_clk is

    signal counter1: std_logic_vector(19 downto 0);
    signal counter2: std_logic_vector(19 downto 0);
    signal out_counter1: std_logic;
    signal out_counter2: std_logic;

begin

    count_rising_edge:process(clk100mhz, reset)
    begin
        if reset='0' then 
            counter1<=(others=>'0');
            out_counter1<='0';
        elsif rising_edge(clk100mhz) then
        
        end if;    
    end process;
    
    count_falling_edge:process(clk100mhz, reset)
    begin
        if reset='0' then 
            counter2<=(others=>'0');
            out_counter2<='0';
        elsif falling_edge(clk100mhz) then
            if counter2=(others=>'0') then
                out_counter2<=not out_counter2;
                counter2<=(precharge slr 1);
            else
                counter2<=unsigned(counter2)-to_unsigned(1);
            end if;
        
        end if;
    end process;

    var_clk<=out_counter1 and out_counter2;   

end Behavioral;
