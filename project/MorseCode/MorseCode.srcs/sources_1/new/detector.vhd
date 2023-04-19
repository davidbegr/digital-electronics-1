-- DONT REALLY NEED THIS EVERYTHING HERE IS IN decoder.vhd by ME

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detector is
    generic (
        g_MAX : natural := 1);  --Number of clk pulses to generate one enable signal period, was 5 now is 1 for 1=250 ms
    
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           morse : in STD_LOGIC;
           en : out STD_LOGIC;
           dot : out STD_LOGIC;
           dash : out STD_LOGIC;
           ch_s : out STD_LOGIC;
           w_s : out STD_LOGIC);
end detector;

architecture Behavioral of detector is

  constant c_lowTime : time := 250 ms;
  signal pushtime : natural;
  
begin
p_clk_enable : process (clk) is
  begin

    if rising_edge(clk) then              -- Synchronous process
      if (rst = '1') then                 -- High-active reset
        pushtime <= 0;                     -- Clear local counter
        en    <= '0';                   -- Set output to low

      -- Test number of clock periods
      elsif (pushtime >= (g_MAX - 1)) then
        pushtime <= 0;                     -- Clear local counter
        en    <= '1';                   -- Generate clock enable pulse
      else
        pushtime <= pushtime + 1;
        en    <= '0';
      end if;
    end if;

  end process p_clk_enable;
  
 p_detector : process (morse) is
  begin
  --if morse = 1 for 250 ms then dot, if m=1 for 750ms then dash, if morse=0 for 750ms then ch_s=1, 7x250 ms then w_s
    
   if (morse = '1') then
        if (pushtime <= c_lowTime) then
            dot <= '1';
        elsif (pushtime \<= 3*c_lowTime) and (c_lowTime \<= pushtime) then
            dash <= '1';
        else
            dot <= '0';
            dash <= '0';
        end if;
   elsif (morse = '0') then
        if (pushtime <= 3*c_lowTime) then
            ch_s <= '1';
        elsif (pushtime <= 7*c_lowTime) and (3*c_lowTime <= pushtime) then
            w_s <= '1';
        else
            ch_s <= '0';
            w_s <= '0';
        end if;
   end if;
   
end Behavioral;
