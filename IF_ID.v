module IF_ID(clock, flush, PC_input, PC_output, instruction_input, instruction_output);
    input clock, flush;
    input [31:0] PC_input, instruction_input;
    output reg [31:0] PC_output, instruction_output;

    always @(posedge clock) begin
        if (flush) begin
            instruction_output <= 0;
            PC_output <= 0;
        end

        else begin
            instruction_output <= instruction_input;
            PC_output <= PC_input;
        end
    end

endmodule
