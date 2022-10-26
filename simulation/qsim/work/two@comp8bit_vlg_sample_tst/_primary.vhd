library verilog;
use verilog.vl_types.all;
entity twoComp8bit_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        enable          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end twoComp8bit_vlg_sample_tst;
