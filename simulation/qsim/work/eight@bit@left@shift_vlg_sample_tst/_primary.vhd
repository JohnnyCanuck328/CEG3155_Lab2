library verilog;
use verilog.vl_types.all;
entity eightBitLeftShift_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        controller      : in     vl_logic;
        enable          : in     vl_logic;
        inp             : in     vl_logic_vector(7 downto 0);
        reset           : in     vl_logic;
        shiftIn         : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end eightBitLeftShift_vlg_sample_tst;
