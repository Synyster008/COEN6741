module data_memory(clock1, clock2, address, data_input, data_output, MEMORY_READ, MEMORY_WRITE, WRITEBACK_MEMORY);
    input clock1, clock2, MEMORY_READ, MEMORY_WRITE;
    input [1:0] WRITEBACK_MEMORY;
    input [31:0] address, data_input;

    output reg [31:0] data_output;

    wire [31:0] address_line;
    reg [31:0] link;
    reg [7:0] data_mem [0:1023];

    integer i;

    initial begin
      for (i=0; i <= 1023; i=i+1)
        data_mem[i] <= 0;
    end

    always @(posedge clock1) begin
      if (MEMORY_READ) begin
        data_output = {data_mem[address_line], data_mem[address_line + 1], data_mem[address_line +2], data_mem[address_line + 3]};
        if (MEMORY_READ && WRITEBACK_MEMORY == 2'b10)
          link = {address_line, address_line + 1, address_line + 2, address_line + 3};
      end
    end
    always @(posedge clock2) begin
      if (MEMORY_WRITE && link == {address_line, address_line + 1, address_line + 2, address_line + 3})
      begin
        {data_mem[address_line], data_mem[address_line + 1], data_mem[address_line +2], data_mem[address_line + 3]} <= data_input;
      end
    end
endmodule
