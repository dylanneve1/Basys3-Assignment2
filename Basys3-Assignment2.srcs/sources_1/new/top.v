`timescale 1ns / 1ps

module top(input clk, sh_en, reset, output [19:0] Y, matches, output match, tick);
    // Wire for MSB of LFSR
    wire op;
    
    // Connect the 20-bit LFSR
    lfsr lsfr(.clk(clk), .sh_en(sh_en), .reset(reset), .Q_out(Y), .max_tick_reg(tick), .op(op));

    // Connect the FSM Sequence Detector
    fsm_sequence_detector fsm(.clk(clk), .reset(reset), .i0(op), .match(match));
    
    // Connect the counter module to count matches
    counter cnt(.clk(clk), .sh_en(sh_en), .reset(reset), .i0(match), .tick(tick), .matches(matches));
endmodule
