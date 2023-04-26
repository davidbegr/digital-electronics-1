library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package my_types_pkg is
    type Morse is array(3 downto 0) of std_logic_vector(1 downto 0); 
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use work.my_types_pkg.all;

entity MorseDecoder is
    Port (
        CLK100MHZ     : in std_logic;
        BTNC    : in std_logic;
        CA      : out STD_LOGIC;
        CB      : out STD_LOGIC;
        CC      : out STD_LOGIC;
        CD      : out STD_LOGIC;
        CE      : out STD_LOGIC;
        CF      : out STD_LOGIC;
        CG      : out STD_LOGIC;
        DP      : out STD_LOGIC;
        AN      : out STD_LOGIC_VECTOR (7 downto 0);
        morseToConvert : in Morse;
        seg : out std_logic_vector(6 downto 0)
    );
end MorseDecoder;

architecture Behavioral of MorseDecoder is
-- This component creates a subModule characterRecognizer to be used.
-- Signal to transfer output of characterRecognizer to SSD
        signal morsedata : Morse; 
begin
    characterRecognizer : entity work.characterRecognizer
        Port map (
            ClkIN => CLK100MHZ,
            button => BTNC,
            OutBus => Morse);

-- This component creates a subModule SSD to be used.
    decoder : entity work.decoder
        Port map(
            morseToConvert => convert,
            seg(6) => CA,
            seg(5) => CB,
            seg(4) => CC,
            seg(3) => CD,
            seg(2) => CE,
            seg(1) => CF,
            seg(0) => CG);

-- Map the inputs and outputs of each submodule 
--    reciever : characterRecognizer port map(ClkIN => clk, button => buttonIn, OutBus => morsedata);
--    display : decoder port map(morseToConvert => morsedata, seg => seg);

end architecture behavioral;
