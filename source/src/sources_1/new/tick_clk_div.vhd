library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tick_clk_div is
    Port (
        clk_100Mhz  : in std_logic;                     -- input 100MHz clock from BASYS3
    
        tempo_clock : out std_logic                     -- divided clock, for tempo
    );
end tick_clk_div;

architecture Behavioral of tick_clk_div is
    constant us_per_quarter_note : integer := 50847; --ENTER THIS AS THE TEMPO
    constant ticks_per_time1     : integer := us_per_quarter_note * 100 / 96;
    signal god_counter : integer := 0;
    signal better_clk  : std_logic := '1';
begin
    process(clk_100Mhz) begin
        if rising_edge(clk_100Mhz) then
            god_counter <= god_counter + 1;
            if god_counter >= ticks_per_time1 / 2 - 1 then
                better_clk <= not better_clk;
                god_counter <= 0;
            end if;
        end if;
    end process;
    tempo_clock <= better_clk;
end Behavioral;