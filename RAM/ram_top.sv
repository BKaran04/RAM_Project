`include "ram_package.sv"
`include "interface.sv"
import ram_package::*;
module top();  
logic clk; 
logic reset; 
initial begin
clk=0; 
forever #10 clk=~clk; 
end
initial begin
reset=1; 
@(posedge clk); 
reset=0; 
repeat(1)@(posedge clk); 
reset=1; 
end
ram_if intrf(clk,reset);
RAM DUV(.data_in(intrf.data_in), .write_enb(intrf.write_enb), .read_enb(intrf.read_enb), .data_out(intrf.data_out), .address(intrf.address), .clk(clk), .reset(reset) );
ram_test t1 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
test_write t2 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
test_read t3 = new(intrf.DRV,intrf.MON,intrf.REF_SB);
test_regression reg_tb = new(intrf.DRV,intrf.MON,intrf.REF_SB);
initial
begin
//t1.run(); 
//t2.run();
//t3.run(); 
reg_tb.run();
$finish();
end
endmodule
