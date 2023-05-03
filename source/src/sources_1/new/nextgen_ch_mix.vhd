library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity nextgen_ch_mix is
    Port ( 
        int1 : in integer range -64 to 63;
        int2 : in integer range -64 to 63;
        int3 : in integer range -64 to 63;
        int4 : in integer range -64 to 63;
        adsr1 : in integer range 0 to 100;
        adsr2 : in integer range 0 to 100;
        adsr3 : in integer range 0 to 100;
        adsr4 : in integer range 0 to 100;
        clk_100MHz : in std_logic;
        
        out_amp : out integer range -256 to 255
    );
end nextgen_ch_mix;

architecture Behavioral of nextgen_ch_mix is 
    signal pre_amp : integer range -25600 to 25500;
begin
    process(clk_100MHz) begin
        if rising_edge(clk_100MHz) then
            pre_amp <= int1 * adsr1 + int2 * adsr2 + int3 * adsr3 + int4 * adsr4;
        end if;
    end process;
    out_amp <= pre_amp / 100;    
end Behavioral;