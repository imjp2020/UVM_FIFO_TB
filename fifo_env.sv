//=======================================================
//  fifo env
//=======================================================

class fifo_env extends uvm_env;
    
  fifo_agent agent_h;
  fifo_sb     sb_h;
  
  `uvm_component_utils(fifo_env)  
  
  function new(string name="fifo_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction
 
  virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);         
   
       `uvm_info("fifo_env","BUILD phase",UVM_LOW)
       agent_h=fifo_agent::type_id::create("agent_h",this);
       sb_h   =fifo_sb::type_id::create("sb_h",this);
    
  endfunction 
  
  virtual function void connect_phase(uvm_phase phase);
       super.connect_phase(phase);         
        `uvm_info("fifo_sb","CONNECT phase  ",UVM_LOW)
           //Monitor and Scoreboard connection 
           agent_h.mon_h.item_collect_port.connect(sb_h.sb_port);
          `uvm_info("fifo_sb","CONNECT phase ****OK**** ",UVM_LOW)
  endfunction 
  
endclass
