//***************************************************************************************************************
//***************************************************************************************************************
package uart_slave_agent_pkg;
   
   import uvm_pkg::*;
   
   `include "uvm_macros.svh"
   `include "uart_slave_monitor.sv"
   `include "uart_slave_agent.sv"

endpackage
// monitor nam ben trong agent, agent  dong vai do la lop vo dai dien de giao tiep ca cac thanh phan khac ben ngoai nhu scoreboard, coverage, vv. ...
// Agetn se duoc truc tiep sinh ra monitor thong qua cau lenh create 
// monitor = uart_slave_monitor_t :: type_id ::create("monitor", this); , this o day khang dinh agent chinh la parent cua monitor 

// Luong di cua du lieu: 
// Vif -> monitor thu thap va dong goi du lieu vao goi tin REQ -> Monitor day ra cong act_uart_ap -> goi tin chay theo 
// duong ong da noi ra cong act_uart_ap cua agnet -> scoreboard, coverage, vv. ... 
