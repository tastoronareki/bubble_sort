/*

	Пузырьковая сортировка, основанная только на комбинаторной логике,
	без применения синхронной логики, т.е. регистров.

*/
module bubble_sort
	#(
		parameter DIM = 4,   // длина массива
		parameter WIDTH = 8  // размерность элемента
	)
	(
		input [DIM*WIDTH-1:0] prand, // исходный упакованный неотсортированный массив
		output [DIM*WIDTH-1:0] pord  // упакованный в битовый вектор результат сортировки
	);
	
	wire [DIM*WIDTH-1:0] pa [DIM-2:0]; // частично упакованные упакованные массивы
	
	assign pa[0] = prand;
	assign pord = pa[DIM-2];
	
	genvar i;
	generate
		for (i = 0; i < DIM - 2; i = i + 1) begin : iter
//			parameter PATH = DIM-i;
			pass_swap #(DIM, WIDTH, DIM-i) pass (pa[i], pa[i+1]); 
		end
	endgenerate
endmodule
