//***************************************************************************************************************
//***************************************************************************************************************
class uart_driver #(type REQ = uvm_sequence_item, type RSP = uvm_sequence_item) extends uvm_driver #(REQ,RSP);

   // REQ: request, goi tin gui di 
   // RSP: response, goi tin phan hoi 
   // uvm_sequence_item : gia tri mac dinh 
    
  `uvm_component_param_utils(uart_driver #(REQ,RSP))
   // cac class co su dung #() thi bat buoc phai dung _param_ de bao cho factory biet la mot class co 
   // chua tham so 
  string   my_name;
  
  virtual interface uart_if vif;
  virtual interface clk_rst_if clk_rst_vif;

  uvm_analysis_port #(REQ) ref_uart_ap;

  // X Todo: declare a uart_cfg handle named cfg
   uart_cfg cfg; 
  //
  // NEW
  //
  function new(string name, uvm_component parent);
     super.new(name,parent);
  endfunction
  
  //
  // BUILD phase
  //
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // P2 Todo: instantiate ref_uart_ap 
    ref_uart_ap = new("ref_uart_ap", this); 
  endfunction

  //
  // CONNECT phase
  //
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    my_name = get_name();
    // Get a handle to clk_rst_if
    if( !uvm_config_db #(virtual clk_rst_if)::get(this,"","CLK_RST_VIF",clk_rst_vif) ) begin
      `uvm_error(my_name, "Could not retrieve virtual clk_rst_if");
    end     
    //
    // Getting the interface handle via get_config_object call
   
    // P1 Todo: retrieve the handle to uart_if using vif. Look in top.sv for references
    // Lay interface cua UART tu database 
    
    if(!uvm_config_db #(virtual uart_if) ::get (this, "", "UART_VIF", vif)) begin 
      `uvm_error(my_name, "Could not retrieve virtual uart_if"); 
    end 

    // X Todo: use uvm_config_db get to retrieve the uart_cfg in cfg
    // lay object cau hinh de biet co can inject loi khong 
    if(!uvm_config_db #(uart_cfg) :: get (this, "", "cfg", cfg)) begin 
      `uvm_fatal(my_name, "could not retrive uart_cfg"); 
    end 
  endfunction
 
  //
  // RUN phase
  //
  virtual task run_phase(uvm_phase phase);
    REQ req_pkt;
    RSP rsp_pkt;
    integer rsp_pkt_cnt;
    bit [9:0] out_data;
    
    rsp_pkt_cnt = 1;
    vif.rx_data <= 1'b1;
    forever @(posedge vif.clk) begin
      //
      // seq_item_port object is part of the uvm_driver class
      // get_next_item method is part of the interface api between uvm_driver and uvm_sequencer
      //
      // P1 Todo: get the next packet req_pkt by calling get_next_item
      // lay goi tin tu sequencer , lenh nay se block cho den khi co goi tin 
      seq_item_port.get_next_item(req_pkt); 

      if (req_pkt.do_reset == 1) begin
        // Packet is reset
      	clk_rst_vif.do_reset(5);
        `uvm_info(my_name,"I saw reset assertion",UVM_NONE)
			end else if (req_pkt.do_wait == 1) begin
        // Packet is wait
				clk_rst_vif.do_wait(5);
			end else begin
        `uvm_info(my_name,$psprintf("Sending rx_data=%0x",req_pkt.rx_data),UVM_NONE)
        
        // P2 Todo: send req_pkt to the scoreboard by calling write function
        ref_uart_ap.write(req_pkt); // Send reference data to the scoreboard 
                                   // gui ban sao goi tin den scoreboard truoc khi day xuong mach 

        
        // Form the data to send
        // Stop bit: rx_data: Start bit, LSB first
        // P1 Todo: construct out_data = {stop_bit, rx_data, start_bit}
        // X Todo: if inject_err==1, invert the value in rx_data: rx_data^8'hff
        if(cfg !=null && cfg.inject_err ==1) begin 
          // goi tin loi, fix bang cac dao nguoc bit du lieu (xor voi 8'hff)
          out_data = {1'b1, req_pkt.rx_data ^ 8'hff, 1'b0}; 
        end 
        else begin 
          // goi tin chuan: Stop bit (1), du lieu (8 bit), start bit (0)

          out_data = {1'b1, req_pkt.rx_data, 1'b0}; 
        end 

        // P1 Todo: use a for loop to send out_data serially, lsb first
        // truyen noi tiep 10 bit ra interface vat ly theo nhip uart_clk 

        for(int i =0; i<10; i ++)begin 
          @(posedge vif.uart_clk); // canh len cua baud rate 
          vif.rx_data <= out_data[i]; 
		  end
         // cho them 1 nhip clock de dam bao stop bit hoan thanh 
        @(posedge vif.uart_clk); 
      end 

      // gui goi req cho DUT va phan hoi goi res cho sequencer 
      // Send response packet back to the sequence
      rsp_pkt_cnt++;
      rsp_pkt = RSP::type_id::create($psprintf("rsp_pkt_id_%d",rsp_pkt_cnt));
      rsp_pkt.set_id_info(req_pkt); // Copy Sequence Id va transaction ID tu transaction goc req_pkt 
      rsp_pkt.copy(req_pkt);
      seq_item_port.item_done(rsp_pkt); // bao cao lai sequencer da xu ly xong, gui goi req_pkt tiep theo  
    end
  endtask

endclass
  
