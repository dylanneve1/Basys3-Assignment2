`timescale 1ns / 1ps

module top_tb;
    reg clk, sh_en, reset, sel, sel2;
    wire match, tick;

    top uut(.CCLK(clk), .sh_en(sh_en), .reset(reset), .sel(sel), .sel2(sel2), .match(match), .tick(tick), .out(), .an(), .sseg());
    
    integer total_cycles = 0;
    integer total_match = 0;
    
    initial begin
        clk = 1;
        forever #10 clk = ~clk;
    end
    
    initial begin
        reset = 1; // Assert reset
        sh_en = 0; // Deassert sh_en
        sel   = 0; // Disable output MUX
        sel2  = 0; // Disable clk scaling
        #40        // Wait 2 clock cyles
        reset = 0; // Deassert reset
        sh_en = 1; // Assert sh_en
        
        while (!tick) begin
            @(posedge clk);
            total_cycles = total_cycles + 1;
            if (match) begin
                total_match = total_match + 1;
            end
        end
        $display("Test complete after %0d cycles", total_cycles);
        $display("Total matches was %0d", total_match);
        $finish;
    end
endmodule
