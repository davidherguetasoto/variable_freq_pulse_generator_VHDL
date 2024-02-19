library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1 is
    Port ( input : in STD_LOGIC_VECTOR (1 downto 0);
           input_select : in STD_LOGIC;
           output : out STD_LOGIC);
end mux_2_1;

architecture RTL of mux_2_1 is

begin

    output <= input(0) when input_select='0' else
              input(1) when input_select='1' else
              '0';

end RTL;
