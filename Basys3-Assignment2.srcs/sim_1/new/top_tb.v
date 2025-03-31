`timescale 1ns / 1ps

module top_tb;
    reg clk, sh_en, reset;
    wire [19:0] Y, matches;
    wire match, tick;

    top uut(.clk(clk), .sh_en(sh_en), .reset(reset), .Y(Y), .matches(matches), .match(match), .tick(tick));
    
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
    
    initial begin
        reset = 1;
        sh_en = 0;
        #40
        reset = 0;
        sh_en = 1;
        $stop;
    end
endmodule
