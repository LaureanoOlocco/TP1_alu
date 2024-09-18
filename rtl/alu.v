// Implementar en FPGA una ALU:
//  - La ALU debe ser parametrizable (bus de datos) para poder ser utilizada posteriormente
//  - Validar el desarrollo con test bench
//      - Debe incluir generacion de entradas aleatorias y codigo de chequeo
//  - Simular el diseno usando vivado con analisis de tiempo

//  ADD     100000
//  SUB     100010
//  AND     100100
//  OR      100101
//  XOR     100110
//  SRA     000011
//  SRL     000010
//  NOR     100111  

module ALU 
#(
    parameter NB_DATA = 8,      // Cantidad de bits de data
    parameter NB_OP   = 6         // Cantidad de bits para la operación
)
(
    input  wire signed  [NB_DATA - 1 : 0] i_data_a,   // 8 bits para a
    input  wire signed  [NB_DATA - 1 : 0] i_data_b,   // 8 bits para b
    input  wire         [NB_OP   - 1 : 0] i_op    ,   // 8 bits para operador
    output reg  signed  [NB_DATA - 1 : 0] o_result    // Salida de la alu
);


always @(*) 
begin
    case (i_op)
        6'b100000: o_result = i_data_a +   i_data_b ; // Operación ADD
        6'b100010: o_result = i_data_a -   i_data_b ; // Operación SUB
        6'b100100: o_result = i_data_a &   i_data_b ; // Operación AND
        6'b100101: o_result = i_data_a |   i_data_b ; // Operación OR
        6'b100110: o_result = i_data_a ^   i_data_b ; // Operación XORi_op
        6'b000011: o_result = i_data_a >>> i_data_b ; // Operación SRA
        6'b000010: o_result = i_data_a >>  i_data_b ; // Operación SRL
        6'b100111: o_result = ~(i_data_a | i_data_b); // Operación NOR
        default:   o_result = {NB_DATA{1'b0}}       ; // Sino, todo 0
    endcase
end

    
endmodule