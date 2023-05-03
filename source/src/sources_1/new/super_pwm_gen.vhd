library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity super_PWM_generator is
    port (
         basys3_100Mhz          : in std_logic;
         pwm_input              : in integer range -1024 to 1023;
         
         PWM_modulated_signal   : out std_logic
    );
end super_PWM_generator;

architecture Behavioral of super_PWM_generator is
    signal pwm_counter : integer range 0 to 1000 := 0;
    signal array_value : integer range 0 to 2047 := 0;  
begin
    process(basys3_100Mhz) begin
        if rising_edge(basys3_100Mhz) then
            array_value <= pwm_input + 1024;
            if pwm_counter = 999 then
                pwm_counter <= 0;
                PWM_modulated_signal <= '1';
            elsif pwm_counter > 999 * array_value / 2048 then
                pwm_counter <= pwm_counter + 1;
                PWM_modulated_signal <= '0';
            else
                pwm_counter <= pwm_counter + 1;
            end if;
        end if;
    end process;
end Behavioral;