`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 09:40:13
// Design Name: RV32I core testbench
// Module Name: core_tb
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


module core_tb;

    reg clk = 0;
    reg [31:0] instruction = 0;

    wire [31:0] pc;
    wire [31:0] pc_nb;
    wire [31:0] next_pc;

    wire [2:0] inst_type;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs;
    wire [4:0] rs2;
    wire [5:0] funct7;
    wire [31:0] imm;

    wire [31:0] if_id_pc;
    wire [2:0] if_id_inst_type;
    wire [4:0] if_id_rd;
    wire [2:0] if_id_funct3;
    wire [4:0] if_id_rs;
    wire [4:0] if_id_rs2;
    wire [5:0] if_id_funct7;
    wire [31:0] if_id_imm;

    wire [31:0] val_rs;
    wire [31:0] val_rs2;

    wire [31:0] id_ex_pc;
    wire [2:0] id_ex_inst_type;
    wire [2:0] id_ex_funct3;
    wire [5:0] id_ex_funct7;
    wire [31:0] id_ex_imm;
    wire [31:0] id_ex_val_rs;
    wire [31:0] id_ex_val_rs2;
    wire [4:0] id_ex_rd;

    wire [31:0] exec_val_out;
    wire exec_reg_w;
    wire [31:0] exec_reg_data;
    wire exec_mem_w;
    wire exec_mem_r;
    wire [31:0] exec_mem_addr;
    wire [31:0] exec_mem_data;
    wire exec_branch;
    wire [31:0] exec_branch_pc;

    wire [31:0] ex_me_val_out;
    wire ex_me_reg_w;
    wire [31:0] ex_me_reg_data;
    wire ex_me_mem_w;
    wire ex_me_mem_r;
    wire [31:0] ex_me_mem_addr;
    wire [31:0] ex_me_mem_data;
    wire ex_me_branch;
    wire [31:0] ex_me_branch_pc;

    pc u_pc (
        .clk(clk),
        .reset(1'b1),
        .pc_in(next_pc),

        .pc_out(pc),
        .pc_nb(pc_nb)
    );

    fetch u_fet (
        .branch(1'b0),
        .branch_pc(32'b0),
        .pc(pc),
        .pc_nb(pc_nb),
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

    IF_ID u_ifid (
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
    
    decoder u_dec (
        .pc(if_id_pc),
        .inst_type(if_id_inst_type),
        .rd(if_id_rd),
        .funct3(if_id_funct3),
        .funct7(if_id_funct7),
        .imm(if_id_imm),
        .rs(if_id_rs),
        .rs2(if_id_rs2),

        .val_rs(val_rs),
        .val_rs2(val_rs2)
    );

    ID_EX u_idex (
        .pc(if_id_pc),
        .inst_type(if_id_inst_type),
        .rd(if_id_rd),
        .funct3(if_id_funct3),
        .funct7(if_id_funct7),
        .imm(if_id_imm),
        .val_rs(val_rs),
        .val_rs2(val_rs2),
        .clk(clk),

        .pc_reg(id_ex_pc),
        .inst_type_reg(id_ex_inst_type),
        .funct3_reg(id_ex_funct3),
        .funct7_reg(id_ex_funct7),
        .imm_reg(id_ex_imm),
        .val_rs_reg(id_ex_val_rs),
        .val_rs2_reg(id_ex_val_rs2),
        .rd_reg(id_ex_rd)
    );

    exec u_exec (
        .pc(id_ex_pc),
        .inst_type(id_ex_inst_type),
        .funct3(id_ex_funct3),
        .funct7(id_ex_funct7),
        .imm(id_ex_imm),
        .val_rs(id_ex_val_rs),
        .val_rs2(id_ex_val_rs2),

        .val_out(exec_val_out),
        .reg_w(exec_reg_w),
        .reg_data(exec_reg_data),
        .mem_w(exec_mem_w),
        .mem_r(exec_mem_r),
        .mem_addr(exec_mem_addr),
        .mem_data(exec_mem_data),
        .branch(exec_branch),
        .branch_pc(exec_branch_pc)
    );

    EX_ME u_exme(
        .val_out(exec_val_out),
        .reg_w(exec_reg_w),
        .reg_data(exec_reg_data),
        .mem_w(exec_mem_w),
        .mem_r(exec_mem_r),
        .mem_addr(exec_mem_addr),
        .mem_data(exec_mem_data),
        .branch(exec_branch),
        .branch_pc(exec_branch_pc),
        .clk(clk),

        .val_out_reg(ex_me_val_out),
        .reg_w_reg(ex_me_reg_w),
        .reg_data_reg(ex_me_reg_data),
        .mem_w_reg(ex_me_mem_w),
        .mem_r_reg(ex_me_mem_r),
        .mem_addr_reg(ex_me_mem_addr),
        .mem_data_reg(ex_me_mem_data),
        .branch_reg(ex_me_branch),
        .branch_pc_reg(ex_me_branch_pc)
    );

    initial begin
        $dumpfile("core_tb.vcd");
        $dumpvars(0, core_tb);

        clk = 0;
        instruction = 32'h01028293;
        #10
        instruction = 32'h26771c63;
        #10
        instruction = 32'h00119193;
        #10
        instruction = 32'h0020c733;
        #10
        instruction = 32'h0100026f;
        #10
        instruction = 32'hfff28293;

        #100
        $finish;
    end
    
    always begin
        #5 clk = ~clk;
    end

endmodule
