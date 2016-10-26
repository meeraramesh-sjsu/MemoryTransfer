module memtomemtrans(clock,reset,dataina);

/*Input Ports*/
input reset,clock;
input [7:0] dataina;

/*Unidirectional, SRAM like memory declaration*/
reg [7:0] mema [7:0];
reg [7:0] memb [4:0];

reg [4:0] temp;
reg wea,incb,web;
reg rstinput,inca;
reg [2:0] addra;
reg [1:0] addrb;
reg [7:0] dout1;
reg [7:0] dout2;
reg [7:0] result;
reg [7:0] addout;
reg [7:0] subout;
reg [7:0] datainb;

initial 
begin 
addra =-1;
addrb = 0;
temp = 0;
wea = 0;
web = 0;
inca = 0;
incb = 0;
datainb = 0;
end

always @(posedge clock)
begin
 if(rstinput==1) 
 begin
 temp = 5'b0000;
 end 
 else 
 begin   
temp = temp + 1; /*Increment the 5-bit counter for the controller*/
/*Reduced expressions for counter-decoder scheme*/ 
wea = (~temp[4]&~temp[3]&temp[2]) | (~temp[4]&~temp[3]&temp[1]) | (~temp[4]&~temp[3]&~temp[2]&temp[0]) | (temp[3]&~temp[1]&~temp[0]&~temp[4]&~temp[2]);
incb = (~temp[4]&temp[3]&temp[2]&temp[0]) | (~temp[4]&temp[3]&temp[1]&temp[0]);
inca = 1;
/*web = (~temp[4]&temp[3]&~temp[2]&temp[1]&~temp[0]) | (~temp[4]&temp[3]&temp[2]&~temp[1]&~temp[0]) | (~temp[4]&temp[3]&temp[2]&temp[1]&~temp[0]) 
| (temp[4]&~temp[3]&~temp[2]&~temp[1]&~temp[0]);*/
web = (~temp[4] & temp[3] & temp[2] & ~temp[0]) | (~temp[4] & temp[3] & temp[1] & ~temp[0]) | (temp[4] & ~temp[3] & ~temp[2] & ~temp[1] & ~temp[0]);
rstinput = (temp[4]&~temp[3]&~temp[2]&temp[1]&~temp[0]) | reset; /*Reset after 18 clock cycles*/
end

/*Counters to determine the addresses for Memory A and B*/
if(reset)
begin
addra <= 0;
addrb <= 0;
end
else
begin
if(inca)
addra <= addra + 1;
if(incb)
addrb <= addrb + 1;
end

/*If write enable is set, write to memory; otherwise read from memory*/
if(wea) 
mema[addra] <= dataina;

if(wea==0) 
begin
dout1 <= mema[addra];
dout2 <= dout1;
end
end

/*Calculate add & sub result*/
always @(dout2 or dout1)
begin
addout <= dout2 + dout1;
subout <= dout2 - dout1;
result <= dout1 - dout2;
end

/*Depending on M.S.B, write the result to Memory B*/
always @(result[7] or addout or subout)
begin 
if(web)
begin
if(result[7]) datainb = addout;
else 		  datainb = subout;	
memb[addrb] <= datainb;
end	
end
endmodule