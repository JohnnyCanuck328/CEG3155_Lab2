library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port(num0, num1: in std_logic_vector(3 downto 0);
			sel0, sel1: in std_logic;
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
	
	signal dividerOut, multiplierOut, addSubOut: std_logic_vector(7 downto 0);
	signal addSubCarry, addSubBit3, overflow: std_logic;
	
	begin
	
		myDiv: divider4bit port map(dividend => num0, divisor => num1, quotient(0) => dividerOut(0),
		quotient(1) => dividerOut(1), quotient(2) => dividerOut(2), quotient(3) => dividerOut(3), remainder => open);
		
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
								s0 => sel0, s1 => sel1, uy => result);

end structData;