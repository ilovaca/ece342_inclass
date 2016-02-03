module bit_counter_datapath(A, clk, ldA, resetA, shiftA, incr_counter, reset_counter, A_0, A_is_zero);
	input clk, ldA, resetA, shiftA, incr_counter, reset_counter;
	input [7 : 0] A;
	output A_0, A_is_zero;
	reg [7 : 0] a;
	reg [2 : 0] counter;

	/* bit counter */
	always @ (posedge clk) begin
		if (reset_counter) counter <= 3'b000;
		else if (incr_counter) counter <= counter + 1;	
		else counter <= counter;
	end


	always @ (posedge clk) begin
		if (resetA)  a <= 8'b00000000;
		else if (ldA) a <= A;
		else if (shiftA) begin
			// shift
			A[0] <= 0;
			A[1] <= A[0];
			A[2] <= A[1];
			A[3] <= A[2];
			A[4] <= A[3];
			A[5] <= A[4];
			A[6] <= A[5];
			A[7] <= A[6];
		end
		else begin
			A <= A;
		end
	end
endmodule