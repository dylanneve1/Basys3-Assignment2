`timescale 1ns / 1ps

module binary_to_hex(input [15:0] binary, output [3:0] hex3, hex2, hex1, hex0);
    assign hex0 = binary[3:0];
    assign hex1 = binary[7:4];
    assign hex2 = binary[11:8];
    assign hex3 = binary[15:12];
endmodule
