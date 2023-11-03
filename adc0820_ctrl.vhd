-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 14:53:34 10/13/2023 
-- adc0820_ctrl.vhd - behavioral 
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	ADC0820 controller. The data output is in o_db. Use cap_clk to capture a
--		data frame.
--	deps:
--		std_type.vhd

library ieee;
use ieee.std_logic_1164.all;
use work.std_type.all;
--use ieee.numeric_std.all;

entity adc0820_ctrl is
port (
	-- "capture clock" rising edge signifies being data transfer
	cap_clk	:	in		std_logic;
	
	-- ports connected directly to ADC
	o_csI		:	out	std_logic;
	o_rdI		:	out	std_logic;
	
	-- data in (connected to ADC) and out
	i_db		:	in		b8_t;
	o_db		:	out	b8_t
);
end adc0820_ctrl;

architecture behavioral of adc0820_ctrl is

signal w_db		:	b8_t := (others => '0');
signal w_rdI	:	std_logic;

begin

process(cap_clk)
begin
	if rising_edge(cap_clk) then
		w_db <= i_db; -- only set o_db on clock
	end if;
end process;

o_csI <= '0';
o_rdI <= cap_clk;
o_db <= w_db;

end behavioral;
