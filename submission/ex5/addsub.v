`include "../ex4/add4.v"

module	addsub( result, operand_a, operand_b, mode );

	input	[3:0]	operand_a, operand_b;
	input	mode;
	output	[3:0]	result;
	wire co;
	wire	[3:0]	xor_b;

	xor	as0(xor_b[0], mode, operand_b[0]);
	xor	as1(xor_b[1], mode, operand_b[1]);
	xor	as2(xor_b[2], mode, operand_b[2]);
	xor	as3(xor_b[3], mode, operand_b[3]);
	
	add4	m1(
		.sum(result),
		.co(co),
		.a(operand_a),	 
		.b(xor_b),	
		.ci(mode)
	);	
endmodule
