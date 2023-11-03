-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 23:04:35 10/14/2023 
-- sped_selt 
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	Speed selector/decoder. Translates user input into a clock reset value.
--	deps:
-- 	- clock.vhd

library ieee;
use ieee.std_logic_1164.all;
use work.clock.all;
--use ieee.numeric_std.all;

entity sped_selt is
port(
	i_usr			:	in		std_logic_vector(1 downto 0);
	o_clk_rst	:	out	clk_speed := SPEED_0_5
);
end sped_selt;

architecture behavioral of sped_selt is
begin

-- mux
with i_usr select
	o_clk_rst	<= SPEED_0_5  when "00", -- about 0.5 Hz
						SPEED_1_0  when "01", -- about 1 Hz
						SPEED_3_8  when "10", -- about 3.8 Hz
						SPEED_7_8K when "11", -- about 7.8 kHz
						SPEED_0_5  when others; -- default to 0.5 (never executed)

end behavioral;

