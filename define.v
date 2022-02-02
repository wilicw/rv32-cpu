// OPCODE define
`define LOAD        7'b0000011
`define LOAD_FP     7'b0000111
`define __custom0   7'b0001011
`define MISC_MEM    7'b0001111
`define OP_IMM      7'b0010011
`define AUIPC       7'b0010111
`define OP_IMM_32   7'b0011011
`define STORE       7'b0100011
`define STORE_FP    7'b0100111
`define __custom1   7'b0101011
`define AMO         7'b0101111
`define OP          7'b0110011
`define LUI         7'b0110111
`define OP_32       7'b0111011
`define MADD        7'b1000011
`define MSUB        7'b1000111
`define NMSUB       7'b1001011
`define NMADD       7'b1001111
`define OP_FP       7'b1010011
`define __reserved0 7'b1010111
`define __custom2   7'b1011011
`define BRANCH      7'b1100011
`define JALR        7'b1100111
`define __reserved1 7'b1101011
`define JAL         7'b1101111
`define SYSTEM      7'b1110011
`define __reserved2 7'b1110111
`define __custom3   7'b1111011

// INSTRUCTION TYPE define
`define R_TYPE      0
`define I_TYPE      1
`define S_TYPE      2
`define B_TYPE      3
`define U_TYPE      4
`define J_TYPE      5


