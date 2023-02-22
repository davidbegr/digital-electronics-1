
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
        f           : out  std_logic_vector(2 downto 0);
        sel         : in  std_logic_vector(1 downto 0)
    );
end entity mux_3bit_4to1;

------------------------------------------------------------
-- Architecture body for MUX
------------------------------------------------------------
architecture Behavioral of mux_3bit_4to1 is
begin
    with sel select
    f <= a when "00",
    	 b when "01",
    	 c when "10",
    	 d when others;
end architecture Behavioral;
