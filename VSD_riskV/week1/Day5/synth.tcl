read_liberty -lib /home/harsh-shah/yosys/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog /home/harsh-shah/week1/Day5/dff-const1.v
synth -top dff_const1
abc -liberty /home/harsh-shah/yosys/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
show
write_verilog -norename dff_const1_nl.v

