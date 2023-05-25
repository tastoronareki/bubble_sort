/*

	Один проход пузырьковой сортировки.	Самый тяжёлый элемент тонет до 
	заданного уровня.

*/
module pass_swap
	#(
		parameter DIM = 4,   // длина массива
		parameter WIDTH = 8, // размерность элемента
		parameter PASS = 0   // индекс последнего элемента в обрабатываемой части массива
	)
	(
		input  [DIM*WIDTH-1:0] pl, // менее уппорядоченный упакованный массив
		output [DIM*WIDTH-1:0] pm  // более (More) уппорядоченный
	);
	
	// распаковка и упаковка входного и выходного векторов данных для
	// передачи отдельных элементов в модуль pair_swap
	wire [WIDTH-1:0] al [DIM-1:0]; // исходный массив
	wire [WIDTH-1:0] am [DIM-1:0]; // результат сортировки
	genvar i;
	generate
		for (i = 0; i < DIM; i = i + 1) begin : unp
//			assign al[i][WIDTH-1:0] = pl[WIDTH * (i + 1) - 1 : WIDTH * i];
//			assign pm[WIDTH * (i + 1) - 1 : WIDTH * i] = am[i][WIDTH-1:0];
			assign al[i] = pl[WIDTH * (i + 1) - 1 : WIDTH * i];
			assign pm[WIDTH * (i + 1) - 1 : WIDTH * i] = am[i];
		end
		
		for (i = 0; i < PASS - 1; i = i + 1) begin : srt
			pair_swap #(WIDTH) pair (al[i], al[i+1], am[i], am[i+1]);
		end
		
		for (i = PASS - 1; i < DIM; i = i + 1) begin : cpy
			assign am[i] = al[i];
		end
	endgenerate
endmodule
