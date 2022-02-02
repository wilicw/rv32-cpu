`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/20 16:48:39
// Design Name: RV32I registers file
// Module Name: register_file
// Project Name: RV32I cpu
// Target Devices: pynq
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file(
    input [4:0] rs,
    input [4:0] rs2,
    input w_en,
    input [4:0] rd,
    input [31:0] w_data,

    output [31:0] o_data,
    output [31:0] o_data2
    );

    reg [31:0] regs[31:0];

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1 ) begin
            initial begin
                regs[i] <= 0;
            end
        end
    endgenerate

    always @(w_en) begin
        if (w_en && rd != 0) begin
            regs[rd] <= w_data;
        end
    end

    assign o_data = rs == 0 ? 32'b0 : regs[rs];
    assign o_data2 = rs2 == 0 ? 32'b0 : regs[rs2];

endmodule
