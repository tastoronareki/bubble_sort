/*

	Пузырьковая сортировка, основанная только на комбинаторной логике,
	без применения синхронной логики, т.е. регистров.

*/
module bubble_sort
	#(
		parameter DIM = 10,   // длина массива
		parameter WIDTH = 8  // размерность элемента
	)
	(
		input [DIM*WIDTH-1:0] prand, // исходный упакованный неотсортированный массив
		output [DIM*WIDTH-1:0] pord  // упакованный в битовый вектор результат сортировки
	);
	
	wire [DIM*WIDTH-1:0] pa [DIM:1]; // частично уппорядоченные упакованные массивы
	
	assign pa[1] = prand;
	assign pord = pa[DIM];
	
	genvar i;
	generate
		for (i = 1; i < DIM; i = i + 1) begin : p // pass
			pass_swap #(DIM, i, WIDTH) pass (pa[i], pa[i+1]);
		end
	endgenerate
endmodule
