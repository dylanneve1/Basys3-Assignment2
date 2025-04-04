`timescale 1ns / 1ps

// Clock scaling module
// Scales the hardware clock down to 1Hz.
module clock(input CCLK, input [25:0] scale, output reg clk);
    // Counter
    reg [25:0] counter = 0;
    always @(posedge CCLK) begin
        // If counter reached 50M
        if (counter >= scale) begin
            // Reset counter
            counter <= 0;
            // Flip clock
            clk <= ~clk;
        end else
            // Inctement counter
            counter <= counter + 1;
    end
endmodule
