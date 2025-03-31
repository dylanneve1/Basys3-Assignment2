`timescale 1ns / 1ps

module counter(input clk, sh_en, reset, i0, tick, output reg [19:0] matches);
    always @(posedge clk or posedge reset)
        if (reset) begin
            matches <= 20'b00000000000000000000;
        end else if (sh_en) begin
            if (tick)
                matches <= 20'b00000000000000000000;
            else if (i0 == 1'b1)
                matches <= matches + 1'b1;
        end
endmodule
