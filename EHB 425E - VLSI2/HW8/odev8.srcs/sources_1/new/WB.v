
module WB(

    input   wire        rst,

    input   wire[4:0]   MemWriteNum,
    input   wire        MemWriteReg,
    input   wire[31:0]  MemWriteData,

    output  reg [4:0]   WriteBackNum,
    output  reg         WriteBackReg,
    output  reg [31:0]  WriteBackData

);

/*
 * This always part controls the signal WriteBackNum.
 */  
always @ (*) begin
    if (rst)
        WriteBackNum <= 5'b0;
    else
        WriteBackNum <= MemWriteNum;
end

/*
 * This always part controls the signal WriteBackReg.
 */
always @ (*) begin
    if (rst)
        WriteBackReg <= 1'b0;
    else
        WriteBackReg <= MemWriteReg;
end

/*
 * This always part controls the signal WriteBackData.
 */
always @ (*) begin
    if (rst)
        WriteBackData <= 32'b0;
    else
        WriteBackData <= MemWriteData;
end

endmodule