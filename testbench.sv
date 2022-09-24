//=======================================================
//  FIFO UVM TESTBENCH 
//=======================================================

`include "fifo_interface.sv"
`include "fifo_pkg.sv"
`include "tb_defs.svh" 

`timescale 1ns/1ns

module fifo_tb;
import uvm_pkg::*;

`include "uvm_macros.svh"
import fifo_pkg::*;  
  
 bit clk ,rst ; 
  
  //---------------------------------------------------
  //  Reset assertions 
  //---------------------------------------------------
    
  initial
      begin
        rst = 1 ;
          repeat(3)           // DUT in rst for 5 clks
          @(posedge clk);
          rst = 0 ;
     end
  
  always #5 clk = !clk ; 
   
  fifo_if  vif(clk,rst);
  
  
  //---------------------------------------------------
  // DUT instanitition
  //---------------------------------------------------
  
  FIFO DUT (.datain(vif.datain),
            .clk(vif.clk),
            .rst(vif.rst),
            .wn(vif.wn),
            .rn(vif.rn),
            .dataout(vif.dataout),
            .full(vif.full),
            .empty(vif.empty)
              );
              
  initial
    begin  
      run_test("fifo_test");
      end
  
  initial
    begin
      uvm_config_db#(virtual fifo_if)::set(uvm_root::get(),"*","vif",vif);
      $dumpfile("dump.vcd");
      $dumpvars;
      #1000;
      $finish();
    end

endmodule
