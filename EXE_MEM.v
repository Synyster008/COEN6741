module EXE_MEM (clock2, PC_input, PC_output, store_input, store_output, result1_input, result2_input, result1_output, result2_output, destination_input, destination_output,MEMORY_READ_input, MEMORY_READ_output, 
    MEMORY_WRITE_input, MEMORY_WRITE_output, WRITEBACK_input, WRITEBACK_output);

    input clock2, MEMORY_READ_input, MEMORY_WRITE_input; 
    input [1:0] WRITEBACK_input;
    input [4:0] destination_input;
    input [31:0] PC_input, result1_input, result2_input, store_input;

    output reg MEMORY_READ_output, MEMORY_WRITE_output; 
    output reg [1:0] WRITEBACK_output;
    output reg [4:0] destination_output;
    output reg [31:0] PC_output, result1_output, result2_output, store_output;

    always @(posedge clock2) begin
        MEMORY_READ_output <= MEMORY_READ_input;
        MEMORY_WRITE_output <=  MEMORY_WRITE_input;
        WRITEBACK_output <= WRITEBACK_input;
        destination_output <= destination_input;
        PC_output <= PC_input;
        result1_output <= result1_input;
        result2_output <= result2_input;
        store_output <= store_input;
    end

endmodule

