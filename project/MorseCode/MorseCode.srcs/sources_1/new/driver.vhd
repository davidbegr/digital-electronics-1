-- DONT REALLY NEED THIS EVERYTHING HERE IS IN decoder.vhd by ME
-- should be signal_IN

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity driver is
    Port ( CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC;
           sig : out STD_LOGIC);  --prozatim signal z BTNC
           
end driver;

architecture Behavioral of driver is

begin
p_driver : process (BTNC) is
begin

    if (BTNC='1') then
        sig <= '1';
    else
        sig <= '0';
    end if;
    
    
  end process p_driver;
end Behavioral;
