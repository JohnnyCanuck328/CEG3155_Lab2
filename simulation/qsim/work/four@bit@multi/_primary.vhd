library verilog;
use verilog.vl_types.all;
entity fourBitMulti is
    port(
        multiplier      : in     vl_logic_vector(3 downto 0);
        multiplicand    : in     vl_logic_vector(3 downto 0);
        product         : out    vl_logic_vector(7 downto 0)
    );
end fourBitMulti;
