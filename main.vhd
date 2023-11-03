-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 11:45:40 10/13/2023 
-- main.vhd
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	Top level entity
--	deps:
--		- std_type.vhd
--		- clock.vhd
--		- display.vhd
-- 	- clk_div.vhd
--		- adc0820_ctrl.vhd
--		- disp_ctrl.vhd
--		- sped_selt.vhd
--		- mode_selt.vhd

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use work.std_type.all;
use work.display.all;
use work.clock.all;

entity main is
port(
	i_gclk		:	in		std_logic; -- input clock (32MHz)
	i_rst			:	in		std_logic; -- reset button
	i_mode		:	in		std_logic_vector(3 downto 0);
	i_speed		:	in		std_logic_vector(1 downto 0); -- only first 2 bits
	i_adc_db		:	in		b8_t; -- adc data in
	o_adc_csI	:	out	std_logic;
	o_adc_rdI	:	out	std_logic;
	o_led			:	out	b8_t -- <0> is rightmost
);
end main;

architecture behavioral of main is

component clk_div is
port(
	i_clk :	in		std_logic;
	o_clk	:	out	std_logic;
	b_rst	:	in		clk_speed;
	i_en	:	in		std_logic
);
end component;

component adc0820_ctrl is
port (
	cap_clk	:	in		std_logic;
	o_csI		:	out	std_logic;
	o_rdI		:	out	std_logic;
	i_db		:	in		b8_t;
	o_db		:	out	b8_t
);
end component;

component disp_ctrl is
port(
	i_clk		:	in		std_logic;
	i_fmt		:	in		disp_fmt;
	i_bin		:	in		b8_t;
	o_disp	:	out	b8_t
);
end component;

component sped_selt is
port(
	i_usr			:	in		std_logic_vector(1 downto 0);
	o_clk_rst	:	out	clk_speed
);
end component;

component mode_selt is
port(
	i_usr			:	in		std_logic_vector(3 downto 0);
	o_disp_fmt	:	out	disp_fmt
);
end component;

signal cap_clk		:	std_logic; -- data capture clock from clock divider
signal cap_en		:	std_logic := '1'; -- data capture enable
signal clk_b_rst	:	clk_speed;
signal adc_db		:	b8_t := (others => '0');
signal usr_fmt		:	disp_fmt;

begin

-- clock divider instance
clk_div_inst	:	clk_div
port map(
	i_clk => i_gclk,
	o_clk => cap_clk,
	b_rst	=> clk_b_rst,
	i_en	=> cap_en
);

-- adc controller instance
adc_ctrl	:	adc0820_ctrl
port map(
	cap_clk	=> cap_clk,
	o_csI		=>	o_adc_csI,
	o_rdI		=>	o_adc_rdI,
	i_db		=> i_adc_db,
	o_db		=> adc_db
);

-- display controller instance
disp_ctrl_inst	:	disp_ctrl
port map(
	i_clk		=> cap_clk,
	i_fmt		=> usr_fmt,
	i_bin		=>	adc_db,
	o_disp	=>	o_led
);

-- speed selector instance
speed_select	:	sped_selt
port map(
	i_usr			=>	i_speed,
	o_clk_rst	=>	clk_b_rst
);

-- mode selector instance
mode_select		:	mode_selt
port map(
	i_usr			=> i_mode,
	o_disp_fmt	=>	usr_fmt
);

-- capture enable toggler
process(i_rst)
begin
	if falling_edge(i_rst) then
		cap_en <= not cap_en;
	end if;
end process;

-- testing purposes. increment adc_db every clock.
--process(cap_clk)
--begin
--if rising_edge(cap_clk) then
--	adc_db <= std_logic_vector(unsigned(adc_db) + 1);
--end if;
--end process;

--adc_db <= i_adc_db;

end behavioral;
