module forwarding_unit (source1_EXECUTE, source2_EXECUTE, store_EXECUTE, destination_MEMORY, destination_WRITEBACK, writeback_MEMORY, writeback_WRITEBACK, source1_select, source2_select, store_select);
  input [4:0] source1_EXECUTE, source2_EXECUTE, store_EXECUTE;
  input [4:0] destination_MEMORY, destination_WRITEBACK;
  input writeback_MEMORY, writeback_WRITEBACK;
  output reg [1:0] source1_select, source2_select, store_select;

  always @ ( * ) begin
    // initializing sel signals to 0
    // they will change to enable forwrding if needed.
    {source1_select, source2_select, store_select} <= 0;

    // determining forwarding control signal for store value (ST_val)
    if (writeback_MEMORY && store_EXECUTE == destination_MEMORY) store_select <= 2'd1;
    else if (writeback_WRITEBACK && store_EXECUTE == destination_WRITEBACK) store_select <= 2'd2;

    // determining forwarding control signal for ALU val1
    if (writeback_MEMORY && source1_EXECUTE == destination_MEMORY) source1_select <= 2'd1;
    else if (writeback_WRITEBACK && source1_EXECUTE == destination_WRITEBACK) source1_select <= 2'd2;

    // determining forwarding control signal for ALU val2
    if (writeback_MEMORY && source2_EXECUTE == destination_MEMORY) source2_select <= 2'd1;
    else if (writeback_WRITEBACK && source2_EXECUTE == destination_WRITEBACK) source2_select <= 2'd2;
  end
endmodule 