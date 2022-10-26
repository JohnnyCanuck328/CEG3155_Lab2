library ieee;
use ieee.std_logic_1164.all;

--is dependant on eightBitAdder, h2InMux
entity twoComp8bit is
	port (A : in std_logic_vector(7 downto 0);
			enable : in std_logic;
			isConverted : out std_logic;
			AC : out std_logic_vector(7 downto 0));
end twoComp8bit;

architecture structTwoComp8b of twoComp8bit is

	component h2InMux
		port(w0: in std_logic_vector(7 downto 0);
			w1: in std_logic_vector(7 downto 0);
			en: in std_logic;
			y: out std_logic_vector(7 downto 0));
	end component;
	
	component eightBitAdder
	PORT(
		i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(7 downto 0);
		carryOut		: OUT	STD_LOGIC;
		carryIn: in std_logic;
		o_Sum			: OUT	STD_LOGIC_VECTOR(7 downto 0));
	END component;
	
	signal NOTA : std_logic_vector(7 downto 0);
	signal complement : std_logic_vector(7 downto 0);
	begin
	
	NOTA <= NOT(A);
	
	adder : eightBitAdder port map(i_Ai => NOTA, i_Bi => "00000001", carryIn => '0', o_sum => complement);
	
	mux: h2InMux port map(w0(0) => A(0), w0(1) => A(1), w0(2) => A(2), w0(3) => A(3), w1 => complement, en => enable, y => AC);
	
	isConverted <= enable;
end structTwoComp8b;