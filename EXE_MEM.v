module EXE_MEM (clock, PC_input, PC_output, store_input, store_output, result_input, result_output, destination_input, destination_output,MEMORY_READ_input, MEMORY_READ_output, MEMORY_WRITE_input, 
MEMORY_WRITE_output, WRITEBACK_input, WRITEBACK_output);

    input clock, MEMORY_READ_input, MEMORY_WRITE_input, WRITEBACK_input;
    input [4:0] destination_input;
    input [31:0] PC_input, result_input, store_input;

    output reg MEMORY_READ_output, MEMORY_WRITE_output, WRITEBACK_output;
    output reg [4:0] destination_output;
    output reg [31:0] PC_output, result_output, store_output;

    always @(posedge clock) begin
        MEMORY_READ_output <= MEMORY_READ_input;
        MEMORY_WRITE_output <=  MEMORY_WRITE_input;
        WRITEBACK_output <= WRITEBACK_input;
        destination_output <= destination_input;
        PC_output <= PC_input;
        result_output <= result_input;
        store_output <= store_input;
    end

endmodule

