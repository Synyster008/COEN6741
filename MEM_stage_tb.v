module MEM_stage_tb();

    reg clock1, clock2, MEMORY_READ, MEMORY_WRITE; 
    reg [1:0] WRITEBACK_MEMORY;
    reg [4:0] destination_MEMORY;
    reg [31:0] result_ALU1_MEMORY, result_ALU2_MEMORY, store_input;
    wire MEMORY_READ_WRITEBACK;
    wire [1:0] WRITEBACK_WRITEBACK;
    wire [4:0] destination_WRITEBACK;
    wire [31:0] memory_out_MEMORY, memory_out_WRITEBACK, result_ALU1_WRITEBACK, result_ALU2_WRITEBACK;

    integer i;

    MEM_stage MEM_tb(
        .clock1(clock1), 
        .clock2(clock2), 
        .result_ALU1_MEMORY(result_ALU1_MEMORY), 
        .result_ALU2_MEMORY(result_ALU2_MEMORY), 
        .result_ALU1_WRITEBACK(result_ALU1_WRITEBACK), 
        .result_ALU2_WRITEBACK(result_ALU2_WRITEBACK), 
        .store_input(store_input), 
        .memory_out_MEMORY(memory_out_MEMORY), 
        .memory_out_WRITEBACK(memory_out_WRITEBACK), 
        .MEMORY_READ(MEMORY_READ), 
        .MEMORY_WRITE(MEMORY_WRITE),
        .MEMORY_READ_WRITEBACK(MEMORY_READ_WRITEBACK), 
        .WRITEBACK_MEMORY(WRITEBACK_MEMORY), 
        .WRITEBACK_WRITEBACK(WRITEBACK_WRITEBACK), 
        .destination_MEMORY(destination_MEMORY), 
        .destination_WRITEBACK(destination_WRITEBACK)
    );

    initial begin
        clock1 = 0;
        clock2 = 0;
        i=0;
        repeat(50) begin
        #50 clock1 = ~clock1;
        #50 clock2 = ~clock2;
        end
    end 

    always @(posedge clock1) begin
        case (i)
            0 : begin
                result_ALU1_MEMORY = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ = 0;
                destination_MEMORY  = 5'd1;
            end
            1 :  begin
                result_ALU1_MEMORY  = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ= 0; 
                destination_MEMORY = 5'd2;
            end
            2 :  begin
                result_ALU1_MEMORY  = 32'h15;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ = 1;
                destination_MEMORY  = 5'd5;
            end 
            3 :  begin
                result_ALU1_MEMORY = 32'h15;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ = 0; 
            end
            4 :  begin
                result_ALU1_MEMORY = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h15;
                MEMORY_READ = 0;
                destination_MEMORY  = 5'd15;
            end
            5 :  begin
                result_ALU1_MEMORY  = 32'b0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ = 1;
                destination_MEMORY = 5'd12;
            end
            6 :  begin
                result_ALU1_MEMORY = 32'h15;
                result_ALU2_MEMORY = 32'h1;
                store_input = 32'h0;
                MEMORY_READ= 0;
                destination_MEMORY  = 5'd0;
            end
            7 :  begin
                result_ALU1_MEMORY = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ = 0; 
                destination_MEMORY  = 5'd0;
            end
            8 :  begin
                result_ALU1_MEMORY = 32'h15;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ = 0;
                destination_MEMORY  = 5'd7;
            end
            9 :  begin
                result_ALU1_MEMORY  = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_READ = 0;
                destination_MEMORY  = 5'd1;
            end
            default:  begin
                result_ALU1_MEMORY = 32'b0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'b0;
                MEMORY_READ = 0;
                destination_MEMORY  = 5'd0; 
            end
        endcase
        i = i+1;
    end

    always @(posedge clock2) begin
        case (i)
            0 : begin
                result_ALU1_MEMORY = 32'h15;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_WRITE = 0;
                WRITEBACK_MEMORY = 2'b1;
                destination_MEMORY  = 5'd1;
            end
            1 :  begin
                result_ALU1_MEMORY = 32'h15;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_WRITE= 0;
                WRITEBACK_MEMORY = 2'b1;
                destination_MEMORY = 5'd2;
            end
            2 :  begin
                result_ALU1_MEMORY  = 32'h15;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_WRITE = 0;
                WRITEBACK_MEMORY  = 2'd2;
                destination_MEMORY  = 5'd5;
            end 
            3 :  begin
                result_ALU1_MEMORY  = 32'h8;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_WRITE = 1;
                WRITEBACK_MEMORY  = 2'b1;
                destination_MEMORY  = 5'd5;
            end
            4 :  begin
                result_ALU1_MEMORY = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h8;
                MEMORY_WRITE = 1;
                WRITEBACK_MEMORY  = 2'b0;
                destination_MEMORY  = 5'd15;
            end
            5 :  begin
                result_ALU1_MEMORY = 32'b0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_WRITE = 0;
                WRITEBACK_MEMORY  = 2'b1;
                destination_MEMORY = 5'd12;
            end
            6 :  begin
                result_ALU1_MEMORY = 32'h2;
                result_ALU2_MEMORY = 32'h1;
                store_input = 32'h0;
                MEMORY_WRITE= 0;
                WRITEBACK_MEMORY  = 2'd3;
                destination_MEMORY  = 5'd0;
            end
            7 :  begin
                result_ALU1_MEMORY = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_WRITE= 0;
                WRITEBACK_MEMORY  = 2'b0;
                destination_MEMORY  = 5'd0;
            end
            8 :  begin
                result_ALU1_MEMORY = 32'h1;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0; 
                MEMORY_WRITE = 0;
                WRITEBACK_MEMORY  = 2'b1;
                destination_MEMORY  = 5'd7;
            end
            9 :  begin
                result_ALU1_MEMORY = 32'h0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'h0;
                MEMORY_WRITE = 0;
                WRITEBACK_MEMORY  = 2'b0;
                destination_MEMORY  = 5'd1;
            end
            default:  begin
                result_ALU1_MEMORY = 32'b0;
                result_ALU2_MEMORY = 32'h0;
                store_input = 32'b0;
                MEMORY_WRITE = 0;
                WRITEBACK_MEMORY  = 2'b0;
                destination_MEMORY = 5'd0;
            end
        endcase
        i = i+1;
    end

endmodule