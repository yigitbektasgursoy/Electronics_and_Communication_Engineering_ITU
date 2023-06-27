`timescale 1ns / 1ps

module CU(
    input Start, clk, reset, CO, Z,
    input [7:0] InA, InB,
    output reg Busy, WE,
    output reg [7:0] CUconst,  
    output reg [3:0] OutMuxAdd, RegAdd,
    output reg [2:0] InMuxAdd,
    output reg [1:0] InsSel 
    );
    
    reg [3:0]durum;
    reg [3:0]durum2;
    
    always@(posedge clk or posedge reset) begin
        if (reset) begin
            InsSel <= 0;
            WE <= 0;
            Busy <= 0;
            CUconst <= 0;
            OutMuxAdd <= 0; 
            RegAdd <= 0;
            InMuxAdd <=0;
            durum <= 0;
            durum2 <= 0;
        end
        else begin
            if (Start) begin
               Busy <=1'b1;
               durum <= 0;
               durum2 <= 0;
            end
            if (Busy == 0) begin
                durum <= 0;
                durum2 <= 0;
            end
            else if (Busy) begin
                if (InA == 8'd0)begin // A==0  => sonuç = 0
                    if (InB == 8'd0) begin
                        InMuxAdd <=3'd2;
                        CUconst <= 8'bzzzz_zzzz;
                        RegAdd <= 3'd0;
                        WE <= 1'b1;
                        Busy <=0;                   
                    end
                    else begin
                        InMuxAdd <=3'd0;
                        RegAdd <= 3'd0;
                        WE <= 1'b1;
                        Busy <=0;
                    end
                end
                   
                else if (InA == 8'd1)begin // A==1  => sonuç = 1
                    InMuxAdd <=3'd0;
                    RegAdd <= 3'd0;
                    WE <= 1'b1;
                    Busy <=0;
                end
                else if (InA == 8'd2)begin // A==10  => sonuç = A << B
                    if (durum == 4'd0) begin // reg1 <= A
                        InMuxAdd <=3'd0;
                        RegAdd <= 3'd1;
                        WE <= 1'b1;
                        durum <= 4'd1;
                    end
                    if (durum == 4'd1) begin // reg2 <= B
                        InMuxAdd <=3'd1;
                        RegAdd <= 3'd2;
                        WE <= 1'b1;
                        durum <= 4'd2;
                    end
                    else if (durum == 4'd2) begin // sonuc = A << B
                        if(InB == 8'd0) begin // B==0 => sonuc = 1
                            InMuxAdd <=3'd2;
                            RegAdd <= 3'd0;
                            WE <= 1'b1;
                            CUconst <= 8'd1;
                            Busy <= 0;
                        end
                        else if(InB == 8'd1) begin // B==1 => sonuc = 10
                            InMuxAdd <=3'd0;
                            RegAdd <= 3'd0;
                            WE <= 1'b1;
                            Busy <= 0;
                        end
                        else if(InB == 8'd2) begin // B==10 => sonuc = 100
                            InsSel <= 2'd3;
                            InMuxAdd <= 3'd3;
                            RegAdd <= 3'd0;
                            WE <= 1'b1;
                            Busy <= 0;
                        end
                        else if(InB == 8'd3) begin // B==11 => sonuc = 1000
                            if (durum2 == 4'b0) begin //reg1 <=100
                                InsSel <= 2'd3;
                                InMuxAdd <= 3'd3;
                                RegAdd <= 3'd1;
                                WE <= 1'b1;
                                durum2 = 4'b1;
                            end
                            else if (durum2 == 4'b1) begin //sonuc = reg1 << 1;
                                InsSel <= 2'd3;
                                InMuxAdd <= 3'd3;
                                RegAdd <= 3'd0;
                                WE <= 1'b1;
                                Busy <= 0;
                            end
                        end
                    end
                end
                else if (InA == 8'd3)begin // A == 11  
                    if (durum == 4'd0) begin // reg1 <= A          
                        InMuxAdd <=3'd0;                           
                        RegAdd <= 3'd1;                            
                        WE <= 1'b1;                                
                        durum <= 4'd1;                            
                    end                                            
                    else if (durum == 4'd1) begin // reg2 <= B     
                        InMuxAdd <=3'd1;                           
                        RegAdd <= 3'd2;                            
                        WE <= 1'b1;                                
                        durum <= 4'd2;                             
                    end                                            
                    else if (durum == 4'd2) begin // sonuc = A << B
                        if(InB == 8'd0) begin // B==0 => sonuc = 1    
                            InMuxAdd <=3'd2;                          
                            RegAdd <= 3'd0;                           
                            WE <= 1'b1;                               
                            CUconst <= 8'd1;                          
                            Busy <= 0;                                
                        end                                           
                        else if(InB == 8'd1) begin // B==1 => sonuc = 11   
                            InMuxAdd <=3'd0;                          
                            RegAdd <= 3'd0;                           
                            WE <= 1'b1;                               
                            Busy <= 0;                                
                        end                                           
                        else if(InB == 8'd2) begin // B==10 => sonuc = 1001
                            if (durum2 == 4'd0) begin //reg2 <=110 
                                InsSel <= 2'd3;                    
                                InMuxAdd <= 3'd3;                  
                                RegAdd <= 3'd2;                    
                                WE <= 1'b1;                        
                                durum2 = 4'b1;                     
                            end 
                            else if (durum2 == 4'd1) begin //sonuc = reg1 + reg2 
                                InsSel <= 2'd2;                    
                                InMuxAdd <= 3'd3;                  
                                RegAdd <= 3'd0;                    
                                WE <= 1'b1;                        
                                Busy <= 0;                     
                            end                                   
                        end 
                        else if(InB == 8'd3) begin // B==11 => sonuc = 11011
                            if (durum2 == 4'b0) begin //reg1 <=110 
                                InsSel <= 2'd3;                    
                                InMuxAdd <= 3'd3;                  
                                RegAdd <= 3'd1;                    
                                WE <= 1'b1;                        
                                durum2 = 4'b1;                     
                            end 
                            else if (durum2 == 4'b1) begin //reg1 <=1100 
                                InsSel <= 2'd3;                    
                                InMuxAdd <= 3'd3;                  
                                RegAdd <= 3'd1;                    
                                WE <= 1'b1;                        
                                durum2 = 4'd2;                     
                            end
                            else if (durum2 == 4'd2) begin //reg1 <=11000 
                                InsSel <= 2'd3;                    
                                InMuxAdd <= 3'd3;                  
                                RegAdd <= 3'd1;                    
                                WE <= 1'b1;                        
                                durum2 = 4'd3;                     
                            end
                            else if (durum2 == 4'd3) begin //sonuc = reg1+reg2
                                InsSel <= 2'd2;                    
                                InMuxAdd <= 3'd3;                  
                                RegAdd <= 3'd0;                    
                                WE <= 1'b1;                        
                                Busy <=0;                     
                            end
                        end
                    end
                end 
            end  
        end
    end
endmodule
