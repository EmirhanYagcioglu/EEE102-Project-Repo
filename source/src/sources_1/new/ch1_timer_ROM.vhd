library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity ch1_timer_ROM is
    Port (
        reset_time : in std_logic;                      -- reset time counter to 0 
        tempo_clock: in std_logic;                      -- 100MHz clock for timer signal update counter
        
        ROMaddress : out integer range 0 to 65535;      -- global timing signal
        checker_s  : out std_logic
    );
end ch1_timer_ROM;

architecture Behavioral of ch1_timer_ROM is
    type ROM_type is array (0 to 278) of std_logic_vector(20 downto 0);
    signal time_ROM : ROM_type := (
    "000000000000000000000",
    "000000000111000010000",
    "000000001000011100000",
    "000000001000111010000",
    "000000001001011000000",
    "000000001001110110000",
    "000000001010010100000",
    "000000001010110010000",
    "000000001011010000000",
    "000000001011101110000",
    "000000001100001100000",
    "000000001100101010000",
    "000000001101001000000",
    "000000001101100110000",
    "000000001110000100000",
    "000000001110100010000",
    "000000001111000000000",
    "000000001111011110000",
    "000000001111111100000",
    "000000010000011010000",
    "000000010000111000000",
    "000000010001010110000",
    "000000010001110100000",
    "000000010010010010000",
    "000000010010110000000",
    "000000010011000100000",
    "000000010011011000000",
    "000000010011101100000",
    "000000010100000000000",
    "000000010100010100000",
    "000000010100101000000",
    "000000010100111100000",
    "000000010101010000000",
    "000000010101100100000",
    "000000010110000010000",
    "000000010110111110000",
    "000000010111011100000",
    "000000010111111010000",
    "000000011000011000000",
    "000000011000110110000",
    "000000011001010100000",
    "000000011001110010000",
    "000000011010010000000",
    "000000011010101110000",
    "000000011011001100000",
    "000000011011101010000",
    "000000011100001000000",
    "000000011100100110000",
    "000000011101000100000",
    "000000011101100010000",
    "000000011110000000000",
    "000000011110011110000",
    "000000011110111100000",
    "000000011111011010000",
    "000000011111111000000",
    "000000100000010110000",
    "000000100000110100000",
    "000000100001010010000",
    "000000100001110000000",
    "000000100010000100000",
    "000000100010011000000",
    "000000100010101100000",
    "000000100011000000000",
    "000000100011010100000",
    "000000100011101000000",
    "000000100100100100000",
    "000000100101000010000",
    "000000100101111110000",
    "000000100110011100000",
    "000000100110111010000",
    "000000100111011000000",
    "000000100111110110000",
    "000000101000010100000",
    "000000101000110010000",
    "000000101001101110000",
    "000000101010001100000",
    "000000101010101010000",
    "000000101011001000000",
    "000000101011100110000",
    "000000101100000100000",
    "000000101100100010000",
    "000000101101011110000",
    "000000101101111100000",
    "000000101110011010000",
    "000000101110111000000",
    "000000101111010110000",
    "000000101111110100000",
    "000000110000010010000",
    "000000110001001110000",
    "000000110001101100000",
    "000000110010001010000",
    "000000110010101000000",
    "000000110010110111000",
    "000000110011000110000",
    "000000110011010101000",
    "000000110011100100000",
    "000000110100000010000",
    "000000110110110110000",
    "000000110111010100000",
    "000000110111110010000",
    "000000111000010000000",
    "000000111000101110000",
    "000000111001001100000",
    "000000111001101010000",
    "000000111010001000000",
    "000000111010100110000",
    "000000111011000100000",
    "000000111011100010000",
    "000000111100000000000",
    "000000111100011110000",
    "000000111100111100000",
    "000000111101011010000",
    "000000111110010110000",
    "000000111110100101000",
    "000000111110110100000",
    "000000111111010010000",
    "000000111111110000000",
    "000001000000001110000",
    "000001000000101100000",
    "000001000001001010000",
    "000001000011000010000",
    "000001000110010100000",
    "000001000110110010000",
    "000001000111000001000",
    "000001000111010000000",
    "000001000111011111000",
    "000001000111101110000",
    "000001000111111101000",
    "000001001000001100000",
    "000001001000011011000",
    "000001001000101010000",
    "000001001000111001000",
    "000001001001001000000",
    "000001001001010111000",
    "000001001001100110000",
    "000001001001110101000",
    "000001001010000100000",
    "000001001010010011000",
    "000001001010100010000",
    "000001001010110001000",
    "000001001101010110000",
    "000001001101110100000",
    "000001001110010010000",
    "000001010000101000000",
    "000001010001100100000",
    "000001010010111110000",
    "000001010011001101000",
    "000001010011011100000",
    "000001010011101011000",
    "000001010011111010000",
    "000001010100001001000",
    "000001010100011000000",
    "000001010100100111000",
    "000001010100110110000",
    "000001010101000101000",
    "000001010101010100000",
    "000001010101100011000",
    "000001010101110010000",
    "000001010110000001000",
    "000001010110010000000",
    "000001010110011111000",
    "000001010110101110000",
    "000001010110111101000",
    "000001010111001100000",
    "000001010111011011000",
    "000001010111101010000",
    "000001010111111001000",
    "000001011000001000000",
    "000001011000010111000",
    "000001011000100110000",
    "000001011000110101000",
    "000001011001000100000",
    "000001011001010011000",
    "000001011001100010000",
    "000001011001110001000",
    "000001011010000000000",
    "000001011010001111000",
    "000001011010011110000",
    "000001011010101101000",
    "000001011010111100000",
    "000001011011001011000",
    "000001011011011010000",
    "000001011011101001000",
    "000001011011111000000",
    "000001011100000111000",
    "000001011100010110000",
    "000001011100100101000",
    "000001011100110100000",
    "000001011101000011000",
    "000001011101010010000",
    "000001011101100001000",
    "000001011101110000000",
    "000001011101111111000",
    "000001011110001110000",
    "000001011110011101000",
    "000001011110101100000",
    "000001011110111011000",
    "000001011111001010000",
    "000001011111011001000",
    "000001011111101000000",
    "000001011111110111000",
    "000001100000000110000",
    "000001100000010101000",
    "000001100000100100000",
    "000001100000110011000",
    "000001100001000010000",
    "000001100001010001000",
    "000001100001100000000",
    "000001100001101111000",
    "000001100001111110000",
    "000001100010001101000",
    "000001100010011100000",
    "000001100010101011000",
    "000001100010111010000",
    "000001100011001001000",
    "000001100011011000000",
    "000001100011100111000",
    "000001100011110110000",
    "000001100100000101000",
    "000001100100010100000",
    "000001100100100011000",
    "000001100100110010000",
    "000001100101000001000",
    "000001100101010000000",
    "000001100101011111000",
    "000001100101101110000",
    "000001100101111101000",
    "000001100110001100000",
    "000001100110011011000",
    "000001100110101010000",
    "000001101000100010000",
    "000001101010111000000",
    "000001101100110000000",
    "000001101110101000000",
    "000001110000000010000",
    "000001110011010100000",
    "000001110011110010000",
    "000001110111000100000",
    "000001110111100010000",
    "000001111000011110000",
    "000001111000111100000",
    "000001111001011010000",
    "000001111001111000000",
    "000001111010010110000",
    "000001111010110100000",
    "000001111011010010000",
    "000001111011110000000",
    "000001111100001110000",
    "000001111100101100000",
    "000001111101001010000",
    "000001111101101000000",
    "000001111110000110000",
    "000001111110100100000",
    "000001111111000010000",
    "000010000110011000000",
    "000010000110100010000",
    "000010001000111000000",
    "000010001010110000000",
    "000010001100101000000",
    "000010001110000010000",
    "000010010000011000000",
    "000010010001110010000",
    "000010010100001000000",
    "000010010101100010000",
    "000010010110011110000",
    "000010010110111100000",
    "000010010111011010000",
    "000010010111111000000",
    "000010011000010110000",
    "000010011000110100000",
    "000010011001010010000",
    "000010011001110000000",
    "000010011010001110000",
    "000010011010101100000",
    "000010011011001010000",
    "000010011011101000000",
    "000010011101000010000",
    "000010100001010000000",
    "000010100101000000000"
    );
    signal index : integer range 0 to 65535:= 0;
    signal count : std_logic_vector(20 downto 0):= (others => '0');
begin
    process(tempo_clock) begin
        if rising_edge(tempo_clock) then
            if reset_time = '0' then
                count <= count + 1;
                if count = time_ROM(index + 1) then
                    index <= index + 1;
                    checker_s <= '1';
                else 
                    checker_s <= '0';
                end if;     
            else
                index <= 0;
                checker_s <= '0';
                count <= (others => '0');
            end if;
        end if;
    end process;
    ROMaddress <= index;
end Behavioral;