library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity freq_selector is
    Port ( up10 : in STD_LOGIC;
           up100 : in STD_LOGIC;
           down10 : in STD_LOGIC;
           down100 : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           precharge : out STD_LOGIC_VECTOR (19 downto 0));
end freq_selector;

architecture Behavioral of freq_selector is
    
    signal precharge_reg: std_logic_vector(19 downto 0);
    signal not_up10: std_logic;
    signal not_up100: std_logic;
    signal not_down10:std_logic;
    signal not_down100:std_logic;   
    
begin
    
    process(clk, reset)
    begin
        if reset='0' then
            precharge_reg <= (others=>'0');
        elsif clk'event and clk='1' then 
            if up10='1' then
                if not_up10='0' then
                    precharge_reg<=std_logic_vector(unsigned(precharge_reg)-to_unsigned(10,precharge_reg'length));
                end if;
            elsif up100='1' then
               if not_up100='0' then
                    precharge_reg<=std_logic_vector(unsigned(precharge_reg)-to_unsigned(100,precharge_reg'length));
                end if;
            elsif down10='1' then
                if not_down10='0' then
                    precharge_reg<=std_logic_vector(unsigned(precharge_reg)+to_unsigned(10,precharge_reg'length));
                end if;
            elsif down100='1' then 
                if not_down100='0' then
                    precharge_reg<=std_logic_vector(unsigned(precharge_reg)+to_unsigned(100,precharge_reg'length));
                end if;
            end if;
       end if;
    end process;
    
    not_up10<='0' when to_integer(unsigned(precharge_reg))>=10 else '1';
    not_up100<='0' when to_integer(unsigned(precharge_reg))>=100 else '1';
    not_down10<='0' when to_integer(unsigned(precharge_reg))<=999990 else '1';
    not_down100<='0' when to_integer(unsigned(precharge_reg))<=999900 else '1';
    
    precharge<=precharge_reg;           

end Behavioral;
