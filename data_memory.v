module data_memory(clock1, clock2, address, data_input, data_output, MEMORY_READ, MEMORY_WRITE);
    input clock1, clock2, MEMORY_READ, MEMORY_WRITE;
    input [31:0] address, data_input;

    output reg [31:0] data_output;

    wire [31:0] address_line;
    reg [7:0] data_mem [0:1024];

    always @(posedge clock1) begin
      if (MEMORY_READ) begin
        data_output = (address < 1024) ? 0 : {data_mem[address_line], data_mem[address_line + 1], data_mem[address_line +2], data_mem[address_line + 3]};
      end
      else if (MEMORY_WRITE)
      begin
        {data_mem[address_line], data_mem[address_line + 1], data_mem[address_line +2], data_mem[address_line + 3]} <= data_input;
      end
    end
endmodule
