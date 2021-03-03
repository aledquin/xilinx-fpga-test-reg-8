/*  contador4.v
    módulo cont4
    Contador de 4 bits sin carga paralela
	Tiene salida Enext = 1 si Cuenta=4'hF.
*/

module cont4(	output reg [3:0] Cuenta,	// Valor del contador síncrono
				output reg Enext,			// Cuenta == 4'hF => Enext = 1
                input nR,					// Reset negativo asíncrono
                input E,					// Enabled E=0 deshabilitado, E=1 habilitado
                input CK					// Clock posedge
);

parameter STD_DELAY = 2;
reg [3:0] CuentaR;

// Cálculo asíncrono del estado siguiente.
// Lista de sensibilidad depende de estado
// actual y variables de control.
// No depende del reloj.
  always @ (Cuenta, E) begin
  if(E==1) begin
	CuentaR = Cuenta + 1;
	Enext = (Cuenta == 4'hF) ? 1: 0;
	end
  end // always asíncrono
  
// Actualización síncrona del estado
// Reset debe estar inactivo.
// Enable debe estar activo.
// Se actualiza con posedge.
  always @ ( negedge nR, posedge CK )
  begin
    if(nR == 0) begin						// Aquí se hace reset
		#(STD_DELAY) Cuenta = 0;
		CuentaR = 0;
		Enext = 0;
	end
    else if( E == 1) begin					// Tiene que estar habilitado para contar
      #(STD_DELAY) Cuenta = CuentaR;		// Actualiza estado
	end
end // always síncrono

// En este caso la salida de la máquina es el estado actual.
// No es necesario actualizar la salida.

endmodule
