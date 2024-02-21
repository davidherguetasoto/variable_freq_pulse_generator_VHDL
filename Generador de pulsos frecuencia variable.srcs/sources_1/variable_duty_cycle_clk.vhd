library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity variable_duty_cycle_clk is
    Port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_out : out STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC);
end variable_duty_cycle_clk;

architecture Behavioral of variable_duty_cycle_clk is

    signal duty_cycle : integer range 0 to 10;
    signal counter : integer;

begin

     process(clk_in, reset, up, down)
    begin
        if reset = '0' then
            duty_cycle <= 0;
        elsif rising_edge(clk_in) then
            if up = '1' and duty_cycle < 8 then
                duty_cycle <= duty_cycle + 1;
            elsif down = '1' and duty_cycle > 0 then
                duty_cycle <= duty_cycle - 1;
            end if;
        end if;
    end process;

    process(clk_in, reset)
    begin
        if reset = '0' then
            pulse_out <= '0';  
            counter <= 0;     
        elsif rising_edge(clk_in) then
            if counter < 9 then
                counter <= counter + 1; 
                if counter <= duty_cycle then
                    pulse_out <= '1';
                else
                    pulse_out <= '0';
                end if;
            else
                counter <= 0;
            end if;
        end if;
    end process;

                    
--    output_generation:process(clk_in,reset)
--    begin
--        if reset='0' then 
--            reg1<="1000000000";
--            output1<='0';
--            index1<=reg1'left;
--            index_out1<=reg1'left;
--        elsif clk_in'event and clk_in='1' then 
--            if up='1' and index1>0 then
--                reg1(index1)<='1';
--                index1<=index1-1;
--                index_out1<=reg1'left;
--            elsif down='1' and index1<reg1'left then 
--                reg1(index1)<='0';
--                index1<=index1+1;
--                index_out1<=reg1'left;
--            else 
--                if index_out1>0 then 
--                    output1<=reg1(index_out1);
--                    index_out1<=index_out1-1;
--                else
--                    output1<=reg1(index_out1);
--                    index_out1<=reg1'left;
--                end if;
--            end if;  
--        end if;
--    end process;

   

end Behavioral;
