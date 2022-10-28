library verilog;
use verilog.vl_types.all;
entity eightBitLeftShift_vlg_check_tst is
    port(
        NOToutput       : in     vl_logic_vector(7 downto 0);
        output0         : in     vl_logic;
        output1         : in     vl_logic;
        output2         : in     vl_logic;
        output3         : in     vl_logic;
        output4         : in     vl_logic;
        output5         : in     vl_logic;
        output6         : in     vl_logic;
        output7         : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end eightBitLeftShift_vlg_check_tst;
