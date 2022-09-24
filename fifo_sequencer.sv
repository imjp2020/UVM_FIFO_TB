//=======================================================
//  fifo sequencer
//=======================================================

class fifo_sequencer extends uvm_sequencer#(fifo_item);
  
  `uvm_component_utils(fifo_sequencer)

  function new (string name="fifo_sequencer", uvm_component parent=null);
      super.new(name, parent); 
  endfunction
  
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
  endfunction
  
endclass
