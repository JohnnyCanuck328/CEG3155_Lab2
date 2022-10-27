library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplier4bit is
 port ( multiplier: in STD_LOGIC_VECTOR (3 downto 0);
	multiplicand: in STD_LOGIC_VECTOR (3 downto 0);
	P: out STD_LOGIC_VECTOR (7 downto 0));
end multiplier4bit;
 
architecture structMulti of multiplier4bit is
 
component oneBitAdder IS
	PORT(
		i_CarryIn		: IN	STD_LOGIC;
		i_Ai, i_Bi		: IN	STD_LOGIC;
		o_Sum, o_CarryOut	: OUT	STD_LOGIC);
END component;

component halfAdder is
	port(A,B: in std_logic;
			sum, carryout: out std_logic);
end component;


--handels negative numbers (only 4 bits), connect msb to enable, at the end, take the xor of both msb
component twoComp
	port (A : in std_logic_vector(3 downto 0);
			enable : in std_logic;
			isConverted : out std_logic;
			AC : out std_logic_vector(3 downto 0));
end component;

component eightBitAdder
	PORT(
		i_Ai, i_Bi		: IN	STD_LOGIC_VECTOR(7 downto 0);
		carryOut		: OUT	STD_LOGIC;
		carryIn: in std_logic;
		o_Sum			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END component;

component h2InMux
	port(w0: in std_logic_vector(7 downto 0);
		w1: in std_logic_vector(7 downto 0);
		en: in std_logic;
		y: out std_logic_vector(7 downto 0));
end component;
	
-- Intermediate declaration
signal A,B : std_logic_vector(3 downto 0);
signal AB0, AB1, AB2, AB3: STD_LOGIC_VECTOR (3 downto 0);
signal C1, C2, C3: STD_LOGIC_VECTOR (3 downto 0);
signal P1, P2, P3: STD_LOGIC_VECTOR (3 downto 0);
signal convertPlier, convertPlicand, convertBack: std_logic;
signal PI, NPI, prodComp : std_logic_vector(7 downto 0);
signal gnd: std_logic_vector(7 downto 0);

begin

input1 : twoComp port map(A => multiplier, enable => multiplier(3), isConverted => convertPlier, AC => A);
input2 : twoComp port map(A => multiplicand, enable => multiplicand(3), isConverted => convertPlicand, AC => B);


-- Multiplier input
AB0(0) <= multiplier(0) and multiplicand(0);
AB0(1) <= A(1) and B(0);
AB0(2) <= A(2) and B(0);
AB0(3) <= A(3) and B(0);

AB1(0) <= A(0) and B(1);
AB1(1) <= A(1) and B(1);
AB1(2) <= A(2) and B(1);
AB1(3) <= A(3) and B(1);

AB2(0) <= A(0) and B(2);
AB2(1) <= A(1) and B(2);
AB2(2) <= A(2) and B(2);
AB2(3) <= A(3) and B(2);

AB3(0) <= A(0) and B(3);
AB3(1) <= A(1) and B(3);
AB3(2) <= A(2) and B(3);
AB3(3) <= A(3) and B(3);

gnd <= "11111111";


FA1: oneBitAdder port map( i_Ai => AB0(2), i_Bi => AB1(1), i_CarryIn => C1(0), o_CarryOut => C1(1), o_Sum => P1(1));
FA2: oneBitAdder port map( i_Ai => AB0(3), i_Bi => AB1(2), i_CarryIn => C1(1), o_CarryOut => C1(2), o_Sum => P1(2));
FA3: oneBitAdder port map( i_Ai => P1(2), i_Bi => AB2(1), i_CarryIn => C2(0), o_CarryOut => C2(1), o_Sum => P2(1));
FA4: oneBitAdder port map( i_Ai => P1(3), i_Bi => AB2(2), i_CarryIn => C2(1), o_CarryOut => C2(2), o_Sum => P2(2));
FA5: oneBitAdder port map( i_Ai => C1(3), i_Bi => AB2(3), i_CarryIn => C2(2), o_CarryOut => C2(3), o_Sum => P2(3));
FA6: oneBitAdder port map( i_Ai => P2(2), i_Bi => AB3(1), i_CarryIn => C3(0), o_CarryOut => C3(1), o_Sum => P3(1));
FA7: oneBitAdder port map( i_Ai => P2(3), i_Bi => AB3(2), i_CarryIn => C3(1), o_CarryOut => C3(2), o_Sum => P3(2));
FA8: oneBitAdder port map( i_Ai => C2(3), i_Bi => AB3(3), i_CarryIn => C3(2), o_CarryOut => C3(3), o_Sum => P3(3));


HA1: halfAdder port map( A => AB0(1), B => AB1(0), carryout => C1(0), sum => P1(0));
HA2: halfAdder port map( A => AB1(3), B => C1(2), carryout => C1(3), sum => P1(3));
HA3: halfAdder port map( A => P1(1), B => AB2(0), carryout => C2(0), sum => P2(0));
HA4: halfAdder port map( A => P2(1), B => AB3(0), carryout => C3(0), sum => P3(0));



PI(0)<= AB0(0);
PI(1)<= P1(0);
PI(2)<= P2(0);
PI(3)<= P3(0);
PI(4)<= P3(1);
PI(5)<= P3(2);
PI(6)<= P3(3);
PI(7)<= C3(3);

--need to create 8 bit 2's complement here, take NOTP
--product : twoComp port map(A(0) => , A(1) => , A(2) => , A(3) => , A(4) => , A(5) => , A(6) => , A(7) => , enable => multiplicand(3), isConverted => convertPlicand, AC => B);

NPI <= NOT(PI);
convertBack <= multiplier(3) xor multiplicand(3);

eightAdder : eightBitAdder port map(i_Ai => PI xor gnd, i_Bi => "00000001", carryIn => '0', carryOut => open, o_Sum => prodComp);

mux: h2InMux port map(w0 => PI, w1 => prodComp, en => convertBack, y => P);


end structMulti;