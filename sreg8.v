//		sreg8.v
// Shift Registr de 8 bits
// Desplaza Q a la derecha con Enable=1 y clock

module sreg8(	output reg [7:0] Q,
				input ShiftIn,
				input Enable,
				input Clock,
				input nReset);

reg [7:0] Qr;

// Calculo asíncrono de registro auxiliar Qr
always @ (Q, ShiftIn, Enable) begin
	Qr = Q;
	if(Enable == 1)
		Qr = {ShiftIn, Q[7:1]};
end

// Reset y asignación de Qr con clock
always @ (posedge Clock, negedge nReset) begin
	if(nReset == 0)
		#2 Q = 0;
	else
		#2 Q = Qr;
end
endmodule
