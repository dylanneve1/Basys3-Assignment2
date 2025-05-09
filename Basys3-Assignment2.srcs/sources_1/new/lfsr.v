`timescale 1ns / 1ps

// 20-bit XOR LFSR Module
module lfsr(input clk, sh_en, reset, output [19:0] Q_out, output reg tick, output op);
    // Seed
    localparam seed = 20'b00000000000000101001;

    // Current State
    reg [19:0] Q_state;
    // Next State
    wire [19:0] Q_ns;
    // Feedback
    wire Q_fb;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset All
            Q_state <= seed;
            tick <= 1'b0;
        end else if (sh_en) begin
            // State to next
            Q_state <= Q_ns;
            // If next state is seed
            if (Q_ns == seed) begin
                // Max tick and increment
                tick <= 1'b1;
            end else
                // Max tick low
                tick <= 1'b0;
        end
    end

    // Next State Logic
    assign Q_fb = Q_state[19] ^ Q_state[16];
    assign Q_ns = {Q_state[18:0], Q_fb};

    // Output Logic
    assign Q_out = Q_state;
    assign op = Q_state[19];

endmodule
