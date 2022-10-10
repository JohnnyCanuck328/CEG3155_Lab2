library ieee;
use ieee.std_logic_1164.all;

entity halfAdder is
	port(A,B: in std_logic;
			sum, carryout: out std_logic);
end halfAdder;

architecture structhalfAdder of halfAdder is
	
	begin
	
	carryout <= A and B;
	sum <= A XOR B;
end structhalfAdder;