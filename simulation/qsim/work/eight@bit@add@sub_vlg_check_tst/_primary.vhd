library verilog;
use verilog.vl_types.all;
entity eightBitAddSub_vlg_check_tst is
    port(
        carryOut        : in     vl_logic;
        o_Sum           : in     vl_logic_vector(3 downto 0);
        sampler_rx      : in     vl_logic
    );
end eightBitAddSub_vlg_check_tst;
