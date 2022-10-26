library verilog;
use verilog.vl_types.all;
entity h2InMux is
    port(
        w0              : in     vl_logic_vector(7 downto 0);
        w1              : in     vl_logic_vector(7 downto 0);
        en              : in     vl_logic;
        y               : out    vl_logic_vector(7 downto 0)
    );
end h2InMux;
