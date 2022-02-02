sim:
	iverilog -o wave -y ./ core_tb.v
	vvp -n wave -lxt2
	# open core_tb.vcd
