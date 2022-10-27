library verilog;
use verilog.vl_types.all;
entity datapath_vlg_sample_tst is
    port(
        num0            : in     vl_logic_vector(3 downto 0);
        num1            : in     vl_logic_vector(3 downto 0);
        sel0            : in     vl_logic;
        sel1            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end datapath_vlg_sample_tst;