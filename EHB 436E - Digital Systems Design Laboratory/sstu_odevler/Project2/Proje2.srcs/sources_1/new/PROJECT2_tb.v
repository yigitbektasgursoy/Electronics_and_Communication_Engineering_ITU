module PROJECT2_tb();
    reg res, x, clk;
    wire Z;

    PROJECT2 DUT(
        .res(res),
        .clk(clk),
        .x(x),
        .Z(Z)
        );
    
    always
    begin
        clk = ~clk; #10;
    end 
    
    
    initial 
    begin
        res =1 ;#20 ;x = 0; clk = 0; #20;
        res = 0; #20;
        x = 0; #20; x = 0; #20; x = 0; #20; 
        x = 0; #20; x = 1; #20;
        x = 1; #20; x = 0; #20;
        x = 1; #20; x = 0; #20;
        x = 0; #20;
        x = 1; #20; x = 1; #20; x = 0; #20; x = 1; #20; x = 1; #20;
        x = 1; #20; x = 1; #20; x = 0; #20; x = 0; #20; x = 1; #20; 
        res = 1; #20;
        res = 0; #20;
        x = 1; #20; x = 1; #20; x = 0; #20; x = 0; #20; x = 1; #20;
        x = 1; #20; x = 0; #20; x = 1; #20; x = 0; #20; x = 1; #20;
        x = 1; #20; x = 0; #20; x = 0; #20; x = 1; #20; x = 1; #20;
        x = 1; #20; x = 1; #20; x = 0; #20; x = 0; #20; x = 1; #20;
    end
endmodule