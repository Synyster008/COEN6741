module WB_stage_tb();

    reg clock2, MEMORY_READ_WRITEBACK;
    reg [1:0] WRITEBACK_WRITEBACK;
    reg [4:0] destination_WRITEBACK;
    reg [31:0] memory_out, result_ALU1_WRITEBACK, result_ALU2_WRITEBACK;
    wire [31:0] result1, result2, reg1, reg2;

    integer i;

    WB_stage WB_tb(
        .clock2(clock2), 
        .MEMORY_READ(MEMORY_READ_WRITEBACK), 
        .memory_out(memory_out_WRITEBACK), 
        .result_ALU1(result_ALU1_WRITEBACK), 
        .result_ALU2(result_ALU2_WRITEBACK), 
        .result1(result1), 
        .result2(result2), 
        .destination_WRITEBACK(destination_WRITEBACK), 
        .WRITEBACK_WRITEBACK(WRITEBACK_WRITEBACK),
        .reg1(reg1),
        .reg2(reg2)
    );

    initial begin
        i=0;
        clock2 = 0;
        repeat(50) begin
        #50 clock2 = ~clock2;
        end
    end

    always @(posedge clock2) begin
        case (i)
            0 : begin
                result_ALU1_WRITEBACK = 32'h15;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h0;
                MEMORY_READ_WRITEBACK = 0;
                WRITEBACK_WRITEBACK = 2'b1;
                destination_WRITEBACK  = 5'd1;
            end
            1 :  begin
                result_ALU1_WRITEBACK  = 32'h15;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h0;
                MEMORY_READ_WRITEBACK = 0;
                WRITEBACK_WRITEBACK = 2'b1;
                destination_WRITEBACK  = 5'd2;
            end
            2 :  begin
                result_ALU1_WRITEBACK   = 32'h0;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h15;
                MEMORY_READ_WRITEBACK = 1;
                WRITEBACK_WRITEBACK  = 2'd2;
                destination_WRITEBACK   = 5'd5;
            end 
            3 :  begin
                result_ALU1_WRITEBACK   = 32'h8;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h0;
                MEMORY_READ_WRITEBACK = 0;
                WRITEBACK_WRITEBACK  = 2'b1;
                destination_WRITEBACK   = 5'd5;
            end
            4 :  begin
                result_ALU1_WRITEBACK  = 32'h0;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h8;
                MEMORY_READ_WRITEBACK = 1;
                WRITEBACK_WRITEBACK  = 2'b0;
                destination_WRITEBACK   = 5'd15;
            end
            5 :  begin
                result_ALU1_WRITEBACK  = 32'b0;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h00120000;
                MEMORY_READ_WRITEBACK = 1;
                WRITEBACK_WRITEBACK  = 2'b1;
                destination_WRITEBACK  = 5'd6;
            end
            6 :  begin
                result_ALU1_WRITEBACK  = 32'h2;
                result_ALU2_WRITEBACK = 32'h1;
                memory_out = 32'h0;
                MEMORY_READ_WRITEBACK= 0;
                WRITEBACK_WRITEBACK  = 2'd3;
                destination_WRITEBACK   = 5'd0;
            end
            7 :  begin
                result_ALU1_WRITEBACK  = 32'h0;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h0;
                MEMORY_READ_WRITEBACK= 0;
                WRITEBACK_WRITEBACK  = 2'b0;
                destination_WRITEBACK   = 5'd0;
            end
            8 :  begin
                result_ALU1_WRITEBACK  = 32'h1;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h0; 
                MEMORY_READ_WRITEBACK = 0;
                WRITEBACK_WRITEBACK  = 2'b1;
                destination_WRITEBACK   = 5'd7;
            end
            9 :  begin
                result_ALU1_WRITEBACK  = 32'h0;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'h0;
                MEMORY_READ_WRITEBACK = 0;
                WRITEBACK_WRITEBACK  = 2'b0;
                destination_WRITEBACK   = 5'd1;
            end
            default:  begin
                result_ALU1_WRITEBACK  = 32'b0;
                result_ALU2_WRITEBACK = 32'h0;
                memory_out = 32'b0;
                MEMORY_READ_WRITEBACK = 0;
                WRITEBACK_WRITEBACK  = 2'b0;
                destination_WRITEBACK  = 5'd0;
            end
        endcase
        i = i+1;
    end

endmodule
