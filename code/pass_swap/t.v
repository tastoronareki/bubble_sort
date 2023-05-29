/*

	pass_swap module testbench
	
	С задержкой по времени инициализирует исходный массив для первого
	экземпляра тестируемого модуля набором случайных чисел, для каждого 
	следующего экземпляра - результатом предидущего.

*/
module testbench;

	parameter DIM = 8;   // длина массива
	parameter WIDTH = 8; // размерность элемента

	genvar i, j;
	
	generate
		for (i = 1; i < DIM; i = i + 1) begin : p // Pass
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
			
			if (i == 1) begin
				task check_pass;
					integer k;
					begin
						// первоначальная инициализация массива случайными числами
						for (k = 0; k < DIM; k = k + 1)
							ran[k] = $random % (1 << DIM);
						#30;
						$display("pass %2d:", i);
						for (k = 0; k < DIM; k = k + 1)
							$display("%d: %d - %d", k, ran[k], ord[k]);
					end
				endtask
			end
			else begin
				task check_pass;
					integer k;
					begin
						// инициализация массива предидущими результатами
						for (k = 0; k < DIM; k = k + 1)
							ran[k] = p[i-1].ord[k];
						#30;
						$display("pass %2d:", i);
						for (k = 0; k < DIM; k = k + 1)
							$display("%d: %d - %d", k, ran[k], ord[k]);
					end
				endtask
			end
		end
	endgenerate

	initial begin
		#10;
		/*
			genblk2 пририсовывает Modelsim.
			Это можно увидеть на вкадке sim.
		*/
		p[1].genblk2.check_pass;
		p[2].genblk2.check_pass;
		p[3].genblk2.check_pass;
		p[4].genblk2.check_pass;
		p[5].genblk2.check_pass;
		p[6].genblk2.check_pass;
		p[7].genblk2.check_pass;
		$stop;
	end
endmodule
