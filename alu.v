`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/27 22:01:23
// Design Name: ALU
// Module Name: alu
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


module alu(
    input nop,
    input [31:0] val_a,
    input [31:0] val_b,
    input [3:0] operation,

    output [31:0] val_out,
    output branch
    );

    // operation code
    // 0x1: add
    // 0x2: sub
    // 0x3: and
    // 0x4: or
    // 0x5: xor
    // 0x6: sll
    // 0x7: srl
    // 0x8: sla
    // 0x9: sra
    // 0xa: ==
    // 0xb: !=
    // 0xc: <
    // 0xd: >=
    // 0xe: unsigned <
    // 0xf: unsigned >=

    assign val_out =
        operation == 4'h1 ? ( val_a + val_b ) :
        operation == 4'h2 ? ( val_a - val_b ) :
        operation == 4'h3 ? ( val_a & val_b ) :
        operation == 4'h4 ? ( val_a | val_b ) :
        operation == 4'h5 ? ( val_a ^ val_b ) :
        operation == 4'h6 ? ( val_a << val_b[5:0] ) :
        operation == 4'h7 ? ( val_a >> val_b[5:0] ) :
        operation == 4'h8 ? ( val_a <<< val_b[5:0] ) :
        operation == 4'h9 ? ( val_a >>> val_b[5:0] ) :
        0;

    assign branch = 
        operation == 4'ha ? ( val_a == val_b ? 1 : 0 ) :
        operation == 4'hb ? ( val_a != val_b ? 1 : 0 ) :
        operation == 4'hc ? ( val_a < val_b ? 1 : 0 ) :
        operation == 4'hd ? ( val_a >= val_b ? 1 : 0 ) :
        operation == 4'he ? ( val_a < val_b ? 1 : 0 ) :
        operation == 4'hf ? ( val_a >= val_b ? 1 : 0 ) :
        0;

endmodule
