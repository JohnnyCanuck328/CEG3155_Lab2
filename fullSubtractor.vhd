library ieee;
use ieee.std_logic_1164.all;

entity fullSubtractor is
	port(A,B,Bin,ctrl : in std_logic;
			D, Bout: out std_logic);
end fullSubtractor;

architecture fullSub of fullSubtractor is
	signal inter: std_logic;
	
	begin
		inter <= A xor B xor Bin;
		Bout <= (NOT(A) and Bin) or (NOT(A) and B) or (B and Bin);
		
		D <= (inter and NOT(ctrl)) or (A and ctrl);
end fullSub;