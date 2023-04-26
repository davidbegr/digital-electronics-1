-- Fungovalo by to, kdyby character_buffer byl bitový signál s jedním stejným rozm?rem

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity morse_7seg is
    Port ( reset : in STD_LOGIC;
           character_buffer : in STD_LOGIC_VECTOR (3 downto 0);
           display_buffer : out STD_LOGIC_VECTOR (6 downto 0));
end morse_7seg;

architecture Behavioral of morse_7seg is

begin


p_7seg_decoder : process (reset, character_buffer) is

begin
    
    if reset = '1' then
        display_buffer <= "1111111";  -- blank
        
    else
    
        case character_buffer is
        
            when ".-"   => 
                display_buffer <= "0000010";  -- A
                
            when "-..." =>
                display_buffer <= "1100000";  -- B
                
            when "-.-." => 
                display_buffer <= "1110010";  -- C
                
            when "-.."  => 
                display_buffer <= "1000010";  -- D
                
            when "."    => 
                display_buffer <= "0110000";  -- E
                
            when "..-." => 
                display_buffer <= "0111000";  -- F
                
            when "--."  => 
                display_buffer <= "0100001";  -- G
                
            when "...." => 
                display_buffer <= "1101000";  -- H
                
            when ".."   => 
                display_buffer <= "0111011";  -- I
                
            when ".---" => 
                display_buffer <= "0100111";  -- J
                
            when "-.-"  => 
                display_buffer <= "0101000";  -- K
                
            when ".-.." => 
                display_buffer <= "1110001";  -- L
                
            when "--"   => 
                display_buffer <= "0101010";  -- M
                
            when "-."   => 
                display_buffer <= "1101010";  -- N
                
            when "---"  => 
                display_buffer <= "1100010";  -- O
                
            when ".--." => 
                display_buffer <= "0011000";  -- P
                
            when "--.-" => 
                display_buffer <= "0001100";  -- Q
                
            when ".-."  => 
                display_buffer <= "1111010";  -- R
                
            when "..."  => 
                display_buffer <= "0100101";  -- S
                
            when "-"    => 
                display_buffer <= "1110000";  -- T
                
            when "..-"  => 
                display_buffer <= "1100011";  -- U
                
            when "...-" => 
                display_buffer <= "1010101";  -- V
                
            when ".--"  => 
                display_buffer <= "1010100";  -- W
                
            when "-..-" => 
                display_buffer <= "1101011";  -- X
                
            when "-.--" => 
                display_buffer <= "1000100";  -- Y
                
            when "--.." => 
                display_buffer <= "0010011";  -- Z
             
            when others => 
                display_buffer <= "1111111";  -- blank
            
        end case;
    
    end if;

  end process p_7seg_decoder;




end Behavioral;
