library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        num0            : in     vl_logic_vector(3 downto 0);
        num1            : in     vl_logic_vector(3 downto 0);
        sel0            : in     vl_logic;
        sel1            : in     vl_logic;
        g_clk           : in     vl_logic;
        globalRes       : in     vl_logic;
        result          : out    vl_logic_vector(7 downto 0)
    );
end datapath;
