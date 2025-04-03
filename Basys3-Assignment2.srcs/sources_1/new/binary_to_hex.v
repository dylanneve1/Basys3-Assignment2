`timescale 1ns / 1ps

module binary_to_hex(input [15:0] binary, output [3:0] hex3, hex2, hex1, hex0);
    wire [3:0] bcd0 = binary[3:0];
    wire [3:0] bcd1 = binary[7:4];
    wire [3:0] bcd2 = binary [11:8];
    wire [3:0] bcd3 = binary [15:12];

    // TODO
    // Implement Binary to Decimal converter using HEX

    assign hex0 = bcd0;
    assign hex1 = bcd1;
    assign hex2 = bcd2;
    assign hex3 = bcd3;
endmodule
