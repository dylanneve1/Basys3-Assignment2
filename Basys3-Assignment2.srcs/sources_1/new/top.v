`timescale 1ns / 1ps

module top(input clk, sh_en, reset, output [19:0] Y);
    wire op;
    wire match;

    // Connect the 20-bit LFSR
    lfsr lsfr(.clk(clk), .sh_en(sh_en), .reset(reset), .Q_out(Y), .max_tick_reg(), .op(op));

    // Connect the FSM Sequence Detector
    fsm_sequence_detector fsm(.clk(), .reset(), .i0(op), .match(match));
endmodule
