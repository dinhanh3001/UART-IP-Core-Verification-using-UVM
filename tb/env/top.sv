
//***************************************************************************************************************
//***************************************************************************************************************
// Top level module. It is responsible for instantiating the dut and the interface modules. It also passes the
// interface handle using set_config_object.
//***************************************************************************************************************
 `timescale 1ns/1ps

import uvm_pkg::*;
import uart_test_pkg::*;

`include "uvm_macros.svh"

module top;
   
  wire clk;
  wire rst;
   
  //
  // Create interface instances here
  //
  clk_rst_if clk_rst_if0(.clk(clk),.rst(rst));
  // P1 Todo: instantiate the uart_if 

  uart_if uart_if0(.clk(clk), .rst(rst)); 
    // Create DUT instance
    receiver DUT(
      .i_Clock     (clk), 
      .i_Rx_Serial(uart_if0.rx_data), 
      .o_Rx_DV     (uart_if0.o_valid), 
      .o_Rx_Byte   (uart_if0.o_data)
    ); 
  //
  
  //
  // P1 Todo: instantiate the DUT and connect the signals

  initial begin
    //uart_if0.rx_data = 1'b1;
    // Put interface handles in resource database
    // Top.sv la the gioi phan cung, no khong the truy cap vao phan mem UVM 
    // do do virtual nterface tao ra va nem chung vao database de cac thanh phan cac co the vao lay ra su dung 
    uvm_config_db #(virtual clk_rst_if)::set(null,"*","CLK_RST_VIF",clk_rst_if0);
    // P1 Todo: place the uart_if in the resource database
    uvm_config_db #(virtual uart_if)::set(null,"*","UART_VIF",uart_if0);

    // Run test
    run_test();
    // khi trinh mo phong doc den dong nay, no se chinh thuc tam dung viec mo phong phan cung don thuan de 
    // chuyen quyen dieu khien cho phan mem UVM, bat daau qua trinh tao ra test, env, agent, driver
  end
  // run_test la mot task toan cu trong uvm_pkg, no se lam 2 nhiem vu sau: 
  //1. Tim va khoi tao test, no se vao makefile de tim xem test nao se duoc  chay 
  //2. Se goi cac chu trinh phase cuar UVM  theo trinh tu ma chung ta code 
  // build_phase -> connect_phase -> run_phase ->, ... .

endmodule
