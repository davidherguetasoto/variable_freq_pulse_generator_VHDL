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

    signal reg_out:std_logic_vector(9 downto 0);
    signal index:integer range 0 to 9;
    
    type state is (ResetState, MoveVector,Increment,Decrement);
    signal next_state:state;
    signal present_state:state;

begin

     STATE_UPDATE:process(clk_in,reset)
     begin
        if reset='0' then 
            present_state<=ResetState;
        elsif rising_edge(clk_in) then 
            present_state<=next_state;
        end if;
     end process;
     
     STATE_TRANSITIONS:process(up,down,index)
     begin 
        case present_state is 
            when ResetState=> 
                
           
            when MoveVector=> 
                
                
            when Increment=> 
                
                
           when Decrement => 
                
        end case;
    end process; 
    
    OUTPUT_GENERATION: process(present_state)
    begin
        case present_state is 
            when ResetState => 
                index<=reg_out'left;
                reg_out<="1000000000";
            
            when MoveVector => 
                reg_out <= reg_out(reg_out'left-1 downto 0)&reg_out(reg_out'left);
                if index<9 then
                    index<=index+1;
                else 
                    index<=0;
                end if;
            
            when Increment => 
            
            when Decrement => 
                index <= index -1;
                
         
                 
                    
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

    
    pulse_out<=reg1(9); --and output2;

end Behavioral;
