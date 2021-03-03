//		test_sreg8.v

module test_sreg8;

wire [7:0] q;
reg si, en, ck, nr;

// Instancia el shift register de 8 bits
sreg8	dut( .Q(q), .ShiftIn(si), .Enable(en), .Clock(ck), .nReset(nr));

// Reset del shift register
initial begin
#10 nr = 0;
#10 nr = 1;
end

initial begin
	wait( nr == 1 );		// Espera que termine el Reset
	
	#10 si = 1; en = 1; nr = 1; ck = 0;
	repeat(8) begin			// ingresa 8 1s
		#5 ck = 1;
		#5 ck = 0;
	end

	#10 si = 0; en = 1; nr = 1; ck = 0;
	repeat(8) begin			// ingresa 8 0s
		#5 ck = 1;
		#5 ck = 0;
	end

	#10 si = 1; en = 1; nr = 1; ck = 0;
	repeat(4) begin			// ingresa 4 1s
		#5 ck = 1;
		#5 ck = 0;
	end
	en = 0;					// deshabilikta Enable
	repeat(4) begin			// por 4 ciclos de clock
		#5 ck = 1;
		#5 ck = 0;
	end
	en = 1;					// rehabilita enable
	repeat(4) begin
		#5 ck = 1;
		#5 ck = 0;
	end

end
endmodule
 