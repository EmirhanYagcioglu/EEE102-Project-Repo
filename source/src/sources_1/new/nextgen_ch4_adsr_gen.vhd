library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity nextgen_ch4_adsr_gen is
    Port (
        clk_100KHz  : in std_logic;
        trigger     : in std_logic;
        restart     : in std_logic;
        checker_s   : in std_logic;
        
        amp_factor  : out integer range 0 to 100
    );
end nextgen_ch4_adsr_gen;

architecture Behavioral of nextgen_ch4_adsr_gen is    
    signal count : integer range 0 to 921600:= 0;
    constant attack_time : integer range 0 to 1023 := 50;
    constant sustain_time : integer range 0 to 8191 := 4500;
begin
    process(clk_100KHz) begin
        if rising_edge(clk_100KHz) then
            if trigger = '1' then
                if count <= 100 * attack_time then
                    count <= count + 1;
                    amp_factor <= (count / attack_time);
                elsif count <= 100 * sustain_time then
                    count <= count + 1; 
                    amp_factor <= (100 * sustain_time - count)/(sustain_time - attack_time);
                end if;
                if checker_s = '1' and restart = '1' then
                    count <= 0;                        
                end if;
            else
                count <= 0;
            end if;
        end if;
    end process;
end Behavioral;