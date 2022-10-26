library verilog;
use verilog.vl_types.all;
entity divider4bit is
    port(
        dividend        : in     vl_logic_vector(3 downto 0);
        divisor         : in     vl_logic_vector(3 downto 0);
        quotient        : out    vl_logic_vector(3 downto 0);
        remainder       : out    vl_logic_vector(3 downto 0)
    );
end divider4bit;
