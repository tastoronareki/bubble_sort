/*

	Уппорядочивает два значения

*/
module testbench;

	parameter DIM = 8;   // длина массива
	parameter WIDTH = 8; // размерность элемента

	reg  [WIDTH-1:0] rn  [DIM-1:0]; // Random
	wire [WIDTH-1:0] ord [DIM-1:0]; // Ordered
	wire [WIDTH-1:0] im  [DIM-1:0]; // Intermediate

	genvar i;
	generate
		assign im[0] = rn[0];
		for (i = 0; i < DIM - 1; i = i + 1) begin : cm // Compare
			pair_swap #(WIDTH) pair (im[i], rn[i+1], ord[i], im[i+1]);		
		end
		assign ord[DIM-1] = im[DIM-1];
	endgenerate

	integer idx;
	initial begin
		#10;
		for (idx = 0; idx < DIM; idx = idx + 1)
			rn[idx] = $random % (1 << DIM);
		#10;
		for (idx = 0; idx < DIM; idx = idx + 1)
			$display("%d: %d - %d", idx, rn[idx], ord[idx]);
		$stop;
	end

endmodule
