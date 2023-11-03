-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 23:31:58 10/14/2023  
-- diag_fmtr.vhd 
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	Special diagnostic display formatter. Depends only on clock.
--	deps:
-- 	none

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity diag_fmtr is
port (
	i_clk		:	in		std_logic;
	o_disp	:	out	std_logic_vector(7 downto 0)
);
end diag_fmtr;

architecture behavioral of diag_fmtr is
signal	disp	:	std_logic_vector(7 downto 0) := (others => '0');
begin

process(i_clk)
begin
if rising_edge(i_clk) then
	disp <= not disp;
end if;
end process;

o_disp <= disp;

end behavioral;

