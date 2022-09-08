module MEM_WB (clock, destination_input, destination_output, result_input, result_output, loadvalue_input, loadvalue_output, MEMORY_READ_input, MEMORY_READ_output, WRITEBACK_input, WRITEBACK_output);

    input clock, MEMORY_READ_input, WRITEBACK_input;
    input [4:0] destination_input;
    input [31:0] result_input, loadvalue_input;

    output reg MEMORY_READ_output, WRITEBACK_output;
    output reg [4:0] destination_output;
    output reg [31:0] result_output, loadvalue_output;

    always @(posedge clock) begin
        MEMORY_READ_output <= MEMORY_READ_input;
        WRITEBACK_output <= WRITEBACK_input;
        destination_output <= destination_input;
        result_output <= result_input; 
        loadvalue_output <= loadvalue_input;
    end

endmodule
