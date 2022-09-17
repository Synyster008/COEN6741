module EXE_stage_tb();

    reg clock2, MEMORY_READ_EXECUTE, MEMORY_WRITE_EXECUTE; 
    reg [1:0] input1_select, input2_select, store_select, WRITEBACK_EXECUTE;
    reg [3:0] EXECUTE_command;
    reg [4:0] destination_EXECUTE;
    reg [31:0] input1, input2, result_forwarding_MEMORY, result_forwarding_WRITEBACK, store_input, PC_EXECUTE;
    wire MEMORY_READ_MEMORY, MEMORY_WRITE_MEMORY;
    wire [1:0] WRITEBACK_MEMORY;
    wire [4:0] destination_MEMORY;
    wire [31:0] result_ALU1, result_ALU2, store_output, PC_MEMORY, store_value_MEMORY, result_ALU1_MEMORY, result_ALU2_MEMORY;

    integer i;

    EXE_stage EXE_tb(
        .clock2(clock2), 
        .input1_select(input1_select), 
        .input2_select(input2_select), 
        .store_select(store_select), 
        .input1(input1), 
        .input2(input2), 
        .result_forwarding_MEMORY(result_forwarding_MEMORY), 
        .result_forwarding_WRITEBACK(result_forwarding_WRITEBACK), 
        .result_ALU1(result_ALU1), 
        .result_ALU2(result_ALU2), 
        .store_input(store_input), 
        .store_output(store_output), 
        .EXECUTE_command(EXECUTE_command), 
        .PC_EXECUTE(PC_EXECUTE), 
        .PC_MEMORY(PC_MEMORY), 
        .MEMORY_READ_EXECUTE(MEMORY_READ_EXECUTE), 
        .MEMORY_WRITE_EXECUTE(MEMORY_WRITE_EXECUTE), 
        .MEMORY_READ_MEMORY(MEMORY_READ_MEMORY), 
        .MEMORY_WRITE_MEMORY(MEMORY_WRITE_MEMORY), 
        .WRITEBACK_EXECUTE(WRITEBACK_EXECUTE), 
        .WRITEBACK_MEMORY(WRITEBACK_MEMORY), 
        .result_ALU1_MEMORY(result_ALU1_MEMORY),
        .result_ALU2_MEMORY(result_ALU2_MEMORY), 
        .store_value_MEMORY(store_value_MEMORY), 
        .destination_EXECUTE(destination_EXECUTE), 
        .destination_MEMORY(destination_MEMORY)
    );

    
    initial begin
        result_forwarding_MEMORY = 32'h15;
        result_forwarding_WRITEBACK = 32'h10;
        i=0;
        PC_EXECUTE = 0;
        clock2 = 0;
        repeat(50) begin
        #50 clock2 = ~clock2;
        end
    end

    always @(posedge clock2) begin
        case (i)
            0 : begin
                input1 = 32'h0;
                input2 = 32'h15;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 0;
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'h1;
                WRITEBACK_EXECUTE = 2'b1;
                destination_EXECUTE = 5'd1;
            end
            1 :  begin
                input1 = 32'h0;
                input2 = 32'h0;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 0; 
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b1;
                store_select = 2'b0;
                EXECUTE_command = 4'b1;
                WRITEBACK_EXECUTE = 2'b1;
                destination_EXECUTE = 5'd2;
            end
            2 :  begin
                input1 = 32'h15;
                input2 = 32'h0;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 1;
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0; 
                store_select = 2'b0;
                EXECUTE_command = 4'b1;
                WRITEBACK_EXECUTE = 2'd2;
                destination_EXECUTE = 5'd5;
            end 
            3 :  begin
                input1 = 32'h15;
                input2 = 32'h7;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 0; 
                MEMORY_WRITE_EXECUTE = 1;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'd2;
                WRITEBACK_EXECUTE = 2'b1;
                destination_EXECUTE = 5'd5;
            end
            4 :  begin
                input1 = 32'h0;
                input2 = 32'h0;
                store_input = 32'h15;
                MEMORY_READ_EXECUTE = 0;
                MEMORY_WRITE_EXECUTE = 1;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'b1;
                WRITEBACK_EXECUTE = 2'b0;
                destination_EXECUTE = 5'd0;
            end
            5 :  begin
                input1 = 32'b0;
                input2 = 32'h12;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 1;
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'd5;
                WRITEBACK_EXECUTE = 2'b1;
                destination_EXECUTE = 5'd12;
            end
            6 :  begin
                input1 = 32'h15;
                input2 = 32'h07;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 0;
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'd3;
                WRITEBACK_EXECUTE = 2'd3;
                destination_EXECUTE = 5'd0;
            end
            7 :  begin
                input1 = 32'h0;
                input2 = 32'h0;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 0; 
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'b0;
                WRITEBACK_EXECUTE = 2'b0;
                destination_EXECUTE = 5'd0;
            end
            8 :  begin
                input1 = 32'h15;
                input2 = 32'h65;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 0;
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'd4;
                WRITEBACK_EXECUTE = 2'b1;
                destination_EXECUTE = 5'd7;
            end
            9 :  begin
                input1 = 32'h0;
                input2 = 32'h0;
                store_input = 32'h0;
                MEMORY_READ_EXECUTE = 0;
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'b0;
                WRITEBACK_EXECUTE = 2'b0;
                destination_EXECUTE = 5'd1;
            end
            default:  begin
                input1 = 32'b0;
                input2 = 32'b0;
                store_input = 32'b0;
                MEMORY_READ_EXECUTE = 0; 
                MEMORY_WRITE_EXECUTE = 0;
                input1_select = 2'b0;
                input2_select = 2'b0;
                store_select = 2'b0;
                EXECUTE_command = 4'b0;
                WRITEBACK_EXECUTE = 2'b0;
                destination_EXECUTE = 5'd0;
            end
        endcase
        PC_EXECUTE = PC_EXECUTE + 4;
        i = i+1;
    end

endmodule
