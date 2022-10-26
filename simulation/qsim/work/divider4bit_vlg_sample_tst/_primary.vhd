library verilog;
use verilog.vl_types.all;
entity divider4bit_vlg_sample_tst is
    port(
        dividend        : in     vl_logic_vector(3 downto 0);
        divisor         : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end divider4bit_vlg_sample_tst;
