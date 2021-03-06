`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/09 11:08:07
// Design Name: RV32I decoder
// Module Name: decoder
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

module decoder (
    input [4:0] rs,
    input [4:0] rs2,

    output [31:0] val_rs,
    output [31:0] val_rs2 
    );

    register_file reg_file_u0 (
        .rs(rs),
        .rs2(rs2),
        .o_data(val_rs),
        .o_data2(val_rs2)
    );

endmodule
