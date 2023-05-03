library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity nextgen_ch4_supermodule is
    port ( 
        reset_time : in std_logic;
        clk_100Mhz : in std_logic;
        clk_100KHz : in std_logic;
        tempo_clock: in std_logic;
        
        PWM_int_out: out integer range -256 to 255
    );
end nextgen_ch4_supermodule;

architecture Behavioral of nextgen_ch4_supermodule is
    component ch4_timer_ROM is
        Port (
            reset_time : in std_logic;
            tempo_clock: in std_logic;
            
            ROMaddress : out integer range 0 to 65535;
            checker_s  : out std_logic
        );
    end component;
    component ch4_nextgen_int_gen is
        Port (
            ROMaddress : in integer range 0 to 65535;
            clk100MHz  : in std_logic;
            clk_100KHz  : in std_logic;
            checker_s   : in std_logic;
            
            int_out : out integer range -256 to 255
         );
    end component;
    signal rom_s : integer range 0 to 65535;
    signal check : std_logic;
begin
    timer : ch4_timer_ROM
        port map (
            reset_time => reset_time,
            tempo_clock=> tempo_clock,
            
            ROMaddress => rom_s,
            checker_s  => check
        );
    intgen : ch4_nextgen_int_gen
        port map (
            ROMaddress => rom_s,
            clk100MHz  => clk_100Mhz,
            clk_100KHz  => clk_100KHz,
            checker_s  => check,

            int_out => PWM_int_out
        );
end Behavioral;