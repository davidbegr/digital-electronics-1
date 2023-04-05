----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 11:37:23 AM
-- Design Name: 
-- Module Name: trans - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity trans is
     Port ( CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC);
end trans;

architecture Behavioral of trans is

  signal sig_en_250ms : std_logic;

begin
    
    --WE NEED TO ADD FUNCTIONS IN SOME ENTITY PROBABLY TO KNOW WHAT IS dot AND WHAT IS line

  hex2seg : entity work.decoder
      port map(
          dots  => BTNC,
          --hex    => sig_cnt_4bit,
          seg(6) => CA,
          seg(5) => CB,
          seg(4) => CC,
          seg(3) => CD,
          seg(2) => CE,
          seg(1) => CF,
          seg(0) => CG
      );

  AN <= b"1111_1110";

end Behavioral;
