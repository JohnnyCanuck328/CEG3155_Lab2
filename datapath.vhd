library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port(num0, num1: in std_logic_vector(3 downto 0);
			sel0, sel1, g_clk, globalRes: in std_logic;
			result: out std_logic_vector(7 downto 0));
end datapath;

architecture structData of datapath is

	component divider4bit
		port (dividend, divisor: in std_logic_vector(3 downto 0);
				quotient, remainder: out std_logic_vector(3 downto 0));
	end component;
	
	component multiplier4bit
	 port ( multiplier: in STD_LOGIC_VECTOR (3 downto 0);
		multiplicand: in STD_LOGIC_VECTOR (3 downto 0);
		P: out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	--sub is active high
	component fourbitaddsub
		PORT(
			i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(3 downto 0);
			carryOut		: OUT	STD_LOGIC;
			controller: in std_logic;
			o_Sum			: OUT	STD_LOGIC_VECTOR(3 downto 0);
			overflow: out std_logic);
	END component;
	
	component fourMux
		port(uw0, uw1, uw2, uw3: in std_logic_vector(7 downto 0);
		s0, s1: in std_logic;
		uy: out std_logic_vector(7 downto 0));
	end component;
	
	COMPONENT eightBitLeftShift
		PORT
		(
			controller :  IN  STD_LOGIC;
			clk :  IN  STD_LOGIC;
			reset :  IN  STD_LOGIC;
			shiftIn :  IN  STD_LOGIC;
			enable :  IN  STD_LOGIC;
			inp :  IN  STD_LOGIC_VECTOR(7 downto 0);
			output0, output1, output2, output3, output4, output5, output6, output7 :  OUT  STD_LOGIC;
			NOToutput:  OUT  STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;
	
	signal dividerOut, multiplierOut, addSubOut, mux4Out: std_logic_vector(7 downto 0);
	signal addSubCarry, addSubBit3, overflow,vcc: std_logic;
	
	begin
	
		myDiv: divider4bit port map(dividend => num0, divisor => num1, quotient(0) => dividerOut(0),
		quotient(1) => dividerOut(1), quotient(2) => dividerOut(2), quotient(3) => dividerOut(3), remainder => open);
		
		vcc <= '1';
		dividerOut(4) <= '0';
		dividerOut(5) <= '0';
		dividerOut(6) <= '0';
		dividerOut(7) <= '0';
		
		myMulti: multiplier4bit port map( multiplier => num0, multiplicand => num1, P => multiplierOut);
		
		addSub: fourbitaddsub PORT MAP(i_Ai => num0, i_Bi => num1, carryOut => addSubCarry, controller => sel0, 
		o_Sum(0) => addSubOut(0), o_Sum(1) => addSubOut(1), o_Sum(2) => addSubOut(2), o_Sum(3) => addSubBit3, overflow => overflow);
		
		addSubOut(3) <= addSubBit3;
		addSubOut(4) <= '0' XOR (addSubBit3 AND NOT(overflow));--()(addSubBit3);
		addSubOut(5) <= '0' XOR (addSubBit3 AND NOT(overflow));
		addSubOut(6) <= '0' XOR (addSubBit3 AND NOT(overflow));
		addSubOut(7) <= '0' XOR (addSubBit3 AND NOT(overflow));
		
		outputMux: fourMux port map(uw0 => multiplierOut, uw1 => dividerOut, uw2 => addSubOut, uw3 => addSubOut,
								s0 => sel0, s1 => sel1, uy => mux4Out);
								
		Display: eightBitLeftShift PORT MAP(controller => vcc, clk => g_clk, reset => NOT(globalRes), shiftIn => vcc, enable => vcc, inp => mux4Out,
													output0 => result(0), output1 => result(1), output2 => result(2), output3 => result(3), output4 => result(4),
													output5 => result(5), output6 => result(6), output7 => result(7), NOToutput => open);
end structData;