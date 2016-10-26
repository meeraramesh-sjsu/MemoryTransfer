`include "verilogHW1.v"
`timescale 10s/1s

module memtomemtranstest;
reg reset_tb,clock_tb;
reg [7:0] dataina_tb;

reg [7:0] memB0;
reg [7:0] memB1;
reg [7:0] memB2;	
reg [7:0] memB3;

memtomemtrans i1 (.reset(reset_tb),.clock(clock_tb),.dataina(dataina_tb));

initial
begin
$dumpfile("memtomemtrans.vcd");
$dumpvars(0,memtomemtranstest);
clock_tb = 0; reset_tb = 0;
#1  dataina_tb = 4;
#2  dataina_tb = 2;
#2  dataina_tb = 8;
#2  dataina_tb = 19;
#2  dataina_tb = 31;
#2  dataina_tb = 29;
#2  dataina_tb = 22;
#2  dataina_tb = 30;
end
always #1 clock_tb = ~clock_tb;
always #34 reset_tb = 1;

always @(posedge clock_tb)
begin
memB0 <= i1.memb[0];
memB1 <= i1.memb[1];
memB2 <= i1.memb[2];
memB3 <= i1.memb[3];
end
endmodule