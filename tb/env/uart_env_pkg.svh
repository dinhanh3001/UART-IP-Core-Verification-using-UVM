//***************************************************************************************************************
//***************************************************************************************************************
package uart_env_pkg;

   import uvm_pkg::*;
   import uart_agent_pkg::*;
   // P2 Todo: import uart_slave_agent_pkg::*;
   import uart_slave_agent_pkg::*;
   // P2 Todo: import uart_chk_pkg::*;
   import uart_chk_pkg::*;
   
   `include "uvm_macros.svh"
   `include "uart_env.sv"
   
endpackage

// luong du lieu: Master agent ban tin hieu di -> vut 1 ban copy cho scoreboard -> DUT xu ly xong day tin hieu ra -> Slave agent thu thap -> vut not cho score board 
// env chinh la noi ket noi cho su luan chuyen nay 