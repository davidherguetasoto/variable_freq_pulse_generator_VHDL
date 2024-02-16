library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity variable_clk is
    Port ( clk100mhz : in STD_LOGIC;
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
            if en='1' then
                if to_integer(unsigned(counter1))=0  then 
                    out_counter1<=not out_counter1;
                    counter1<='0' & precharge(19 downto 1);
                else
                    counter1<=std_logic_vector(unsigned(counter1)-to_unsigned(1,counter1'length));
                end if;
            end if;
        end if;    
    end process;
    
    count_falling_edge:process(clk100mhz, reset)
    begin
        if reset='0' then 
            counter2<=(others=>'0');
            out_counter2<='0';
        elsif falling_edge(clk100mhz) then
            if en='1' then
                if to_integer(unsigned(counter2))=0 then
                    out_counter2<=not out_counter2;
                    counter2<='0'& precharge(19 downto 1);
                else
                    counter2<=std_logic_vector(unsigned(counter2)-to_unsigned(1,counter2'length));
                end if;
            end if;
        end if;
    end process;

    var_clk<=(out_counter1 xor out_counter2) when to_integer(unsigned(precharge))=0 else (out_counter1 and out_counter2);   

end Behavioral;
