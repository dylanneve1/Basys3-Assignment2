`timescale 1ns / 1ps

module fsm_sequence_detector(input clk, sh_en, reset, i0, output reg match, output reg [2:0] state);
    // Regs for state and next_state
    reg [2:0] next_state;
    
    always @ (posedge clk or posedge reset) begin
        // If reset, reset state
        if (reset) begin
            state <= 3'b000;
        // Otherwise shift state to next state
        end else if (sh_en) begin
            state <= next_state;
        end
    end
    
    always @ * begin
        // Logic for FSM, detecting occurances of 010100 in bitstream
        case (state)
            3'b000: next_state = (i0 == 1'b0) ? 3'b001 : 3'b000; // i0 = 0 -> seen 0      | i0 = 1 -> seen 1      -> discard
            3'b001: next_state = (i0 == 1'b1) ? 3'b010 : 3'b001; // i0 = 1 -> seen 01     | i0 = 0 -> seen 00     -> seen 0    -> to 001
            3'b010: next_state = (i0 == 1'b0) ? 3'b011 : 3'b000; // i0 = 0 -> seen 010    | i0 = 1 -> seen 011    -> discard
            3'b011: next_state = (i0 == 1'b1) ? 3'b100 : 3'b001; // i0 = 1 -> seen 0101   | i0 = 0 -> seen 0100   -> seen 0    -> to 001
            3'b100: next_state = (i0 == 1'b0) ? 3'b101 : 3'b000; // i0 = 0 -> seen 01010  | i0 = 1 -> seen 01011  -> discard
            3'b101: next_state = (i0 == 1'b0) ? 3'b110 : 3'b100; // i0 = 0 -> seen 010100 | i0 = 1 -> seen 010101 -> seen 0101 -> to 100
            3'b110: next_state = (i0 == 1'b0) ? 3'b001 : 3'b000; // i0 = 0 -> seen 0      | i0 = 1 -> seen 1      -> discard
            default: next_state = 3'b000;
        endcase
    end
    
    always @ * begin
        if (sh_en) begin
            // If state is seen 010100 then assert match
            match = (state == 3'b110) ? 1'b1 : 1'b0;
        end
    end
endmodule
