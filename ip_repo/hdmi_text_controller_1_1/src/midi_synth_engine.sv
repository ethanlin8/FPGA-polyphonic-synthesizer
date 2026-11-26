module midi_synth_engine (
    input  logic         Clk,
    input  logic         Reset,
    input  logic         event_valid,
    input  logic [23:0]  event_packet,
    input  logic [7:0]   voice_idle,
    output logic [255:0] tuning_words,
    output logic [55:0]  velocity_words,
    output logic [7:0]   voice_gate,
    output logic [7:0]   voice_sustained,
    output logic         voice_clear,
    output logic [87:0]  hw_active_keys,
    output logic [1:0]   wave_sel,
    output logic         sustain_pedal
);

    localparam integer NUM_VOICES = 8;

    logic [23:0] event_fifo [0:63];
    logic [5:0] fifo_write_ptr;
    logic [5:0] fifo_read_ptr;
    logic [6:0] fifo_count;
    logic fifo_pop;
    logic fifo_push;
    logic [23:0] fifo_event;
    logic allocation_stage_valid;
    logic [7:0] allocation_idle_mask;
    logic [7:0] allocation_release_mask;
    logic [7:0] allocation_sustain_mask;
    logic [7:0] allocation_active_mask;
    logic [6:0] allocation_note;
    logic [6:0] allocation_velocity;
    logic [7:0] age_older_comb [0:7];
    logic [7:0] age_older_stage [0:7];
    logic [7:0] release_oldest_mask;
    logic [7:0] sustain_oldest_mask;
    logic [7:0] active_oldest_mask;
    logic [2:0] selected_voice_next;
    logic selected_voice_valid;
    logic pending_note_on;
    logic [2:0] pending_voice;
    logic [6:0] pending_note;
    logic [6:0] pending_velocity;

    logic [6:0] voice_note [0:7];
    logic [31:0] voice_age [0:7];
    logic [31:0] base_tuning [0:7];
    logic [6:0] voice_velocity [0:7];
    logic [7:0] voice_assigned;
    logic [7:0] voice_key_down;
    logic [7:0] voice_gate_retrigger;
    logic [11:0] sustain_ms [0:7];
    logic [16:0] ms_counter;
    logic ms_tick;
    logic [31:0] age_counter;
    logic [13:0] pitch_bend;
    logic signed [14:0] pitch_delta;
    logic [16:0] pitch_factor;
    logic [32:0] pitch_low_product [0:7];
    logic [32:0] pitch_high_product [0:7];
    logic [48:0] pitch_product_sum [0:7];
    logic [31:0] tuning_word_reg [0:7];
    logic [6:0] folded_note;
    logic [7:0] sustained_match_mask;
    logic sustained_match_valid;
    logic [2:0] sustained_match_voice;

    integer voice;

    assign ms_tick = (ms_counter == 17'd99999);

    function automatic logic [31:0] note_tuning(input logic [6:0] note_index);
        begin
            case (note_index)
                7'd0: note_tuning = 32'h0000049D;
                7'd1: note_tuning = 32'h000004E3;
                7'd2: note_tuning = 32'h0000052E;
                7'd3: note_tuning = 32'h0000057D;
                7'd4: note_tuning = 32'h000005D0;
                7'd5: note_tuning = 32'h00000629;
                7'd6: note_tuning = 32'h00000686;
                7'd7: note_tuning = 32'h000006EA;
                7'd8: note_tuning = 32'h00000753;
                7'd9: note_tuning = 32'h000007C2;
                7'd10: note_tuning = 32'h00000839;
                7'd11: note_tuning = 32'h000008B6;
                7'd12: note_tuning = 32'h0000093A;
                7'd13: note_tuning = 32'h000009C7;
                7'd14: note_tuning = 32'h00000A5C;
                7'd15: note_tuning = 32'h00000AF9;
                7'd16: note_tuning = 32'h00000BA0;
                7'd17: note_tuning = 32'h00000C51;
                7'd18: note_tuning = 32'h00000D0D;
                7'd19: note_tuning = 32'h00000DD3;
                7'd20: note_tuning = 32'h00000EA6;
                7'd21: note_tuning = 32'h00000F85;
                7'd22: note_tuning = 32'h00001071;
                7'd23: note_tuning = 32'h0000116B;
                7'd24: note_tuning = 32'h00001274;
                7'd25: note_tuning = 32'h0000138D;
                7'd26: note_tuning = 32'h000014B7;
                7'd27: note_tuning = 32'h000015F2;
                7'd28: note_tuning = 32'h00001740;
                7'd29: note_tuning = 32'h000018A2;
                7'd30: note_tuning = 32'h00001A19;
                7'd31: note_tuning = 32'h00001BA7;
                7'd32: note_tuning = 32'h00001D4C;
                7'd33: note_tuning = 32'h00001F0A;
                7'd34: note_tuning = 32'h000020E2;
                7'd35: note_tuning = 32'h000022D7;
                7'd36: note_tuning = 32'h000024E9;
                7'd37: note_tuning = 32'h0000271B;
                7'd38: note_tuning = 32'h0000296E;
                7'd39: note_tuning = 32'h00002BE5;
                7'd40: note_tuning = 32'h00002E81;
                7'd41: note_tuning = 32'h00003145;
                7'd42: note_tuning = 32'h00003433;
                7'd43: note_tuning = 32'h0000374D;
                7'd44: note_tuning = 32'h00003A97;
                7'd45: note_tuning = 32'h00003E13;
                7'd46: note_tuning = 32'h000041C4;
                7'd47: note_tuning = 32'h000045AD;
                7'd48: note_tuning = 32'h000049D2;
                7'd49: note_tuning = 32'h00004E36;
                7'd50: note_tuning = 32'h000052DC;
                7'd51: note_tuning = 32'h000057C9;
                7'd52: note_tuning = 32'h00005D02;
                7'd53: note_tuning = 32'h0000628A;
                7'd54: note_tuning = 32'h00006866;
                7'd55: note_tuning = 32'h00006E9B;
                7'd56: note_tuning = 32'h0000752E;
                7'd57: note_tuning = 32'h00007C26;
                7'd58: note_tuning = 32'h00008388;
                7'd59: note_tuning = 32'h00008B5A;
                7'd60: note_tuning = 32'h000093A4;
                7'd61: note_tuning = 32'h00009C6B;
                7'd62: note_tuning = 32'h0000A5B8;
                7'd63: note_tuning = 32'h0000AF93;
                7'd64: note_tuning = 32'h0000BA04;
                7'd65: note_tuning = 32'h0000C513;
                7'd66: note_tuning = 32'h0000D0CB;
                7'd67: note_tuning = 32'h0000DD36;
                7'd68: note_tuning = 32'h0000EA5D;
                7'd69: note_tuning = 32'h0000F84D;
                7'd70: note_tuning = 32'h00010710;
                7'd71: note_tuning = 32'h000116B5;
                7'd72: note_tuning = 32'h00012747;
                7'd73: note_tuning = 32'h000138D6;
                7'd74: note_tuning = 32'h00014B71;
                7'd75: note_tuning = 32'h00015F26;
                7'd76: note_tuning = 32'h00017407;
                7'd77: note_tuning = 32'h00018A26;
                7'd78: note_tuning = 32'h0001A196;
                7'd79: note_tuning = 32'h0001BA6B;
                7'd80: note_tuning = 32'h0001D4BA;
                7'd81: note_tuning = 32'h0001F099;
                7'd82: note_tuning = 32'h00020E21;
                7'd83: note_tuning = 32'h00022D6A;
                7'd84: note_tuning = 32'h00024E8F;
                7'd85: note_tuning = 32'h000271AD;
                7'd86: note_tuning = 32'h000296E1;
                7'd87: note_tuning = 32'h0002BE4C;
                default: note_tuning = 32'd0;
            endcase
        end
    endfunction

    function automatic logic [6:0] fold_midi_note(input logic [6:0] midi_note);
        logic [6:0] folded;
        begin
            folded = midi_note;
            for (int octave = 0; octave < 8; octave++) begin
                if (folded < 7'd21)
                    folded = folded + 7'd12;
                else if (folded > 7'd108)
                    folded = folded - 7'd12;
            end
            fold_midi_note = folded;
        end
    endfunction

    function automatic logic age_is_older(
        input logic [31:0] age_a,
        input logic [31:0] age_b
    );
        age_is_older = $signed(age_a - age_b) < 0;
    endfunction

    assign fifo_pop = (fifo_count != 0) && !pending_note_on &&
                      !allocation_stage_valid;
    assign fifo_push = event_valid && ((fifo_count < 64) || fifo_pop);
    assign fifo_event = event_fifo[fifo_read_ptr];
    assign folded_note = fold_midi_note(fifo_event[14:8]);

    always_comb begin
        selected_voice_next = 3'd0;
        selected_voice_valid = 1'b0;
        release_oldest_mask = 8'd0;
        sustain_oldest_mask = 8'd0;
        active_oldest_mask = 8'd0;
        sustained_match_mask = 8'd0;
        sustained_match_valid = 1'b0;
        sustained_match_voice = 3'd0;

        for (int i = 0; i < 8; i++)
            age_older_comb[i] = 8'd0;

        for (int i = 0; i < 8; i++) begin
            for (int j = i + 1; j < 8; j++) begin
                age_older_comb[i][j] =
                    age_is_older(voice_age[i], voice_age[j]) ||
                    (voice_age[i] == voice_age[j]);
                age_older_comb[j][i] = !age_older_comb[i][j];
            end
        end

        for (int i = 0; i < 8; i++) begin
            if (allocation_idle_mask[i] && !selected_voice_valid) begin
                selected_voice_next = i[2:0];
                selected_voice_valid = 1'b1;
            end
        end

        for (int i = 0; i < 8; i++) begin
            if (allocation_release_mask[i]) begin
                release_oldest_mask[i] = 1'b1;
                for (int j = 0; j < 8; j++) begin
                    if (allocation_release_mask[j] && age_older_stage[j][i])
                        release_oldest_mask[i] = 1'b0;
                end
            end
            if (allocation_sustain_mask[i]) begin
                sustain_oldest_mask[i] = 1'b1;
                for (int j = 0; j < 8; j++) begin
                    if (allocation_sustain_mask[j] && age_older_stage[j][i])
                        sustain_oldest_mask[i] = 1'b0;
                end
            end
            if (allocation_active_mask[i]) begin
                active_oldest_mask[i] = 1'b1;
                for (int j = 0; j < 8; j++) begin
                    if (allocation_active_mask[j] && age_older_stage[j][i])
                        active_oldest_mask[i] = 1'b0;
                end
            end
        end

        if (fifo_count != 0 && fifo_event[23:20] == 4'h9 &&
            fifo_event[7:0] != 0) begin
            for (int i = 0; i < 8; i++) begin
                if (voice_assigned[i] && voice_sustained[i] &&
                    voice_note[i] == folded_note) begin
                    sustained_match_mask[i] = 1'b1;
                    if (!sustained_match_valid) begin
                        sustained_match_valid = 1'b1;
                        sustained_match_voice = i[2:0];
                    end
                end
            end
        end

        if (!selected_voice_valid) begin
            for (int i = 0; i < 8; i++) begin
                if (release_oldest_mask[i] && !selected_voice_valid) begin
                    selected_voice_next = i[2:0];
                    selected_voice_valid = 1'b1;
                end
            end
        end

        if (!selected_voice_valid) begin
            for (int i = 0; i < 8; i++) begin
                if (sustain_oldest_mask[i] && !selected_voice_valid) begin
                    selected_voice_next = i[2:0];
                    selected_voice_valid = 1'b1;
                end
            end
        end

        if (!selected_voice_valid) begin
            for (int i = 0; i < 8; i++) begin
                if (active_oldest_mask[i] && !selected_voice_valid) begin
                    selected_voice_next = i[2:0];
                    selected_voice_valid = 1'b1;
                end
            end
        end

        if (!selected_voice_valid)
            selected_voice_next = 3'd0;
    end

    always_comb begin
        pitch_delta = $signed({1'b0, pitch_bend}) - 15'sd8192;
        pitch_factor = 17'd65536 + pitch_delta;
        tuning_words = '0;
        velocity_words = '0;
        voice_gate = (voice_key_down | voice_sustained) & ~voice_gate_retrigger;
        hw_active_keys = '0;
        for (int i = 0; i < 8; i++) begin
            tuning_words[i*32 +: 32] = tuning_word_reg[i];
            velocity_words[i*7 +: 7] = voice_velocity[i];
            if (voice_gate[i] && !voice_sustained[i] &&
                voice_note[i] >= 7'd21 &&
                voice_note[i] <= 7'd108)
                hw_active_keys[voice_note[i] - 7'd21] = 1'b1;
        end
    end

    always_ff @(posedge Clk) begin
        if (Reset) begin
            fifo_write_ptr <= 0;
            fifo_read_ptr <= 0;
            fifo_count <= 0;
            age_counter <= 0;
            allocation_stage_valid <= 0;
            allocation_idle_mask <= 0;
            allocation_release_mask <= 0;
            allocation_sustain_mask <= 0;
            allocation_active_mask <= 0;
            allocation_note <= 0;
            allocation_velocity <= 0;
            pending_voice <= 0;
            pending_note <= 0;
            pending_velocity <= 0;
            pitch_bend <= 14'h2000;
            wave_sel <= 2'b01;
            voice_clear <= 0;
            pending_note_on <= 0;
            voice_assigned <= 0;
            voice_key_down <= 0;
            voice_sustained <= 0;
            voice_gate_retrigger <= 0;
            sustain_pedal <= 0;
            ms_counter <= 0;
            for (voice = 0; voice < 8; voice++) begin
                voice_note[voice] <= 0;
                voice_age[voice] <= 0;
                age_older_stage[voice] <= 0;
                base_tuning[voice] <= 0;
                voice_velocity[voice] <= 0;
                pitch_low_product[voice] <= 0;
                pitch_high_product[voice] <= 0;
                pitch_product_sum[voice] <= 0;
                tuning_word_reg[voice] <= 0;
                sustain_ms[voice] <= 0;
            end
        end else begin
            if (ms_tick)
                ms_counter <= 0;
            else
                ms_counter <= ms_counter + 1'b1;

            voice_clear <= 0;
            voice_gate_retrigger <= 0;
            allocation_stage_valid <= 0;
            pending_note_on <= 0;

            if (pending_note_on) begin
                voice_assigned[pending_voice] <= 1;
                if (voice_gate[pending_voice])
                    voice_gate_retrigger[pending_voice] <= 1;
                voice_key_down[pending_voice] <= 1;
                voice_sustained[pending_voice] <= 0;
                voice_note[pending_voice] <= pending_note;
                base_tuning[pending_voice] <=
                    note_tuning(pending_note - 7'd21);
                voice_velocity[pending_voice] <= pending_velocity;
                voice_age[pending_voice] <= age_counter;
                age_counter <= age_counter + 1'b1;
            end

            if (allocation_stage_valid) begin
                pending_note_on <= 1;
                pending_voice <= selected_voice_next;
                pending_note <= allocation_note;
                pending_velocity <= allocation_velocity;
            end

            if (fifo_push) begin
                event_fifo[fifo_write_ptr] <= event_packet;
                fifo_write_ptr <= fifo_write_ptr + 1'b1;
            end
            if (fifo_pop)
                fifo_read_ptr <= fifo_read_ptr + 1'b1;
            case ({fifo_push, fifo_pop})
                2'b10: fifo_count <= fifo_count + 1'b1;
                2'b01: fifo_count <= fifo_count - 1'b1;
                default: fifo_count <= fifo_count;
            endcase

            for (voice = 0; voice < 8; voice++) begin
                pitch_low_product[voice] <=
                    {17'd0, base_tuning[voice][15:0]} *
                    {16'd0, pitch_factor};
                pitch_high_product[voice] <=
                    {17'd0, base_tuning[voice][31:16]} *
                    {16'd0, pitch_factor};
                pitch_product_sum[voice] <=
                    {pitch_high_product[voice], 16'b0} +
                    {16'b0, pitch_low_product[voice]};
                tuning_word_reg[voice] <= pitch_product_sum[voice][47:16];

                if (voice_assigned[voice] && !voice_key_down[voice] &&
                    voice_idle[voice] &&
                    !(pending_note_on && (voice == pending_voice))) begin
                    voice_assigned[voice] <= 0;
                    base_tuning[voice] <= 0;
                    voice_velocity[voice] <= 0;
                end

                if (pending_note_on && (voice == pending_voice)) begin
                    sustain_ms[voice] <= 0;
                end else if (!voice_sustained[voice]) begin
                    sustain_ms[voice] <= 0;
                end else if (voice_idle[voice] ||
                             sustain_ms[voice] >= 12'd1100) begin
                    voice_sustained[voice] <= 0;
                    voice_key_down[voice] <= 0;
                    sustain_ms[voice] <= 0;
                end else if (ms_tick) begin
                    sustain_ms[voice] <= sustain_ms[voice] + 1'b1;
                end
            end

            if (fifo_pop) begin
                case (fifo_event[23:20])
                    4'h8, 4'h9: begin
                        if ((fifo_event[23:20] == 4'h8) ||
                            (fifo_event[7:0] == 0)) begin
                            for (voice = 0; voice < 8; voice++) begin
                                if (voice_assigned[voice] &&
                                    voice_note[voice] == folded_note) begin
                                    if (sustain_pedal) begin
                                        voice_key_down[voice] <= 0;
                                        voice_sustained[voice] <= 1;
                                    end else begin
                                        voice_key_down[voice] <= 0;
                                        voice_sustained[voice] <= 0;
                                    end
                                end
                            end
                        end else begin
                            if (sustained_match_valid) begin
                                pending_note_on <= 1;
                                pending_voice <= sustained_match_voice;
                                pending_note <= folded_note;
                                pending_velocity <= fifo_event[6:0];
                            end else begin
                                allocation_stage_valid <= 1;
                                allocation_idle_mask <=
                                    voice_idle & ~voice_key_down & ~voice_sustained;
                                allocation_note <= folded_note;
                                allocation_velocity <= fifo_event[6:0];
                                for (voice = 0; voice < 8; voice++) begin
                                    allocation_release_mask[voice] <=
                                        voice_assigned[voice] &&
                                        !voice_gate[voice] &&
                                        !voice_gate_retrigger[voice];
                                    allocation_sustain_mask[voice] <=
                                        voice_assigned[voice] && voice_sustained[voice];
                                    allocation_active_mask[voice] <=
                                        voice_assigned[voice] && voice_gate[voice] &&
                                        !voice_sustained[voice];
                                    age_older_stage[voice] <= age_older_comb[voice];
                                end
                            end
                        end
                    end
                    4'hB: begin
                        if (fifo_event[15:8] == 8'd64) begin
                            if (fifo_event[7:0] >= 8'd64)
                                sustain_pedal <= 1'b1;
                            else begin
                                sustain_pedal <= 1'b0;
                                for (voice = 0; voice < 8; voice++) begin
                                    if (voice_sustained[voice]) begin
                                        voice_sustained[voice] <= 1'b0;
                                        voice_key_down[voice] <= 1'b0;
                                    end
                                end
                            end
                        end else if (fifo_event[15:8] == 8'd121) begin
                            sustain_pedal <= 1'b0;
                            for (voice = 0; voice < 8; voice++) begin
                                if (voice_sustained[voice]) begin
                                    voice_sustained[voice] <= 1'b0;
                                    voice_key_down[voice] <= 1'b0;
                                end
                            end
                        end else if (fifo_event[15:8] == 8'd120 ||
                                     fifo_event[15:8] == 8'd123) begin
                            voice_clear <= 1;
                            sustain_pedal <= 1'b0;
                            voice_assigned <= 0;
                            voice_key_down <= 0;
                            voice_sustained <= 0;
                            for (voice = 0; voice < 8; voice++) begin
                                base_tuning[voice] <= 0;
                                voice_velocity[voice] <= 0;
                            end
                        end
                    end
                    4'hC: wave_sel <= fifo_event[9:8];
                    4'hE: pitch_bend <= {fifo_event[6:0], fifo_event[14:8]};
                    4'hF: begin
                        if (fifo_event[23:16] == 8'hFF) begin
                            voice_clear <= 1;
                            sustain_pedal <= 0;
                            voice_assigned <= 0;
                            voice_key_down <= 0;
                            voice_sustained <= 0;
                            for (voice = 0; voice < 8; voice++) begin
                                base_tuning[voice] <= 0;
                                voice_velocity[voice] <= 0;
                            end
                        end
                    end
                    default: begin
                    end
                endcase
            end
        end
    end
endmodule
