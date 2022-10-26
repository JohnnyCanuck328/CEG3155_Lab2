library verilog;
use verilog.vl_types.all;
entity multiplier4bit is
    port(
        multiplier      : in     vl_logic_vector(3 downto 0);
        multiplicand    : in     vl_logic_vector(3 downto 0);
        P               : out    vl_logic_vector(7 downto 0)
    );
end multiplier4bit;
