
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for mux
------------------------------------------------------------
entity mux_3bit_4to1 is
    port(
        a           : in  std_logic_vector(2 downto 0);
        b           : in  std_logic_vector(2 downto 0);
        c           : in  std_logic_vector(2 downto 0);
        d           : in  std_logic_vector(2 downto 0);
        f           : in  std_logic_vector(2 downto 0);
        sel           : in  std_logic_vector(1 downto 0);                                
    );
end entity mux_3bit_4to1;

------------------------------------------------------------
-- Architecture body for 4-bit binary comparator
------------------------------------------------------------
architecture Behavioral of mux_3bit_4to1 is
begin
    with addr_i select
    f <= a when (sel="00") else  
         b when (sel="01") else
         c when (sel="10") else
         d; 
end architecture Behavioral;
