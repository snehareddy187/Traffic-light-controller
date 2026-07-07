module traffic(hwy, cntry, x, clk, rst);
output reg [1:0] hwy, cntry;
input x, clk, rst;
reg [2:0] state, next_state;
reg [3:0] counter;
parameter red=2'd0,green=2'd1,yellow=2'd2;
parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
always@(posedge clk or posedge rst)
 begin
 if (rst)
 state <= s0;
 else
state <= next_state;
end
always@(state)
 begin
 hwy = green;
 cntry = red;
 case(state)
 s0: begin
 hwy = green;
 cntry = red;
 end
 s1: begin
 hwy = yellow;
 cntry = red;
 end
 s2: begin
 hwy = red;
 cntry = red;
 end
 s3: begin
 if (x)
 next_state = s3;
 else
 next_state = s4;
 end
 s4: begin
 if (counter == 2)
 next_state = s0;
 else
 next_state = s4;
 end
 default: next_state = s0;
 endcase
 end
always @(posedge clk or posedge rst)
begin
 if (rst)
 counter <= 0;
 else if (state == s1 || state == s2 || state ==s4)
 counter <= counter + 1;
 else
 counter <= 0;
 end
endmodule
