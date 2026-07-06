class ram_reference_model;
ram_transaction ref_trans;
mailbox #(ram_transaction)mbx_rs;
mailbox #(ram_transaction)mbx_dr;
virtual ram_if.REF_SB vif;
reg [`DATA_WIDTH-1:0]MEM[`DATA_DEPTH-1:0];
function new(mailbox #(ram_transaction)mbx_dr, mailbox #(ram_transaction)mbx_rs,virtual ram_if.REF_SB vif);
this.mbx_dr=mbx_dr;
this.mbx_rs=mbx_rs;
this.vif=vif;
endfunction
task start();
for(int i=0;i<`num_transactions;i=i+1)
begin
ref_trans=new();
mbx_dr.get(ref_trans);
repeat(1) @(vif.ref_cb)
begin
if(ref_trans.write_enb)
MEM[ref_trans.address]=ref_trans.data_in;
$display("Reference Model Data in memory MEM[%0h]=%0h,T=%0t",ref_trans.address,MEM[ref_trans.address],$time);
if(ref_trans.read_enb)
ref_trans.data_out = MEM[ref_trans.address];
$display("Reference Model Data out from memory data_out=%0h,T=%0t",ref_trans.data_out,$time);
end
mbx_rs.put(ref_trans);
end
endtask
endclass
