module AHB_slave(hclk,hreset,hready_in,hwrite,htrans,haddr,hwdata,pr_data,haddr_1,haddr_2,hwdata_1,hwdata_2,valid,hwrite_1,hwrite_2,hr_data,temp_sel);
input hclk,hreset, hready_in, hwrite;
input [1:0]htrans;
input [31:0]haddr,hwdata,pr_data;
output reg[31:0]haddr_1,haddr_2,hwdata_1,hwdata_2; output reg valid,hwrite_1,hwrite_2;
output [31:0]hr_data; output reg[2:0]temp_sel;
//pipelining for haddr, hwdata, hwrite//
always @(posedge hclk) begin
if (hreset==1) begin
hwdata_2<=0;
haddr_1<=0; //code for haddr// haddr_2<=0;
hwdata_1<=0; //code for hwdata//
hwrite_1<=0; //code for hwrite//
hwrite_2<=0; end
else if (hreset==0) begin
haddr_1<=haddr;
haddr_2<=haddr_1; hwdata_1<=hwdata;
 hwdata_2<=hwdata_1;
hwrite_1<=hwrite;
hwrite_2<=hwrite_1; end
end
//valid signals using hready in, address range and htrans//
always @(*) begin
valid=1'b0;
if (hready_in==1 && haddr>=32'h8000_0000 && haddr<=32'h8c00_0000 && htrans==2'b10 || htrans==2'b11)
valid=1'b1; else
valid=1'b0;
end
// generate temp_sel//
always @(*)
begin
temp_sel=3'b000;
if (haddr>=32'h8000_0000 && haddr<32'h8400_0000) temp_sel=3'b001;
else if (haddr>=32'h8400_0000 && haddr<32'h8800_0000) temp_sel=3'b010;
else if (haddr>=32'h8800_0000 && haddr<=32'h8c00_0000) temp_sel=3'b011;
end
assign hr_data=pr_data;

endmodule
