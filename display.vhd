-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- display.vhd 
-- r0.1
-- desc:
-- 	Defines the global "disp_fmt" type, which is used for selecting display
--		modes.
--	deps:
-- 	none

library ieee;
use ieee.std_logic_1164.all;

package display is

type disp_fmt	is	(abst, mdpt, bnry, diag, alon, alof);

end display;
