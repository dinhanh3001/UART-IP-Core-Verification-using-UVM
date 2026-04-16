//***************************************************************************************************************

//***************************************************************************************************************
class uart_demo_seq #(type REQ = uvm_sequence_item, type RSP = uvm_sequence_item) extends uvm_sequence #(REQ,RSP);

  `uvm_object_param_utils(uart_demo_seq #(REQ,RSP))
  
  string my_name;
   
  //
  // NEW
  //
  function new(string name="");
    super.new(name);
		my_name = name;
  endfunction

  //
	// Start the transmission max_loop times. Each time num_chars of bits are transmitted
  //
  task body;
    REQ req_pkt;
    RSP rsp_pkt;

    // P1 Todo: implement a for loop that sends 10 packets. Each loop executes the following pseudo code
    //          - create the packet
    //          - randomize the packet
    //          - for P3, trigger event req_pkt.sample_e
    //          - send the req_pkt
    //          - get the response
    for(int i =0; i<10; i++)begin 
      //1. create the packet 
      req_pkt = REQ:: type_id ::create($sformatf("req_pkg_%0d", i)); 
      start_item(req_pkt); 
      //2. random the packet 
      if(!req_pkt.randomize())begin 
        `uvm_error(my_name, "Randomize failed")
      end 
      //3. Trigger for coverage 
      ->req_pkt.sample_e; 

      //4. Send the req_pkt (day goi tin xuong driver)
      finish_item(req_pkt); 

      //5. Get the respone: Cho driver xu ly xong va gui phan hoi 
      get_response(rsp_pkt); 

      `uvm_info(my_name, $sformatf("Done packet %0d", i), UVM_MEDIUM)
    end 
  endtask
   
endclass
