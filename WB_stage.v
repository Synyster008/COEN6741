module WB_stage(clock1, MEMORY_READ, memory_out, result_ALU1, result_ALU2, result1, result2);

    input clock1, MEMORY_READ;
    input [31:0] memory_out, result_ALU1, result_ALU2;
    output reg [31:0] result1, result2;

    always @(posedge clock1) begin
        result1 <= (MEMORY_READ) ? memory_out : result1;
        result2 <= result_ALU2;
    end

endmodule
