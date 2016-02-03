module bit_counter_control (clk, start, resetn, A_0, A_is_zero, ldA, resetA, shiftA, incr_counter, reset_counter );
	input clk, start, resetn, A_0;
	output ldA, resetA, shiftA, incr_counter, reset_counter;

	/* state encoding */
	parameter S0 = 2'b00, S1 = 2'b01, SD = 2'b10;
	/* state registers */
	reg [1 : 0] ps, ns;

	always @ (*) 
	begin
		case (ps)
		S0:	if (!start) ns = S0; else ns = S1;
		S1:	if (A_is_zero) ns = SD; else ns = S1;
		SD:	ns = SD;
		default: ns = S0;
		endcase
	end

	/* state updates */
	always @(posedge clk or posedge resetn) begin
		if (!resetn) begin
			ps <= S0;
		end
		else begin
			ps <= ns;
		end
	end

	/* FSM control output signals*/

	assign ldA = (ps == S0);
	assign reset_counter = (ps == S0);
	assign shiftA = (ps == S1);
	assign incr_counter = (ps == S1) && (!A_0);
endmodule
