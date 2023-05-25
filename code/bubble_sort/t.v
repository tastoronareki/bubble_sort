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
		for (i = 0; i < DIM; i = i + 1) begin : pak
			assign prand[(WIDTH + 1) * i - 1 : WIDTH * i] = arand[i];
			assign aord[i] = pord[(WIDTH + 1) * i - 1 : WIDTH * i];
		end
	endgenerate

	// unit under test
	bubble_sort #(DIM, WIDTH) uut (prand, pord);

	integer idx;

	initial begin

		for (idx = 0; idx <= 7; idx = idx + 1) begin
			arand[idx] = $rtoi($random * 255.0);
		end
		
		#10;

		for (idx = 0; idx <= 7; idx = idx + 1) begin
			$display("%idx: %idx - %idx", idx, arand[idx], aord[idx]);
		end
		$stop;
	end
	
endmodule
