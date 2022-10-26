library IEEE;
use ieee.std_logic_1164.all;

entity h2InMux is
	port(w0: in std_logic_vector(7 downto 0);
	w1: in std_logic_vector(7 downto 0);
	en: in std_logic;
	y: out std_logic_vector(7 downto 0));
end h2InMux;

architecture struct2mux of h2InMux is 
	signal NOTen: std_logic;
	
	begin
		NOTen <= not(en);
		y(7) <= (NOTen and w0(7)) or (en and w1(7));
		y(6) <= (NOTen and w0(6)) or (en and w1(6));
		y(5) <= (NOTen and w0(5)) or (en and w1(5));
		y(4) <= (NOTen and w0(4)) or (en and w1(4));
		y(3) <= (NOTen and w0(3)) or (en and w1(3));
		y(2) <= (NOTen and w0(2)) or (en and w1(2));
		y(1) <= (NOTen and w0(1)) or (en and w1(1));
		y(0) <= (NOTen and w0(0)) or (en and w1(0));
end struct2mux;