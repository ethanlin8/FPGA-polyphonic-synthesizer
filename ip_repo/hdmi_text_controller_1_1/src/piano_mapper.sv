module piano_mapper (
    input  logic        Clk,
    input  logic        Reset,
    input  logic [9:0]  DrawX,
    input  logic [9:0]  DrawY,
    input  logic        blank,
    input  logic [87:0] active_keys,
    input  logic [7:0]  scope_sample,
    input  logic [7:0]  scope_previous_sample,
    input  logic        scope_valid,
    input  logic [1:0]  wave_sel,
    input  logic [7:0]  voice_gate,
    input  logic [31:0] adsr_config,
    input  logic [4:0]  firmware_status,
    output logic [3:0] Red,
    output logic [3:0] Green,
    output logic [3:0] Blue
);

    logic [5:0] white_idx;
    logic [3:0] local_x;
    logic [3:0] octave_note_index;
    logic [6:0] white_midi_counter;
    logic [6:0] white_note;
    logic [6:0] current_black_note;
    logic [6:0] previous_black_note;
    logic [6:0] black_note;
    logic black_hit;
    logic [3:0] text_index;
    logic [1:0] text_column;
    logic [2:0] text_row;
    logic [7:0] text_character;
    logic text_active;
    logic [9:0] sample_y;
    logic [9:0] previous_sample_y;
    logic [9:0] trace_top;
    logic [9:0] trace_bottom;
    logic trace_pixel;
    logic [7:0] sample_value;
    logic [7:0] previous_sample_value;

    function automatic logic [2:0] white_interval(input logic [3:0] note_index);
        case (note_index)
            4'd11, 4'd4: white_interval = 3'd1;
            default: white_interval = 3'd2;
        endcase
    endfunction

    function automatic logic [6:0] black_after_white(input logic [5:0] index);
        case (index)
            6'd0:  black_after_white = 7'd22;
            6'd2:  black_after_white = 7'd25;
            6'd3:  black_after_white = 7'd27;
            6'd5:  black_after_white = 7'd30;
            6'd6:  black_after_white = 7'd32;
            6'd7:  black_after_white = 7'd34;
            6'd9:  black_after_white = 7'd37;
            6'd10: black_after_white = 7'd39;
            6'd12: black_after_white = 7'd42;
            6'd13: black_after_white = 7'd44;
            6'd14: black_after_white = 7'd46;
            6'd16: black_after_white = 7'd49;
            6'd17: black_after_white = 7'd51;
            6'd19: black_after_white = 7'd54;
            6'd20: black_after_white = 7'd56;
            6'd21: black_after_white = 7'd58;
            6'd23: black_after_white = 7'd61;
            6'd24: black_after_white = 7'd63;
            6'd26: black_after_white = 7'd66;
            6'd27: black_after_white = 7'd68;
            6'd28: black_after_white = 7'd70;
            6'd30: black_after_white = 7'd73;
            6'd31: black_after_white = 7'd75;
            6'd33: black_after_white = 7'd78;
            6'd34: black_after_white = 7'd80;
            6'd35: black_after_white = 7'd82;
            6'd37: black_after_white = 7'd85;
            6'd38: black_after_white = 7'd87;
            6'd40: black_after_white = 7'd90;
            6'd41: black_after_white = 7'd92;
            6'd42: black_after_white = 7'd94;
            6'd44: black_after_white = 7'd97;
            6'd45: black_after_white = 7'd99;
            6'd47: black_after_white = 7'd102;
            6'd48: black_after_white = 7'd104;
            6'd49: black_after_white = 7'd106;
            default: black_after_white = 7'd0;
        endcase
    endfunction

    function automatic logic [2:0] font_row(
        input logic [7:0] character,
        input logic [2:0] row
    );
        begin
            font_row = 3'b000;
            case (character)
                "A": case (row) 0: font_row=3'b111; 1: font_row=3'b101; 2: font_row=3'b111; 3: font_row=3'b101; 4: font_row=3'b101; endcase
                "B": case (row) 0: font_row=3'b110; 1: font_row=3'b101; 2: font_row=3'b110; 3: font_row=3'b101; 4: font_row=3'b110; endcase
                "C": case (row) 0: font_row=3'b111; 1: font_row=3'b100; 2: font_row=3'b100; 3: font_row=3'b100; 4: font_row=3'b111; endcase
                "D": case (row) 0: font_row=3'b110; 1: font_row=3'b101; 2: font_row=3'b101; 3: font_row=3'b101; 4: font_row=3'b110; endcase
                "E": case (row) 0: font_row=3'b111; 1: font_row=3'b100; 2: font_row=3'b110; 3: font_row=3'b100; 4: font_row=3'b111; endcase
                "G": case (row) 0: font_row=3'b111; 1: font_row=3'b100; 2: font_row=3'b101; 3: font_row=3'b101; 4: font_row=3'b111; endcase
                "I": case (row) 0: font_row=3'b111; 1: font_row=3'b010; 2: font_row=3'b010; 3: font_row=3'b010; 4: font_row=3'b111; endcase
                "L": case (row) 0: font_row=3'b100; 1: font_row=3'b100; 2: font_row=3'b100; 3: font_row=3'b100; 4: font_row=3'b111; endcase
                "N": case (row) 0: font_row=3'b101; 1: font_row=3'b111; 2: font_row=3'b111; 3: font_row=3'b111; 4: font_row=3'b101; endcase
                "O": case (row) 0: font_row=3'b111; 1: font_row=3'b101; 2: font_row=3'b101; 3: font_row=3'b101; 4: font_row=3'b111; endcase
                "P": case (row) 0: font_row=3'b110; 1: font_row=3'b101; 2: font_row=3'b110; 3: font_row=3'b100; 4: font_row=3'b100; endcase
                "Q": case (row) 0: font_row=3'b111; 1: font_row=3'b101; 2: font_row=3'b101; 3: font_row=3'b111; 4: font_row=3'b001; endcase
                "R": case (row) 0: font_row=3'b110; 1: font_row=3'b101; 2: font_row=3'b110; 3: font_row=3'b101; 4: font_row=3'b101; endcase
                "S": case (row) 0: font_row=3'b111; 1: font_row=3'b100; 2: font_row=3'b111; 3: font_row=3'b001; 4: font_row=3'b111; endcase
                "T": case (row) 0: font_row=3'b111; 1: font_row=3'b010; 2: font_row=3'b010; 3: font_row=3'b010; 4: font_row=3'b010; endcase
                "V": case (row) 0: font_row=3'b101; 1: font_row=3'b101; 2: font_row=3'b101; 3: font_row=3'b101; 4: font_row=3'b010; endcase
                "W": case (row) 0: font_row=3'b101; 1: font_row=3'b101; 2: font_row=3'b111; 3: font_row=3'b111; 4: font_row=3'b101; endcase
                "Y": case (row) 0: font_row=3'b101; 1: font_row=3'b101; 2: font_row=3'b010; 3: font_row=3'b010; 4: font_row=3'b010; endcase
                "0": case (row) 0: font_row=3'b111; 1: font_row=3'b101; 2: font_row=3'b101; 3: font_row=3'b101; 4: font_row=3'b111; endcase
                "1": case (row) 0: font_row=3'b010; 1: font_row=3'b110; 2: font_row=3'b010; 3: font_row=3'b010; 4: font_row=3'b111; endcase
                "2": case (row) 0: font_row=3'b110; 1: font_row=3'b001; 2: font_row=3'b010; 3: font_row=3'b100; 4: font_row=3'b111; endcase
                "3": case (row) 0: font_row=3'b110; 1: font_row=3'b001; 2: font_row=3'b010; 3: font_row=3'b001; 4: font_row=3'b110; endcase
                "4": case (row) 0: font_row=3'b101; 1: font_row=3'b101; 2: font_row=3'b111; 3: font_row=3'b001; 4: font_row=3'b001; endcase
                "5": case (row) 0: font_row=3'b111; 1: font_row=3'b100; 2: font_row=3'b110; 3: font_row=3'b001; 4: font_row=3'b110; endcase
                "6": case (row) 0: font_row=3'b011; 1: font_row=3'b100; 2: font_row=3'b110; 3: font_row=3'b101; 4: font_row=3'b111; endcase
                "7": case (row) 0: font_row=3'b111; 1: font_row=3'b001; 2: font_row=3'b010; 3: font_row=3'b010; 4: font_row=3'b010; endcase
                "8": case (row) 0: font_row=3'b111; 1: font_row=3'b101; 2: font_row=3'b111; 3: font_row=3'b101; 4: font_row=3'b111; endcase
                default: font_row = 3'b000;
            endcase
        end
    endfunction

    function automatic logic font_pixel(
        input logic [7:0] character,
        input logic [2:0] row,
        input logic [1:0] column
    );
        logic [2:0] bits;
        begin
            bits = font_row(character, row);
            font_pixel = (column < 3) ? bits[2-column] : 1'b0;
        end
    endfunction

    function automatic logic [9:0] sample_to_y(input logic [7:0] sample);
        logic signed [8:0] delta;
        logic signed [11:0] scaled;
        begin
            delta = $signed({1'b0, sample}) - 9'sd128;
            scaled = (delta * 12'sd5) >>> 3;
            sample_to_y = 10'sd160 - scaled;
        end
    endfunction

    always_ff @(posedge Clk) begin
        if (Reset) begin
            white_idx <= 6'd0;
            local_x <= 4'd0;
            octave_note_index <= 4'd9;
            white_midi_counter <= 7'd21;
        end else if (DrawX == 10'd7) begin
            white_idx <= 6'd0;
            local_x <= 4'd0;
            octave_note_index <= 4'd9;
            white_midi_counter <= 7'd21;
        end else if ((DrawX >= 10'd8) && (DrawX < 10'd631)) begin
            if (local_x == 4'd11) begin
                local_x <= 4'd0;
                if (white_idx < 6'd51) begin
                    white_idx <= white_idx + 1'b1;
                    white_midi_counter <= white_midi_counter +
                                          white_interval(octave_note_index);
                    if (octave_note_index == 4'd11)
                        octave_note_index <= 4'd0;
                    else
                        octave_note_index <= octave_note_index +
                                             white_interval(octave_note_index);
                end
            end else begin
                local_x <= local_x + 1'b1;
            end
        end
    end

    always_comb begin
        Red = 4'h1;
        Green = 4'h1;
        Blue = 4'h3;
        white_note = white_midi_counter;
        current_black_note = black_after_white(white_idx);
        previous_black_note = (white_idx == 0) ? 7'd0 :
                              black_after_white(white_idx - 1'b1);
        black_note = 7'd0;
        black_hit = 1'b0;

        sample_value = scope_valid ? scope_sample : 8'd128;
        previous_sample_value = scope_valid ? scope_previous_sample : 8'd128;
        sample_y = sample_to_y(sample_value);
        previous_sample_y = sample_to_y(previous_sample_value);
        trace_top = (sample_y < previous_sample_y) ? sample_y : previous_sample_y;
        trace_bottom = (sample_y > previous_sample_y) ? sample_y : previous_sample_y;
        trace_pixel = 1'b0;
        text_active = 1'b0;
        text_index = 4'd0;
        text_column = 2'd0;
        text_row = 3'd0;
        text_character = 8'd0;

        if (DrawY < 10'd64) begin
            if ((DrawY >= 10'd12) && (DrawY < 10'd18) &&
                (DrawX >= 10'd8) && (DrawX < 10'd24)) begin
                text_active = 1'b1;
                text_index = (DrawX - 10'd8) >> 2;
                text_column = (DrawX - 10'd8) & 2'b11;
                text_row = DrawY - 10'd12;
                case (text_index)
                    0: text_character = "W";
                    1: text_character = "A";
                    2: text_character = "V";
                    3: text_character = "E";
                    default: text_character = 0;
                endcase
            end else if ((DrawY >= 10'd12) && (DrawY < 10'd18) &&
                         (DrawX >= 10'd32) && (DrawX < 10'd48)) begin
                text_active = 1'b1;
                text_index = (DrawX - 10'd32) >> 2;
                text_column = (DrawX - 10'd32) & 2'b11;
                text_row = DrawY - 10'd12;
                case (wave_sel)
                    0: case (text_index) 0: text_character="S"; 1: text_character="I"; 2: text_character="N"; 3: text_character="E"; default: text_character=0; endcase
                    1: case (text_index) 0: text_character="S"; 1: text_character="A"; 2: text_character="W"; 3: text_character=0; default: text_character=0; endcase
                    default: case (text_index) 0: text_character="S"; 1: text_character="Q"; 2: text_character="R"; 3: text_character=0; default: text_character=0; endcase
                endcase
                {Red, Green, Blue} = 12'h062;
            end else if ((DrawY >= 10'd12) && (DrawY < 10'd18) &&
                         (DrawX >= 10'd78) && (DrawX < 10'd98)) begin
                text_active = 1'b1;
                text_index = (DrawX - 10'd78) >> 2;
                text_column = (DrawX - 10'd78) & 2'b11;
                text_row = DrawY - 10'd12;
                case (text_index)
                    0: text_character = "V";
                    1: text_character = "O";
                    2: text_character = "I";
                    3: text_character = "C";
                    4: text_character = "E";
                    default: text_character = 0;
                endcase
            end else if ((DrawY >= 10'd12) && (DrawY < 10'd18) &&
                         (DrawX >= 10'd326) && (DrawX < 10'd350)) begin
                text_active = 1'b1;
                text_index = (DrawX - 10'd326) >> 2;
                text_column = (DrawX - 10'd326) & 2'b11;
                text_row = DrawY - 10'd12;
                case (text_index)
                    0: text_character = "O";
                    1: text_character = "C";
                    2: text_character = "T";
                    3: text_character = 8'h20;
                    4: text_character = "C";
                    5: text_character = 8'd50 + firmware_status[2:0];
                    default: text_character = 0;
                endcase
            end else if ((DrawY >= 10'd12) && (DrawY < 10'd18) &&
                         (DrawX >= 10'd410) && (DrawX < 10'd426)) begin
                text_active = 1'b1;
                text_index = (DrawX - 10'd410) >> 2;
                text_column = (DrawX - 10'd410) & 2'b11;
                text_row = DrawY - 10'd12;
                case (firmware_status[4:3])
                    0: case (text_index) 0: text_character="I"; 1: text_character="D"; 2: text_character="L"; 3: text_character="E"; default: text_character=0; endcase
                    1: case (text_index) 0: text_character="S"; 1: text_character="O"; 2: text_character="N"; 3: text_character="G"; default: text_character=0; endcase
                    2: case (text_index) 0: text_character="R"; 1: text_character="E"; 2: text_character="C"; 3: text_character=0; default: text_character=0; endcase
                    default: case (text_index) 0: text_character="L"; 1: text_character="O"; 2: text_character="O"; 3: text_character="P"; default: text_character=0; endcase
                endcase
            end

            if (text_active && font_pixel(text_character, text_row, text_column)) begin
                {Red, Green, Blue} = 12'hCDE;
            end

            if ((DrawY >= 10'd13) && (DrawY < 10'd20)) begin
                for (int led = 0; led < 8; led++) begin
                    if ((DrawX >= (10'd108 + led*12)) &&
                        (DrawX < (10'd116 + led*12))) begin
                        if (voice_gate[led])
                            {Red, Green, Blue} = 12'h4F8;
                        else
                            {Red, Green, Blue} = 12'h334;
                    end
                end
            end

            if ((DrawY >= 10'd22) && (DrawY < 10'd50)) begin
                case (DrawY)
                    22,23,24,25,26: begin
                        if (DrawX >= 10'd250 && DrawX < 10'd254 &&
                            font_pixel("A", DrawY - 10'd22, DrawX-10'd250))
                            {Red, Green, Blue} = 12'hCDE;
                        if (DrawX >= 10'd264 && DrawX < 10'd324 &&
                            (DrawX-10'd264) < ((adsr_config[7:0] * 8'd60) >> 8))
                            {Red, Green, Blue} = 12'h4A8;
                    end
                    29,30,31,32,33: begin
                        if (DrawX >= 10'd250 && DrawX < 10'd254 &&
                            font_pixel("D", DrawY - 10'd29, DrawX-10'd250))
                            {Red, Green, Blue} = 12'hCDE;
                        if (DrawX >= 10'd264 && DrawX < 10'd324 &&
                            (DrawX-10'd264) < ((adsr_config[15:8] * 8'd60) >> 8))
                            {Red, Green, Blue} = 12'h4A8;
                    end
                    36,37,38,39,40: begin
                        if (DrawX >= 10'd250 && DrawX < 10'd254 &&
                            font_pixel("S", DrawY - 10'd36, DrawX-10'd250))
                            {Red, Green, Blue} = 12'hCDE;
                        if (DrawX >= 10'd264 && DrawX < 10'd324 &&
                            (DrawX-10'd264) < ((adsr_config[23:16] * 8'd60) >> 8))
                            {Red, Green, Blue} = 12'h4A8;
                    end
                    43,44,45,46,47: begin
                        if (DrawX >= 10'd250 && DrawX < 10'd254 &&
                            font_pixel("R", DrawY - 10'd43, DrawX-10'd250))
                            {Red, Green, Blue} = 12'hCDE;
                        if (DrawX >= 10'd264 && DrawX < 10'd324 &&
                            (DrawX-10'd264) < ((adsr_config[31:24] * 8'd60) >> 8))
                            {Red, Green, Blue} = 12'h4A8;
                    end
                    default: begin
                    end
                endcase
            end
        end else if ((DrawX >= 10'd64) && (DrawX <= 10'd575) &&
                     (DrawY >= 10'd72) && (DrawY <= 10'd247)) begin
            {Red, Green, Blue} = 12'h041;
            if ((DrawY == 10'd160) ||
                (DrawX == 10'd64) || (DrawX == 10'd575) ||
                (DrawY == 10'd72) || (DrawY == 10'd247))
                {Red, Green, Blue} = 12'h174;
            if ((DrawY >= trace_top) && (DrawY <= trace_bottom))
                trace_pixel = 1'b1;
            if (trace_pixel)
                {Red, Green, Blue} = 12'h5FC;
        end else if ((DrawY >= 10'd268) && (DrawY < 10'd460) &&
                     (DrawX >= 10'd8) && (DrawX < 10'd632)) begin
            if ((DrawX >= 10'd8) && (DrawX < 10'd632)) begin
                if ((local_x >= 4'd8) && (current_black_note != 0)) begin
                    black_hit = 1'b1;
                    black_note = current_black_note;
                end else if ((local_x <= 4'd2) && (white_idx != 0) &&
                             (previous_black_note != 0)) begin
                    black_hit = 1'b1;
                    black_note = previous_black_note;
                end

                if ((DrawY < 10'd386) && black_hit) begin
                    if (active_keys[black_note - 7'd21])
                        {Red, Green, Blue} = 12'hF80;
                    else
                        {Red, Green, Blue} = 12'h111;
                end else if (local_x == 0) begin
                    {Red, Green, Blue} = 12'h444;
                end else if (active_keys[white_note - 7'd21]) begin
                    {Red, Green, Blue} = 12'hF80;
                end else begin
                    {Red, Green, Blue} = 12'hFFF;
                end
            end
        end

        if (blank)
            {Red, Green, Blue} = 12'h000;
    end

endmodule
