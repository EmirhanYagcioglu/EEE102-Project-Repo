library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mixer_4_channel is
    port ( 
        ch_1_in     : in integer range -256 to 255;
        ch_2_in     : in integer range -256 to 255;
        ch_3_in     : in integer range -256 to 255;
        ch_4_in     : in integer range -256 to 255;
        clk_100KHz  : in std_logic;
        
        switch_ch   : in std_logic_vector(3 downto 0);
        
        pwm_out     : out integer range -1024 to 1023
    );
end mixer_4_channel;

architecture Behavioral of mixer_4_channel is 
    signal ch1sw, ch2sw, ch3sw, ch4sw : integer range 0 to 1;
begin
    ch1sw <= to_integer(unsigned'('0' & switch_ch(0)));
    ch2sw <= to_integer(unsigned'('0' & switch_ch(1)));
    ch3sw <= to_integer(unsigned'('0' & switch_ch(2)));
    ch4sw <= to_integer(unsigned'('0' & switch_ch(3)));
    process(clk_100KHz) begin
        if rising_edge(clk_100KHz) then
            if switch_ch = "0000" then
                pwm_out <= 0;
            else
                pwm_out <= (ch_1_in * ch1sw + ch_2_in * ch2sw + ch_3_in * ch3sw + ch_4_in * ch4sw) * 4 / (ch1sw + ch2sw + ch3sw + ch4sw);
            end if;
        end if;
    end process;
end Behavioral;