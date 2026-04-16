//***************************************************************************************************************

class uart_cfg extends uvm_object;

  `uvm_object_utils(uart_cfg)

  // X Todo: declare a bit variable inject_err
    bit inject_err; 
  //
  // NEW
  //
  function new(string name = "");
    super.new(name);
    // X Todo: assign 0 to inject_err
    inject_err = 0; 
  endfunction

  
endclass
