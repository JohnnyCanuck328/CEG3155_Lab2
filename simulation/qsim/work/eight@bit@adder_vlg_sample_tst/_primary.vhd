library verilog;
use verilog.vl_types.all;
entity eightBitAdder_vlg_sample_tst is
    port(
        controller      : in     vl_logic;
        i_Ai            : in     vl_logic_vector(7 downto 0);
        i_Bi            : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end eightBitAdder_vlg_sample_tst;
