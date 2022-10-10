library verilog;
use verilog.vl_types.all;
entity halfAdder_vlg_check_tst is
    port(
        carryout        : in     vl_logic;
        sum             : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end halfAdder_vlg_check_tst;
