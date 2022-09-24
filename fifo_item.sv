//=======================================================
//  fifo item 
//=======================================================

class fifo_item extends  uvm_sequence_item;
  
//     rand logic  	     rst;  
rand   logic         wn, rn;
rand   logic  [7:0]  datain;
       logic         full,empty;
       logic  [7:0]  dataout;
   
 constraint wn_rn_ {  !wn == rn ;}
 constraint data_c{ datain <= 32 ;}
  

  function new(string name = "fifo_item");
      super.new(name);
  endfunction
  
  
  `uvm_object_utils(fifo_item)

    
 function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("dataout", dataout,$bits(dataout), UVM_HEX);
    printer.print_field_int("wn",wn, $bits(wn),UVM_HEX);
    printer.print_field_int("rn",rn, $bits(rn),UVM_HEX);
    printer.print_field_int("datain",datain,$bits(datain),UVM_HEX);
    printer.print_field_int("full",full,$bits(full),UVM_HEX);
    printer.print_field_int("empty",empty,$bits(empty),UVM_HEX);
    //printer.print_field_int("rst",rst,$bits(rst),UVM_HEX);
 endfunction
  
  
    // Customizse print()
 /*  virtual function string convert2string();
    
     string msg =super.convert2string(); 
     $sformat(msg,"%s\n-------------------\n\wr\t= %0d\n ",msg,wn);
     $sformat(msg,"%srn\t= %0d\n",msg,rn);
     $sformat(msg,"%sdatain\t= %0d\n",msg,datain);
     $sformat(msg,"%sdataout\t= %0d\n",msg,dataout);
     $sformat(msg,"%sfull\t= %0d\n",msg,full);
     $sformat(msg,"%sempty\t= %0d\n---------------\n",msg,empty);
     
    return msg;
    
    endfunction
  */
  
   /*virtual function string convert2string();
     string m_data= "";
      //$sformat(m_data,"%s sop %h",m_data,sop);
     $sformat(m_data,"%s datain %h",m_data,datain);
     //foreach(data[i]) begin
     //  $sformat(m_data,"%s data %h",m_data,data[i]);
    //   end
     return m_data;
  endfunction*/
  
endclass
