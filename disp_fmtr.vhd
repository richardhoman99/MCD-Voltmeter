-- MCD Voltmeter Project
-- LeTourneau University
-- Richard Homan
-- 22:28:51 10/14/2023  
-- disp_fmtr.vhd 
-- target: XC9572XL-10VG44C
-- r0.1
-- desc:
-- 	A module used to format a binary input into displayable output. Different
--		architectures define different behaviors for their respective formats.
--	deps:
-- 	std_type.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.std_type.all;

entity disp_fmtr is
port(
	i_bin		:	in		b8_t;
	o_disp	:	out	b8_t := (others => '0')
);
end disp_fmtr;

-- absolute formatter architecture
architecture abst of disp_fmtr is
begin

process(i_bin)
variable int_eq	: integer;
variable	thresh	: integer;
begin

int_eq := to_integer(unsigned(i_bin));
for b in 0 to 7 loop
	thresh := 32*b + 16;
	if int_eq > thresh then
		o_disp(b) <= '1';
	else
		o_disp(b) <= '0';
	end if;
end loop;

end process;
end abst;

-- midpoint formatter architecture
architecture mdpt of disp_fmtr is
begin

process(i_bin)
variable int_eq	:	integer;
variable thresh	:	integer;
begin

int_eq := to_integer(unsigned(i_bin))-127;
if int_eq > 0 then
	o_disp(0) <= '0';
	o_disp(1) <= '0';
	o_disp(2) <= '0';
	o_disp(3) <= '0';
	for b in 0 to 3 loop
		thresh := (32*b + 16);
		if int_eq > thresh then
			o_disp(b+4) <= '1';
		else
			o_disp(b+4) <= '0';
		end if;
	end loop;
else
	o_disp(4) <= '0';
	o_disp(5) <= '0';
	o_disp(6) <= '0';
	o_disp(7) <= '0';
	for b in 0 to 3 loop
		thresh := -(32*b + 16);
		if int_eq < thresh then
			o_disp(3-b) <= '1';
		else
			o_disp(3-b) <= '0';
		end if;
	end loop;
end if;

end process;
end mdpt;
