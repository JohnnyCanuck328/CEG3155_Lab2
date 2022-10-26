library verilog;
use verilog.vl_types.all;
entity comparator is
    port(
        y               : in     vl_logic_vector(3 downto 0);
        x               : in     vl_logic_vector(3 downto 0);
        V               : out    vl_logic;
        N               : out    vl_logic;
        Z               : out    vl_logic
    );
end comparator;
