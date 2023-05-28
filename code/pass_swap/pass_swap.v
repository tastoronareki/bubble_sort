/*

	Один проход пузырьковой сортировки.	Самый тяжёлый элемент тонет до 
	заданного уровня.
	
	На входе менее уппорядоченный массив; на выходе - более уппорядоченный.
	Less ordered --> More ordered
	
	Порядковый номер прохода определяет до какого индекса "тонет" самый
	"тяжёлый" элемент "верхней" (с младшими индексами) части массива.

*/
module pass_swap
	#(
		parameter DIM = 8,  // длина массива
		parameter PASS = 1, // 1..(DIM-1) порядковый номер "прохода" по массиву
		parameter WIDTH = 8 // размерность элемента
	)
	(
		input  [DIM*WIDTH-1:0] pl, // менее (Less) уппорядоченный упакованный массив
		output [DIM*WIDTH-1:0] pm  // более (More) уппорядоченный
	);
	
	wire [WIDTH-1:0] al [DIM-1:0]; // исходный массив
	wire [WIDTH-1:0] am [DIM-1:0]; // результат сортировки

	wire [WIDTH-1:0] ai [DIM-1:0]; // промежуточный (Intermediate) массив
	genvar i;
	generate

		// распаковка и упаковка входного и выходного массивов
		for (i = 0; i < DIM; i = i + 1) begin : unp // Unpack
			assign al[i] = pl[WIDTH * (i + 1) - 1 : WIDTH * i];
			assign pm[WIDTH * (i + 1) - 1 : WIDTH * i] = am[i];
		end

		// сортирка
		assign ai[0] = al[0];
		for (i = 0; i < DIM - PASS; i = i + 1) begin : srt // Compare
			pair_swap #(WIDTH) pair (ai[i], al[i+1], am[i], ai[i+1]);		
		end
		assign am[DIM - PASS] = ai[DIM - PASS];

		// "перенос" нижней, отсортироанной части
		for (i = DIM - PASS + 1; i < DIM; i = i + 1) begin : crr // Carry
			assign am[i] = al[i];
		end
	endgenerate
endmodule
