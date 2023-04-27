library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package my_types_pkg is
    type Morse is array(3 downto 0) of std_logic_vector(1 downto 0); 
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types_pkg.all;

entity SSD is
    Port ( morseToConvert : in Morse;
           HexOut : out std_logic_vector(6 downto 0));
end SSD;

architecture Behavioral of SSD is

	-- Stores the morse code in 8 bits
    signal fourBitMorse : std_logic_vector(7 downto 0); 
	-- Outputs 7 bit representation of letter for seven segment display
    signal value : std_logic_vector(6 downto 0); 

begin
	-- Concatenate the morseArray into an 8 bit bus
    fourBitMorse <= morseToConvert(3) & morseToConvert(2) & morseToConvert(1) & morseToConvert(0);

    process (morseToConvert)
    begin
		-- Compare the 8 bit bus to the correct morse code letter, then assert “value” to equal the 7 bit letter code.
            case fourBitMorse is
                --when "00000000" => value <= value;
                when others =>
                    case fourBitMorse is
                        when "00000000" => value <= "1111111";
                        when "01100000" => value <= Not("1110111"); -- A
                        when "10010101" => value <= Not("0011111"); -- B
                        when "10011001" => value <= Not("1001110"); -- C
                        when "10010100" => value <= Not("0111101"); -- D
                        when "01000000" => value <= Not("1001111"); -- E
                        when "01011001" => value <= Not("1000111"); -- F
                        when "10100100" => value <= Not("1111011"); -- G -- rip k, m, w, x
                        when "01010101" => value <= Not("0010111"); -- H
                        when "01010000" => value <= Not("0110000"); -- I
                        when "01101010" => value <= Not("0111000"); -- J
                        when "01100101" => value <= Not("0001110"); -- L
                        when "10010000" => value <= Not("0010101"); -- N
                        when "10101000" => value <= Not("1111110"); -- O
                        when "01101001" => value <= Not("1100111"); -- P
                        when "10100110" => value <= Not("1111110"); -- Q
                        when "01100100" => value <= Not("0000101"); -- R
                        when "01010100" => value <= Not("1011011"); -- S
                        when "10000000" => value <= Not("0001111"); -- T
                        when "01011000" => value <= Not("0011100"); -- U
                        when "01010110" => value <= Not("0111110"); -- V
                        when "10011010" => value <= Not("0111011"); -- Y
                        when "10100101" => value <= Not("1101101"); -- Z
                        when others => value <= "1111111";
                    end case;
            end case;
    end process;
    HexOut <= value; -- map “value” to the “HexOut” output
end Behavioral;
