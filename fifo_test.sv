//=======================================================
//  fifo test
//=======================================================

class fifo_test extends uvm_test;
  
   fifo_env	     env_h;
   write_seq        wr_seq;
   read_seq         rd_seq;
   write_read_seq   wr_rd_seq;
  
  `uvm_component_utils(fifo_test)  
  
  function new(string name="fifo_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
    
  
  virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase); 
        `uvm_info("fifo_test","BUILD phase",UVM_LOW)
         //`uvm_config_wrapper::set(this,"env_h.agent_h.sqr_h.run_phase","default_sequence",fifo_seq::get_type());
           env_h =fifo_env::type_id::create("env_h",this);  
            wr_rd_seq =write_read_seq::type_id::create("wr_rd_seq",this);
  endfunction 
   
   virtual function void connect_phase(uvm_phase phase);
         super.connect_phase(phase);     
            //`uvm_info("fifo_test","DUMMMY Connect phase",UVM_LOW)
  endfunction 
   
  virtual function void end_of_elaboration_phase(uvm_phase phase);
       super.end_of_elaboration_phase(phase);         
          `uvm_info("fifo_test","end_of_elaboration_phase ",UVM_LOW)
            uvm_top.print_topology();
            //  Debug Use -Check all TLM port connections 
            env_h.agent_h.mon_h.item_collect_port.debug_connected_to();
  endfunction 
  
   virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);         
          `uvm_info("fifo_test","start_of_simulation_phase",UVM_LOW)
  endfunction 
   
  //----------------------------------------------------------
  //   run_phase task()
  //----------------------------------------------------------
  task run_phase(uvm_phase phase);
     
       //super.run_phase(phase);     
           `uvm_info("fifo_test","RUN_PHASE ON",UVM_LOW)
           phase.raise_objection(this, "Raise Objection");
           
      wr_rd_seq=write_read_seq::type_id::create("wr_rd_seq",this);
        forever           
            begin
               wr_rd_seq.start(env_h.agent_h.sqr_h);
              #10;
            end
     
         phase.drop_objection(this, "Drop Objection");
     `uvm_info("fifo_test","RUN_PHASE OFF",UVM_LOW)
   endtask 
    
   task reset_phase(uvm_phase phase);
       phase.raise_objection(this);
         //super.reset_phase(phase);   
         `uvm_info("fifo_test..reset_phase","reset phase [on]",UVM_LOW)
          #30;
         `uvm_info("fifo_test..reset_phase","reset phase [off]",UVM_LOW)
   phase.drop_objection(this);
           
  endtask   
   
  task pre_configure_phase(uvm_phase phase);
        phase.raise_objection(this);
          `uvm_info("fifo_test","pre_configure_phase [on]",UVM_LOW)
          
     //***************************************************
      //  wr_seq=fifo_seq::type_id::create("wr_seq",this);
      //   repeat(15)           
      //     begin
      //        wr_rd_seq.start(env_h.agent_h.sqr_h);
      //       #10;
      //     end
      phase.drop_objection(this);
     //****************************************************
    `uvm_info("fifo_test","pre_configure_phase [off]",UVM_LOW)
   endtask
  
  
     task configure_phase(uvm_phase phase);
       phase.raise_objection(this);
      //***************************************************
     `uvm_info("fifo_test","configure_phase [on]",UVM_LOW)
      //#10;
       phase.drop_objection(this);
     //****************************************************
       `uvm_info("fifo_test","configure_phase [off]",UVM_LOW)
   endtask
  
    
     task post_configure_phase(uvm_phase phase);
       phase.raise_objection(this);
      //***************************************************
      // #10;
       `uvm_info("fifo_test","post configure_phase [on]",UVM_LOW)
      phase.drop_objection(this);
       `uvm_info("fifo_test","post configure_phase [off]",UVM_LOW)
     //****************************************************
   endtask
    
  task main_phase(uvm_phase phase);
       phase.raise_objection(this);
         //****************************************************
     `uvm_info("fifo_test","main_phase [on]",UVM_LOW)
     // #25;     
      phase.drop_objection(this);
     `uvm_info("fifo_test","main_phase [off]",UVM_LOW)
     //***************************************************
  endtask 
   
    task shutdown_phase(uvm_phase phase);
        phase.raise_objection(this);
       // #125;
        phase.drop_objection(this);        
      `uvm_info("fifo_test..","shutdown_phase [off]",UVM_LOW)
  endtask

endclass
