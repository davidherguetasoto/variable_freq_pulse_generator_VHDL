library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity one_hot_8bit_mux is
    Port ( input : in STD_LOGIC_VECTOR (7 downto 0);
           input_select : in STD_LOGIC_VECTOR (7 downto 0);
           output : out STD_LOGIC);
end one_hot_8bit_mux;

architecture RTL of one_hot_8bit_mux is

begin
    output<=input(0)when input_select="00000001" else
            input(1)when input_select="00000010" else
            input(2)when input_select="00000100" else
            input(3)when input_select="00001000" else
            input(4)when input_select="00010000" else 
            input(5)when input_select="00100000" else
            input(6)when input_select="01000000" else 
            input(7)when input_select="10000000" else 
            '0';
end RTL;
