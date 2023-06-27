`timescale 1ns / 1ps

module Top_Module_tb();
    reg [14:0]IN;
    wire [7:0]OUT;
    Top_Module DUT(.IN(IN),
                .OUT(OUT)
                );
    initial
        //AND GATE
        begin
            IN[0]=0;
            IN[1]=0;
        #10
            IN[0]=1;
            IN[1]=0;
        #10
            IN[0]=0;
            IN[1]=1;        
        #10
            IN[0]=1;
            IN[1]=1;
      
        //OR GATE
        #10
            IN[2]=0;
            IN[3]=0;
        #10
            IN[2]=1;
            IN[3]=0;
        #10
            IN[2]=0;
            IN[3]=1;        
        #10
            IN[2]=1;
            IN[3]=1;
        //NOT GATE    
        #10
            IN[4]=0;

        #10
            IN[4]=1;
        //NAND GATE
        
        #10
            IN[5]=0;
            IN[6]=0;
        #10
            IN[5]=1;
            IN[6]=0;
        #10
            IN[5]=0;
            IN[6]=1;        
        #10
            IN[5]=1;
            IN[6]=1;
        //NOR GATE    
        #10
            IN[7]=0;
            IN[8]=0;
        #10
            IN[7]=1;
            IN[8]=0;
        #10
            IN[7]=0;
            IN[8]=1;        
        #10
            IN[7]=1;
            IN[8]=1;
            
        //EXOR GATE    
        #10
            IN[9]=0;
            IN[10]=0;
        #10
            IN[9]=1;
            IN[10]=0;
        #10
            IN[9]=0;
            IN[10]=1;        
        #10
            IN[9]=1;
            IN[10]=1;
            
        //EXNOR GATE
        #10
            IN[11]=0;
            IN[12]=0;
        #10
            IN[11]=1;
            IN[12]=0;
        #10
            IN[11]=0;
            IN[12]=1;        
        #10
            IN[11]=1;
            IN[12]=1;
        //TRI GATE
        #10
            IN[13]=0;
            IN[14]=0;
        #10
            IN[13]=1;
            IN[14]=0;
        #10
            IN[13]=0;
            IN[14]=1;        
        #10
            IN[13]=1;
            IN[14]=1; 
          
        end                
endmodule
