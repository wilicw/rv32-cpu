`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/27 22:01:23
// Design Name: IF/ID Register
// Module Name: IF_ID
// Project Name: RV32I CPU
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


module IF_ID(
    input [31:0] pc,
    input [2:0] inst_type,
    input [2:0] funct3,
    input [5:0] funct7,
    input [31:0] imm,
    input [4:0] rs,
    input [4:0] rs2,
    input [4:0] rd,
    input [6:0] opcode,
    input clk,

    output reg [31:0] pc_reg,
    output reg [2:0] inst_type_reg,
    output reg [2:0] funct3_reg,
    output reg [5:0] funct7_reg,
    output reg [31:0] imm_reg,
    output reg [4:0] rs_reg,
    output reg [4:0] rs2_reg,
    output reg [4:0] rd_reg,
    output reg [6:0] opcode_reg
    );

    always @(posedge clk) begin
        pc_reg <= pc;
        inst_type_reg <= inst_type;
        funct3_reg <= funct3;
        funct7_reg <= funct7;
        imm_reg <= imm;
        rs_reg <= rs;
        rs2_reg <= rs2;
        rd_reg <= rd;
        opcode_reg <= opcode;
    end

endmodule
