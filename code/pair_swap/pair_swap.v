/*

	Уппорядочивает два значения

*/
module pair_swap
	#(
		parameter WIDTH = 8  // размерность элемента
	)
	(
		// не уппорядоченная пара значений
		input [WIDTH-1:0] rand1,
		input [WIDTH-1:0] rand2,
		
		// уппорядоченная пара значений
		output [WIDTH-1:0] ord1,
		output [WIDTH-1:0] ord2
	);

	assign
		ord1 = rand1 > rand2 ? rand2 : rand1,
		ord2 = rand1 > rand2 ? rand1 : rand2;

endmodule
