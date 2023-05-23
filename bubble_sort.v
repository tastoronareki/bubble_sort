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
	


module bubble_sort
	#(
		parameter DIM = 4,   // длина массива
		parameter WIDTH = 8  // размерность элемента
	)
	(
		input [DIM*WIDTH-1:0] prand, // исходный упакованный неотсортированный массив
		output [DIM*WIDTH-1:0] pord  // упакованный в битовый вектор результат сортировки
	);

	wire [WIDTH-1:0] arand [DIM-1:0]; // исходный неотсортированный массив
	wire [WIDTH-1:0] aord [DIM-1:0];  // результат сортировки
	

	generate

endmodule

module pass_swap
	#(
		parameter DIM = 4,
		parameter WIDTH = 8
	)
	(
		input [N-1:0] a [DIM-1:0],
		output [N-1:0] a [DIM-1:0]
	);

    pair_swap #(.N(N)) [N-1:0] swap();
	assign
		q1 = d1 > d2 ? d2 : d1,
		q2 = d1 > d2 ? d1 : d2;

endmodule

module pair_swap
	#(
		parameter N = 8
	)
	(
		d1[N-1:0],
		d2[N-1:0],
		q1[N-1:0],
		q2[N-1:0]
	);

	assign
		q1 = d1 > d2 ? d2 : d1,
		q2 = d1 > d2 ? d1 : d2;

endmodule
