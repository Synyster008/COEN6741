module forwarding_unit (source1_EXECUTE, source2_EXECUTE, store_EXECUTE, destination_MEMORY, destination_WRITEBACK, writeback_MEMORY, writeback_WRITEBACK, source1_select, source2_select, store_select, forward);
  input [4:0] source1_EXECUTE, source2_EXECUTE, store_EXECUTE;
  input [4:0] destination_MEMORY, destination_WRITEBACK;
  input writeback_MEMORY, writeback_WRITEBACK;

  output reg forward;
  output reg [1:0] source1_select, source2_select, store_select;

  always @ ( * ) begin
    {source1_select, source2_select, store_select} <= 0;

    if (writeback_MEMORY && store_EXECUTE == destination_MEMORY) store_select <= 2'd1;
    else if (writeback_WRITEBACK && store_EXECUTE == destination_WRITEBACK) store_select <= 2'd2;

    if (writeback_MEMORY && source1_EXECUTE == destination_MEMORY) source1_select <= 2'd1;
    else if (writeback_WRITEBACK && source1_EXECUTE == destination_WRITEBACK) source1_select <= 2'd2;

    if (writeback_MEMORY && source2_EXECUTE == destination_MEMORY) source2_select <= 2'd1;
    else if (writeback_WRITEBACK && source2_EXECUTE == destination_WRITEBACK) source2_select <= 2'd2;

    assign forward = (store_select || source1_select || source2_select) ? 1: 0;

  end
endmodule 