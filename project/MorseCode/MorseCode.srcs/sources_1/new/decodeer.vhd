-- decoder.vhd by ME
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity morse_decoder is
    port (
        clk : in std_logic;
        reset : in std_logic;
        button : in std_logic;
        generator : in std_logic;
        signal_in : in std_logic;
        display : out std_logic_vector(6 downto 0)
    );
end entity;

architecture behavior of morse_decoder is
    -- define Morse code lookup table
    type morse_code_array is array(character range 'A' to 'Z') of string(1 to 4);
    constant morse_code : morse_code_array := (
        'A' => ".-", 'B' => "-...", 'C' => "-.-.", 'D' => "-..", 'E' => ".", 'F' => "..-.", 'G' => "--.", 'H' => "....",
        'I' => "..", 'J' => ".---", 'K' => "-.-", 'L' => ".-..", 'M' => "--", 'N' => "-.", 'O' => "---", 'P' => ".--.",
        'Q' => "--.-", 'R' => ".-.", 'S' => "...", 'T' => "-", 'U' => "..-", 'V' => "...-", 'W' => ".--", 'X' => "-..-",
        'Y' => "-.--", 'Z' => "--.."
    );

    -- define signal timing constants
    constant dot_duration : natural := 250; -- in ms
    constant dash_duration : natural := dot_duration * 3;
    constant character_space_duration : natural := dash_duration;
    constant word_space_duration : natural := dot_duration * 7;

    -- define internal signals
    signal signal_buffer : std_logic_vector(2 downto 0);        -- was (because of us): signal signal_buffer : std_logic_vector(1 downto 0);
    signal signal_duration : natural;
    signal character_buffer : std_logic_vector(3 downto 0);
    signal display_buffer : std_logic_vector(6 downto 0);
    signal enable_display : std_logic := '0';

begin

    -- counter to measure signal duration
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                signal_duration <= 0;
            else
                if signal_in = '1' then
                    signal_duration <= signal_duration + 1;
                else
                    signal_duration <= 0;
                end if;
            end if;
        end if;
    end process;

    -- buffer incoming signal
    process(clk)
    begin
        if rising_edge(clk) then
            signal_buffer <= signal_buffer(1 downto 0) & signal_in;     -- add 1 to certain position in signal_buffer and move to next position
        end if;
    end process;

    -- decode morse code and update character buffer
    process(signal_duration, signal_buffer)
        variable morse_character : string(1 to 4);
        variable character : character;
    begin
        if signal_duration = 0 then
            -- do nothing, waiting for next signal
        elsif signal_buffer = "001" then
            morse_character := ".";
            enable_display <= '1';
        elsif signal_buffer = "0001" then
            morse_character := "-";
            enable_display <= '1';
        elsif signal_buffer = "0000001" then
            -- end of character
            character := find_character(morse_character);
            if character /= ' ' then
                character_buffer <= character_buffer(2 downto 0) & "0000";
            end if;
        elsif signal_buffer = "0000000001" then
-- end of word
            character := find_character(morse_character);
            character_buffer <= character & " ";
        end if;
    end process;

    -- find character corresponding to Morse code
    function find_character(morse_code_str : string) return character is
        variable i : natural;
    begin
        for i in morse_code'range loop
            if morse_code(morse_code'left + i) = morse_code_str then
                return character'val(morse_code'left + i);
            end if;
        end loop;
        return ' ';
    end function;
    
    -- update display buffer
    process(character_buffer)
    begin
        case character_buffer is
            when ".-"   => display_buffer <= "0000010";  -- A
            when "-..." => display_buffer <= "1100000";  -- B
            when "-.-." => display_buffer <= "1110010";  -- C
            when "-.."  => display_buffer <= "1000010";  -- D
            when "."    => display_buffer <= "0110000";  -- E
            when "..-." => display_buffer <= "0111000";  -- F
            when "--."  => display_buffer <= "0100001";  -- G
            when "...." => display_buffer <= "1101000";  -- H
            when ".."   => display_buffer <= "0111011";  -- I
            when ".---" => display_buffer <= "0100111";  -- J
            when "-.-"  => display_buffer <= "0101000";  -- K
            when ".-.." => display_buffer <= "1110001";  -- L
            when "--"   => display_buffer <= "0101010";  -- M
            when "-."   => display_buffer <= "1101010";  -- N
            when "---"  => display_buffer <= "1100010";  -- O
            when ".--." => display_buffer <= "0011000";  -- P
            when "--.-" => display_buffer <= "0001100";  -- Q
            when ".-."  => display_buffer <= "1111010";  -- R
            when "..."  => display_buffer <= "0100101";  -- S
            when "-"    => display_buffer <= "1110000";  -- T
            when "..-"  => display_buffer <= "1100011";  -- U
            when "...-" => display_buffer <= "1010101";  -- V
            when ".--"  => display_buffer <= "1010100";  -- W
            when "-..-" => display_buffer <= "1101011";  -- X
            when "-.--" => display_buffer <= "1000100";  -- Y
            when "--.." => display_buffer <= "0010011";  -- Z
             

            when others => display_buffer <= "1111111";  -- blank
        end case;
    end process;

    -- update display
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                display <= "1111111";
            else
                if enable_display = '1' then
                    display <= display_buffer;
                    enable_display <= '0';
                end if;
            end if;
        end if;
    end process;