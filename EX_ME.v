
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/27 22:01:23
// Design Name: EX/ME Register
// Module Name: EX_ME
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


module EX_ME(
    input [31:0] val_out,
    input reg_w,
    input [31:0] reg_data,
    input mem_w,
    input mem_r,
    input [31:0] mem_addr,
    input [31:0] mem_data,
    input [1:0] mem_len,
    input mem_uns,
    input branch,
    input [31:0] branch_pc,
    input clk,

    output reg [31:0] val_out_reg,
    output reg reg_w_reg,
    output reg [31:0] reg_data_reg,
    output reg mem_w_reg,
    output reg mem_r_reg,
    output reg [31:0] mem_addr_reg,
    output reg [31:0] mem_data_reg,
    output reg [1:0] mem_len_reg,
    output reg mem_uns_reg,
    output reg branch_reg,
    output reg [31:0] branch_pc_reg
  );

  always @(posedge clk ) begin 
    val_out_reg <= val_out;
    reg_w_reg <= reg_w;
    reg_data_reg <= reg_data;
    mem_w_reg <= mem_w;
    mem_r_reg <= mem_r;
    mem_addr_reg <= mem_addr;
    mem_data_reg <= mem_data;
    mem_len_reg <= mem_len;
    mem_uns_reg <= mem_uns;
    branch_reg <= branch;
    branch_pc_reg <= branch_pc;
  end

endmodule
