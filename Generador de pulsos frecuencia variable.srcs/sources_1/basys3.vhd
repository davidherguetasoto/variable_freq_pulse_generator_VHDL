library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity basys3 is
    port(   
        JB: out std_logic_vector(7 downto 0);
        reset: in std_logic;
        btnU: in std_logic;
        btnL: in std_logic;
        btnR: in std_logic;
        btnD: in std_logic;
        clk: in std_logic;
        sw: in std_logic_vector(15 downto 0);
        led: out std_logic_vector(15 downto 0));
end basys3;

architecture RTL of basys3 is

    component debouncer is 
    port(
        CLK    : in std_logic;
	    btn_in	: in std_logic;
	    btn_out	: out std_logic;
	    reset: in std_logic);
	 end component;
	 
	 component edgedtctr is 
	 port(
	   CLK : in std_logic;       --Entrada del reloj 
       sync_in : in std_logic;   --Entrada síncrona 
       edge : out std_logic;     --Flanco de salida
       reset: in std_logic       --Señal de reset
     );
     end component;
     
     component synchrnzr is
     port(
        clk : in std_logic;
        async_in : in std_logic;
        sync_out : out std_logic;
        reset: in std_logic
     );
     end component;

    component top is
    Port ( input_buttons: in std_logic_vector(5 downto 0);
           reset : in STD_LOGIC;
           clk100mhz : in STD_LOGIC;
           freq_duty_selector : in STD_LOGIC;
           freq_selector_fixed_clk : in STD_LOGIC_VECTOR (7 downto 0);
           pulse_out : out STD_LOGIC;
           fixed_clk_out: out std_logic);
    end component;
    
    signal not_reset: std_logic;
    signal input_buttons: std_logic_vector(5 downto 0);
    signal synchr_out: std_logic_vector(5 downto 0);
    signal deb_out:std_logic_vector(5 downto 0);
    signal edge_out:std_logic_vector(5 downto 0);
    signal fixed_clk_in:std_logic;
    
begin
    
    input_buttons(0)<=btnU;
    input_buttons(1)<=btnR;
    input_buttons(2)<=btnD;
    input_buttons(3)<=btnL;
    input_buttons(4)<=btnU;
    input_buttons(5)<=btnD;
    
    input_buttons_conditioning_100mhz: for i in 0 to 3 generate
    inst_synchrnyzr: SYNCHRNZR port map(
                            clk=>clk,
                            async_in=>input_buttons(i),
                            sync_out=>synchr_out(i),
                            reset=>reset);
                            
    inst_debouncer: DEBOUNCER port map(
                            CLK=>clk,
                            btn_in=>synchr_out(i),
                            btn_out=>deb_out(i),
                            reset=>reset);
                            
    inst_edgedtctr: EDGEDTCTR port map(
                            CLK=>clk,
                            sync_in=>deb_out(i),
                            edge=>edge_out(i),
                            reset=>reset);
    end generate input_buttons_conditioning_100mhz;
    
    input_buttons_conditioning_fixed_clk: for i in 4 to 5 generate
    inst_synchrnyzr: SYNCHRNZR port map(
                            clk=>fixed_clk_in,
                            async_in=>input_buttons(0),
                            sync_out=>synchr_out(i),
                            reset=>reset);
                            
    inst_debouncer: DEBOUNCER port map(
                            CLK=>fixed_clk_in,
                            btn_in=>synchr_out(i),
                            btn_out=>deb_out(i),
                            reset=>reset);
                            
    inst_edgedtctr: EDGEDTCTR port map(
                            CLK=> fixed_clk_in,
                            sync_in=>deb_out(i),
                            edge=>edge_out(i),
                            reset=>reset);
    end generate input_buttons_conditioning_fixed_clk;
    
    unit_top: top
        port map(
            input_buttons(0) => edge_out(0),
            input_buttons(1) => edge_out(1),
            input_buttons(2) => edge_out(2),
            input_buttons(3) => edge_out(3),
            input_buttons(4) => edge_out(4),
            input_buttons(5) => edge_out(5),
            reset => not_reset,
            clk100mhz => clk,
            freq_duty_selector => sw(0), 
            freq_selector_fixed_clk => sw(15 downto 8),
            pulse_out => JB(0));

    led<=sw;
    not_reset<= not reset;
    JB(3)<=clk;
    
end RTL;
