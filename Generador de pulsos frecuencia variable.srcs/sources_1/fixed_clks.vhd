library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fixed_clks is
    port(
        up: in std_logic;
        down: in std_logic;
        clk100mhz:in std_logic;
        reset:in std_logic;
        clk100mhz_out:out std_logic;
        clk50mhz: out std_logic;
        clk25mhz: out std_logic;
        clk10mhz: out std_logic;
        clk1mhz: out std_logic;
        clk100kz: out std_logic;
        clk10kz: out std_logic;
        clk1khz:out std_logic);
end fixed_clks;         
        

architecture behavioral of fixed_clks is

constant T1: integer:=1;
constant T2: integer:=2;
constant T3: integer:=50;
constant T4: integer:=500;
constant T5: integer:=5000;
constant T6: integer:=50000;

signal outputs_aux: std_logic_vector(7 downto 0);

signal contador1: integer range 0 to T1;
signal contador2: integer range 0 to T2;
signal contador3: integer range 0 to T3;
signal contador4: integer range 0 to T4;
signal contador5: integer range 0 to T5;
signal contador6: integer range 0 to T6;

begin

    clk_50Mhz:process(clk100mhz, reset)
    begin
        if reset='0' then 
            outputs_aux(1)<='0';
        elsif rising_edge(clk100mhz)then
            outputs_aux(1)<= not outputs_aux(1);
        end if;
    end process;
    
    clk_25MHz:process(clk100mhz, reset)
    begin
        if reset='0' then
            outputs_aux(2)<='0';
            contador1<=T1;  
        elsif rising_edge(clk100mhz) then
            if contador1<=0 then
                outputs_aux(2)<= not outputs_aux(2);
                contador1<=T1;
            else 
                contador1<=contador1-1;
            end if;
        end if; 
    end process;
    
    clk_10MHz:process(clk100mhz, reset)
    begin
        if reset='0' then
            outputs_aux(3)<='0';
            contador2<=T2;  
        elsif rising_edge(clk100mhz) then
            if contador2<=0 then
                outputs_aux(3)<= not outputs_aux(3);
                contador2<=T2;
            else 
                contador2<=contador2-1;
            end if;
        end if; 
   end process; 
    
    clk1_MHz:process(clk100mhz, reset)
    begin
        if reset='0' then
            outputs_aux(4)<='0';
            contador3<=T3; 
        elsif rising_edge(clk100mhz) then
            if contador3<=0 then
                outputs_aux(4)<= not outputs_aux(4);
                contador3<=T3;
            else 
                contador3<=contador3-1;
            end if;
        end if;
    end process; 
        
    clk_100KHz:process(clk100mhz, reset)
    begin
        if reset='0' then
            outputs_aux(5)<='0';
            contador4<=T4; 
        elsif rising_edge(clk100mhz) then
            if contador4<=0 then
                outputs_aux(5)<= not outputs_aux(5);
                contador4<=T4;
            else 
                contador4<=contador4-1;
            end if;
        end if;
    end process;
    
    clk_10KHz:process(clk100mhz, reset)
    begin
        if reset='0' then
            outputs_aux(6)<='0';
            contador5<=T5;  
        elsif rising_edge(clk100mhz) then
            if contador5<=0 then
                outputs_aux(6)<= not outputs_aux(6);
                contador5<=T5;
            else 
                contador5<=contador5-1;
            end if;
        end if;
    end process;
    
    clk_1kHz:process(clk100mhz, reset)
    begin
        if reset='0' then
            outputs_aux(7)<='0';
            contador6<=T6;  
        elsif rising_edge(clk100mhz) then
            if contador6<=0 then
                outputs_aux(7)<= not outputs_aux(7);
                contador6<=T6;
            else 
                contador6<=contador6-1;
            end if;
        end if; 
   end process;                                            

outputs_aux(0)<=clk100mhz when reset='0' else '0';

clk100mhz_out<=outputs_aux(0);
clk50mhz<=outputs_aux(1);
clk25mhz<=outputs_aux(2);
clk10mhz<=outputs_aux(3);
clk1mhz<=outputs_aux(4);
clk100kz<=outputs_aux(5);
clk10kz<=outputs_aux(6);
clk1khz<=outputs_aux(7);
       
end behavioral;
