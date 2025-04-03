`timescale 1ns / 1ps

module top(input CCLK, sh_en, reset, sel, sel2, output match, tick, output [9:0] out);
    // Wire for MSB of LFSR
    wire op, scaled_clk, clk;
    wire [19:0] Q_state;
    
    clock clk(.CCLK(CCLK), .clkscale(50000000), .clk(scaled_clk));
    
    multiplexer_2bit plex2bit(.CCLK(CCLK), .scaled_clk(scaled_clk), .sel(sel2), .clk(clk));
    
    // Connect the 20-bit LFSR
    lfsr gen(.clk(clk), .sh_en(sh_en), .reset(reset), .Q_out(Q_state), .max_tick_reg(tick), .op(op));

    // Connect the FSM Sequence Detector
    fsm_sequence_detector fsm(.clk(clk), .reset(reset), .i0(op), .match(match));
    
    // Connect the counter module to count matches
    counter cnt(.clk(clk), .sh_en(sh_en), .reset(reset), .i0(match), .tick(tick), .matches());
    
    // Multiplex
    multiplexer plex(.Q_state(Q_state), .sel(sel), .out(out));
endmodule
