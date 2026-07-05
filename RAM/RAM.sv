`include "defines.svh"

module RAM(
    input clk,
    input reset,
    input write_enb,
    input read_enb,
    input [`DATA_WIDTH-1:0] data_in,
    input [ADDR_WIDTH-1:0] address,
    output reg [`DATA_WIDTH-1:0] data_out
);

reg [`DATA_WIDTH-1:0] mem [0:`DATA_DEPTH-1];

always @(posedge clk)
begin
    if(reset)
    begin
        data_out <= {`DATA_WIDTH{1'bz}};
        for(integer i=0;i<`DATA_DEPTH;i=i+1)
            mem[i] <= 0;
    end
    else
    begin
        if(write_enb && !read_enb)
        begin
            mem[address] <= data_in;
        end
        else if(read_enb && !write_enb)
        begin
            data_out <= mem[address];
        end
    end
end

endmodule
