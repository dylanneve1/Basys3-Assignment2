`timescale 1ns / 1ps

module top(
    input wire CCLK,         // Clock from Basys3
    input wire sh_en,        // Shift enable input
    input wire reset,        // Reset input
    input wire sel,          // Sel for LED multiplex
    input wire sel2,         // Sel for clk multiplex
    output wire match,       // Indicate if a match is detected
    output wire tick,        // Seed has been reached
    output wire [9:0] out,   // LED output
    output wire [3:0] anode, // ANODE for SSEG display
    output wire [6:0] sseg   // Main for SSEG display
);
    // Wire for MSB of LFSR, scaled clk and final clk
    wire op, scaled_clk, clk;
    // Wire for current output of LFSR
    wire [19:0] Q_state;
    // Wire to connect number of matches to SSEG
    wire [15:0] matches; // 16-bit MAX!!!!
    
    wire [3:0] hex0, hex1, hex2, hex3;
    
    // Connect the clock scaler
    clock clkscaler(.CCLK(CCLK), .clkscale(50000000), .clk(scaled_clk));
    
    // Connect the clock multiplexer
    multiplexer_2bit plex2bit(.CCLK(CCLK), .scaled_clk(scaled_clk), .sel(sel2), .clk(clk));
    
    // Connect the 20-bit LFSR
    lfsr gen(.clk(clk), .sh_en(sh_en), .reset(reset), .Q_out(Q_state), .max_tick_reg(tick), .op(op));

    // Connect the FSM Sequence Detector
    fsm_sequence_detector fsm(.clk(clk), .reset(reset), .i0(op), .match(match));
    
    // Connect the counter module to count matches
    counter cnt(.clk(clk), .sh_en(sh_en), .reset(reset), .i0(match), .tick(tick), .matches(matches));
    
    // Multiplex
    multiplexer plex(.Q_state(Q_state), .sel(sel), .out(out));
    
    // Convert the binary matches to 4 hex words
    binary_to_hex helper(.binary(matches), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0));
    
    // sseg display
    sseg display(.clk(CCLK), .reset(reset), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0), .anode(anode), .sseg(sseg));
endmodule
