library verilog;
use verilog.vl_types.all;
entity multiplier is
    port(
        multiplier      : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        S               : out    vl_logic_vector(7 downto 0)
    );
end multiplier;
