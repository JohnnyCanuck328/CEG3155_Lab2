library IEEE;
use ieee.std_logic_1164.all;

entity h2InMux4bit is
	port(w0: in std_logic_vector(3 downto 0);
	w1: in std_logic_vector(3 downto 0);
	en: in std_logic;
	y: out std_logic_vector(3 downto 0));
end h2InMux4bit;

architecture struct2mux4b of h2InMux4bit is 
	signal NOTen: std_logic;
	
	begin
		NOTen <= not(en);
		y(3) <= (NOTen and w0(3)) or (en and w1(3));
		y(2) <= (NOTen and w0(2)) or (en and w1(2));
		y(1) <= (NOTen and w0(1)) or (en and w1(1));
		y(0) <= (NOTen and w0(0)) or (en and w1(0));
end struct2mux4b;