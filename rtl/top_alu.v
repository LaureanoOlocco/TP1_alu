module top_alu
#(
    parameter NB_DATA = 8,      // Cantidad de bits de data
    parameter NB_OP   = 6       // Cantidad de bits para la operación
)
(   
    input  wire                           clk      ,
    input  wire         [2           : 0] i_btn    ,
    input  wire         [NB_OP   - 1 : 0] i_sw_op  ,
    input  wire         [NB_DATA - 1 : 0] i_sw_data,
    output wire signed  [NB_DATA - 1 : 0] o_result      // Resultado
);

    wire [NB_DATA - 1 : 0] i_data_a; // preguntar esto al feli
    wire [NB_DATA - 1 : 0] i_data_b;
    wire [NB_OP   - 1 : 0] i_op    ;

    assign i_data_a = i_sw_data;
    assign i_data_b = i_sw_data;

    // Instanciación de la ALU
    ALU #(
        .NB_DATA(NB_DATA),
        .NB_OP  (NB_OP  )
    ) alu_instance (
        .i_data_a(i_data_a),
        .i_data_b(i_data_b),
        .i_op    (i_op    ),
        .o_result(o_result)
    );

    always(posedge clk) begin
        
        if(i_btn[0])begin
            i_data_a <= i_sw_data;
        end

        else if (i_btn[1]) begin
            i_data_b <= i_sw_data;
        end

        else if(i_btn[2])begin
            i_op <= i_sw_op;
        end

    end

endmodule