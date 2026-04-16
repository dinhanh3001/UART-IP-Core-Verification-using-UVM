

//============================================================================================================================
// Scoreboard responsible for data checking
//============================================================================================================================
class sb #(type REQ = uvm_sequence_item) extends uvm_scoreboard;

	`uvm_component_param_utils(sb #(REQ))
  
	uvm_tlm_analysis_fifo #(REQ) ref_ap_fifo; // reference data 
	uvm_tlm_analysis_fifo #(REQ) act_ap_fifo; // actual data 
  string  my_name;

  // X Todo: declare a uart_cfg handle named cfg
  uart_cfg cfg ; 
  //
  // NEW
  //
  function new(string name, uvm_component parent);
    super.new(name,parent);
    my_name = name;
  endfunction
		
  //
  // BUILD phase
  //
	function void build_phase(uvm_phase phase);
    // P2 Todo: instantiate ref_ap_fifo
    ref_ap_fifo = new("ref_ap_fifo", this); 

    // P2 Todo: instantiate act_ap_fifo
    act_ap_fifo = new("act_ap_fifo", this); 
	endfunction

  //
  // CONNECT phase
  //
	function void connect_phase(uvm_phase phase);
    // X Todo: use uvm_config_db::get to obtain the handle to uart_cfg
    super.connect_phase(phase); 
    if(!uvm_config_db #(uart_cfg):: get (this, "", "cfg", cfg))begin 
      `uvm_fatal(my_name, "Not found uart_cfg from uvm_config_db"); 
    end 
  endfunction

  //
  // CHECK phase
  //
	function void check_phase(uvm_phase phase);
    // At the end of simulation, if there are any packets left in the ref_ap_fifo, then
    // it is an error condition
    if (ref_ap_fifo.used() > 0) begin
      `uvm_error(my_name,$psprintf("ref_ap_fifo is not empty : %0d",ref_ap_fifo.used()))
    end
	endfunction

  //
  // RUN phase
  //
  task run_phase(uvm_phase phase);
		REQ ref_pkt;
		REQ act_pkt;

		forever begin
      // P2 Todo: get the next actual packet from the act_ap_fifo by calling get
      act_ap_fifo.get(act_pkt); // dung doi cho den khi monitor bao cao ket qua thuc te 

      // P2 Todo: verify that the ref_ap_fifo is not empty, otherwise issue an fatal error
      if(ref_ap_fifo.is_empty())begin 
        `uvm_fatal(my_name, "Not found any packet in fifo")
      end 
      // P2 Todo: get the next reference packet from the ref_ap_fifo by calling get
      ref_ap_fifo.get(ref_pkt); 
      // P2 Todo: perform comparison between the rx_data in the reference packet against the o_data in actual packet
      // P2 Todo: print match/mismatch message
      // X Todo: if inject_err==0, perform comparison as in the above two lines
      // X Todo: if inject_err==1, verify that the comparison fails as expected
      if(cfg !=null && cfg.inject_err ==1)begin 
        // chung ta co tinh them loi o driver, nen o day ki vong la du lieu phai khac 
        if(ref_pkt.rx_data !=act_pkt.o_data)begin 
        `uvm_info(my_name, $sformatf("PASS (Loi du kien): act_pkt (0x%0h) khac ref_pkt (0x%0h) nhu mong doi!", act_pkt.o_data, ref_pkt.rx_data), UVM_LOW)
      end else begin 
        `uvm_error(my_name, $sformatf("FAIL: Ep loi nhung mach van hoat dong dung? Co bug! act = 0x%0h, ref = 0x%0h", act_pkt.o_data, ref_pkt.rx_data))
      end 
    end else begin 
      // ky vong: du lieu gui di va nhan ve phai giong het nhau 
      if(ref_pkt.rx_data == act_pkt.o_data)begin 
        `uvm_info(my_name, $sformatf("PASS: DATA ALIGNS ref_pkt = 0x%0h, act_pkt = 0x%0h", ref_pkt.rx_data, act_pkt.o_data), UVM_LOW)
        end else begin
           `uvm_error(my_name, $sformatf("FAIL: DATA not ALIGNS! ref_pkt = 0x%0h, act_pkt = 0x%0h", ref_pkt.rx_data, act_pkt.o_data))
		end
    end 
    end 
	endtask

endclass
