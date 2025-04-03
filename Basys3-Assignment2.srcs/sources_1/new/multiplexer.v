`timescale 1ns / 1ps

module multiplexer(input [19:0] Q_state, input sel, output reg [9:0] out);
    // Calculate which value should be passed to out based on sel
    
    always @(*) begin
        case(sel)
            1'b0: out = Q_state[19:10];
            1'b1: out = Q_state[9:0];
        endcase
    end
endmodule
