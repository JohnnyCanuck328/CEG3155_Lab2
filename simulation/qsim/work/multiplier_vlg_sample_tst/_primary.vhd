library verilog;
use verilog.vl_types.all;
entity multiplier_vlg_sample_tst is
    port(
        B               : in     vl_logic_vector(3 downto 0);
        multiplier      : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end multiplier_vlg_sample_tst;
