library ieee;
use ieee.std_logic_1164.all;

--is dependant on fourbitaddsub, h2InMux4bit
entity twoComp is
	port (A : in std_logic_vector(3 downto 0);
			enable : in std_logic;
			isConverted : out std_logic;
			AC : out std_logic_vector(3 downto 0));
end twoComp;

architecture structTwoComp of twoComp is

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
	
	signal NOTA : std_logic_vector(3 downto 0);
	signal complement : std_logic_vector(3 downto 0);
	begin
	
	NOTA <= NOT(A);
	
	fourBitAdder : fourbitaddsub port map(i_Ai => NOTA, i_Bi => "0001", controller => '0', o_sum => complement);
	
	mux: h2InMux4bit port map(w0(0) => A(0), w0(1) => A(1), w0(2) => A(2), w0(3) => A(3), w1 => complement, en => enable, y => AC);
	
	isConverted <= enable;
end structTwoComp;