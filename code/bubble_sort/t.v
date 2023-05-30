/*

	Сортировка пузырьком только на комбинаторной логике. Без
	синхросигнала и промежуточных состояний.

*/
module testbench();

	parameter DIM = 10;    // длина массива
	parameter WIDTH = 8;  // размерность элемента
	
	reg [WIDTH-1:0] arand [DIM-1:0]; // исходный неотсортированный массив
	wire [WIDTH-1:0] aord [DIM-1:0]; // результат сортировки

	// упаковка и распаковка входного и выходного векторов данных для передачи внутрь модуля uut
	wire [DIM*WIDTH-1:0] prand, pord;
	
	genvar i;
	generate
		for (i = 0; i < DIM; i = i + 1) begin : pak
			assign prand[WIDTH * (i + 1) - 1 : WIDTH * i] = arand[i];
			assign aord[i] = pord[WIDTH * (i + 1) - 1 : WIDTH * i];
		end
	endgenerate

	// unit under test
	bubble_sort #(DIM, WIDTH) uut (prand, pord);

	integer k;

	initial begin

		for (k = 0; k < DIM; k = k + 1)
			arand[k] = $random % (1 << DIM);
		
		#30;

		for (k = 0; k < DIM; k = k + 1)
			$display("%d: %d - %d", k, arand[k], aord[k]);

		$stop;
	end
	
endmodule
