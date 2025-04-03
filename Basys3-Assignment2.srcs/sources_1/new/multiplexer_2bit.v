`timescale 1ns / 1ps

module multiplexer_2bit(input CCLK, scaled_clk, sel, output reg clk);
    // Calculate which value should be passed to out based on sel
    always @(*) begin
        case(sel)
            1'b0: clk = CCLK;
            1'b1: clk = scaled_clk;
        endcase
    end
endmodule
