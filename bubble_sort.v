/*

	Сортировка пузырьком только на комбинаторной логике. Без
	синхросигнала и промежуточных состояний.

*/

module testbench();

	reg [7:0] d [7:0];
	reg [7:0] q [7:0];

	integer i;

	initial begin

		for (i = 0; i <= 7; i = i + 1) begin
			d[7:0][i] = $rtoi($random * 255.0);
			q[7:0][i] = 0;
		end

		bubble_sort #(8, 8) uut (d, q);

		for (i = 0; i <= 7; i = i + 1)
			$display("%i: %i - %i", i, d[7:0], q[7:0]);
	end
endmodule

module bubble_sort
	#(
		parameter DIM = 8,
		parameter N = 8
	)
	(
		input [N-1:0] a [DIM-1:0],
		output [N-1:0] a [DIM-1:0]
	);

	

	generate

endmodule

module pass_swap
	#(
		parameter DIM = 8,
		parameter N = 8
	)
	(
		input [N-1:0] a [DIM-1:0],
		output [N-1:0] a [DIM-1:0]
	);


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
