`timescale 1ns / 1ps

module binary_to_hex(input [15:0] binary, output [3:0] hex3, hex2, hex1, hex0);
    wire [3:0] bcd0 = binary[3:0];
    wire [3:0] bcd1 = binary[7:4];
    wire [3:0] bcd2 = binary [11:8];
    wire [3:0] bcd3 = binary [15:12];

    reg [3:0] bcd0_next, bcd1_next, bcd2_next, bcd3_next;

    // 3-digit bcd counter
    always @* begin
        // default: keep the previous value
        bcd0_next = bcd0;
        bcd1_next = bcd1;
        bcd2_next = bcd2;
        bcd3_next = bcd3;
        if (bcd0_next == 4'ha) begin
            bcd0_next = 4'h0;
            bcd1_next = bcd1_next + 4'h1;
            if (bcd1_next == 4'ha) begin
                bcd1_next = 4'h0;
                bcd2_next = bcd2_next + 4'h1;
                if (bcd2_next == 4'ha) begin
                    bcd2_next = 4'h0;
                    bcd3_next = bcd3_next + 4'h1;
                    if (bcd3_next == 4'ha) begin
                        bcd3_next = 4'h9;
                    end
                end
            end
        end
   end

    assign hex0 = bcd0_next;
    assign hex1 = bcd1_next;
    assign hex2 = bcd2_next;
    assign hex3 = bcd3_next;
endmodule
