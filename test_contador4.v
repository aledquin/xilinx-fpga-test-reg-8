/*  test_contador4.v

*/

module test_contador4;
wire [3:0] cuenta, cuenta1;
wire enext, enext1;
reg e;
reg nr, ck;

cont4 dut( .Cuenta(cuenta), .Enext(enext), .nR(nr), .E(e), .CK(ck) );
cont4 dut1( .Cuenta(cuenta1), .Enext(enext1), .nR(nr), .E(enext), .CK(ck) );

	initial begin
		nr = 0;
		e = 0;
		ck = 0;
		#15;
		nr = 1;
	end
	always begin
		wait(nr == 1);
		#10 ck = 0;
		#10 ck = 1;
	end
	initial begin
		wait(nr == 1);
		#65;
		e = 1;
	end

endmodule
