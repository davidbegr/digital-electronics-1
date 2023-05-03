library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_MorseDecoder is
--  Port ( );
end tb_MorseDecoder;

architecture Behavioral of tb_MorseDecoder is

-- Local constans    
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

-- Local signals
    signal sig_clk_100mhz : std_logic;
    signal sig_BTNC    : std_logic;
    signal sig_CA      : STD_LOGIC;
    signal sig_CB      : STD_LOGIC;
    signal sig_CC      : STD_LOGIC;
    signal sig_CD      : STD_LOGIC;
    signal sig_CE      : STD_LOGIC;
    signal sig_CF      : STD_LOGIC;
    signal sig_CG      : STD_LOGIC;
    signal sig_DP      : STD_LOGIC;
    signal sig_AN      : STD_LOGIC_VECTOR (7 downto 0);
    --signal sig_morseToConvert : Morse;
    signal sig_seg : std_logic_vector(6 downto 0);



begin
    -- Connecting testbench signals with MorseDecoder
    -- entity (Unit Under Test)
    uut_MorseDecoder : entity work.MorseDecoder
        port map(
            BTNC        => sig_BTNC,
            CA          => sig_CA,
            CB          => sig_CB,
            CC          => sig_CC,
            CD          => sig_CD,
            CE          => sig_CE,
            CF          => sig_CF,
            CG          => sig_CG,
            DP          => sig_DP,
            AN          => sig_AN,
            --morseToConvert => sig_morseToConvert,
            seg         => sig_seg
        );

    p_clk_gen : process is
    begin

      while now < 400 ns loop -- 40 periods of 100MHz clock

        sig_clk_100mhz <= '0';
        wait for c_CLK_100MHZ_PERIOD / 2;
        sig_clk_100mhz <= '1';
        wait for c_CLK_100MHZ_PERIOD / 2;

      end loop;
      wait;

    end process p_clk_gen;
     
    p_stimulus : process
    begin
       

        sig_BTNC <= '0'; wait for 100 ns;        
        sig_BTNC <= '1'; wait for 100 ns;        
       
        wait;
    end process p_stimulus;


end Behavioral;