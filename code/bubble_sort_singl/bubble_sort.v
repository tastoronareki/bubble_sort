/*

	За один такт выполняется пузырьковая сортировка

*/
module bubble_sort_singl
	#(
		parameter DIM = 10,   // длина массива
		parameter WIDTH = 8  // размерность элемента
	)
	(
		input clk,
		input [DIM*WIDTH-1:0] prand, // исходный упакованный неотсортированный массив
		output reg [DIM*WIDTH-1:0] pord  // упакованный в битовый вектор результат сортировки
	);
	
	wire [DIM*WIDTH-1:0] pa [DIM:1]; // частично уппорядоченные упакованные массивы
	
	assign pa[1] = prand;

	always (posedge clk)
		pord <= pa[DIM];
	
	genvar i;
	generate
		for (i = 1; i < DIM; i = i + 1) begin : p // pass
			pass_swap #(DIM, i, WIDTH) pass (pa[i], pa[i+1]);
		end
	endgenerate
endmodule
