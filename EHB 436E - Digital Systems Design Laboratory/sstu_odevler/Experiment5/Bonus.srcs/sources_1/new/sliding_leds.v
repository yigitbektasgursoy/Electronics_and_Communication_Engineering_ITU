`timescale 1ns / 1ps

module sliding_leds#(
    parameter MAX_CNT_DEST = 5000000 // 100MHz / 10 = 10M
    )(
    input rst,clk,
    input [1:0]SW,
    output reg [15:0]LED
    );
    reg [$clog2(MAX_CNT_DEST-1)-1:0] divcounter = 0;
    reg divclk;
    always @(posedge clk or posedge rst)
    
        begin
        if(rst)
            LED<= 16'h0001;
        else 
            begin
                case(SW)
                    //stop
                    2'b00: 
                        LED <= LED;
                        
                    //10Hz
                    2'b01: 
                    begin
                        if(LED == 16'h8000) 
                        begin 
                            if (divcounter % (MAX_CNT_DEST-1) == 0 && divcounter !=0)
                                LED <= 16'h0001; 
                        end
                        
                        else 
                        begin
                            if (divcounter % (MAX_CNT_DEST-1) == 0 && divcounter !=0)
                                LED <= LED<<1'b1;
                        end
                    end
                    
                //20Hz 
                2'b10: 
                    begin
                        if(LED == 16'h8000)
                        begin 
                            if (divcounter % ((MAX_CNT_DEST-1)/2) == 0 && divcounter !=0)
                                LED <= 16'h0001; 
           
                        end
                        
                        else 
                        begin
                            if (divcounter % ((MAX_CNT_DEST-1)/2) == 0 && divcounter !=0)
                                LED <= LED<<1'b1;
                        end
                    end
                    
                //50Hz 
                2'b11:
                    begin
                        if(LED == 16'h8000) 
                        begin 
                            if (divcounter % ((MAX_CNT_DEST-1)/5) == 0 && divcounter !=0)
                                LED <= 16'h0001;           
                        end
                        
                        else 
                        begin
                            if (divcounter % ((MAX_CNT_DEST-1)/5) == 0 && divcounter !=0)
                                LED <= LED<<1'b1;
                        end
                    end  
                default : LED <= LED;
            endcase
        end
    end
    
        
    always @(posedge clk or posedge rst)
        begin
            if(rst)
                divcounter <=0;
            else
            begin
                if (divcounter == MAX_CNT_DEST)
                    divcounter <= 0;
                else 
                    divcounter <= divcounter+1;
            end
        end    
endmodule
