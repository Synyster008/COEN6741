module forward_tb ();

    reg [4:0] source1_EXECUTE, source2_EXECUTE, store_EXECUTE, destination_MEMORY, destination_WRITEBACK; 
    reg writeback_MEMORY, writeback_WRITEBACK;

    wire forward;
    wire [1:0] source1_select, source2_select, store_select;


    forwarding_unit forward_test (source1_EXECUTE, source2_EXECUTE, store_EXECUTE, destination_MEMORY, destination_WRITEBACK, writeback_MEMORY, writeback_WRITEBACK, source1_select, source2_select,
    store_select, forward);

    initial begin
        assign source1_EXECUTE = 5'b10000;
        assign source2_EXECUTE = 5'b10010;
        assign store_EXECUTE = 5'b10100;
        assign destination_MEMORY = 5'b10001;
        assign destination_WRITEBACK = 5'b10100;
        assign writeback_MEMORY = 1;
        assign writeback_WRITEBACK = 1;
    end

endmodule