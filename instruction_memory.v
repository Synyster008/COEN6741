module instruction_memory (clock, address, instruction);
    input clock;
    input [31:0] address;
    output [31:0] instruction;

    wire [9:0] address_bus = address [9:0];
    reg [7:0] instruction_mem [0:1023];


    always @(posedge clock) begin

        instruction_mem[0] <= 8'b00001000; // addi r1, r0, 15
        instruction_mem[1] <= 8'b00100000; // 32'h0820000f
        instruction_mem[2] <= 8'b00000000;
        instruction_mem[3] <= 8'b00001111;

        instruction_mem[4] <= 8'b00000100; // addu r2, r4, r1
        instruction_mem[5] <= 8'b01000100; // 32'h04440800
        instruction_mem[6] <= 8'b00001000;
        instruction_mem[7] <= 8'b00000000;

        instruction_mem[8] <= 8'b00101000; // ll r5, r1
        instruction_mem[9] <= 8'b10100001; // 32'h 28a10004
        instruction_mem[10] <= 8'b00000000;
        instruction_mem[11] <= 8'b00000100;

        instruction_mem[12] <= 8'b00001100; // subiu r5, r1, #7
        instruction_mem[13] <= 8'b10100001; //32'h0ca10007
        instruction_mem[14] <= 8'b00000000;
        instruction_mem[15] <= 8'b00000111;

        instruction_mem[16] <= 8'b00101100; // sc r5, r2
        instruction_mem[17] <= 8'b10100010; // 32'h2ca20000
        instruction_mem[18] <= 8'b00000000;
        instruction_mem[19] <= 8'b00000000;

        instruction_mem[20] <= 8'b00010100; // lui r6, #12
        instruction_mem[21] <= 8'b11000000; // 32'h14c0040c
        instruction_mem[22] <= 8'b00000100;
        instruction_mem[23] <= 8'b00001100;

        instruction_mem[24] <= 8'b00011000; // div r5, r1 
        instruction_mem[25] <= 8'b10100001; // 32'h18a10000
        instruction_mem[26] <= 8'b00000000;
        instruction_mem[27] <= 8'b00000000;

        instruction_mem[28] <= 8'b00100100; // beq r5, r1, 0
        instruction_mem[29] <= 8'b10100001; // 32'h24a10000
        instruction_mem[30] <= 8'b00000000;
        instruction_mem[31] <= 8'b00000000;

        instruction_mem[32] <= 8'b00010000; // slti r7, r2, #65
        instruction_mem[33] <= 8'b11100010; // 32'h10e20041
        instruction_mem[34] <= 8'b00000000;
        instruction_mem[35] <= 8'b01000001;

        
        instruction_mem[36] <= 8'b00100000; // jr r1
        instruction_mem[37] <= 8'b00100000; // 32'h20200000
        instruction_mem[38] <= 8'b00000000;
        instruction_mem[39] <= 8'b00000000;

    end

    assign instruction = {instruction_mem[address_bus], instruction_mem[address_bus+ 1], instruction_mem[address_bus+ 2],instruction_mem[address_bus+ 3]};
endmodule
