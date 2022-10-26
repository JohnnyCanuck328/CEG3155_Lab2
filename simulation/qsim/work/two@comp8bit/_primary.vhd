library verilog;
use verilog.vl_types.all;
entity twoComp8bit is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        enable          : in     vl_logic;
        isConverted     : out    vl_logic;
        AC              : out    vl_logic_vector(7 downto 0)
    );
end twoComp8bit;
