library ieee;
use ieee.std_logic_1164.all;

entity divider4bit is
	port (dividend, divisor: in std_logic_vector(3 downto 0);
			quotient, remainder: out std_logic_vector(3 downto 0));
end divider4bit;

architecture structDiv of divider4bit is

	component fullSubtractor
		port(A,B,Bin,ctrl : in std_logic;
			D, Bout: out std_logic);
	end component;
	
	component twoComp
		port (A : in std_logic_vector(3 downto 0);
				enable : in std_logic;
				isConverted : out std_logic;
				AC : out std_logic_vector(3 downto 0));
	end component;
	
	component h2InMux4bit
		port(w0: in std_logic_vector(3 downto 0);
			w1: in std_logic_vector(3 downto 0);
			en: in std_logic;
			y: out std_logic_vector(3 downto 0));
	end component;
	
	component fourbitaddsub
		PORT(
			i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(3 downto 0);
			carryOut		: OUT	STD_LOGIC;
			controller: in std_logic;
			o_Sum			: OUT	STD_LOGIC_VECTOR(3 downto 0));
	END component;
		
	signal A, B, NOTdivisor, NOTB, NOTRes, reverseComp: std_logic_vector(3 downto 0);
	signal convertDividend, convertDivisor, convertBack: std_logic;
	signal mux2: std_logic;
	signal ORout: std_logic_vector(4 downto 0); 
	signal ANDout: std_logic_vector(5 downto 0);
	signal row1Bout, row2Bout, row3Bout: std_logic;
	signal difference, Bout: std_logic_vector(8 downto 0);
	
	begin
	
		input1: twoComp port map(A => dividend, enable => dividend(3), isConverted => convertDividend, AC => A);
		input2: twoComp port map(A => divisor, enable => divisor(3), isConverted => convertDivisor, AC => B);
	
		NOTdivisor <= divisor;
		
		ANDout(0) <= NOTB(1) and  NOTB(2) and NOTB(3);
		ANDout(1) <= NOTB(0) and A(3);
		ANDout(2) <= ANDout(0) and  A(3) and B(3);
		ANDout(3) <= NOT(ORout(0)) and ORout(2);
		ANDout(4) <= NOT(ORout(1)) and ORout(3);
		ANDout(5) <= NOT(Bout(8)) and ORout(4);
		
		ORout(0) <= Bout(1) or B(2) or B(3);
		ORout(1) <= Bout(4) or b(3);
		ORout(2) <= B(0) or B(1);
		ORout(3) <= ORout(2) or B(2);
		ORout(4) <= ORout(3) or B(3);
		
		
		mux2 <= (A(3) and NOT(ANDout(0))) or (ANDout(1) and ANDout(0));
		
		--row 1
		
		FS0: fullSubtractor port map(A => A(2), B => B(0), Bin => '0', ctrl => ORout(0), D => difference(0), Bout => Bout(0));
		FS1: fullSubtractor port map(A => mux2, B => B(1), Bin => Bout(0), ctrl => ORout(0), D => difference(1), Bout => Bout(1));
		
		--row 2
		
		FS2: fullSubtractor port map(A => A(1), B => B(0), Bin => '0', ctrl => ORout(1), D => difference(2), Bout => Bout(2));
		FS3: fullSubtractor port map(A => difference(0), B => B(1), Bin => Bout(2), ctrl => ORout(1), D => difference(3), Bout => Bout(3));
		FS4: fullSubtractor port map(A => difference(1), B => B(2), Bin => Bout(3), ctrl => ORout(1), D => difference(4), Bout => Bout(4));
		
		--row 3
		
		FS5: fullSubtractor port map(A => A(0), B => B(0), Bin => '0', ctrl => Bout(8), D => remainder(0), Bout => Bout(5));
		FS6: fullSubtractor port map(A => difference(2), B => B(1), Bin => Bout(5), ctrl => Bout(8), D => remainder(1), Bout => Bout(6));
		FS7: fullSubtractor port map(A => difference(3), B => B(2), Bin => Bout(6), ctrl => Bout(8), D => remainder(2), Bout => Bout(7));
		FS8: fullSubtractor port map(A => difference(4), B => B(3), Bin => Bout(7), ctrl => Bout(8), D => remainder(3), Bout => Bout(8));
		
		convertBack <= convertDivisor XOR convertDividend;
		
		NOTRes(0) <= NOT(ANDout(5));
		NOTRes(1) <= NOT(ANDout(4));
		NOTRes(2) <= NOT(ANDout(3));
		NOTRes(3) <= NOT(ANDout(2));
		
		fourBitAdder : fourbitaddsub port map(i_Ai => NOTRes, i_Bi => "1111", controller => '1', o_sum => reverseComp);
		
		resultMux: h2InMux4bit port map(w0(0) => ANDout(5), w0(1) => ANDout(4), w0(2) => ANDout(3), w0(3) => ANDout(2), w1 => reverseComp, en => convertBack, y => quotient);
		
end structDiv;