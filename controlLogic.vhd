library ieee;
use ieee.std_logic_1164.all;

entity controlLogic is
	port(sel0, sel1: in std_logic;
			globalClk: in std_logic;
			globalReset: in std_logic;
			S: out std_logic_vector(4 downto 0));
end controlLogic;

architecture structControl of controlLogic is

	component dFF_2
	PORT(i_setBar   : IN STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q 	: OUT	STD_LOGIC);
	end component;
	
	signal set, state: std_logic;
	signal sIn: std_logic_vector(4 downto 0);
	signal output: std_logic_vector(4 downto 0);
	signal gnd, vcc: std_logic;
	signal NOTSel0, NOTSel1: std_logic;
	
	
	begin	
	

	set <= NOT(globalReset);
	NOTsel0 <= NOT(sel0);
	NOTsel1 <= NOT(sel1);
	sIn(0) <= '1';
	sIn(1) <= NOTsel0 AND NOTsel1;
	sIn(2) <= sel0 AND NOTsel1;
	sIn(3) <= NOTsel0 AND sel1;
	sIn(4) <= sel0 AND sel1;
	
	--might need to be changed to vcc
	state0: dFF_2 port map(i_setBar => set, i_d => sIn(0), i_clock => globalClk, o_q => output(0));
	
	state1: dFF_2 port map(i_setBar => globalReset, i_d => sIn(1), i_clock => globalClk, o_q => output(1));
	
	state2: dFF_2 port map(i_setBar => globalReset, i_d => sIn(2), i_clock => globalClk, o_q => output(2));
	
	state3: dFF_2 port map(i_setBar => globalReset, i_d => sIn(3), i_clock => globalClk, o_q => output(3));
	
	state4: dFF_2 port map(i_setBar => globalReset, i_d => sIn(4), i_clock => globalClk, o_q => output(4));
	
	S(0) <= output(0);
	S(1) <= output(1);
	S(2) <= output(2);
	S(3) <= output(3);
	S(4) <= output(4);

end structControl;