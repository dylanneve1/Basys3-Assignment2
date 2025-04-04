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
    output wire [3:0] an,    // ANODE for SSEG display
    output wire [7:0] sseg,  // Main for SSEG display
    output wire [2:0] state  // Current state of FSM
);
    // Wire for MSB of LFSR, scaled clk and final clk
    wire op, sclk, clk;
    // Wire for current output of LFSR
    wire [19:0] Q_state;
    // Wire to connect number of matches to SSEG
    wire [3:0] hex3, hex2, hex1, hex0;
    // Wire to store number of matches in binary for comparison
    wire [15:0] binary_counter;
    
    // Connect the clock scaler
    clock clkscaler_unit(.CCLK(CCLK), .scale(50000000), .clk(sclk));
    
    // Connect the clock multiplexer
    multiplexer_2bit plex2bit_unit(.CCLK(CCLK), .sclk(sclk), .sel(sel2), .reset(reset), .clk(clk));
    
    // Connect the 20-bit LFSR
    lfsr lfsr_unit(.clk(clk), .sh_en(sh_en), .reset(reset), .Q_out(Q_state), .tick(tick), .op(op));

    // Connect the FSM Sequence Detector
    fsm_sequence_detector fsm_unit(.clk(clk), .sh_en(sh_en), .reset(reset), .i0(op), .match(match), .state(state));
    
    // Connect the counter module to count matches
    counter cnt_unit(.clk(clk), .sh_en(sh_en), .reset(reset), .i0(match), .tick(tick), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0), .bin(binary_counter));
    
    // Multiplex
    multiplexer plex_unit(.Q_state(Q_state), .sel(sel), .out(out));
    
    // sseg display
    sseg display_unit(.clk(CCLK), .reset(reset), .hex3(hex3), .hex2(hex2), .hex1(hex1), .hex0(hex0), .dp_in(4'b1111), .an(an), .sseg(sseg));
endmodule
