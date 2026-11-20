module piano_mapper (
    input  logic        Clk,
    input  logic        Reset,
    input  logic [9:0]  DrawX,
    input  logic [9:0]  DrawY,
    input  logic        blank,
    input  logic [63:0] active_keys,
    output logic [3:0]  Red,
    output logic [3:0]  Green,
    output logic [3:0]  Blue
);

    logic [5:0] white_idx;
    logic [4:0] sub_x;
    logic [2:0] octave_note;
    logic [5:0] octave_base;
    logic [5:0] white_key_idx;
    logic [5:0] black_key_idx;
    logic left_black;
    logic right_black;
    logic black_hit;

    function automatic logic [3:0] white_offset(input logic [2:0] note);
        case (note)
            3'd0: white_offset = 4'd0;
            3'd1: white_offset = 4'd2;
            3'd2: white_offset = 4'd4;
            3'd3: white_offset = 4'd5;
            3'd4: white_offset = 4'd7;
            3'd5: white_offset = 4'd9;
            default: white_offset = 4'd11;
        endcase
    endfunction

    always_ff @(posedge Clk) begin
        if (Reset) begin
            white_idx <= 6'd0;
            sub_x <= 5'd0;
            octave_note <= 3'd0;
            octave_base <= 6'd0;
        end else if (DrawX == 10'd13) begin
            // DrawX is registered by the VGA counter, so preload the x=14 state.
            white_idx <= 6'd0;
            sub_x <= 5'd0;
            octave_note <= 3'd0;
            octave_base <= 6'd0;
        end else if ((DrawX >= 10'd14) && (DrawX < 10'd625)) begin
            if (sub_x == 5'd16) begin
                sub_x <= 5'd0;
                if (white_idx < 6'd35) begin
                    white_idx <= white_idx + 6'd1;
                    if (octave_note == 3'd6) begin
                        octave_note <= 3'd0;
                        if (octave_base < 6'd60)
                            octave_base <= octave_base + 6'd12;
                    end else begin
                        octave_note <= octave_note + 3'd1;
                    end
                end
            end else begin
                sub_x <= sub_x + 5'd1;
            end
        end
    end

    always_comb begin
        Red = 4'h1;
        Green = 4'h1;
        Blue = 4'h3;
        white_key_idx = octave_base + white_offset(octave_note);
        black_key_idx = 6'd0;
        left_black = 1'b0;
        right_black = 1'b0;
        black_hit = 1'b0;

        if (blank) begin
            {Red, Green, Blue} = 12'h000;
        end else if (DrawY < 10'd260) begin
            if ((DrawX >= 10'd40) && (DrawX < 10'd600) &&
                (DrawY >= 10'd240) && (DrawY < 10'd248))
                {Red, Green, Blue} = 12'h26A;
        end else if (DrawY < 10'd480) begin
            if (DrawX == 10'd626) begin
                {Red, Green, Blue} = 12'h444;
            end else if ((DrawX >= 10'd14) && (DrawX <= 10'd625)) begin
                left_black = (white_idx < 6'd35) &&
                             ((octave_note == 3'd0) || (octave_note == 3'd1) ||
                              (octave_note == 3'd3) || (octave_note == 3'd4) ||
                              (octave_note == 3'd5)) &&
                             (sub_x >= 5'd12);
                right_black = (white_idx > 6'd0) &&
                              ((octave_note == 3'd1) || (octave_note == 3'd2) ||
                               (octave_note == 3'd4) || (octave_note == 3'd5) ||
                               (octave_note == 3'd6)) &&
                              (sub_x <= 5'd4);

                if (left_black) begin
                    black_hit = 1'b1;
                    black_key_idx = white_key_idx + 6'd1;
                end else if (right_black) begin
                    black_hit = 1'b1;
                    black_key_idx = white_key_idx - 6'd1;
                end

                if ((DrawY < 10'd390) && black_hit) begin
                    if (active_keys[black_key_idx])
                        {Red, Green, Blue} = 12'hF80;
                    else
                        {Red, Green, Blue} = 12'h111;
                end else if (sub_x == 5'd0) begin
                    {Red, Green, Blue} = 12'h444;
                end else if (active_keys[white_key_idx]) begin
                    {Red, Green, Blue} = 12'hF80;
                end else begin
                    {Red, Green, Blue} = 12'hFFF;
                end
            end
        end
    end

endmodule
