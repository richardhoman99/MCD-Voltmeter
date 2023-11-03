-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 11:46:14 10/13/2023
-- clk_div.vhd - behavioral 
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	Basic clock divider circuit. Utilizes an internal counter signal of
--		length COUNT_WIDTH to determine division. In effect, the period of
--		o_clk (T_o_clk) = (T_i_clk)*(2^COUNT_WIDTH). Default division factor
--		is 2.
--	deps:
-- 	clock.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.clock.all;

entity clk_div is
port(
	i_clk :	in		std_logic;
	o_clk	:	out	std_logic;
	b_rst	:	in		clk_speed;
	i_en	:	in		std_logic -- enable
);
end clk_div;

architecture behavioral of clk_div is
signal count : unsigned(CLOCK_WIDTH-1 downto 0) := (others=>'0');
begin

process(i_clk, i_en)
begin
	if i_en = '1' then
		if rising_edge(i_clk) then
			count <= count + 1;
			if count(b_rst) = '1' then
				count <= (others => '0');
			end if;
		end if;
	end if;
end process;

o_clk <= count(b_rst-1);

end behavioral;
