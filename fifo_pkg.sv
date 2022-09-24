//=======================================================
//  fifo pkg 
//=======================================================

package fifo_pkg;
  
// DO NOT ADD interface.sv

import uvm_pkg::*;

`include "uvm_macros.svh"

  `include "tb_defs.svh" 
  `include  "fifo_item.sv"
  `include  "fifo_sequencer.sv"
  `include  "fifo_seq.sv"
  `include  "fifo_monitor.sv"
  `include  "fifo_driver.sv"
  `include  "fifo_agent.sv"
  `include  "fifo_sb.sv"
  `include  "fifo_env.sv"
  `include  "fifo_test.sv"

endpackage 
