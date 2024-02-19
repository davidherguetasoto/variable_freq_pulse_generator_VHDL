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

    signal reg1:std_logic_vector(9 downto 0);
    signal output1:std_logic;
    signal index1:integer range 1 to 9;
    signal index_out1:integer range 1 to 9;

--FOR HALF WIDTH PULSES    
--    signal reg2:std_logic_vector(9 downto 0);
--    signal output2:std_logic;
--    signal index2:integer range 1 to 9;
--    signal index_out2:integer range 1 to 9;

begin

    output_generation:process(clk_in,reset)
    begin
        if reset='0' then 
            reg1<="1000000000";
            output1<='0';
            index1<=reg1'left;
            index_out1<=reg1'left;
        elsif clk_in'event and clk_in='1' then 
            if up='1' and index1>0 then
                reg1(index1)<='1';
                index1<=index1-1;
                index_out1<=reg1'left;
            elsif down='1' and index1<reg1'left then 
                reg1(index1)<='0';
                index1<=index1+1;
                index_out1<=reg1'left;
            else 
                if index_out1>0 then 
                    output1<=reg1(index_out1);
                    index_out1<=index_out1-1;
                else
                    output1<=reg1(index_out1);
                    index_out1<=reg1'left;
                end if;
            end if;  
        end if;
    end process;

--FOR HALF WIDHT PULSES   
--    output_generation2:process(clk_in,reset)
--    begin
--        if reset='0' then 
--            reg2<="1000000000";
--            output2<='0';
--            index2<=reg2'left;
--            index_out2<=reg2'left;
--        elsif clk_in'event and clk_in='0' then 
--            if up='1' and index2>0 then
--                reg2(index2)<='1';
--                index2<=index2-1;
--                index_out2<=reg2'left;
--            elsif down='1' and index2<reg2'left then 
--                reg2(index2)<='0';
--                index2<=index2+1;
--                index_out2<=reg2'left;
--            else 
--                if index_out2>0 then 
--                    output2<=reg2(index_out2);
--                    index_out2<=index_out2-1;
--                else
--                    output2<=reg2(index_out2);
--                    index_out2<=reg2'left;
--                end if; 
--            end if;  
--        end if;
--    end process;
    
    pulse_out<=output1; --and output2;

end Behavioral;
