module MEM_WB (clock2, destination_input, destination_output, result_input1, result_input2, result_output1, result_output2, loadvalue_input, loadvalue_output, MEMORY_READ_input, MEMORY_READ_output, 
    WRITEBACK_input, WRITEBACK_output);

    input clock2, MEMORY_READ_input; 
    input [1:0] WRITEBACK_input;
    input [4:0] destination_input;
    input [31:0] result_input1, result_input2, loadvalue_input;

    output reg MEMORY_READ_output;
    output reg [1:0] WRITEBACK_output;
    output reg [4:0] destination_output;
    output reg [31:0] result_output1, result_output2, loadvalue_output;

    always @(posedge clock2) begin
        MEMORY_READ_output <= MEMORY_READ_input;
        WRITEBACK_output <= WRITEBACK_input;
        destination_output <= destination_input;
        result_output1 <= result_input1; 
        result_output2 <= result_input2; 
        loadvalue_output <= loadvalue_input;
    end

endmodule
