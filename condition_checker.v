module condition_checker(in1, in2, branch_command, condition);
    input [31:0] in1, in2;
    input [1:0] branch_command;
    output reg condition;

    always @(*) begin
        case (branch_command)
        2'b01: condition <= 1; //J
        2'b10: condition <= 1; //JR
        2'b11: condition <= (in1 == in2) ? 1: 0; //BEQ
        default: condition <= 0;
        endcase
    end

endmodule
