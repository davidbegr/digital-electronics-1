library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package my_types_pkg is
    type Morse is array(3 downto 0) of std_logic_vector(1 downto 0); 
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.my_types_pkg.all;

entity decoder is
--  Port ( );
   Port ( morseToConvert : in Morse;
           seg : out std_logic_vector(6 downto 0));
end decoder;

architecture Behavioral of decoder is
-- Stores the morse code in 8 bits
    signal fourBitMorse : std_logic_vector(7 downto 0); 
	-- Outputs 7 bit representation of letter for seven segment display
    signal morse : std_logic_vector(7 downto 0); 

begin
	-- Concatenate the morseArray into an 8 bit bus
    fourBitMorse <= morseToConvert(3) & morseToConvert(2) & morseToConvert(1) & morseToConvert(0);

p_7seg_decoder : process (morseToConvert) is

  begin

      case morse is
        when "00000000" => 
        seg <= "1111111"; --blank
        when "01100000" =>
          seg <= "0000010"; -- A
        when "10010101" =>
          seg <= "1100000"; -- B
        when "10011001" =>
          seg <= "1110010"; -- C          
        when "10010100" =>
          seg <= "1000010"; -- D
        when "01000000" =>
          seg <= "0110000"; -- E          
        when "01011001" =>
          seg <= "0111000"; -- F        
        when "10100100" =>
          seg <= "0100001"; -- G        
        when "01010101" =>
          seg <= "1101000"; -- H
        when "01010000" =>
          seg <= "0111011"; -- I
        when "01101010" =>
          seg <= "0100111"; -- J       
        when "10011000" =>
          seg <= "0101000"; -- K
        when "01100101" =>
          seg <= "1110001"; -- L
        when "10100000" =>
          seg <= "0101010"; -- M
        when "10010000" =>
          seg <= "1101010"; -- N
        when "10101000" =>
          seg <= "1100010"; -- O
        when "01101001" =>
          seg <= "0011000"; -- P
        when "10100110" =>
          seg <= "0001100"; -- Q
        when "01100100" =>
          seg <= "1111010"; -- R
        when "01010100" =>
          seg <= "0100101"; -- S
        when "10000000" =>
          seg <= "1110000"; -- T
        when "01011000" =>
          seg <= "1100011"; -- U
        when "01010110" =>
          seg <= "1010101"; -- V
        when "01101000" =>
          seg <= "1010100"; -- W
        when "10010110" =>
          seg <= "1101011"; -- X
        when "10011010" =>
          seg <= "1000100"; -- Y
        when "10100101" =>
          seg <= "0010011"; -- Z
      end case;
  end process p_7seg_decoder;
end Behavioral;