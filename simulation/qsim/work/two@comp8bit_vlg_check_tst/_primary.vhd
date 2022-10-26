library verilog;
use verilog.vl_types.all;
entity twoComp8bit_vlg_check_tst is
    port(
        AC              : in     vl_logic_vector(7 downto 0);
        isConverted     : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end twoComp8bit_vlg_check_tst;
