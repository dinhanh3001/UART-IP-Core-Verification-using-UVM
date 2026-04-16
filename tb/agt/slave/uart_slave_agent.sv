//***************************************************************************************************************

//***************************************************************************************************************
// (type REQ = uvm_sequence_item, type RSP = uvm_sequence_item)  là cách khai báo Tham số kiểu dữ liệu (Parameterized Type). 
// no hoat dong nhu la agent nay se lam viec voi cac goi tin dinh dang REQ va RSP, no chi la khai bao hinh thu cu du lie cho compiler biet, 
// khong tao ra bat ky cong vat ly nao de day dy lieu ra ngoai 
// cong giao tiep thuc su duoc day ra ngoai la doi tuong uvm_analysis_port #(REQ)act_uart_ap 
// 
// REQ la goi tin di tu sequencer truyen den driver , RSP la goi tin di nguoc lai tu driver den sequencer -> xac nhan handsakes
// -> hai goi tin nay chu yeu dung de giao tiep noi bo giua sequencer va driver ben trong agent 
class uart_slave_agent #(type REQ = uvm_sequence_item, type RSP = uvm_sequence_item) extends uvm_agent;

  `uvm_component_param_utils(uart_slave_agent #(REQ,RSP))
  
  string   my_name;

  typedef uart_slave_monitor #(REQ) uart_slave_monitor_t;
  uart_slave_monitor_t    monitor;
 
  uvm_analysis_port #(REQ) act_uart_ap;  // This port is used to send coverage data
 
  //
  // NEW
  //
  function new(string name, uvm_component parent);
    super.new(name,parent);
    my_name = name;
    // P2 Todo: instantiate act_uart_ap for hierarchical connection
    act_uart_ap = new("act_uart_ap", this); 
  endfunction
  
  //
  // BUILD phase
  //
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // P2 Todo: instantiate the monitor
    monitor = uart_slave_monitor_t :: type_id ::create("monitor", this); 
  endfunction
  
  //
  // CONNECT phase
  //
  function void connect;
    // P2 Todo: connect the monitor act_uart_ap to the agent act_uart_ap
    monitor.act_uart_ap.connect(this.act_uart_ap); 
  endfunction
  
endclass
