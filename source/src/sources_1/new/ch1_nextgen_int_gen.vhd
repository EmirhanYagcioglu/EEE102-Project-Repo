library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ch1_nextgen_int_gen is
    Port (
        ROMaddress  : in integer range 0 to 65535;
        clk100MHz   : in std_logic;
        clk_100KHz  : in std_logic;
        checker_s   : in std_logic;
        
        int_out     : out integer range -256 to 255
     );
end ch1_nextgen_int_gen;

architecture Behavioral of ch1_nextgen_int_gen is
    component ch1_ROM is
        Port (
            ROMaddress : in integer range 0 to 65535;        -- ROM access address
            
            sub_ch1_vec : out std_logic_vector(20 downto 0); -- sub channel-1 input vector
            sub_ch2_vec : out std_logic_vector(20 downto 0); -- sub channel-2 input vector
            sub_ch3_vec : out std_logic_vector(20 downto 0); -- sub channel-3 input vector
            sub_ch4_vec : out std_logic_vector(20 downto 0)  -- sub channel-4 input vector
        );
    end component;
    component nextgen_ch1subch_inst_gen is
        Port (
            note_string : in std_logic_vector(20 downto 0);
            clk100MHz   : in std_logic;
            clk100KHz   : in std_logic;
            
            trigger_o   : out std_logic;
            restart_o   : out std_logic;
            int_out : out integer range -64 to 63
         );
    end component;
    component nextgen_ch1_adsr_gen is
        Port (
            clk_100KHz  : in std_logic;
            trigger     : in std_logic;
            restart     : in std_logic;
            checker_s   : in std_logic;
            
            amp_factor  : out integer range 0 to 100
        );
    end component;
    component nextgen_ch_mix is
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
    end component;
    signal s_sub_ch1_vec, s_sub_ch2_vec, s_sub_ch3_vec, s_sub_ch4_vec : std_logic_vector(20 downto 0);
    signal s_int_out_1, s_int_out_2, s_int_out_3, s_int_out_4 : integer range -64 to 63;
    signal trigger1, trigger2, trigger3, trigger4 : std_logic;
    signal restart1, restart2, restart3, restart4 : std_logic;
    signal amp1, amp2, amp3, amp4 : integer range 0 to 100;
begin
    ch1ROM: ch1_ROM
        port map(
            ROMaddress => ROMaddress,
            
            sub_ch1_vec => s_sub_ch1_vec,
            sub_ch2_vec => s_sub_ch2_vec,
            sub_ch3_vec => s_sub_ch3_vec,
            sub_ch4_vec => s_sub_ch4_vec
        );
    instrument_gen1 : nextgen_ch1subch_inst_gen
        port map(
            note_string => s_sub_ch1_vec,
            clk100MHz   => clk100MHz,
            clk100KHz   => clk_100KHz,
            
            trigger_o   => trigger1,
            restart_o   => restart1,
            int_out     => s_int_out_1
        );
    instrument_gen2 : nextgen_ch1subch_inst_gen
        port map(
            note_string => s_sub_ch2_vec,
            clk100MHz   => clk100MHz,
            clk100KHz   => clk_100KHz,
            
            trigger_o   => trigger2,
            restart_o   => restart2,
            int_out     => s_int_out_2
        );
    instrument_gen3 : nextgen_ch1subch_inst_gen
        port map(
            note_string => s_sub_ch3_vec,
            clk100MHz   => clk100MHz,
            clk100KHz   => clk_100KHz,
            
            trigger_o   => trigger3,
            restart_o   => restart3,
            int_out     => s_int_out_3
        );
    instrument_gen4 : nextgen_ch1subch_inst_gen
        port map(
            note_string => s_sub_ch4_vec,
            clk100MHz   => clk100MHz,
            clk100KHz   => clk_100KHz,
            
            trigger_o   => trigger4,
            restart_o   => restart4,
            int_out     => s_int_out_4
        );
    adsr_gen1 : nextgen_ch1_adsr_gen
        port map (
            clk_100KHz  => clk_100KHz,
            trigger     => trigger1,
            restart     => restart1,
            checker_s   => checker_s,
            
            amp_factor  => amp1
        );
    adsr_gen2 : nextgen_ch1_adsr_gen
        port map (
            clk_100KHz  => clk_100KHz,
            trigger     => trigger2,
            restart     => restart2,
            checker_s   => checker_s,
            
            amp_factor  => amp2
        );
    adsr_gen3 : nextgen_ch1_adsr_gen
        port map (
            clk_100KHz  => clk_100KHz,
            trigger     => trigger3,
            restart     => restart3,
            checker_s   => checker_s,
            
            amp_factor  => amp3
        );
    adsr_gen4 : nextgen_ch1_adsr_gen
        port map (
            clk_100KHz  => clk_100KHz,
            trigger     => trigger4,
            restart     => restart4,
            checker_s   => checker_s,
            
            amp_factor  => amp4
        );
    ch_mix : nextgen_ch_mix
        port map( 
            int1 => s_int_out_1,
            int2 => s_int_out_2,
            int3 => s_int_out_3,
            int4 => s_int_out_4,
            adsr1 => amp1,
            adsr2 => amp2,
            adsr3 => amp3,
            adsr4 => amp4,
            
            clk_100MHz => clk100MHz,
            out_amp => int_out
        );
end Behavioral;