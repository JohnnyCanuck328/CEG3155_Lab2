library ieee;
use ieee.std_logic_1164.all;

entity datapath is
	port(operandA, operandB: in std_logic_vector(3 downto 0);
			sel0, sel1, g_clk, globalRes: in std_logic;
			MuxOut: out std_logic_vector(7 downto 0);
			zeroOut, overflowOut, carryOut: out std_logic);
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
	
	signal dividerOut, multiplierOut, addSubOut, mux4Out, resultInt: std_logic_vector(7 downto 0);
	signal addSubCarry, addSubBit3, overflow,vcc: std_logic;
	
	begin
	
		myDiv: divider4bit port map(dividend => operandA, divisor => operandB, quotient(0) => dividerOut(0),
		quotient(1) => dividerOut(1), quotient(2) => dividerOut(2), quotient(3) => dividerOut(3), remainder => open);
		
		vcc <= '1';
		dividerOut(4) <= dividerOut(2);
		dividerOut(5) <= dividerOut(2);
		dividerOut(6) <= dividerOut(2);
		dividerOut(7) <= dividerOut(2);
		
		myMulti: multiplier4bit port map( multiplier => operandA, multiplicand => operandB, P => multiplierOut);
		
		addSub: fourbitaddsub PORT MAP(i_Ai => operandA, i_Bi => operandB, carryOut => addSubCarry, controller => sel0, 
		o_Sum(0) => addSubOut(0), o_Sum(1) => addSubOut(1), o_Sum(2) => addSubOut(2), o_Sum(3) => addSubBit3, overflow => overflow);
		
		addSubOut(3) <= addSubBit3;
		addSubOut(4) <= '0' XOR (addSubBit3 AND NOT(overflow));
		addSubOut(5) <= '0' XOR (addSubBit3 AND NOT(overflow));
		addSubOut(6) <= '0' XOR (addSubBit3 AND NOT(overflow));
		addSubOut(7) <= '0' XOR (addSubBit3 AND NOT(overflow));
		
		outputMux: fourMux port map(uw0 => multiplierOut, uw1 => dividerOut, uw2 => addSubOut, uw3 => addSubOut,
								s0 => sel0, s1 => sel1, uy => mux4Out);
								
		Display: eightBitLeftShift PORT MAP(controller => vcc, clk => g_clk, reset => NOT(globalRes), shiftIn => vcc, enable => vcc, inp => mux4Out,
													output0 => resultInt(0), output1 => resultInt(1), output2 => resultInt(2), output3 => resultInt(3), output4 => resultInt(4),
													output5 => resultInt(5), output6 => resultInt(6), output7 => resultInt(7), NOToutput => open);
													
		zeroOut <= NOT(resultInt(0) OR resultInt(1) OR resultInt(2) OR resultInt(3) OR resultInt(4) OR resultInt(5) OR resultInt(6));
		carryOut <= sel1 and addSubCarry;
		overflowOut <= overflow;
		MuxOut <= resultInt;
end structData;