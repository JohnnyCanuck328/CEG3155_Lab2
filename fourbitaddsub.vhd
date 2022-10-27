--------------------------------------------------------------------------------
-- Title         : 3-bit Adder
-- Project       : VHDL Synthesis Overview
-------------------------------------------------------------------------------
-- File          : threeBitAdder.vhd
-- Author        : Rami Abielmona  <rabielmo@site.uottawa.ca>
-- Created       : 2003/05/17
-- Last modified : 2007/09/25
-------------------------------------------------------------------------------
-- Description : This file creates a 3-bit binary full adder as defined in the VHDL
--		 Synthesis lecture.  The architecture is done at the RTL
--		 abstraction level and the implementation is done in structural
--		 VHDL.
-------------------------------------------------------------------------------
-- Modification history :
-- 2003.05.17 	R. Abielmona		Creation
-- 2004.09.22 	R. Abielmona		Ported for CEG 3550
-- 2007.09.25 	R. Abielmona		Modified copyright notice
-------------------------------------------------------------------------------
-- This file is copyright material of Rami Abielmona, Ph.D., P.Eng., Chief Research
-- Scientist at Larus Technologies.  Permission to make digital or hard copies of part
-- or all of this work for personal or classroom use is granted without fee
-- provided that copies are not made or distributed for profit or commercial
-- advantage and that copies bear this notice and the full citation of this work.
-- Prior permission is required to copy, republish, redistribute or post this work.
-- This notice is adapted from the ACM copyright notice.
--------------------------------------------------------------------------------

--Modified version uses an active low for addition and an active high for subtraction, doesn't support overflow, but does provide a carry bit,
--which can be xor with msb to detect
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fourbitaddsub IS
	PORT(
		i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(3 downto 0);
		carryOut		: OUT	STD_LOGIC;
		controller: in std_logic;
		o_Sum			: OUT	STD_LOGIC_VECTOR(3 downto 0);
		overflow: out std_logic);
END fourbitaddsub;

ARCHITECTURE rtl OF fourbitaddsub IS
	SIGNAL int_CarryOut : STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL gnd : STD_LOGIC;
	signal XORout: std_logic_vector(3 downto 0);

	COMPONENT oneBitAdder
	PORT(
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

	-- Concurrent Signal Assignment
	gnd <= '0';
	XORout(0) <= i_Bi(0) XOR controller;
	XORout(1) <= i_Bi(1) XOR controller;
	XORout(2) <= i_Bi(2) XOR controller;
	XORout(3) <= i_Bi(3) XOR controller;

	--msb to lsb
bit0: oneBitAdder
	PORT MAP (i_CarryIn => controller, 
			  i_Ai => i_Ai(0),
			  i_Bi => XORout(0),
			  o_Sum => o_Sum(0),
			  o_CarryOut => int_CarryOut(0));

bit1: oneBitAdder
	PORT MAP (i_CarryIn => int_CarryOut(0), 
			  i_Ai => i_Ai(1),
			  i_Bi => XORout(1),
			  o_Sum => o_Sum(1),
			  o_CarryOut => int_CarryOut(1));

bit2: oneBitAdder
	PORT MAP (i_CarryIn => int_CarryOut(1), 
			  i_Ai => i_Ai(2),
			  i_Bi => XORout(2),
			  o_Sum => o_Sum(2),
			  o_CarryOut => int_CarryOut(2));
			  
bit3: oneBitAdder
	PORT MAP (i_CarryIn => int_CarryOut(2), 
			  i_Ai => i_Ai(3),
			  i_Bi => XORout(3),
			  o_Sum => o_Sum(3),
			  o_CarryOut => int_CarryOut(3));
			  

			  
			  
overflow <= int_CarryOut(2) XOR int_CarryOut(3);
carryOut <= int_CarryOut(3);

END rtl;
