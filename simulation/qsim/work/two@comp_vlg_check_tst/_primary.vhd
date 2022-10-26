library verilog;
use verilog.vl_types.all;
entity twoComp_vlg_check_tst is
    port(
        AC              : in     vl_logic_vector(3 downto 0);
        isConverted     : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end twoComp_vlg_check_tst;
