library verilog;
use verilog.vl_types.all;
entity comparator_vlg_check_tst is
    port(
        N               : in     vl_logic;
        V               : in     vl_logic;
        Z               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end comparator_vlg_check_tst;
