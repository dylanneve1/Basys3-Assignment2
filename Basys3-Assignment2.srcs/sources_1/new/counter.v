`timescale 1ns / 1ps

module counter(input clk, sh_en, reset, i0, tick, output reg [15:0] matches);
    always @(posedge clk or posedge reset)
        // If reset asserted, reset counter
        if (reset) begin
            matches <= 16'b0000000000000000;
        end else if (sh_en) begin
            // If max_tick_reg / seed reached, reset matches
            if (tick)
                matches <= 16'b0000000000000000;
            // Otherwise if match, increment matches
            else if (i0 == 1'b1)
                matches <= matches + 1'b1;
        end
endmodule
