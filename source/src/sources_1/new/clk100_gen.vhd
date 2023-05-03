library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk100_gen is
    port ( 
        clk_100MHz : in std_logic;
        
        clk_100KHz : out std_logic
    );
end clk100_gen;

architecture Behavioral of clk100_gen is
    signal huh : std_logic := '1';
    signal cnt : integer range 0 to 499;
begin
    process(clk_100MHz) begin
        if rising_edge(clk_100MHz) then
            cnt <= cnt + 1;
            if cnt = 499 then
                huh <= not huh;
                cnt <= 0;
            end if;
        end if;
    end process;
    clk_100KHz <= huh;
end Behavioral;