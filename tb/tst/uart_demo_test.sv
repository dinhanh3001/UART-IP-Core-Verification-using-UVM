
//***************************************************************************************************************
//***************************************************************************************************************
// A demo test case.
//***************************************************************************************************************
class uart_demo_test extends uvm_test;

	`uvm_component_utils(uart_demo_test)
	
	string	my_name;
	
  typedef uart_demo_seq #(uart_tlm,uart_tlm) uart_demo_seq_t;
  uart_demo_seq_t uart_demo_seq;
  typedef uart_env #(uart_tlm,uart_tlm) env_t;
  env_t env_h;
  // X Todo: declare a uart_cfg variable named cfg
  uart_cfg cfg; 
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
		super.build_phase(phase);
    // P1 Todo: instantiate the environment class
    env_h = env_t ::type_id::create("env_h", this); 
    // P1 Todo: instantiate the demo sequence

    // sequence la uvm_object nen khong co tham so this (parent) 
    uart_demo_seq = uart_demo_seq_t :: type_id::create("uart_demo_seq"); 

    // X Todo: instantiate cfg
    cfg = uart_cfg ::type_id::create("cfg"); 
    // X Todo: use uvm_config_db set to place the cfg handle in the resource database
    // gui cau hinh len databbase de driver va scoreboard lay ve 
    uvm_config_db #(uart_cfg)::set(this,"*","cfg", cfg); 
	endfunction
  
  //
  // RUN phase
  //
	task run_phase(uvm_phase phase);

    // When the last transaction is sent, this drain time allows the transfer
    // to complete before simulation ends
    uvm_test_done.set_drain_time(this,10us); // metthod nay : sau khi kich ban hoan tat (drop_objection) thi them mot khoang thoi gian 10us de qua trinh 
    //                                       truyen du lieu cuoi dung duoc haon tat truoc khi ket thuc mo phong, vi khi sequencer vua gui xong goi tin cuoi dung 
                                            // thi no co the ngay lap tuc bi drop_objection va DUT chua kip xu ly goi tin do 

    `uvm_info(my_name,"Raising objection",UVM_NONE)
    phase.raise_objection(this,"Objection raised by uart_demo_test");
    
    // P1 Todo: start the demo sequence

    // uart_demo_seq von dang troi noi, srat se cam kich ban nay nhet thang vao sequencer nam ben trong master 
   	uart_demo_seq.start(env_h.uart_agent_0.sequencer,null);
     // sequencer la  mot objec duoc viet trong uvm_sequencer, uart_agent duoc ke thua bien nay 
     // env_h.uat_agent_0.sequencer chi don gian la duong dan phan cap di tu ngoai vao trong: tu test vao env -> tu env vao master agent -> vao sequencer lay cai 
    // sequencer dang nam trong do ra 

    `uvm_info(my_name,"Dropping objection",UVM_NONE)
    phase.drop_objection(this,"Objection dropped by uart_demo_test");
	endtask
	
endclass
