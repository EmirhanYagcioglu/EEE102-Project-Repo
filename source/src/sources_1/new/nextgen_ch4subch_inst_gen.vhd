library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity nextgen_ch4subch_inst_gen is
    Port (
        note_string : in std_logic_vector(20 downto 0);
        clk100MHz   : in std_logic;
        clk100KHz   : in std_logic;
        
        trigger_o   : out std_logic;
        restart_o   : out std_logic;
        int_out : out integer range -64 to 63
     );
end nextgen_ch4subch_inst_gen;

architecture Behavioral of nextgen_ch4subch_inst_gen is
    signal index_counter : integer := 0;    
    -- disect note_string  
    signal trigger : std_logic;
    signal restart : std_logic;
    signal frequency : std_logic_vector(11 downto 0);
    signal volume : std_logic_vector(6 downto 0);
    -- LUT instantiation 
    signal index : integer range 0 to 63;
    type memory_type is array (0 to 63) of integer range -64 to 63;
    signal amplitude : memory_type := (  
    -- guit
    0, -4, -1, -1, -1, -4, -9, -13, -16, -17, -16, -1, 9, 12, 21, 29, 36, 37, 31, 17, 12, 20, 16, 12, 12, 11, 5, 0, -2, 3, 18, 27, 25, 20, 18, 22, 29, 36, 42, 44, 44, 44, 42, 43, 49, 57, 63, 56, 55, 53, 55, 50, 37, 23, 15, 9, 2, -5, -2, 3, 11, 15, 15, 9
    );
    -- vec to int conversions
    signal freq : integer:= to_integer(unsigned(frequency));
    signal vol  : integer:= to_integer(unsigned(volume));
    
begin
    trigger <= note_string(20);
    restart <= note_string(19);
    freq    <= to_integer(unsigned(note_string(18 downto 7)));
    vol     <= to_integer(unsigned(note_string(6 downto 0)));
    process(clk100MHz) begin
        if rising_edge(clk100MHz) then
            if trigger = '1' then
                if index_counter > 100000000 / (64 * freq) then 
                    index_counter <= 0;
                    if index = 63 then
                        index <= 0;
                    else 
                        index <= index + 1;
                    end if;
                else 
                    index_counter <= index_counter + 1;
                end if;
            else 
                index <= 0;
                index_counter <= 0;
            end if;
        end if;
    end process;
    process(clk100KHz) begin
        if rising_edge(clk100KHz) then
            if trigger = '1' then
                int_out <= amplitude(index);
            else
                int_out <= 0;
            end if;
        end if;
    end process;
    trigger_o <= trigger;
    restart_o <= restart;
end Behavioral;