library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( input_buttons: in std_logic_vector(3 downto 0);
           reset : in STD_LOGIC;
           clk100mhz : in STD_LOGIC;
           freq_duty_selector : in STD_LOGIC;
           freq_selector_fixed_clk : in STD_LOGIC_VECTOR (7 downto 0);
           pulse_out : out STD_LOGIC);
end top;

architecture RTL of top is

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
     
     component fixed_clks is 
     port(
        clk100mhz:in std_logic;
        reset:in std_logic;
        clk100mhz_out:out std_logic;
        clk50mhz: out std_logic;
        clk25mhz: out std_logic;
        clk10mhz: out std_logic;
        clk1mhz: out std_logic;
        clk100kz: out std_logic;
        clk10kz: out std_logic;
        clk1khz:out std_logic 
     );
     end component;
     
     component freq_selector is
     port(
        up10 : in STD_LOGIC;
        up100 : in STD_LOGIC;
        down10 : in STD_LOGIC;
        down100 : in STD_LOGIC;
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        precharge : out STD_LOGIC_VECTOR (19 downto 0)
     );
     end component;
     
     component mux_2_1 is
     port(
        input : in STD_LOGIC_VECTOR (1 downto 0);
        input_select : in STD_LOGIC;
        output : out STD_LOGIC
     );
     end component;
     
     component one_hot_8bit_mux is
     port(
        input : in STD_LOGIC_VECTOR (7 downto 0);
        input_select : in STD_LOGIC_VECTOR (7 downto 0);
        output : out STD_LOGIC
        );
     end component;
     
     component variable_freq_clk is
     port(
        clk100mhz : in STD_LOGIC;
        reset : in STD_LOGIC;
        en: in std_logic;
        precharge: in std_logic_vector(19 downto 0);
        var_clk: out std_logic);
     end component;
     
     component variable_duty_cycle_clk is
     port(
        clk_in : in STD_LOGIC;
        reset : in STD_LOGIC;
        pulse_out : out STD_LOGIC;
        up : in STD_LOGIC;
        down : in STD_LOGIC
     );
     end component;
     
     signal synchr_out: std_logic_vector(3 downto 0);
     signal deb_out: std_logic_vector(3 downto 0);
     signal edge_out: std_logic_vector(3 downto 0);
     
     signal clk50mhz: std_logic;
     signal clk25mhz: std_logic;
     signal clk10mhz: std_logic;
     signal clk1mhz: std_logic;
     signal clk100khz: std_logic;
     signal clk10khz: std_logic;
     signal clk1khz: std_logic;
     
     signal mux_8_1_out: std_logic;
     
     signal precharge: std_logic_vector(19 downto 0);
     signal variable_freq_clk_out: std_logic;
     signal variable_duty_cycle_clk_out: std_logic;
     
begin

    input_buttons_conditioning: for i in 0 to 3 generate
    inst_synchrnyzr: SYNCHRNZR port map(
                            clk=>clk100mhz,
                            async_in=>input_buttons(i),
                            sync_out=>synchr_out(i),
                            reset=>reset);
                            
    inst_debouncer: DEBOUNCER port map(
                            CLK=>clk100mhz,
                            btn_in=>synchr_out(i),
                            btn_out=>deb_out(i),
                            reset=>reset);
                            
    inst_edgedtctr: EDGEDTCTR port map(
                            CLK=>clk100mhz,
                            sync_in=>deb_out(i),
                            edge=>edge_out(i),
                            reset=>reset);
    end generate input_buttons_conditioning;
    
    inst_fixed_clks: fixed_clks port map(
                            clk100mhz => clk100mhz,
                            reset => reset,
                            clk100mhz_out => open,
                            clk50mhz => clk50mhz,
                            clk25mhz => clk25mhz,
                            clk10mhz => clk10mhz,
                            clk1mhz => clk1mhz,
                            clk100kz => clk100khz,
                            clk10kz => clk10khz,
                            clk1khz => clk1khz);
                            
    inst_freq_selector: freq_selector port map(
                            up10 => edge_out(0),
                            up100 => edge_out(1),
                            down10 => edge_out(2),
                            down100 => edge_out(3),
                            clk => clk100mhz,
                            reset => reset,
                            precharge => precharge);
                            
    inst_variable_frq_clk: variable_freq_clk port map(
                            clk100mhz => clk100mhz,
                            reset => reset,
                            en => freq_selector_fixed_clk(0),
                            precharge => precharge,
                            var_clk => variable_freq_clk_out);
                            
    inst_one_hot_8bit_mux: one_hot_8bit_mux port map(
                            input(0) => clk100mhz,
                            input(1) => clk50mhz,
                            input(2) => clk25mhz,
                            input(3) => clk10mhz,
                            input(4) => clk1mhz,
                            input(5) => clk100khz,
                            input(6) => clk10khz,
                            input(7) => clk1khz,
                            input_select => freq_selector_fixed_clk,
                            output => mux_8_1_out);
    
    inst_variable_duty_cycle_clk: variable_duty_cycle_clk port map(
                            clk_in => mux_8_1_out,
                            reset => reset,
                            pulse_out => variable_duty_cycle_clk_out,
                            up => edge_out(0),
                            down => edge_out(2));
                            
    inst_mux_2_1: mux_2_1 port map(
                             input(0) => variable_freq_clk_out,
                             input(1) => variable_duty_cycle_clk_out,
                             input_select => freq_duty_selector,
                             output => pulse_out);

end RTL;
