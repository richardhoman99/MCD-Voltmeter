-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 23:11:49 10/14/2023 
-- mode_selt 
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	Mode selector/decoder. Translates user input into a a display format.
--	deps:
-- 	- display.vhd

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use work.display.all;

entity mode_selt is
port(
	i_usr			:	in		std_logic_vector(3 downto 0);
	o_disp_fmt	:	out	disp_fmt
);
end mode_selt;

architecture behavioral of mode_selt is
begin

-- mux
with i_usr select
	o_disp_fmt	<= abst when "0001",
						mdpt when "0010",
						diag when "0011",
						bnry when "0101",
						alon when "1111",
						alof when others;

end behavioral;
