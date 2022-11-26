module apb_interface(penable, pwrite, pwdata, paddr,psel,penable_out,
pwrite_out,pwdata_out,paddr_out,psel_out,pr_data);
input penable, pwrite;
input [31:0]pwdata, paddr;
input [2:0]psel;
output penable_out, pwrite_out;
output [31:0]pwdata_out,paddr_out;
output [2:0]psel_out;
output reg [31:0]pr_data;

assign penable_out=penable;
assign pwrite_out=pwrite;
assign pwdata_out=pwdata;
assign paddr_out=paddr;
assign psel_out=psel;
always@(*)
begin
if(penable==1 && pwrite==0)
pr_data={$random}%256;
else
pr_data=0;
end
endmodule