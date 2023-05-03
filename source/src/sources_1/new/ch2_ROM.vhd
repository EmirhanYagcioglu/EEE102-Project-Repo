library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity ch2_ROM is
    Port (
        ROMaddress : in integer range 0 to 65535;        -- ROM access address
        
        sub_ch1_vec : out std_logic_vector(20 downto 0); -- sub channel-1 input vector
        sub_ch2_vec : out std_logic_vector(20 downto 0); -- sub channel-2 input vector
        sub_ch3_vec : out std_logic_vector(20 downto 0); -- sub channel-3 input vector
        sub_ch4_vec : out std_logic_vector(20 downto 0)  -- sub channel-4 input vector
    );
end ch2_ROM;

architecture Behavioral of ch2_ROM is
    type ROM_entry is array (0 to 3) of std_logic_vector(20 downto 0);
    type ROM_type is array (0 to 170) of ROM_entry;
    signal ch_ROM : ROM_type := (
    ("000000000000000000000",	"000000000000000000000",	"000000000000000000000",	"000000000000000000000"),
    ("110001010111011111111",	"000000000000000000000",	"000000000000000000000",	"000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010010010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010010010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110100000101111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011101001001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010010010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010010010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010010010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010100100111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010100100111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010100100111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011101001001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110100000101111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("100100000101111111111",    "110001000001101111111",    "000000000000000000000",    "000000000000000000000"),
    ("000000000000000000000",    "100001000001101111111",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "110001100010001111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "110001100010001111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001010111011111111",    "110001100111111111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001010111011111111",    "110001000101011111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001010111011111111",    "110001100111111111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "110001010010101111111",    "000000000000000000000",    "000000000000000000000"),
    ("000000000000000000000",    "110001010010101111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001010111011111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001010010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001000001101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001000001101111111",    "110001010010101111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001000101011111111",    "110001010111011111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("100001100010001111111",    "110001100111111111111",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001111011101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010100100111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010100100111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001010111011111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100010001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001100111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110001110100101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010000010111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010001010101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010100100111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011000100001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110010101110101111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011101001001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011101001001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011101001001111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110011001111111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110100000101111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("110100000101111111111",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000"),
    ("000000000000000000000",    "000000000000000000000",    "000000000000000000000",    "000000000000000000000")
    );

begin

    sub_ch1_vec <= ch_ROM(ROMaddress)(0);
    sub_ch2_vec <= ch_ROM(ROMaddress)(1);
    sub_ch3_vec <= ch_ROM(ROMaddress)(2);
    sub_ch4_vec <= ch_ROM(ROMaddress)(3);

end Behavioral;