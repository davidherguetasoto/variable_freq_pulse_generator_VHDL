library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity duty_cycle_select is
    Port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_out : out STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC);
end duty_cycle_select;

architecture Behavioral of duty_cycle_select is

    signal reg:std_logic_vector(9 downto 0);
    signal output:std_logic;
    signal index:integer range 1 to 9;

begin

    output_generation:process(clk_in,reset)
    begin
        if reset='0' then 
            reg<="1000000000";
            output<='0';
            index<=reg'left-1;
        elsif clk_in'event and clk_in='1' then 
            output<=reg(9);
            reg<=reg(8 downto 0)&reg(9);
        end if;
    end process;
    
    duty_cycle_variation:process(clk_in,reset)
    begin
        if reset='0' then 
            
        elsif clk_in'event and clk_in='1' then 
            if up='1' and index<reg'left-1 then
                reg(index)<='1';
                index<=index+1;
            elsif down='1' and index>0 then 
                reg(index)<='0';
                index<=index-1;
            end if;
       end if;
    end process;
    
    pulse_out<=output;

end Behavioral;
