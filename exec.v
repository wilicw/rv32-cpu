`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/09 11:08:07
// Design Name: RV32I execution
// Module Name: exec
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

`include "define.v"

module exec (
    input [31:0] pc,
    input [2:0] inst_type,
    input [2:0] funct3,
    input [5:0] funct7,
    input [31:0] imm,
    input [31:0] val_rs,
    input [31:0] val_rs2,
    input [6:0] opcode,

    output [31:0] val_out,
    output reg_w,
    output [31:0] reg_data,
    output mem_w,
    output mem_r,
    output [31:0] mem_addr,
    output [31:0] mem_data,
    output [1:0] mem_len,
    output mem_uns,
    output branch,
    output [31:0] branch_pc
    );

    wire [31:0] val_a;
    wire [31:0] val_b;
    wire [5:0] operation;

    wire [31:0] sign_imm12;
    wire [31:0] sign_imm13;
    wire [31:0] sign_imm21;

    wire alu_branch;
    wire exe_branch;
    wire [31:0] branch_offset;

    assign val_a = inst_type == `J_TYPE ? pc : val_rs;
    assign val_b = inst_type == `I_TYPE ? sign_imm12 :
                   val_rs2;

    assign operation =
    inst_type == `I_TYPE ? (
        funct3 == 0 ? 1 :
        funct3 == 1 ? 6 :
        funct3 == 2 ? 0 :
        funct3 == 3 ? 0 :
        funct3 == 4 ? 5 :
        funct3 == 5 ? (
            imm[10] ? 9 
                    : 7
        ) :
        funct3 == 6 ? 4 :
        funct3 == 7 ? 3 :
                      0 
    ) : inst_type == `R_TYPE ? (
        funct3 == 0 ? (
            funct7 == 0 ? 1 
                        : 2
        ) : 
        funct3 == 1 ? 6 :
        funct3 == 2 ? 0 :
        funct3 == 3 ? 0 :
        funct3 == 4 ? 5 :
        funct3 == 5 ? (
            funct7 == 0 ? 7 
                        : 9
        ) :
        funct3 == 6 ? 4 :
        funct3 == 7 ? 3 :
                      0
    ) : inst_type == `B_TYPE ? (
        funct3 == 0 ? 4'ha :
        funct3 == 1 ? 4'hb :
        funct3 == 4 ? 4'hc :
        funct3 == 5 ? 4'hd :
        funct3 == 6 ? 4'he :
        funct3 == 7 ? 4'hf :
        0
    ) : 0;

    assign exe_branch = inst_type == `J_TYPE ? 1 : 0;

    assign branch_offset = 
        inst_type == `J_TYPE ? sign_imm21 :
        inst_type == `I_TYPE ? sign_imm13 :
        0;

    assign branch_pc = pc + branch_offset;
    assign branch = alu_branch | exe_branch;

    alu u_alu (
        .operation(operation),
        .val_a(val_a),
        .val_b(val_b),
        .nop(nop),

        .val_out(val_out),
        .branch(alu_branch)
    );

    assign reg_w = 
        ( inst_type == `R_TYPE ) |
        ( inst_type == `J_TYPE ) |
        ( inst_type == `I_TYPE ) ;

    assign reg_data = inst_type == `J_TYPE ? pc + 4 : val_out;

    assign mem_w = opcode == `STORE | opcode == `STORE_FP;
    assign mem_r = opcode == `LOAD | opcode == `LOAD_FP;
    assign mem_addr = val_rs + sign_imm12;
    assign mem_data = val_rs2;
    assign mem_len = funct3[1:0];
    assign mem_uns = funct3[2];

    sign_ext #(
        .bits(32),
        .sign_bit(12)
    ) u_se12 (
        .in(imm),
        .out(sign_imm12)
    );

    sign_ext #(
        .bits(32),
        .sign_bit(13)
    ) u_se13 (
        .in(imm),
        .out(sign_imm13)
    );

    sign_ext #(
        .bits(32),
        .sign_bit(21)
    ) u_se21 (
        .in(imm),
        .out(sign_imm21)
    );

endmodule

module sign_ext #(
    parameter bits = 32,
    parameter sign_bit = 12
    ) (
    input [sign_bit-1:0] in, 
    input [bits-1:0] out
    );

    assign out = {{( bits - sign_bit ){in[sign_bit-1]}}, in[sign_bit-1:0]};

endmodule
