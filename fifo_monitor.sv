//=======================================================
//  fifo monitor
//=======================================================

class fifo_monitor extends uvm_monitor;
 
  // declaration for the virtual interface, analysis port, and fifo_monitor sequence item.
  virtual fifo_if  vif;
  uvm_analysis_port#(fifo_item)item_collect_port;
   
  fifo_item mon_txn;
  
  `uvm_component_utils(fifo_monitor)
  
  function new(string name = "fifo_monitor", uvm_component parent = null);
        super.new(name, parent);
       // mon_txn = new();
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    mon_txn=fifo_item::type_id::create("mon_txn",this);
    
    item_collect_port = new("item_collect_port", this);
           `uvm_info("fifo_monitor","BUILD phase",UVM_LOW)
              if(!uvm_config_db#(virtual fifo_if) :: get(this, "", "vif", vif))
                   `uvm_fatal(get_type_name(), "fifo monitor - Not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase); 
    //super.run_phase(phase)
    //Use if needs all run_phases to drive rst and other config or main sequences
    
   forever
       begin
         @(posedge vif.clk);
         begin
      			    //repeat(1)begin
                // Sample DUT information and translate into transaction
                `uvm_info("fifo_monitor","RUN phase [on]",UVM_LOW)
                `uvm_info("fifo_monitor","********monitor[BEFORE ] **********",UVM_LOW)
                //mon_txn.print();
                 mon_txn.rn<=vif.rn;
                 mon_txn.wn<=vif.wn;
                 mon_txn.dataout<=vif.dataout;
                 mon_txn.datain<=vif.datain;
                 mon_txn.empty<=vif.empty;
                 mon_txn.full<=vif.full;
               item_collect_port.write(mon_txn);
               end
                `uvm_info("fifo_monitor","********monitor[AFTER -from VIF] **********",UVM_LOW)        
                // mon_txn.print();

       `uvm_info("fifo_monitor","RUN phase [off]",UVM_LOW)
   end //}
 endtask
  
endclass
