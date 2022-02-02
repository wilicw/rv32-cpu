`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/21 09:40:13
// Design Name: RV32I program counter
// Module Name: pc
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


module pc(
    input clk,
    input reset,
    input [31:0] pc_in,
    output reg [31:0] pc_out,
    output reg [31:0] pc_nb
    );
    
    initial begin
        pc_out <= 0;
        pc_nb <= 4;
    end

    always @(posedge clk or negedge reset) begin
        if(~reset) begin
            pc_out <= 0;
        end else begin
            pc_out <= pc_in;
            pc_nb <= pc_in + 4;
        end
    end

endmodule
