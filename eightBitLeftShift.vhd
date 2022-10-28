LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY eightBitLeftShift IS 
	PORT
	(
		controller :  IN  STD_LOGIC;
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		shiftIn :  IN  STD_LOGIC;
		enable :  IN  STD_LOGIC;
		inp :  IN  STD_LOGIC_VECTOR(7 downto 0);
		output0, output1, output2, output3, output4, output5, output6, output7 :  OUT  STD_LOGIC;
		NOToutput:  OUT  STD_LOGIC_VECTOR(7 downto 0));
END eightBitLeftShift;

ARCHITECTURE bdf_type OF eightBitLeftShift IS 

COMPONENT enardff_2
	PORT(i_resetBar : IN STD_LOGIC;
		 i_d : IN STD_LOGIC;
		 i_enable : IN STD_LOGIC;
		 i_clock : IN STD_LOGIC;
		 o_q : OUT STD_LOGIC;
		 o_qBar : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	regIn0, reg1In, reg2In, reg3In, reg4In, reg5In, reg6In, reg7In :  STD_LOGIC;
SIGNAL	reg0Out, reg1Out, reg2Out, reg3Out, reg4Out, reg5Out, reg6Out, reg7Out:  STD_LOGIC;
SIGNAL	NOTcontroller :  STD_LOGIC;
SIGNAL	loadOp0, loadOp1, loadOp2, loadOp3, loadOp4, loadOp5, loadOp6, loadOp7 :  STD_LOGIC;
SIGNAL	shiftOp0, shiftOp1, shiftOp2, shiftOp3, shiftOp4, shiftOp5, shiftOp6, shiftOp7 :  STD_LOGIC;


BEGIN 
output0 <= reg0Out;
output1 <= reg1Out;
output2 <= reg2Out;
output3 <= reg3Out;
output4 <= reg4Out;
output5 <= reg5Out;
output6 <= reg6Out;
output7 <= reg7Out;



bit0 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => regIn0,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg0Out,
		 o_qBar => NOToutput(0));


bit1 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => reg1In,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg1Out,
		 o_qBar => NOToutput(1));


bit2 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => reg2In,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg2Out,
		 o_qBar => NOToutput(2));


bit3 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => reg3In,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg3Out,
		 o_qBar => NOToutput(3));


bit4 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => reg4In,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg4Out,
		 o_qBar => NOToutput(4));


bit5 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => reg5In,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg5Out,
		 o_qBar => NOToutput(5));


bit6 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => reg6In,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg6Out,
		 o_qBar => NOToutput(6));


bit7 : enardff_2
PORT MAP(i_resetBar => reset,
		 i_d => reg7In,
		 i_enable => enable,
		 i_clock => clk,
		 o_q => reg7Out,
		 o_qBar => NOToutput(7));


loadOp0 <= controller AND inp(0);
loadOp1 <= controller AND inp(1);
loadOp2 <= controller AND inp(2);
loadOp3 <= controller AND inp(3);
loadOp4 <= controller AND inp(4);
loadOp5 <= controller AND inp(5);
loadOp6 <= controller AND inp(6);
loadOp7 <= controller AND inp(7);

shiftOp0 <= shiftIn AND NOTcontroller;
shiftOp1 <= reg0Out AND NOTcontroller;
shiftOp2 <= reg1Out AND NOTcontroller;
shiftOp3 <= reg2Out AND NOTcontroller;
shiftOp4 <= reg3Out AND NOTcontroller;
shiftOp5 <= reg4Out AND NOTcontroller;
shiftOp6 <= reg5Out AND NOTcontroller;
shiftOp7 <= reg6Out AND NOTcontroller;

regIn0 <= loadOp0 OR shiftOp0;
reg1In <= loadOp1 OR shiftOp1;
reg2In <= loadOp2 OR shiftOp2;
reg3In <= loadOp3 OR shiftOp3;
reg4In <= loadOp4 OR shiftOp4;
reg5In <= loadOp5 OR shiftOp5;
reg6In <= loadOp6 OR shiftOp6;
reg7In <= loadOp7 OR shiftOp7;

NOTcontroller <= NOT(controller);

END bdf_type;