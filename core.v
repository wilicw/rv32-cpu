`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 09:40:13
// Design Name: 
// Module Name: core
// Project Name: 
// Target Devices: 
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


module core(
    input clk,
    input [31:0] instruction
    );


    wire [31:0] next_pc;
    wire [2:0] inst_type;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs;
    wire [4:0] rs2;
    wire [5:0] funct7;
    wire [31:0] imm;

    wire [31:0] pc;

    wire [31:0] if_id_pc;
    wire [2:0] if_id_inst_type;
    wire [4:0] if_id_rd;
    wire [2:0] if_id_funct3;
    wire [4:0] if_id_rs;
    wire [4:0] if_id_rs2;
    wire [5:0] if_id_funct7;
    wire [31:0] if_id_imm;

    initial begin
        assign pc = 0;
    end

    fetch(
        .branch(0),
        .branch_pc(0),
        .pc(pc),
        .instruction(instruction),

        .next_pc(next_pc),
        .inst_type(inst_type),
        .rd(rd),
        .funct3(funct3),
        .rs(rs),
        .rs2(rs2),
        .funct7(funct7),
        .imm(imm)
    );

    IF_ID(
        .pc(pc),
        .inst_type(inst_type),
        .funct3(funct3),
        .funct7(funct7),
        .imm(imm),
        .rs(rs),
        .rs2(rs2),
        .rd(rd),
        .clk(clk),

        .pc_reg(if_id_pc),
        .inst_type_reg(if_id_inst_type),
        .rd_reg(if_id_rd),
        .funct3_reg(if_id_funct3),
        .funct7_reg(if_id_funct7),
        .imm_reg(if_id_imm),
        .rs_reg(if_id_rs),
        .rs2_reg(if_id_rs2)
    );

    

endmodule
