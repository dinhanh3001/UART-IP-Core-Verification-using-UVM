# UART-IP-Core-Verification-using-UVM
## Diagram:  
<img width="964" height="792" alt="image" src="https://github.com/user-attachments/assets/e4441a9a-399a-4596-9a3b-7cd9f029ca89" />

## Tools: 
Siemens QuestaSim

## Simulation: 
```
vsim -c top -do sim.do +UVM_TESTNAME=uart_demo_test
Reading pref.tcl

# 2021.2_1

# vsim -c top -do "sim.do" "+UVM_TESTNAME=uart_demo_test" 
# Start time: 23:37:34 on Mar 28,2026
# ** Note: (vsim-8009) Loading existing optimized design _opt
# //  Questa Sim-64
# //  Version 2021.2_1 linux_x86_64 May 15 2021
# //
# //  Copyright 1991-2021 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  QuestaSim and its associated documentation contain trade
# //  secrets and commercial or financial information that are the property of
# //  Mentor Graphics Corporation and are privileged, confidential,
# //  and exempt from disclosure under the Freedom of Information Act,
# //  5 U.S.C. Section 552. Furthermore, this information
# //  is prohibited from disclosure under the Trade Secrets Act,
# //  18 U.S.C. Section 1905.
# //
# Loading sv_std.std
# Loading mtiUvm.uvm_pkg(fast)
# Loading work.uart_seq_pkg(fast)
# Loading work.uart_cfg_pkg(fast)
# Loading work.uart_tlm_pkg(fast)
# Loading work.uart_chk_pkg(fast)
# Loading work.uart_if(fast)
# Loading work.clk_rst_if(fast)
# Loading work.uart_slave_agent_pkg(fast)
# Loading work.uart_agent_pkg(fast)
# Loading work.uart_env_pkg(fast)
# Loading work.uart_test_pkg(fast)
# Loading work.top_sv_unit(fast)
# Loading mtiUvm.questa_uvm_pkg(fast)
# Loading work.top(fast)
# Loading work.receiver(fast)
# Loading /home/dinhanh/Downloads/questa_install/questasim/uvm-1.1d/linux_x86_64/uvm_dpi.so
# do sim.do
# ----------------------------------------------------------------
# UVM-1.1d
# (C) 2007-2013 Mentor Graphics Corporation
# (C) 2007-2013 Cadence Design Systems, Inc.
# (C) 2006-2013 Synopsys, Inc.
# (C) 2011-2013 Cypress Semiconductor Corp.
# ----------------------------------------------------------------
# 
#   ***********       IMPORTANT RELEASE NOTES         ************
# 
#   You are using a version of the UVM library that has been compiled
#   with `UVM_NO_DEPRECATED undefined.
#   See http://www.eda.org/svdb/view.php?id=3313 for more details.
# 
#   You are using a version of the UVM library that has been compiled
#   with `UVM_OBJECT_MUST_HAVE_CONSTRUCTOR undefined.
#   See http://www.eda.org/svdb/view.php?id=3770 for more details.
# 
#       (Specify +UVM_NO_RELNOTES to turn off this notice)
# 
# UVM_INFO verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv(277) @ 0: reporter [Questa UVM] QUESTA_UVM-1.2.3
# UVM_INFO verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv(278) @ 0: reporter [Questa UVM]  questa_uvm::init(+struct)
# UVM_INFO @ 0: reporter [RNTST] Running test uart_demo_test...
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/tst/uart_demo_test.sv(54) @ 0: uvm_test_top [uvm_test_top] Raising objection
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 1000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=0
# UVM_ERROR /home/dinhanh/Desktop/uart_rx/tb/agt/slave/uart_slave_monitor.sv(63) @ 8351000: uvm_test_top.env_h.uart_slave_agent_0.monitor [monitor] Framming error: Dont found stop bit
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 9671000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 0
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 9681000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=ff
# UVM_ERROR /home/dinhanh/Desktop/uart_rx/tb/chk/sb.sv(90) @ 16581000: uvm_test_top.env_h.sb_0 [sb_0] FAIL: DATA not ALIGNS! ref_pkt = 0x0, act_pkt = 0xfb
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 19351000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 1
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 19361000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=ff
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 29031000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 2
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 29041000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=ff
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/chk/sb.sv(88) @ 38211000: uvm_test_top.env_h.sb_0 [sb_0] PASS: DATA ALIGNS ref_pkt = 0xff, act_pkt = 0x0
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 38711000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 3
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 38721000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=aa
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 48391000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 4
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 48401000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=aa
# UVM_ERROR /home/dinhanh/Desktop/uart_rx/tb/chk/sb.sv(90) @ 57571000: uvm_test_top.env_h.sb_0 [sb_0] FAIL: DATA not ALIGNS! ref_pkt = 0xff, act_pkt = 0xaa
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 58071000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 5
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 58081000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=55
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 67751000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 6
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 67761000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=0
# UVM_ERROR /home/dinhanh/Desktop/uart_rx/tb/chk/sb.sv(90) @ 76931000: uvm_test_top.env_h.sb_0 [sb_0] FAIL: DATA not ALIGNS! ref_pkt = 0xff, act_pkt = 0x0
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 77431000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 7
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 77441000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=0
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 87111000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 8
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/uart_driver.sv(91) @ 87121000: uvm_test_top.env_h.uart_agent_0.driver [driver] Sending rx_data=ff
# UVM_ERROR /home/dinhanh/Desktop/uart_rx/tb/chk/sb.sv(90) @ 96291000: uvm_test_top.env_h.sb_0 [sb_0] FAIL: DATA not ALIGNS! ref_pkt = 0xaa, act_pkt = 0xff
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/agt/master/seq/uart_demo_seq.sv(48) @ 96791000: uvm_test_top.env_h.uart_agent_0.sequencer@@uart_demo_seq [] Done packet 9
# UVM_INFO /home/dinhanh/Desktop/uart_rx/tb/tst/uart_demo_test.sv(60) @ 96791000: uvm_test_top [uvm_test_top] Dropping objection
# UVM_INFO verilog_src/uvm-1.1d/src/base/uvm_objection.svh(1267) @ 106791000: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
# UVM_ERROR /home/dinhanh/Desktop/uart_rx/tb/chk/sb.sv(53) @ 106791000: uvm_test_top.env_h.sb_0 [sb_0] ref_ap_fifo is not empty : 5
# 
# --- UVM Report Summary ---
# 
# ** Report counts by severity
# UVM_INFO :   27
# UVM_WARNING :    0
# UVM_ERROR :    6
# UVM_FATAL :    0
# ** Report counts by id
# []    10
# [Questa UVM]     2
# [RNTST]     1
# [TEST_DONE]     1
# [driver]    10
# [monitor]     1
# [sb_0]     6
# [uvm_test_top]     2
# ** Note: $finish    : /home/dinhanh/Downloads/questa_install/questasim/linux_x86_64/../verilog_src/uvm-1.1d/src/base/uvm_root.svh(430)
#    Time: 106791 ns  Iteration: 53  Instance: /top
# End time: 23:37:36 on Mar 28,2026, Elapsed time: 0:00:02
# Errors: 0, Warnings: 0
```
## Coverage: 

