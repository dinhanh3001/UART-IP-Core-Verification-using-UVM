//***************************************************************************************************************

//***************************************************************************************************************
class uart_slave_monitor #(type PKT = uvm_sequence_item) extends uvm_monitor;

  `uvm_component_param_utils(uart_slave_monitor #(PKT))
  
  string   my_name;
  
  virtual interface uart_if       vif;
	virtual interface clk_rst_if clk_rst_vif;

	uvm_analysis_port #(PKT) act_uart_ap;
 
  //
  // NEW
  //
  function new(string name, uvm_component parent);
    super.new(name,parent);
    my_name = name;
    // P2 Todo: instantiate act_uart_ap
    act_uart_ap = new("act_uart_ap", this); 
  endfunction
  
  //
  // CONNECT phase
  //
  function void connect_phase(uvm_phase phase);
    //
    // Getting the interface handle
    //
		if( !uvm_config_db #(virtual clk_rst_if)::get(this,"","CLK_RST_VIF",clk_rst_vif) ) begin
			`uvm_error(my_name, "Could not retrieve virtual clk_rst_if");
		end
    // P2 Todo: retrieve the handle to uart_if in vif. Refer top.sv
    if (!uvm_config_db #(virtual uart_if) :: get (this,"", "UART_VIF", vif))begin 
      `uvm_error(my_name, "Could not retrieve virtual uart_if"); 
    end 

  endfunction
  
  //
	// Monitor and capture SPI data
  //
  task monitoring_data;
		PKT act_pkt;
    bit [7:0] temp_rx;
    int timeout_count; 
    forever @(negedge vif.uart_clk) begin
      // P2 Todo: if recognizing start bit
      // start bit cua UART luon la 0 
      if(vif.rx_data == 1'b0) begin 

      // P2 Todo: capture 8 data bits
         for(int i =0; i<8; i++)begin 
          @(negedge vif.uart_clk); 
          temp_rx[i] = vif.rx_data; 
         end 

      // P2 Todo: verify the next bit is a stop bit. If not, issue an error
     /* @(negedge vif.uart_clk); 
      if(vif.rx_data !==1'b1)begin 
        `uvm_error(my_name, "Framming error: Dont found stop bit"); 
      end 
      // P2 Todo: wait for o_valid to assert. Time out after 10 clocks. 
      timeout_count = 0; 
      fork  
        begin :wait_valid 
           wait(vif.o_valid == 1'b1); 
        end 
        begin :wait_timeout 
           repeat(10)@(posedge clk_rst_vif.clk); // dung xung nhip he thong 
        end 
      join_any 
      disable fork ; // tat cac tien trinh con lai 
      */ 
      // Thay vì tuần tự chờ negedge uart_clk rồi mới đợi o_valid, 
      // ta cho chúng chạy song song để không bị lỡ nhịp nào cả!
      fork  
        // Tiến trình 1: Chờ o_valid (Sẽ bắt trúng vì nó xảy ra trước negedge uart_clk)
        begin :wait_valid 
           wait(vif.o_valid == 1'b1); 
        end 
        
        // Tiến trình 2: Timeout (Cho hẳn 2000 xung i_Clock để dư dả thời gian)
        begin :wait_timeout 
           repeat(2000) @(posedge clk_rst_vif.clk); 
        end 

        // Tiến trình 3 (Tùy chọn): Kiểm tra Stop bit chạy song song
        begin :check_stop_bit
           @(negedge vif.uart_clk); 
           if(vif.rx_data !== 1'b1) begin 
             `uvm_error(my_name, "Framming error: Dont found stop bit"); 
           end
        end
      join_any 
      disable fork; // Tắt các tiến trình còn lại khi 1 cái đã hoàn thành
      // P2 Todo: if o_valid is asserted, create act_pkt and assign vif.o_data to act_pkt.o_data
      if(vif.o_valid == 1'b1)begin 
        act_pkt = PKT:: type_id ::create("act_pkt"); 
        act_pkt.o_data = vif.o_data; 
        `uvm_info(my_name, $sformatf("Monitor have data:0x%0h", act_pkt.o_data), UVM_HIGH)

      // P2 Todo: send act_pkt to act_uart_ap
      act_uart_ap.write(act_pkt); 
      end 
      else begin 
        `uvm_error(my_name, "Timeout!")
      end 
      end 
    end
  endtask

  //
  // RUN phase
  //
  task run_phase(uvm_phase phase);
  	monitoring_data();
  endtask
   
endclass
