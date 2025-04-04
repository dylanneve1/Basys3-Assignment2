`timescale 1ns / 1ps

module counter(
    input clk,             // Clock signal
    input sh_en,           // Shift enable signal
    input reset,           // Reset signal
    input i0,              // Input signal, to count
    input tick,            // When seed has been reached
    output reg [3:0] hex3, // For SSEG, 4th HEX digit
    output reg [3:0] hex2, // For SSEG, 3rd HEX digit
    output reg [3:0] hex1, // For SSEG, 2nd HEX digit
    output reg [3:0] hex0, // For SSEG, 1st HEX digit
    output reg [15:0] bin  // Binary counter output, for validation
);

    // Next-state variables
    reg [3:0] hex3_next, hex2_next, hex1_next, hex0_next;
    reg [15:0] bin_next;

    // Combinational next-state logic
    always @(*) begin
        // Default: keep current state
        hex3_next = hex3;
        hex2_next = hex2;
        hex1_next = hex1;
        hex0_next = hex0;
        bin_next = bin;
        
        // On reset or tick, clear the counter
        if (reset || tick) begin
            hex3_next = 4'h0;
            hex2_next = 4'h0;
            hex1_next = 4'h0;
            hex0_next = 4'h0;
            bin_next = 16'b0000000000000000;
        end else if (sh_en && i0) begin
            // Increment the least-significant digit
            hex0_next = hex0 + 4'h1;
            bin_next = bin + 1'b1;
            // Handle 1nd digit overflow
            if (hex0 == 4'h9) begin
                hex0_next = 4'h0;
                hex1_next = hex1 + 4'h1;
                // Handle 2nd digit overflow
                if (hex1 == 4'h9) begin
                    hex1_next = 4'h0;
                    hex2_next = hex2 + 4'h1;
                    // Handle 3rd digit overflow
                    if (hex2 == 4'h9) begin
                        hex2_next = 4'h0;
                        hex3_next = hex3 + 4'h1;
                        // Saturate if hex3 reaches 10
                        // SSEG can only display up to 9999
                        if (hex3 == 4'h9)
                            hex3_next = 4'h9;
                    end
                end
            end
        end
    end

    // Sequential state update using nonblocking assignments
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hex3 <= 4'h0;
            hex2 <= 4'h0;
            hex1 <= 4'h0;
            hex0 <= 4'h0;
            bin <= 16'b0000000000000000;
        end else begin
            hex3 <= hex3_next;
            hex2 <= hex2_next;
            hex1 <= hex1_next;
            hex0 <= hex0_next;
            bin <= bin_next;
        end
    end

endmodule
