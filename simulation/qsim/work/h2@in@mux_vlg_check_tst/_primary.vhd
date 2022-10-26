library verilog;
use verilog.vl_types.all;
entity h2InMux_vlg_check_tst is
    port(
        y               : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end h2InMux_vlg_check_tst;
