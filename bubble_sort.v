/*

	Сортировка пузырьком только на комбинаторной логике. Без
	синхросигнала и промежуточных состояний.

*/


module testbench();

	parameter DIM = 4;    // длина массива
	parameter WIDTH = 8;  // размерность элемента
	

	reg [WIDTH-1:0] arand [DIM-1:0]; // исходный неотсортированный массив
	wire [WIDTH-1:0] aord [DIM-1:0]; // результат сортировки

	// упаковка и распаковка входного и выходного векторов данных для передачи внутрь модуля uut
	wire [DIM*WIDTH-1:0] prand, pord;
	genvar i;
	generate
		for (i = 0; i < DIM; i = i + 1) begin
			assign prand[(WIDTH + 1) * i - 1 : WIDTH * i] = arand[i];
			assign aord[i] = pord[(WIDTH + 1) * i - 1 : WIDTH * i];
		end
	endgenerate

	// unit under test
	bubble_sort #(DIM, WIDTH) uut (prand, pord);

	integer i;

	initial begin

		for (i = 0; i <= 7; i = i + 1)
			arand[i] = $rtoi($random * 255.0);

		#10;

		for (i = 0; i <= 7; i = i + 1)
			$display("%i: %i - %i", i, d[7:0], q[7:0]);
			
		$stop;
	end
	
endmodule
	

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
	
	pass_swap #(DIM, WIDTH) pass0 (DIM-1, prand, pord); 

	// genvar i;
	// generate
		// for (i = 0; i < DIM; i = i + 1) begin
			// assign prand[(WIDTH + 1) * i - 1 : WIDTH * i] = arand[i];
			// assign aord[i] = pord[(WIDTH + 1) * i - 1 : WIDTH * i];
		// end
	// endgenerate
	// assign

endmodule


/*

	Один проход пузырьковой сортировки.	Самый тяжёлый элемент тонет до 
	заданного уровня.

*/
module pass_swap
	#(
		parameter DIM = 4,   // длина массива
		parameter WIDTH = 8  // размерность элемента
	)
	(
		input integer level, // индекс последнего элемента в обрабатываемой части массива
		input  [DIM*WIDTH-1:0] prand, // исходный упакованный неотсортированный массив
		output [DIM*WIDTH-1:0] pord   // упакованный в битовый вектор результат сортировки
	);
	
	// распаковка и упаковка входного и выходного векторов данных для
	// передачи отдельных элементов в модуль pair_swap
	wire [WIDTH-1:0] arand [DIM-1:0]; // исходный неотсортированный массив
	wire [WIDTH-1:0] aord  [DIM-1:0]; // результат сортировки
	genvar i;
	generate
		for (i = 0; i <= level; i = i + 1) begin
			assign arand[i] = prand[(WIDTH + 1) * i - 1 : WIDTH * i];
			assign pord[(WIDTH + 1) * i - 1 : WIDTH * i] = aord[i];
		end
	endgenerate



	// wire 
	// genvar i,j;
	// generate
		// for (i = 0; i < level; i = i + 1) begin
			
			// for (j = 0; j < i; j = j + 1)
			// pair_swap #(WIDTH) pair();
			// assign prand[(WIDTH + 1) * i - 1 : WIDTH * i] = arand[i];
			// assign aord[i] = pord[(WIDTH + 1) * i - 1 : WIDTH * i];
		// end
	// endgenerate
endmodule


/*

	Уппорядочивает два значения

*/
module pair_swap
	#(
		parameter WIDTH = 8  // размерность элемента
	)
	(
		// не уппорядоченная пара значений
		input rand1[WIDTH-1:0],
		input rand2[WIDTH-1:0],
		
		// уппорядоченная пара значений
		output ord1[WIDTH-1:0],
		output ord2[WIDTH-1:0]
	);

	assign
		ord1 = rand1 > rand2 ? rand2 : rand1,
		ord2 = rand1 > rand2 ? rand1 : rand2;

endmodule
