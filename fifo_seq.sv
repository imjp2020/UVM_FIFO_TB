
//=============================================
//  Write  sequence
//=============================================

class write_seq extends uvm_sequence#(fifo_item);
  
   fifo_item req; 
   fifo_item rsp; 
   int count;
    
  `uvm_object_utils(write_seq)

  function new(string name = "write_seq");
    super.new(name);
  endfunction
 
  task body();
       
   // uvm_phase starting_phase=get_starting_phase();
   //if(starting_phase!=null)
   //starting_phase.raise_objection(this);
   //if(starting_phase!=null)
   //starting_phase.drop_objection(this);
   // end
   repeat(4)                 
      begin        
        //`uvm_do(req)
        //`uvm_info("write_seq","111111111111111111",UVM_LOW)
        `uvm_info("write_seq","READ START",UVM_LOW)
        `uvm_do_with(req,{wn==1;})
        `uvm_info("write_seq","READ START",UVM_LOW)
         //`uvm_info_context("FIFO_WRITE_SEQ(base)",req.convert2string(),UVM_LOW,uvm_top)
         // req.print();
   end
 endtask  
endclass

//============================================
//     READ SEQUENCE 
//============================================

class read_seq extends write_seq;
  
 fifo_item req; 
 int       count;
    
  `uvm_object_utils(read_seq)

  function new(string name = "read_seq");
    super.new(name);
  endfunction
 
  task body();
    repeat(2)
    begin
       `uvm_info("read_seq","READ START",UVM_LOW)
       `uvm_do_with(req,{rn== 1;})
       // `uvm_info_context("FIFO_READ_SEQ",req.convert2string(),UVM_LOW,uvm_top)
      `uvm_info("read_seq","READ DONE",UVM_LOW)
      end
    
   endtask 
endclass


//============================================
//    WRITE - READ SEQUENCE 
//============================================

class write_read_seq extends write_seq;
 
  write_seq a1;
  read_seq b1;
 
  int count;
    
  `uvm_object_utils(write_read_seq)

  function new(string name = "write_read_seq");
    super.new(name);
  endfunction
 
  task body();

    repeat(8) 
    begin
    `uvm_do(a1)
   
     `uvm_do(b1)
    end
    
   endtask
endclass

//============================================
//    WRITE - READ SEQUENCE 
//============================================

class d_write_read_seq extends write_seq;
  
  write_seq a1;
  read_seq b1;
  
  int count;
    
  `uvm_object_utils(write_read_seq)

  function new(string name = "write_read_seq");
    super.new(name);
  endfunction
 
  task body();
    
     begin
       `uvm_do(a1)
      end

    begin
       `uvm_do(b1)
      end
   endtask 
endclass


/*
begin
          `uvm_info("write_seq","write START",UVM_LOW)
          start_item(req);
          `uvm_info("write_seq","write STARTED ",UVM_LOW)
          
          
         req.randomize();
          `uvm_info("write_seq","write randomize()",UVM_LOW)
          
          finish_item(req);
         `uvm_info("write_seq","write END",UVM_LOW)
          
          `uvm_info("write_seq","write waiting for RSP",UVM_LOW)
          //get_response(rsp);
          `uvm_info("write_seq","write RSP arrivied !",UVM_LOW)
          
*/
