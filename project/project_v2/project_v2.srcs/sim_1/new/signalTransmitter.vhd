library ieee;
use ieee.std_logic_1164.ALL;
package my_types_pkg is 
    type Morse is array(3 downto 0) of std_logic_vector(1 downto 0);
            --creates an array with 4 cells, each containing a 2 bit bus
end package;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

use work.my_types_pkg.all;

entity characterRecognizer is

    port (ClkIN : in std_logic;
          button : in std_logic;
          OutBus : out Morse);        
end entity characterRecognizer;

architecture Behavioral of characterRecognizer is

-- set up array--
signal morseArray : Morse := ("00", "00", "00", "00");

begin

    process (button,ClkIN) is
    
    constant DotTime : integer := 250000000; -- time representing press of button(250ms)
    constant SpaceTime : integer := (DotTime); -- time representing a space between a charakters   
    constant DashTime : integer := (DotTime * 4); -- time representig time longer than a dash
    
    variable lastButtonState : integer := 0; -- keeps track of the last state on the button (pressed or not)
    variable pressCounter : integer := 0; -- counts for which time is button pressed
    variable waitCounter : integer := 0; -- keeps track of the total wait time when button is not pressed 
    variable arrayCounter : integer := 0; -- keeps track of how full the array is ( if it equals 4 it will send off the data)
    
    begin
        if (rising_edge(ClkIN)) then

        -- check if the Array is full before proceeding 
             if arrayCounter = 4 then  
                OutBus <= morseArray; -- send out array
                arrayCounter := 0;
                morseArray <= ("00", "00", "00", "00");
                waitCounter := 0;
            end if;
            
            if (button = '1' and lastButtonState = 0) then
		-- Reset the button count and counts for how long it is pressed
                pressCounter := 1; 
                lastButtonState := 1;
                waitCounter := 0;
            
            elsif (button = '1' and lastButtonState = 1) then
		-- Counts how long the button is pressed
                pressCounter := pressCounter + 1;
                waitCounter :=0;

            elsif (button = '0' and lastButtonState = 1) then
        --button is released, we CHECK to see if its a dot or a dash
	    
            arrayCounter := arrayCounter + 1; 
        -- keeps track of how many cells in the array are full
            
                if pressCounter > 0 and pressCounter < DotTime then
            --if the button is pressed within a DotTime, append array with "01"
                    for i in morseArray'range loop 
                        if morseArray(i) = "00" then
                            morseArray(i) <= "01";
                            exit;
                        end if;
                    end loop;
                lastButtonState := 0;        

                elsif pressCounter > DotTime and pressCounter < DashTime then
            -- if the button is pressed and held longer than a DotTime & shorter than an DashTime, append array with "10"
                    for i in morseArray'range loop 
                        if morseArray(i) = "00" then
                            morseArray(i) <= "10";
                            exit;
                        end if;
                    end loop;
                end if; 
                lastButtonState := 0;
                waitCounter := 0;
            else
	-- if the button is not pressed for a unit wait time, send off the data bus and reset all counters
                lastButtonState := 0;
                pressCounter := 0;
                waitCounter := waitCounter + 1;
                if waitCounter = DotTime then
                    OutBus <= morseArray;
                    arrayCounter := 0; 
                    morseArray <= ("00", "00", "00", "00");
                    waitCounter := 0;
                end if;
            end if;
        end if;
    end process;
end Behavioral;                                                                                                                                              