-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- std_type.vhd 
-- r0.1
-- desc:
-- 	Defines an 8-bit bus type
--	deps:
-- 	none

library ieee;
use ieee.std_logic_1164.all;

package std_type is

subtype b8_t	is	std_logic_vector(7 downto 0);

end std_type;
