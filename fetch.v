`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 09:22:36
// Design Name: RV32I fetch
// Module Name: fetch
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


module fetch(
    input branch,
    input [31:0] branch_pc,
    input [31:0] pc,
    input [31:0] pc_nb,
    input [31:0] instruction,

    output [31:0] next_pc,
    output [2:0] inst_type,
    output [4:0] rd,
    output [2:0] funct3,
    output [4:0] rs,
    output [4:0] rs2,
    output [5:0] funct7,
    output [31:0] imm
    );

    wire [6:0] opcode;

    wire rtype;
    wire itype;
    wire stype;
    wire btype;
    wire utype;
    wire jtype;

    wire [11:0] i_imm;
    wire [11:0] s_imm;
    wire [12:0] b_imm;
    wire [12:0] u_imm;
    wire [20:0] j_imm;

    assign opcode = instruction[6:0];

    assign rtype = `OP == opcode;
    assign itype = ( `LOAD == opcode ) | ( `OP_IMM == opcode ) | ( `JALR == opcode );
    assign stype = `STORE == opcode;
    assign btype = `BRANCH == opcode;
    assign utype = ( `LUI == opcode ) | ( `AUIPC == opcode );
    assign jtype = `JAL == opcode;

    assign rd = instruction[11:7];
    assign rs = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];

    assign i_imm = instruction[31:20];
    assign s_imm = ( instruction[31:25] << 5 ) | instruction[11:7];
    assign b_imm = ( instruction[31] << 12 ) | ( instruction[7] << 11 ) | ( instruction[30:25] << 5 ) | ( instruction[11:8] << 1 );
    assign u_imm = instruction[31:12] << 12;
    assign j_imm = ( instruction[31] << 20 ) | ( instruction[19:12] << 12 ) | ( instruction[20] << 11 ) | ( instruction[30:21] << 1 );

    assign inst_type = rtype ? `R_TYPE :
                       itype ? `I_TYPE :
                       stype ? `S_TYPE :
                       btype ? `B_TYPE :
                       utype ? `U_TYPE :
                               `J_TYPE ;

    assign imm = rtype ? 0     :
                 itype ? i_imm :
                 stype ? s_imm :
                 btype ? b_imm :
                 utype ? u_imm :
                         j_imm ;

    branch_prediction u_bp (
        .pc(pc),
        .pc_nb(pc_nb),
        .inst_type(inst_type),
        .imm(imm),

        .next_pc(next_pc)
    );

endmodule

module branch_prediction(
    input [31:0] pc,
    input [31:0] pc_nb,
    input [2:0] inst_type,
    input [31:0] imm,

    output [31:0] next_pc
    );

    wire imm_branch = ( `B_TYPE == inst_type ) | ( `U_TYPE == inst_type ) | ( `J_TYPE == inst_type );

    assign next_pc = imm_branch ? pc + imm : pc_nb;

endmodule
