library verilog;
use verilog.vl_types.all;
entity eightbitaddsub_vlg_check_tst is
    port(
        carryOut        : in     vl_logic;
        o_Sum           : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end eightbitaddsub_vlg_check_tst;
