module data_memory(clock1, clock2, address, data_input, data_output);
    input clock1, clock2;
    input [31:0] address, data_input;
    output reg [31:0] data_output;

    integer i;

    wire [31:0] address_line;
    reg [7:0] data_mem [0:1024];

    always @(posedge clock1) begin
      data_output = (address < 1024) ? 0 : {data_mem[address_line], data_mem[address_line + 1], data_mem[address_line +2], data_mem[address_line + 3]};
    end

    always @(posedge clock2) begin
        {data_mem[address_line], data_mem[address_line + 1], data_mem[address_line +2], data_mem[address_line + 3]} <= data_input;
    end
endmodule
