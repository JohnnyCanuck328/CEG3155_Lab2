library ieee;
use ieee.std_logic_1164.all;

entity fourBitMulti is
	port(multiplier: in std_logic_vector(3 downto 0);--X
			multiplicand: in std_logic_vector(3 downto 0);--Y
			product: out std_logic_vector(7 downto 0));
end fourBitMulti;

architecture structfourMulti of fourBitMulti is

	component halfAdder
		port(A,B: in std_logic;
			sum, carryout: out std_logic);
	end component;
	
	component onebitadder
		PORT(
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
	end component;
	
	signal andOut: std_logic_vector(9 downto 0);
	signal nandOut: std_logic_vector(5 downto 0);
	signal adderOut: std_logic_vector(5 downto 0);
	signal carryValue: std_logic_vector(11 downto 0);
	
	begin
	
	product(0) <= multiplier(0) and multiplicand(0);
	
	--	First Row		X						Y
	--half adder 0
	andOut(1) <= multiplier(0) and multiplicand(1);
	andOut(2) <= multiplier(1) and multiplicand(0);
	
	--full adder 0
	andOut(3) <= multiplier(1) and multiplicand(1);
	andOut(4) <= multiplier(2) and multiplicand(0);
	
	--full adder 1
	andOut(5) <= multiplier(2) and multiplicand(1);
	nandOut(0) <= NOT(multiplier(3) and multiplicand(0));
	
	--full adder 2(also takes '1')
	nandOut(1) <= NOT(multiplier(3) and multiplicand(1));
	
	
	
	--Second Row		X						Y
	--half adder 1
	andOut(6) <= multiplier(0) and multiplicand(2);
	
	--full adder 3
	andOut(7) <= multiplier(1) and multiplicand(2);
	
	--full adder 4
	andOut(8) <= multiplier(2) and multiplicand(2);
	
	--full adder 5
	nandOut(2) <= NOT(multiplier(3) and multiplicand(2));
	
	--Third Row
	--half adder 2
	nandOut(3) <= NOT(multiplier(0) and multiplicand(3));
	
	--full adder 6
	nandOut(4) <= NOT(multiplier(1) and multiplicand(3));
	
	--full adder 7
	nandOut(5) <= NOT(multiplier(2) and multiplicand(3));
	
	--full adder 8
	andOut(9) <= multiplier(3) and multiplicand(3);
	
	--------------------------------------
	--												--
	--												--
	--												--
	--------------------------------------
	
	--FIRST ROW
	hA0: halfAdder port map(A => andOut(1), B => andOut(2), sum => product(1), carryout => carryValue(0));
	
	fA0: onebitadder port map(i_CarryIn => carryValue(0), i_Ai => andOut(3), i_Bi => andOut(4), o_Sum => adderOut(0), o_CarryOut => carryValue(1));
	
	fA1: onebitadder port map(i_CarryIn => carryValue(1), i_Ai => andOut(5), i_Bi => nandOut(0), o_Sum => adderOut(1), o_CarryOut => carryValue(2));
	
	fA2: onebitadder port map(i_CarryIn => carryValue(2), i_Ai => nandOut(1), i_Bi => '1', o_Sum => adderOut(2), o_CarryOut => carryValue(3));
	
	
	--SECOND ROW
	hA1: halfAdder port map(A => andOut(6), B => adderOut(0), sum => product(2), carryout => carryValue(4));
	
	fA3: onebitadder port map(i_CarryIn => carryValue(4), i_Ai => andOut(7), i_Bi => adderOut(1), o_Sum => adderOut(3), o_CarryOut => carryValue(5));
	
	fA4: onebitadder port map(i_CarryIn => carryValue(5), i_Ai => andOut(8), i_Bi => adderOut(2), o_Sum => adderOut(4), o_CarryOut => carryValue(6));
	
	fA5: onebitadder port map(i_CarryIn => carryValue(6), i_Ai => carryValue(3), i_Bi => nandOut(2), o_Sum => adderOut(5), o_CarryOut => carryValue(7));
	
	--THIRD ROW
	hA2: halfAdder port map(A => nandOut(3), B => adderOut(3), sum => product(3), carryout => carryValue(8));
	fA6: onebitadder port map(i_CarryIn => carryValue(8), i_Ai => nandOut(4), i_Bi => adderOut(4), o_Sum => product(4), o_CarryOut => carryValue(9));
	fA7: onebitadder port map(i_CarryIn => carryValue(9), i_Ai => nandOut(5), i_Bi => adderOut(5), o_Sum => product(5), o_CarryOut => carryValue(10));
	
	--Error occures with these two, could be because of error above in design
	fA8: onebitadder port map(i_CarryIn => carryValue(10), i_Ai => andOut(9), i_Bi => carryValue(7), o_Sum => product(6), o_CarryOut => carryValue(11));
	hA3: halfAdder port map(A => carryValue(11), B => '1', sum => product(7), carryout => open);
end structfourMulti;