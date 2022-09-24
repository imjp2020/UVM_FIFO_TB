//=======================================================
//  fifo scoreboard
//=======================================================

class fifo_sb extends uvm_scoreboard;
  
  uvm_analysis_imp#(fifo_item,fifo_sb)sb_port;
    
  // pick queue or array ir mem and store data 
  
  fifo_item act_data[$];
  bit [7:0] mem_data [7:0];

  `uvm_component_utils(fifo_sb)  
  
  function new(string name="fifo_sb",uvm_component parent=null);
    super.new(name,parent);
       sb_port = new("sb_port", this);
      // w_txn=0;
      // r_txn=0;
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
          `uvm_info("fifo_sb","BUILD phase",UVM_LOW)
  endfunction
  
  function void write(fifo_item sb_txn);
      // repeat(100)
    
      begin
       `uvm_info("scoreboard data ","Received transaction",UVM_LOW);
         sb_txn.print();
         act_data.push_back(sb_txn);
       
        /* $display("jayesh_dataout=%h",sb_txn.dataout);
        $display("jayesh_datain=%h",sb_txn.datain);
        $display("jayesh_wn=%h",sb_txn.wn);
        $display("jayesh_rn=%h",sb_txn.rn);
        item_q.push_back(req);*/
      end
  endfunction
  
   
task run_phase(uvm_phase phase);
  
  int w_txn,r_txn;
    
 forever 
     begin 
       // to get data as same as driven from fifo_txn  
       fifo_item exp_data;   
         
      wait(act_data.size()>0);
           exp_data=act_data.pop_front();
         
      if(exp_data.wn==1)  begin 
        mem_data[w_txn++]=exp_data.datain;
         //w_txn++;                   
        `uvm_info(get_type_name(),$sformatf("exp_data       : %0h,   write enable =%0h",exp_data.datain,exp_data.wn),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("w_txn=%0d",w_txn),UVM_LOW)
        `uvm_info(get_type_name(),$sformatf("mem_wdata=%0h",mem_data[w_txn]),UVM_LOW)
       end 

      else if(exp_data.rn==1 && !exp_data.empty) begin
        // r_txn++;  
        if(exp_data.dataout==mem_data[r_txn++]) 
           begin
             `uvm_info(get_type_name(),$sformatf("------ :: PASS MATCH:: ------"),UVM_LOW)                
             `uvm_info(get_type_name(),$sformatf("exp_data       : %0h,   read enable =%0h",exp_data.dataout,exp_data.rn),UVM_LOW)
             `uvm_info(get_type_name(),$sformatf("r_txn=%0d",r_txn),UVM_LOW)
             `uvm_info(get_type_name(),$sformatf("mem_rdata=%0h",mem_data[r_txn]),UVM_LOW)
             `uvm_info(get_type_name(),$sformatf("Data: %0h,mem_data[%0d]=%0h",exp_data.dataout,r_txn,mem_data[r_txn]),UVM_LOW)
           end
        
        else  
           begin 
              `uvm_info(get_type_name(),$sformatf("------ ::FAILED MATCH:: ------"),UVM_LOW)
              `uvm_info(get_type_name(),$sformatf("Data: %0h,mem_wdata[%0d]=%0h",exp_data.dataout,r_txn,mem_data[r_txn]),UVM_LOW)
           end   
           //r_txn++;         
      end
             
    end 
  endtask
endclass
