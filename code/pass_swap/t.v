/*

	pass_swap module testbench
	
	С задержкой по времени инициализирует исходный массив сначала
	набором случайных чисел, потом результатом одного из экземпляров
	тестируемого модуля.

*/
module testbench;

	parameter DIM = 8;   // длина массива
	parameter WIDTH = 8; // размерность элемента

	genvar i, j;
	
//	generate
//		// упаковка входного массива
//		for (j = 0; j < DIM; j = j + 1) begin : pk // Pack
//			assign pak_less[WIDTH * (j + 1) - 1 : WIDTH * j] = ran[j];
//		end
//	endgenerate

	
	generate
		for (i = 0; i < DIM; i = i + 1) begin : p // Pass
			reg  [WIDTH-1:0] ran [DIM-1:0]; // входной массив (Random)
			wire [WIDTH-1:0] ord [DIM-1:0]; // выходной массив (Ordered)
			wire [DIM * WIDTH - 1 : 0] pak_less; // Packed, Less ordered
			wire [DIM * WIDTH - 1 : 0] pak_more; // Packed, More ordered

			// упаковка/распаковка входного/выходного массива
			for (j = 0; j < DIM; j = j + 1) begin : upk // Unpack
			assign pak_less[WIDTH * (j + 1) - 1 : WIDTH * j] = ran[j];
				assign ord[j] = pak_more[WIDTH * (j + 1) - 1 : WIDTH * j];
			end

			pass_swap #(DIM, i, WIDTH) pass (pak_less, pak_more);
			
			if (i == 0) begin
				task check_pass;
					integer k;
					begin
						// первоначальная инициализация массива случайными числами
						for (k = 0; k < DIM; k = k + 1)
							ran[k] = $random % (1 << DIM);
						#30;
						$display("pass %d:", i)
					end
				endtask
			end
			else begin
				task check_pass;
					integer k;
					begin
						// инициализация массива предидущими результатами
						for (k = 0; k < DIM; k = k + 1)
							ran[k] = ord[k];
					end
				endtask

		// упаковка входного массива
		for (j = 0; j < DIM; j = j + 1) begin : pk // Pack
		end
	endgenerate

	integer k, l;
	initial begin
		#10;
		
		p[0].check_pass;
		p[1].check_pass;
		p[2].check_pass;
		p[3].check_pass;
		p[4].check_pass;
		p[5].check_pass;
		p[6].check_pass;
		p[7].check_pass;


		// вывод результатов и подготовка входных данных соответствующих следующей интерации
		k = 1;
		forever begin : prn
			#30;
			$display("iteration: %d", k);
			for (l = 0; l < DIM; l = l + 1)
				$display("%d: %d - %d", l, ran[l], p[k].ord[l]);
			if (k >= DIM)
				disable prn;
			for (l = 0; l < DIM; l = l + 1)
				ran[l] = p[k].ord[l];
			k = k + 1;
		end

		$stop;
	end
endmodule
