library verilog;
use verilog.vl_types.all;
entity halfAdder is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        sum             : out    vl_logic;
        carryout        : out    vl_logic
    );
end halfAdder;
