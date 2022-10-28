library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        operandA        : in     vl_logic_vector(3 downto 0);
        operandB        : in     vl_logic_vector(3 downto 0);
        sel0            : in     vl_logic;
        sel1            : in     vl_logic;
        g_clk           : in     vl_logic;
        globalRes       : in     vl_logic;
        MuxOut          : out    vl_logic_vector(7 downto 0);
        zeroOut         : out    vl_logic;
        overflowOut     : out    vl_logic;
        carryOut        : out    vl_logic
    );
end datapath;
