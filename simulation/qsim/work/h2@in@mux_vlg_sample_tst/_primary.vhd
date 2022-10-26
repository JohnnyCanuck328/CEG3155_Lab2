library verilog;
use verilog.vl_types.all;
entity h2InMux_vlg_sample_tst is
    port(
        en              : in     vl_logic;
        w0              : in     vl_logic_vector(7 downto 0);
        w1              : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end h2InMux_vlg_sample_tst;
