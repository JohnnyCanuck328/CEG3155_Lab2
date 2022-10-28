library verilog;
use verilog.vl_types.all;
entity eightBitLeftShift is
    port(
        controller      : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        shiftIn         : in     vl_logic;
        enable          : in     vl_logic;
        inp             : in     vl_logic_vector(7 downto 0);
        output0         : out    vl_logic;
        output1         : out    vl_logic;
        output2         : out    vl_logic;
        output3         : out    vl_logic;
        output4         : out    vl_logic;
        output5         : out    vl_logic;
        output6         : out    vl_logic;
        output7         : out    vl_logic;
        NOToutput       : out    vl_logic_vector(7 downto 0)
    );
end eightBitLeftShift;
