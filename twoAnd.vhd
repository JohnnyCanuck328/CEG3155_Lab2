library ieee;
use ieee.std_logic_1164.all;

entity twoAnd is

    port(A : in std_logic;      
         B : in std_logic;      
         Y : out std_logic);    

end twoAnd;

architecture andLogic of twoAnd is
begin process(A,B)
 begin
    
    Y <= A AND B;
end process;
end andLogic; 