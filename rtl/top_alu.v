module top_alu
#(
    parameter NB_DATA = 8,      // Cantidad de bits de data
    parameter NB_OP   = 6       // Cantidad de bits para la operación
)
(   
    input  wire                           clk      ,
    input  wire         [2           : 0] i_btn    ,
    input  wire signed  [NB_DATA - 1 : 0] i_sw_data,
    input  wire                           i_rst    ,
    output wire signed  [NB_DATA - 1 : 0] o_led      // Resultado
);

    reg [NB_DATA - 1 : 0] data_a; // preguntar esto al feli
    reg [NB_DATA - 1 : 0] data_b;
    reg [NB_OP   - 1 : 0] op    ;

  
    // Instanciación de la ALU
    ALU #(
        .NB_DATA(NB_DATA),
        .NB_OP  (NB_OP  )
    ) alu_instance (
        .i_data_a(data_a),
        .i_data_b(data_b),
        .i_op    (op    ),
        .o_result(o_led )
    );

    always@(posedge clk) begin

            if(i_btn[0])begin
                data_a <= i_sw_data;
            end

            else if (i_btn[1]) begin
                data_b <= i_sw_data;
            end

            else if(i_btn[2])begin
                op <= i_sw_data[NB_OP-1:0];          // Revisar para que en lugar de usar i sw op usar los de data pero 6 bits nomas, op queda igual porque en la alu es un input de 6 bits
                
            end
                
    end    

    
 
endmodule