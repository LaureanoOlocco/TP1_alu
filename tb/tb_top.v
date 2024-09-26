`timescale 1ns / 1ps

module tb_top_alu;

    // Parámetros
    parameter NB_DATA = 8;
    parameter NB_OP   = 6;

    // Entradas
    reg clk;
    reg i_valid;
    reg i_rst;
    reg [2:0] i_btn;
    reg signed [NB_DATA-1:0] i_sw_data;

    // Salidas
    wire signed [NB_DATA-1:0] o_led;

    // Instanciación del módulo top_alu
    top_alu #(
        .NB_DATA(NB_DATA),
        .NB_OP  (NB_OP  )
    ) uut (
        .clk      (clk),
        .i_valid  (i_valid),
        .i_btn    (i_btn),
        .i_sw_data(i_sw_data),
        .i_rst    (i_rst),
        .o_led    (o_led)
    );

    // Generación del reloj (50 MHz -> periodo de 20 ns)
    always #10 clk = ~clk;

    initial begin
        // Inicialización de las señales
        clk = 0;
        i_valid = 0;
        i_btn = 3'b000;
        i_sw_data = 8'd0;
        i_rst = 1;

        // Reset al sistema
        #20;
        i_rst = 0;  // Activar reset
        #20;
        i_rst = 1;  // Desactivar reset
        #20;

        // Habilitar entrada válida
        i_valid = 1;

        // Cargar data_a (botón i_btn[0])
        i_btn = 3'b001;      // Presionamos el botón i_btn[0]
        i_sw_data = 8'd15;   // Valor de data_a = 15
        #20;                 // Esperamos 1 ciclo de reloj
        i_btn = 3'b000;      // Soltamos el botón
        #20;

        // Cargar data_b (botón i_btn[1])
        i_btn = 3'b010;      // Presionamos el botón i_btn[1]
        i_sw_data = 8'd10;   // Valor de data_b = 10
        #20;
        i_btn = 3'b000;      // Soltamos el botón
        #20;

        // Seleccionar operación (botón i_btn[2] -> ADD)
        i_btn = 3'b100;      // Presionamos el botón i_btn[2]
        i_sw_data = 6'b100000;  // Operación ADD (suma)
        #20;
        i_btn = 3'b000;      // Soltamos el botón
        #20;

        // Comprobar el resultado de la suma
        #100;

        // Realizar una resta (SUB)
        i_btn = 3'b100;      // Presionamos el botón i_btn[2]
        i_sw_data = 6'b100010;  // Operación SUB (resta)
        #20;
        i_btn = 3'b000;      // Soltamos el botón
        #100;

        // Deshabilitar la señal de validación
        i_valid = 0;
        #50;

        // Añadir más pruebas si es necesario...
        
        // Terminar la simulación
        $finish;
    end

endmodule