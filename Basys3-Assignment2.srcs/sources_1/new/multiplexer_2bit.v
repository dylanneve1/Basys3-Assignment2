`timescale 1ns / 1ps

// 2-bit Multiplexer module
// Used because for hardware testing the clk speed is too high to
// observe the output, so we use switch W17 to control the clock
// scale so we can use a 1Hz refresh rate.
module multiplexer_2bit(input CCLK, scaled_clk, sel, reset, output reg clk);
    // Calculate which value should be passed to out based on sel
    always @(posedge reset) begin
        case(sel)
            // Use hardware clock
            1'b0: clk = CCLK;
            // Use scaled clock
            1'b1: clk = scaled_clk;
        endcase
    end
endmodule
