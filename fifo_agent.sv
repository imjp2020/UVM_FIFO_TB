//=======================================================
//  fifo agent 
//=======================================================

class fifo_agent extends uvm_agent; //can be uvm_fifo_agent with parent args
  
  fifo_driver    drv_h;
  fifo_sequencer sqr_h;
  fifo_monitor   mon_h;
  
  `uvm_component_utils(fifo_agent)  
  
  function new(string name="fifo_agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  
  virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);         
      `uvm_info("fifo_agent","BUILD phase",UVM_LOW)
      
       drv_h =fifo_driver::type_id::create("drv_h",this);
       sqr_h =fifo_sequencer::type_id::create("sqr_h",this);  
       mon_h =fifo_monitor::type_id::create("mon_h",this); 
  
  endfunction 
  
  
  virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);         
      `uvm_info("fifo_agent ","CONNECT phase  ",UVM_LOW)
    
      //driver and sequencer connection
      drv_h.seq_item_port.connect(sqr_h.seq_item_export);
  endfunction 
   
  
endclass
