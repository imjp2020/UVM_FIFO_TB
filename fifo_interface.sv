//=======================================================
//  fifo interafce 
//=======================================================

interface fifo_if(input bit clk,rst);
  
logic [7:0] dataout;
logic       full, empty;
logic [7:0] datain;
logic       wn, rn;
   
//keeping it simple 
//No clocking Block 

endinterface
