-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- clock.vhd 
-- r0.1
-- desc:
-- 	Defines the global clock speeds and clock widths.
--	deps:
-- 	none

library ieee;
use ieee.std_logic_1164.all;

package clock is

subtype clk_speed	is integer range 12 to 26;

constant CLOCK_WIDTH	:	integer	:= 27;
constant SPEED_0_5	:	clk_speed := 26;
constant SPEED_1_0	:	clk_speed := 25;
constant SPEED_3_8	:	clk_speed := 23;
constant SPEED_7_8K	:	clk_speed := 12;

end clock;
