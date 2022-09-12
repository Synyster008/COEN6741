module instruction_memory (clock, address, instruction);
    input clock;
    input [31:0] address;
    output [31:0] instruction;

    wire [9:0] address_bus = address [9:0];
    reg [7:0] instruction_mem [0:1024];


    always @(posedge clock) begin
        instruction_mem[0] <= 8'b10000000; //-- Addi	r1,r0,10
        instruction_mem[1] <= 8'b00100000;
        instruction_mem[2] <= 8'b00000000;
        instruction_mem[3] <= 8'b00001010;
 
    end

    assign instruction = {instruction_mem[address_bus], instruction_mem[address_bus+ 1], instruction_mem[address_bus+ 2],instruction_mem[address_bus+ 3]};
endmodule
