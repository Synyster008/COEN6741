module WB_stage(clock2, MEMORY_READ, memory_out, result_ALU1, result_ALU2, result1, result2, destination_WRITEBACK, WRITEBACK_WRITEBACK, reg1, reg2);

    input clock2, MEMORY_READ;
    input [1:0] WRITEBACK_WRITEBACK;
    input [4:0] destination_WRITEBACK;
    input [31:0] memory_out, result_ALU1, result_ALU2;
    output [31:0] result1, reg1, reg2;
    output [31:0] result2;

    assign result2 = result_ALU2;

    mux2_1 #(.LENGTH (32)) mux_select(
        .in1(result_ALU1),
        .in2(memory_out),
        .select(MEMORY_READ),
        .out(result1)
        );

    register register(
      .clock(clock2), 
      .source1(5'b0), 
      .source2(5'b0), 
      .destination(destination_WRITEBACK), 
      .reg1(reg1), 
      .reg2(reg2), 
      .write_value1(result1), 
      .write_value2(result2), 
      .WRITEBACK(WRITEBACK_WRITEBACK)  
    ); 


endmodule
