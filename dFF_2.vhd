LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY dFF_2 IS
	PORT(
					i_setBar   : IN STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q 	: OUT	STD_LOGIC);
		
END dFF_2;

ARCHITECTURE rtl OF dFF_2 IS
	signal i_n : STD_LOGIC;

BEGIN

oneBitRegister:
PROCESS(i_clock)
BEGIN

	IF (i_clock'EVENT and i_clock = '1' and i_setBar = '1') THEN
		i_n <= '0';
	ELSIF (i_clock'EVENT and i_clock = '1') THEN
		 i_n	<=	i_d;
	END IF;
END PROCESS oneBitRegister;

	--  Output Driver

	o_q		<=	i_n;


END rtl;