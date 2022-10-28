library verilog;
use verilog.vl_types.all;
entity datapath_vlg_check_tst is
    port(
        carryOut        : in     vl_logic;
        MuxOut          : in     vl_logic_vector(7 downto 0);
        overflowOut     : in     vl_logic;
        zeroOut         : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end datapath_vlg_check_tst;
