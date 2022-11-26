module top_tb();
reg hclk,hreset;
wire [31:0]hr_data;
wire [1:0]hresp;
wire hwrite,hready_in;
wire [1:0]htrans;
wire [31:0]haddr,hwdata;
wire [31:0]pr_data;
wire penable,pwrite,hr_readyout;
wire [2:0]psel;
wire [31:0]paddr, pwdata;
wire penable_out,pwrite_out;
wire [31:0]pwdata_out, paddr_out;
wire [2:0]psel_out;
//the bridge top , apb interface ,ahb master instantiation//
ahb_master_inst(hwrite,hr_data,hresp,hwrite,hclk,hreset,hready_in,htrans,haddr,hwdata);
top_inst(hclk,hreset,hready_in,hwrite,htrans,haddr,hwdata,pr_data,
penable,pwrite,hr_readyout,psel,paddr,pwdata,hr_data);
apb_interface_inst(penable, pwrite, pwdata, paddr,psel,penable_out,
pwrite_out,pwdata_out,paddr_out,psel_out,pr_data);

initial
begin
hclk=1'b0;
forever #10 hclk=~hclk;
end

task reset;
begin
@(negedge hclk);
hreset=1'b1;
@(negedge hclk);
hreset=1'b0;
end
endtask
initial
begin
reset;

ahb_master_inst.single_read();
#500 $finish;
end
endmodule
