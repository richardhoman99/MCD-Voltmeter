-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 22:07:41 10/14/2023  
-- disp_ctrl.vhd 
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	The voltmeter display controller. Formats binary input as a displayable led
--		string based on the input format.
--	deps:
--		std_type.vhd
-- 	display.vhd
--		disp_fmtr.vhd
--		diag_fmtr.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.std_type.all;
use work.display.all;

entity disp_ctrl is
port(
	i_clk		:	in		std_logic; -- input clock, negative edge triggered
	i_fmt		:	in		disp_fmt; -- format select
	i_bin		:	in		b8_t; -- input binary
	
	-- formatted output
	o_disp	:	out	b8_t := (others => '0')
);
end disp_ctrl;

architecture behavioral of disp_ctrl is

component disp_fmtr is
port(
	i_bin		:	in		b8_t;
	o_disp	:	out	b8_t
);
end component;

component diag_fmtr is
port (
	i_clk		:	in		std_logic;
	o_disp	:	out	b8_t
);
end component;

signal s_abst	:	b8_t;
signal s_mdpt	:	b8_t;
signal s_diag	:	b8_t;
signal s_bnry	:	b8_t;
begin

-- absolute mode formatter instance
abst_fmtr	: entity work.disp_fmtr(abst)
port map(
	i_bin		=> i_bin,
	o_disp	=>	s_abst
);

-- midpoint mode formatter instance
mdpt_fmtr	: entity work.disp_fmtr(mdpt)
port map(
	i_bin		=> i_bin,
	o_disp	=>	s_mdpt
);

-- diagnostic mode instance
diag_fmtr_inst	:	diag_fmtr
port map(
	i_clk		=>	i_clk,
	o_disp	=> s_diag
);

-- select format from input format
with i_fmt select
	o_disp	<=	s_abst when abst,
					s_mdpt when mdpt,
					s_bnry when bnry,
					s_diag when diag,
					(others => '1') when alon,
					(others => '0') when others;

s_bnry <= i_bin; -- binary format is hardwired to input binary

end behavioral;

