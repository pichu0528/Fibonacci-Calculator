module fibonacci_calculator(
	clk,
	reset_n,
	input_s,
	begin_fibo,
	done,
	fibo_out
);

input[4:0] input_s;
input reset_n;
input begin_fibo;  //Start calculation
input clk;
output done;
output[15:0] fibo_out;

reg[15:0] pre, cur;
reg[4:0] count;
wire[15:0] fibo_out;

initial
begin
pre = 16'd0;
cur = 16'd1;
count = 5'd1;
end

assign finalClk = clk ^ begin_fibo;
assign start = (begin_fibo|start) & reset_n;
always@(posedge finalClk)
	begin
		if(start & ~done)
		begin			
			cur <= cur + pre;
			pre <= cur;
			count <= count + 5'd1;			
		end
		else if(~start)
		begin
			cur <= 16'd1;
			pre <= 16'd0;
			count <= 5'd2;
		end
	end

assign done = (input_s == count);
assign fibo_out = cur + pre;

endmodule
