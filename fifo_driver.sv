//=======================================================
//           fifo driver
//=======================================================

class fifo_driver extends uvm_driver#(fifo_item);
  
  virtual fifo_if vif;
  
  fifo_item rsp;
  //fifo_item resp;
  
  `uvm_component_utils(fifo_driver)
  
  function new(string name = "fifo_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //rsp=fifo_item::type_id::create("rsp",this);
        
     `uvm_info("fifo_driver","BUILD phase",UVM_LOW)
    
      if(!uvm_config_db#(virtual fifo_if)::get(this,"","vif",vif))
         `uvm_fatal(get_type_name(),"fifo driver - vif is not set at top level");
    endfunction
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    
    forever      
      begin
        `uvm_info("fifo_driver","RUN phase started()",UVM_LOW)
        
        seq_item_port.get_next_item(req);   
        
        data_drive(req);
             
        //drive with req & rsp 
        //rsp.set_id_info(req);    
        //get rsp 
        
        seq_item_port.item_done();
        
        `uvm_info("fifo_driver","RUN phase ended()",UVM_LOW)
      end    
  endtask   
  
  task data_drive(fifo_item req);     
    
    fifo_item resp;  
    
    // if(!$cast(resp,req.clone()))
    //   `uvm_fatal("fifo_driver","cast to resp failed")
    //resp=fifo_item::type_id::create("resp",this);
    
    if(vif.rst) begin
        `uvm_info("fifo_driver","RESET [ON]",UVM_LOW) 
         begin   
           vif.datain<=  0; 
           vif.wn<=		 0;  
           vif.rn<=      0;
           vif.full<=    0;
           vif.empty<=   0;
           vif.dataout<= 0;
        end
    `uvm_info("fifo_driver","RESET [OFF]",UVM_LOW)  
    
    end
    else
      begin //{
        

       //write
        if(req.wn)
           begin
            vif.datain<=req.datain;
            vif.wn<=req.wn;
           end
             @(posedge vif.clk);
              vif.wn<=0;
              if(vif.full)
                //req.print();
              `uvm_warning("FIFO FULL Asserted","**********Write stop calls()***********")
               //`uvm_info("fifo_driver","driver [off]",UVM_LOW) 
              //`uvm_info("driver ",$sformatf("vif.datain=%h vif.rn=%h vif.wn=%h",vif.datain,vif.rn,vif.wn),UVM_LOW)
           end
                
      //read 
      if(req.rn) begin              
             
           vif.rn<=req.rn;
           req.dataout<=vif.dataout;
           @(posedge vif.clk)begin
           vif.rn<=0;
             
          //RESP we got from FIFO   
         
           end //}

           //resp.empty<=vif.empty;
           //rsp<=resp;
      end    
  endtask
endclass
             
