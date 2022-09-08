module control_unit (opcode, branch, EXECUTE_command, branch_command, immediate_check, store_check, WRITEBACK, MEMORY_READ, MEMORY_WRITE, hazard);
    input [5:0] opcode;
    input hazard;
    output reg branch;
    output reg [3:0] EXECUTE_command;
    output reg [1:0] branch_command;
    output reg immediate_check, store_check, WRITEBACK, MEMORY_READ, MEMORY_WRITE;

    always @(*) begin
        if (hazard == 0) begin
            {branch, EXECUTE_command, branch_command, immediate_check, store_check, WRITEBACK, MEMORY_READ, MEMORY_WRITE} <= 0;

            case (opcode)

            6'b000001: begin //ADDU
                EXECUTE_command <= 4'b0001;
                WRITEBACK <= 1'b1;
            end
            6'b000010: begin //ADDI
                EXECUTE_command <= 4'b0001;
                WRITEBACK <= 1'b1;
                immediate_check <= 1;
            end
            6'b000011: begin //SUBIU
                EXECUTE_command <= 4'b0010;
                WRITEBACK <= 1'b1;
                immediate_check <= 1;
            end
            6'b000100: begin //SLTI
                EXECUTE_command <= 4'b0100;
                WRITEBACK <= 1'b1;
                immediate_check <= 1;
            end
            6'b000101: begin //LUI
                EXECUTE_command <= 4'b0101;
                WRITEBACK <= 1'b1;
                immediate_check <= 1;
                MEMORY_READ <= 1;
                store_check <= 1;
            end
            6'b000110: begin //DIV
                EXECUTE_command <= 4'b0011;
                WRITEBACK <= 1'b1;
            end
            6'b000111: begin //J
                EXECUTE_command <= 4'b0000;
                immediate_check <= 1;
                branch <= 1;
                branch_command <= 2'b01;
            end
            6'b001000: begin //JR
                EXECUTE_command <= 4'b0000;
                branch <= 1;
                branch_command <= 2'b10;
            end
            6'b001001: begin //BEQ
                EXECUTE_command <= 4'b0000;
                immediate_check <= 1;
                branch <= 1;
                branch_command <= 2'b11;
            end
            6'b001010: begin //LL
                EXECUTE_command <= 4'b0001;
                WRITEBACK <= 1'b1;
                immediate_check <= 1;
                MEMORY_READ <= 1;
                store_check <= 1;
            end
            6'b001011: begin //SC
                EXECUTE_command <= 4'b0001;
                immediate_check <= 1;
                MEMORY_WRITE <= 1;
                store_check <= 1;
            end
            default: {branch, EXECUTE_command, branch_command, immediate_check, store_check, WRITEBACK, MEMORY_READ, MEMORY_WRITE} <= 0;
            endcase
        end

        else if (hazard == 1) begin
            {EXECUTE_command, WRITEBACK, MEMORY_WRITE} <=0;
        end
    end
endmodule