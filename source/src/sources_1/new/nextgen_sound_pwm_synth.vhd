library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nextgen_sound_pwm_synth is
    port (
        reset_time : in std_logic;
        clk_100Mhz : in std_logic;
        
        switch_ch  : in std_logic_vector(3 downto 0);
        final_PWM  : out std_logic
    );
end nextgen_sound_pwm_synth;

architecture Behavioral of nextgen_sound_pwm_synth is
    component clk100_gen is
        port ( 
            clk_100MHz : in std_logic;
            
            clk_100KHz : out std_logic
        );
    end component;
    component tick_clk_div is
        port (
            clk_100Mhz  : in std_logic;                     -- input 100MHz clock from BASYS3
        
            tempo_clock : out std_logic                     -- divided clock, for tempo
        );
    end component;
    component nextgen_ch1_supermodule is 
        port ( 
            reset_time : in std_logic;
            clk_100Mhz : in std_logic;
            clk_100KHz : in std_logic;
            tempo_clock: in std_logic;
            
            PWM_int_out: out integer range -256 to 255
        );
    end component;
    component nextgen_ch2_supermodule is 
        port ( 
            reset_time : in std_logic;
            clk_100Mhz : in std_logic;
            clk_100KHz : in std_logic;
            tempo_clock: in std_logic;
                
            PWM_int_out: out integer range -256 to 255
        );
    end component;
    component nextgen_ch3_supermodule is 
        port ( 
            reset_time : in std_logic;
            clk_100Mhz : in std_logic;
            clk_100KHz : in std_logic;
            tempo_clock: in std_logic;
            
            PWM_int_out: out integer range -256 to 255
        );
    end component;
    component nextgen_ch4_supermodule is 
        port ( 
            reset_time : in std_logic;
            clk_100Mhz : in std_logic;
            clk_100KHz : in std_logic;
            tempo_clock: in std_logic;
            
            PWM_int_out: out integer range -256 to 255
        );
    end component;
    component mixer_4_channel is
        port ( 
            ch_1_in     : in integer range -256 to 255;
            ch_2_in     : in integer range -256 to 255;
            ch_3_in     : in integer range -256 to 255;
            ch_4_in     : in integer range -256 to 255;
            clk_100KHz  : in std_logic;
            switch_ch   : in std_logic_vector(3 downto 0);
            
            pwm_out     : out integer range -1024 to 1023
        );
    end component;
    component super_PWM_generator is
        port (
             basys3_100Mhz          : in std_logic;
             pwm_input              : in integer range -1024 to 1023;
             
             PWM_modulated_signal   : out std_logic
        );
    end component;
    signal ch1_int_out, ch2_int_out, ch3_int_out, ch4_int_out   : integer range -256 to 255;
    signal to_pwm                                               : integer range -1024 to 1023;
    signal tempo_clock, slow_clock                              : std_logic;
begin
    clk100 : clk100_gen
        port map (
            clk_100Mhz   => clk_100Mhz,
            
            clk_100KHz  => slow_clock
        );
    t_clk : tick_clk_div
        port map (
            clk_100Mhz   => clk_100Mhz,
            
            tempo_clock  => tempo_clock
        );
    ch1 : nextgen_ch1_supermodule
        port map (
            reset_time   => reset_time,
            clk_100Mhz   => clk_100Mhz,
            clk_100KHz   => slow_clock,
            tempo_clock  => tempo_clock,
            
            PWM_int_out  => ch1_int_out
        );
    ch2 : nextgen_ch2_supermodule
        port map (
            reset_time   => reset_time,
            clk_100Mhz   => clk_100Mhz,
            clk_100KHz   => slow_clock,
            tempo_clock  => tempo_clock,
            
            PWM_int_out  => ch2_int_out
        );
    ch3 : nextgen_ch3_supermodule
        port map (
            reset_time   => reset_time,
            clk_100Mhz   => clk_100Mhz,
            clk_100KHz   => slow_clock,
            tempo_clock  => tempo_clock,
            
            PWM_int_out  => ch3_int_out
        );
    ch4 : nextgen_ch4_supermodule
        port map (
            reset_time   => reset_time,
            clk_100Mhz   => clk_100Mhz,
            clk_100KHz   => slow_clock,
            tempo_clock  => tempo_clock,
            
            PWM_int_out  => ch4_int_out
        );
    final_mix : mixer_4_channel
        port map (
            ch_1_in   => ch1_int_out,
            ch_2_in   => ch2_int_out,
            ch_3_in   => ch3_int_out,
            ch_4_in   => ch4_int_out,
            clk_100KHz=> slow_clock,

            switch_ch => switch_ch,
            pwm_out   => to_pwm
        );
    pwm_gen : super_PWM_generator
        port map (
            basys3_100Mhz       => clk_100Mhz,
            pwm_input           => to_pwm,
            
            PWM_modulated_signal=> final_PWM
        );
end Behavioral;