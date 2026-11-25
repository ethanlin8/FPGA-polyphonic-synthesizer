module poly_synth_core (
    input  logic         Clk,
    input  logic         Reset,
    input  logic [255:0] tuning_words,
    input  logic [7:0]   voice_gate,
    input  logic [55:0]  velocity_words,
    input  logic         voice_clear,
    input  logic [31:0]  adsr_config,
    input  logic [1:0]   wave_sel,
    output logic [7:0]   voice_idle,
    output logic [7:0]   scope_sample,
    output logic         scope_sample_tick,
    output logic         audio_out
);

    logic [31:0] phase_acc [0:7];
    logic signed [15:0] sine_rom [0:255];
    logic signed [15:0] voice_wave [0:7];
    logic signed [15:0] voice_sample_reg [0:7];
    logic [6:0] voice_velocity_reg [0:7];
    logic [15:0] envelope_sample_reg [0:7];
    logic [15:0] envelope_level [0:7];
    logic signed [23:0] voice_velocity_product [0:7];
    logic [15:0] stage1_envelope [0:7];
    logic signed [40:0] voice_env_product [0:7];
    logic [2:0] envelope_state [0:7];
    logic [16:0] envelope_elapsed [0:7];
    logic [15:0] envelope_fraction [0:7];
    logic [31:0] envelope_step_q16 [0:7];
    logic [31:0] step_dividend [0:7];
    logic [31:0] step_div_quotient [0:7];
    logic [16:0] step_divisor [0:7];
    logic [17:0] step_div_remainder [0:7];
    logic [5:0] step_div_remaining [0:7];
    logic [7:0] step_div_active;
    logic [31:0] step_div_quotient_next [0:7];
    logic [17:0] step_div_remainder_next [0:7];
    logic [16:0] envelope_fraction_add [0:7];
    logic [16:0] envelope_fraction_sub [0:7];
    logic [7:0] prev_gate;
    logic [7:0] voice_running;
    logic envelope_sample_tick;
    logic [10:0] envelope_clock_divider;
    logic signed [23:0] voice_scaled [0:7];
    logic signed [23:0] voice_scaled_next [0:7];
    logic signed [24:0] pair_sum [0:3];
    logic signed [24:0] pair_sum_next [0:3];
    logic signed [25:0] quad_sum [0:1];
    logic signed [25:0] quad_sum_next [0:1];
    logic signed [26:0] mix_sum_next;
    logic signed [19:0] clipped_next;
    logic signed [19:0] clipped_sample;
    logic signed [15:0] dac_sample;
    logic [15:0] x_unsigned;
    logic [15:0] x_clamped;
    logic [15:0] x_clamped_next;
    logic signed [19:0] e1_ext;
    logic signed [19:0] e2_ext;
    logic signed [19:0] y_unq;
    logic signed [19:0] y_unq_reg;
    logic signed [19:0] err_wide;
    logic signed [17:0] e1;
    logic signed [17:0] e2;
    logic signed [17:0] err;
    logic modulator_phase;
    logic modulator_silence;
    logic dout;
    logic [7:0] attack_units;
    logic [7:0] decay_units;
    logic [7:0] sustain_level;
    logic [7:0] release_units;
    logic [15:0] sustain_target;
    logic [16:0] attack_samples;
    logic [16:0] decay_samples;
    logic [16:0] release_samples;
    logic [16:0] attack_samples_next;
    logic [16:0] decay_samples_next;
    logic [16:0] release_samples_next;

    localparam logic [2:0] ENV_IDLE = 3'd0;
    localparam logic [2:0] ENV_ATTACK = 3'd1;
    localparam logic [2:0] ENV_DECAY = 3'd2;
    localparam logic [2:0] ENV_SUSTAIN = 3'd3;
    localparam logic [2:0] ENV_RELEASE = 3'd4;

    function automatic logic [16:0] duration_to_samples(input logic [7:0] duration_10ms);
        logic [21:0] scaled_duration;
        begin
            scaled_duration = (duration_10ms * 22'd15625) + 22'd16;
            duration_to_samples = scaled_duration[21:5];
            if (duration_to_samples == 0)
                duration_to_samples = 17'd1;
        end
    endfunction

    initial begin
        sine_rom[0] = 16'sd0;
        sine_rom[1] = 16'sd804;
        sine_rom[2] = 16'sd1608;
        sine_rom[3] = 16'sd2410;
        sine_rom[4] = 16'sd3212;
        sine_rom[5] = 16'sd4011;
        sine_rom[6] = 16'sd4808;
        sine_rom[7] = 16'sd5602;
        sine_rom[8] = 16'sd6393;
        sine_rom[9] = 16'sd7179;
        sine_rom[10] = 16'sd7962;
        sine_rom[11] = 16'sd8739;
        sine_rom[12] = 16'sd9512;
        sine_rom[13] = 16'sd10278;
        sine_rom[14] = 16'sd11039;
        sine_rom[15] = 16'sd11793;
        sine_rom[16] = 16'sd12539;
        sine_rom[17] = 16'sd13279;
        sine_rom[18] = 16'sd14010;
        sine_rom[19] = 16'sd14732;
        sine_rom[20] = 16'sd15446;
        sine_rom[21] = 16'sd16151;
        sine_rom[22] = 16'sd16846;
        sine_rom[23] = 16'sd17530;
        sine_rom[24] = 16'sd18204;
        sine_rom[25] = 16'sd18868;
        sine_rom[26] = 16'sd19519;
        sine_rom[27] = 16'sd20159;
        sine_rom[28] = 16'sd20787;
        sine_rom[29] = 16'sd21403;
        sine_rom[30] = 16'sd22005;
        sine_rom[31] = 16'sd22594;
        sine_rom[32] = 16'sd23170;
        sine_rom[33] = 16'sd23731;
        sine_rom[34] = 16'sd24279;
        sine_rom[35] = 16'sd24811;
        sine_rom[36] = 16'sd25329;
        sine_rom[37] = 16'sd25832;
        sine_rom[38] = 16'sd26319;
        sine_rom[39] = 16'sd26790;
        sine_rom[40] = 16'sd27245;
        sine_rom[41] = 16'sd27683;
        sine_rom[42] = 16'sd28105;
        sine_rom[43] = 16'sd28510;
        sine_rom[44] = 16'sd28898;
        sine_rom[45] = 16'sd29268;
        sine_rom[46] = 16'sd29621;
        sine_rom[47] = 16'sd29956;
        sine_rom[48] = 16'sd30273;
        sine_rom[49] = 16'sd30571;
        sine_rom[50] = 16'sd30852;
        sine_rom[51] = 16'sd31113;
        sine_rom[52] = 16'sd31356;
        sine_rom[53] = 16'sd31580;
        sine_rom[54] = 16'sd31785;
        sine_rom[55] = 16'sd31971;
        sine_rom[56] = 16'sd32137;
        sine_rom[57] = 16'sd32285;
        sine_rom[58] = 16'sd32412;
        sine_rom[59] = 16'sd32521;
        sine_rom[60] = 16'sd32609;
        sine_rom[61] = 16'sd32678;
        sine_rom[62] = 16'sd32728;
        sine_rom[63] = 16'sd32757;
        sine_rom[64] = 16'sd32767;
        sine_rom[65] = 16'sd32757;
        sine_rom[66] = 16'sd32728;
        sine_rom[67] = 16'sd32678;
        sine_rom[68] = 16'sd32609;
        sine_rom[69] = 16'sd32521;
        sine_rom[70] = 16'sd32412;
        sine_rom[71] = 16'sd32285;
        sine_rom[72] = 16'sd32137;
        sine_rom[73] = 16'sd31971;
        sine_rom[74] = 16'sd31785;
        sine_rom[75] = 16'sd31580;
        sine_rom[76] = 16'sd31356;
        sine_rom[77] = 16'sd31113;
        sine_rom[78] = 16'sd30852;
        sine_rom[79] = 16'sd30571;
        sine_rom[80] = 16'sd30273;
        sine_rom[81] = 16'sd29956;
        sine_rom[82] = 16'sd29621;
        sine_rom[83] = 16'sd29268;
        sine_rom[84] = 16'sd28898;
        sine_rom[85] = 16'sd28510;
        sine_rom[86] = 16'sd28105;
        sine_rom[87] = 16'sd27683;
        sine_rom[88] = 16'sd27245;
        sine_rom[89] = 16'sd26790;
        sine_rom[90] = 16'sd26319;
        sine_rom[91] = 16'sd25832;
        sine_rom[92] = 16'sd25329;
        sine_rom[93] = 16'sd24811;
        sine_rom[94] = 16'sd24279;
        sine_rom[95] = 16'sd23731;
        sine_rom[96] = 16'sd23170;
        sine_rom[97] = 16'sd22594;
        sine_rom[98] = 16'sd22005;
        sine_rom[99] = 16'sd21403;
        sine_rom[100] = 16'sd20787;
        sine_rom[101] = 16'sd20159;
        sine_rom[102] = 16'sd19519;
        sine_rom[103] = 16'sd18868;
        sine_rom[104] = 16'sd18204;
        sine_rom[105] = 16'sd17530;
        sine_rom[106] = 16'sd16846;
        sine_rom[107] = 16'sd16151;
        sine_rom[108] = 16'sd15446;
        sine_rom[109] = 16'sd14732;
        sine_rom[110] = 16'sd14010;
        sine_rom[111] = 16'sd13279;
        sine_rom[112] = 16'sd12539;
        sine_rom[113] = 16'sd11793;
        sine_rom[114] = 16'sd11039;
        sine_rom[115] = 16'sd10278;
        sine_rom[116] = 16'sd9512;
        sine_rom[117] = 16'sd8739;
        sine_rom[118] = 16'sd7962;
        sine_rom[119] = 16'sd7179;
        sine_rom[120] = 16'sd6393;
        sine_rom[121] = 16'sd5602;
        sine_rom[122] = 16'sd4808;
        sine_rom[123] = 16'sd4011;
        sine_rom[124] = 16'sd3212;
        sine_rom[125] = 16'sd2410;
        sine_rom[126] = 16'sd1608;
        sine_rom[127] = 16'sd804;
        sine_rom[128] = 16'sd0;
        sine_rom[129] = -16'sd804;
        sine_rom[130] = -16'sd1608;
        sine_rom[131] = -16'sd2410;
        sine_rom[132] = -16'sd3212;
        sine_rom[133] = -16'sd4011;
        sine_rom[134] = -16'sd4808;
        sine_rom[135] = -16'sd5602;
        sine_rom[136] = -16'sd6393;
        sine_rom[137] = -16'sd7179;
        sine_rom[138] = -16'sd7962;
        sine_rom[139] = -16'sd8739;
        sine_rom[140] = -16'sd9512;
        sine_rom[141] = -16'sd10278;
        sine_rom[142] = -16'sd11039;
        sine_rom[143] = -16'sd11793;
        sine_rom[144] = -16'sd12539;
        sine_rom[145] = -16'sd13279;
        sine_rom[146] = -16'sd14010;
        sine_rom[147] = -16'sd14732;
        sine_rom[148] = -16'sd15446;
        sine_rom[149] = -16'sd16151;
        sine_rom[150] = -16'sd16846;
        sine_rom[151] = -16'sd17530;
        sine_rom[152] = -16'sd18204;
        sine_rom[153] = -16'sd18868;
        sine_rom[154] = -16'sd19519;
        sine_rom[155] = -16'sd20159;
        sine_rom[156] = -16'sd20787;
        sine_rom[157] = -16'sd21403;
        sine_rom[158] = -16'sd22005;
        sine_rom[159] = -16'sd22594;
        sine_rom[160] = -16'sd23170;
        sine_rom[161] = -16'sd23731;
        sine_rom[162] = -16'sd24279;
        sine_rom[163] = -16'sd24811;
        sine_rom[164] = -16'sd25329;
        sine_rom[165] = -16'sd25832;
        sine_rom[166] = -16'sd26319;
        sine_rom[167] = -16'sd26790;
        sine_rom[168] = -16'sd27245;
        sine_rom[169] = -16'sd27683;
        sine_rom[170] = -16'sd28105;
        sine_rom[171] = -16'sd28510;
        sine_rom[172] = -16'sd28898;
        sine_rom[173] = -16'sd29268;
        sine_rom[174] = -16'sd29621;
        sine_rom[175] = -16'sd29956;
        sine_rom[176] = -16'sd30273;
        sine_rom[177] = -16'sd30571;
        sine_rom[178] = -16'sd30852;
        sine_rom[179] = -16'sd31113;
        sine_rom[180] = -16'sd31356;
        sine_rom[181] = -16'sd31580;
        sine_rom[182] = -16'sd31785;
        sine_rom[183] = -16'sd31971;
        sine_rom[184] = -16'sd32137;
        sine_rom[185] = -16'sd32285;
        sine_rom[186] = -16'sd32412;
        sine_rom[187] = -16'sd32521;
        sine_rom[188] = -16'sd32609;
        sine_rom[189] = -16'sd32678;
        sine_rom[190] = -16'sd32728;
        sine_rom[191] = -16'sd32757;
        sine_rom[192] = -16'sd32767;
        sine_rom[193] = -16'sd32757;
        sine_rom[194] = -16'sd32728;
        sine_rom[195] = -16'sd32678;
        sine_rom[196] = -16'sd32609;
        sine_rom[197] = -16'sd32521;
        sine_rom[198] = -16'sd32412;
        sine_rom[199] = -16'sd32285;
        sine_rom[200] = -16'sd32137;
        sine_rom[201] = -16'sd31971;
        sine_rom[202] = -16'sd31785;
        sine_rom[203] = -16'sd31580;
        sine_rom[204] = -16'sd31356;
        sine_rom[205] = -16'sd31113;
        sine_rom[206] = -16'sd30852;
        sine_rom[207] = -16'sd30571;
        sine_rom[208] = -16'sd30273;
        sine_rom[209] = -16'sd29956;
        sine_rom[210] = -16'sd29621;
        sine_rom[211] = -16'sd29268;
        sine_rom[212] = -16'sd28898;
        sine_rom[213] = -16'sd28510;
        sine_rom[214] = -16'sd28105;
        sine_rom[215] = -16'sd27683;
        sine_rom[216] = -16'sd27245;
        sine_rom[217] = -16'sd26790;
        sine_rom[218] = -16'sd26319;
        sine_rom[219] = -16'sd25832;
        sine_rom[220] = -16'sd25329;
        sine_rom[221] = -16'sd24811;
        sine_rom[222] = -16'sd24279;
        sine_rom[223] = -16'sd23731;
        sine_rom[224] = -16'sd23170;
        sine_rom[225] = -16'sd22594;
        sine_rom[226] = -16'sd22005;
        sine_rom[227] = -16'sd21403;
        sine_rom[228] = -16'sd20787;
        sine_rom[229] = -16'sd20159;
        sine_rom[230] = -16'sd19519;
        sine_rom[231] = -16'sd18868;
        sine_rom[232] = -16'sd18204;
        sine_rom[233] = -16'sd17530;
        sine_rom[234] = -16'sd16846;
        sine_rom[235] = -16'sd16151;
        sine_rom[236] = -16'sd15446;
        sine_rom[237] = -16'sd14732;
        sine_rom[238] = -16'sd14010;
        sine_rom[239] = -16'sd13279;
        sine_rom[240] = -16'sd12539;
        sine_rom[241] = -16'sd11793;
        sine_rom[242] = -16'sd11039;
        sine_rom[243] = -16'sd10278;
        sine_rom[244] = -16'sd9512;
        sine_rom[245] = -16'sd8739;
        sine_rom[246] = -16'sd7962;
        sine_rom[247] = -16'sd7179;
        sine_rom[248] = -16'sd6393;
        sine_rom[249] = -16'sd5602;
        sine_rom[250] = -16'sd4808;
        sine_rom[251] = -16'sd4011;
        sine_rom[252] = -16'sd3212;
        sine_rom[253] = -16'sd2410;
        sine_rom[254] = -16'sd1608;
        sine_rom[255] = -16'sd804;
    end

    always_comb begin
        attack_units = (adsr_config[7:0] == 0) ? 8'd1 : adsr_config[7:0];
        decay_units = (adsr_config[15:8] == 0) ? 8'd1 : adsr_config[15:8];
        sustain_level = adsr_config[23:16];
        release_units = (adsr_config[31:24] == 0) ? 8'd1 : adsr_config[31:24];
        sustain_target = {sustain_level, sustain_level};
        attack_samples_next = duration_to_samples(attack_units);
        decay_samples_next = duration_to_samples(decay_units);
        release_samples_next = duration_to_samples(release_units);
        envelope_sample_tick = (envelope_clock_divider == 11'd2047);

        for (int voice = 0; voice < 8; voice++) begin
            voice_running[voice] = voice_gate[voice] ||
                                   (envelope_state[voice] != ENV_IDLE);
            envelope_fraction_add[voice] =
                {1'b0, envelope_fraction[voice]} +
                {1'b0, envelope_step_q16[voice][15:0]};
            envelope_fraction_sub[voice] =
                {1'b0, envelope_fraction[voice]} -
                {1'b0, envelope_step_q16[voice][15:0]};
            step_div_remainder_next[voice] =
                {step_div_remainder[voice][16:0], step_dividend[voice][31]};
            step_div_quotient_next[voice] =
                {step_div_quotient[voice][30:0], 1'b0};
            if (step_div_remainder_next[voice] >= {1'b0, step_divisor[voice]}) begin
                step_div_remainder_next[voice] =
                    step_div_remainder_next[voice] - {1'b0, step_divisor[voice]};
                step_div_quotient_next[voice][0] = 1'b1;
            end
            voice_idle[voice] = (envelope_state[voice] == ENV_IDLE);
            voice_wave[voice] = 16'sd0;
            if (voice_running[voice]) begin
                case (wave_sel)
                    2'b00: voice_wave[voice] = sine_rom[phase_acc[voice][31:24]];
                    2'b01: voice_wave[voice] = $signed(phase_acc[voice][31:16]);
                    2'b10: voice_wave[voice] =
                               phase_acc[voice][31] ? 16'sh7FFF : 16'sh8000;
                    default: voice_wave[voice] = sine_rom[phase_acc[voice][31:24]];
                endcase
            end

            voice_env_product[voice] =
                $signed({{17{voice_velocity_product[voice][23]}},
                         voice_velocity_product[voice]}) *
                $signed({24'd0, 1'b0, stage1_envelope[voice]});
            voice_scaled_next[voice] = voice_env_product[voice] >>> 23;
        end

        for (int pair = 0; pair < 4; pair++) begin
            pair_sum_next[pair] =
                $signed({voice_scaled[pair*2][23], voice_scaled[pair*2]}) +
                $signed({voice_scaled[pair*2+1][23], voice_scaled[pair*2+1]});
        end
        quad_sum_next[0] =
            $signed({pair_sum[0][24], pair_sum[0]}) +
            $signed({pair_sum[1][24], pair_sum[1]});
        quad_sum_next[1] =
            $signed({pair_sum[2][24], pair_sum[2]}) +
            $signed({pair_sum[3][24], pair_sum[3]});
        mix_sum_next =
            $signed({quad_sum[0][25], quad_sum[0]}) +
            $signed({quad_sum[1][25], quad_sum[1]});

        if (mix_sum_next > 27'sd524287)
            clipped_next = 20'sh7FFFF;
        else if (mix_sum_next < -27'sd524288)
            clipped_next = 20'sh80000;
        else
            clipped_next = mix_sum_next[19:0];

        if (clipped_sample > 20'sd32767)
            dac_sample = 16'sh7FFF;
        else if (clipped_sample < -20'sd32768)
            dac_sample = 16'sh8000;
        else
            dac_sample = clipped_sample[15:0];
        x_unsigned = $unsigned(dac_sample) ^ 16'h8000;
        if (x_unsigned < 16'd2048)
            x_clamped_next = 16'd2048;
        else if (x_unsigned > 16'd63487)
            x_clamped_next = 16'd63487;
        else
            x_clamped_next = x_unsigned;

        e1_ext = {{2{e1[17]}}, e1};
        e2_ext = {{2{e2[17]}}, e2};
        y_unq = $signed({4'b0000, x_clamped}) +
                e1_ext + (e1_ext >>> 1) - (e2_ext >>> 1);
        if (modulator_silence) begin
            dout = ~audio_out;
            err_wide = 20'sd0;
        end else begin
            dout = y_unq_reg >= 20'sd32768;
            err_wide = y_unq_reg - (dout ? 20'sd65535 : 20'sd0);
        end

        if (err_wide > 20'sd131071)
            err = 18'sh1FFFF;
        else if (err_wide < -20'sd131072)
            err = 18'sh20000;
        else
            err = err_wide[17:0];
    end

    always_comb begin
        scope_sample = dac_sample[15:8] ^ 8'h80;
        scope_sample_tick = envelope_sample_tick;
    end

    always_ff @(posedge Clk) begin
        if (Reset) begin
            envelope_clock_divider <= 0;
            prev_gate <= 0;
            attack_samples <= 17'd1953;
            decay_samples <= 17'd8790;
            release_samples <= 17'd19531;
            for (int voice = 0; voice < 8; voice++) begin
                phase_acc[voice] <= 0;
                envelope_state[voice] <= ENV_IDLE;
                envelope_level[voice] <= 0;
                envelope_fraction[voice] <= 0;
                envelope_elapsed[voice] <= 0;
                envelope_step_q16[voice] <= 0;
                step_dividend[voice] <= 0;
                step_div_quotient[voice] <= 0;
                step_divisor[voice] <= 0;
                step_div_remainder[voice] <= 0;
                step_div_remaining[voice] <= 0;
                step_div_active[voice] <= 0;
                voice_sample_reg[voice] <= 0;
                voice_velocity_reg[voice] <= 0;
                envelope_sample_reg[voice] <= 0;
                voice_velocity_product[voice] <= 0;
                stage1_envelope[voice] <= 0;
                voice_scaled[voice] <= 0;
            end
            for (int pair = 0; pair < 4; pair++)
                pair_sum[pair] <= 0;
            for (int quad = 0; quad < 2; quad++)
                quad_sum[quad] <= 0;
        end else begin
            prev_gate <= voice_gate;
            if (envelope_sample_tick)
                envelope_clock_divider <= 0;
            else
                envelope_clock_divider <= envelope_clock_divider + 1'b1;
            attack_samples <= attack_samples_next;
            decay_samples <= decay_samples_next;
            release_samples <= release_samples_next;

            for (int voice = 0; voice < 8; voice++) begin
                if (voice_running[voice])
                    phase_acc[voice] <=
                        phase_acc[voice] + tuning_words[voice*32 +: 32];
                else
                    phase_acc[voice] <= 0;

                if (step_div_active[voice]) begin
                    step_dividend[voice] <= {step_dividend[voice][30:0], 1'b0};
                    step_div_quotient[voice] <= step_div_quotient_next[voice];
                    step_div_remainder[voice] <= step_div_remainder_next[voice];
                    if (step_div_remaining[voice] == 6'd1) begin
                        step_div_active[voice] <= 0;
                        step_div_remaining[voice] <= 0;
                        envelope_step_q16[voice] <=
                            step_div_quotient_next[voice];
                    end else begin
                        step_div_remaining[voice] <=
                            step_div_remaining[voice] - 1'b1;
                    end
                end

                voice_sample_reg[voice] <=
                    voice_running[voice] ? voice_wave[voice] : 16'sd0;
                voice_velocity_reg[voice] <=
                    voice_running[voice] ? velocity_words[voice*7 +: 7] : 7'd0;
                envelope_sample_reg[voice] <=
                    voice_running[voice] ? envelope_level[voice] : 16'd0;
                voice_velocity_product[voice] <=
                    $signed({{8{voice_sample_reg[voice][15]}},
                             voice_sample_reg[voice]}) *
                    $signed({16'd0, 1'b0, voice_velocity_reg[voice]});
                stage1_envelope[voice] <= envelope_sample_reg[voice];
                voice_scaled[voice] <= voice_scaled_next[voice];

                if (voice_clear) begin
                    envelope_state[voice] <= ENV_IDLE;
                    envelope_level[voice] <= 0;
                    envelope_fraction[voice] <= 0;
                    envelope_elapsed[voice] <= 0;
                    envelope_step_q16[voice] <= 0;
                    step_div_active[voice] <= 0;
                end else if (voice_gate[voice] && !prev_gate[voice]) begin
                    envelope_state[voice] <= ENV_ATTACK;
                    envelope_level[voice] <= 0;
                    envelope_fraction[voice] <= 0;
                    envelope_elapsed[voice] <= 0;
                    step_dividend[voice] <= {16'hFFFF, 16'b0};
                    step_div_quotient[voice] <= 0;
                    step_divisor[voice] <= attack_samples;
                    step_div_remainder[voice] <= 0;
                    step_div_remaining[voice] <= 6'd32;
                    step_div_active[voice] <= 1;
                end else if (!voice_gate[voice] && prev_gate[voice]) begin
                    if (envelope_level[voice] == 0 &&
                        envelope_fraction[voice] == 0) begin
                        envelope_state[voice] <= ENV_IDLE;
                        envelope_elapsed[voice] <= 0;
                        envelope_step_q16[voice] <= 0;
                        step_div_active[voice] <= 0;
                    end else begin
                        envelope_state[voice] <= ENV_RELEASE;
                        envelope_elapsed[voice] <= 0;
                        step_dividend[voice] <=
                            {envelope_level[voice], 16'b0};
                        step_div_quotient[voice] <= 0;
                        step_divisor[voice] <= release_samples;
                        step_div_remainder[voice] <= 0;
                        step_div_remaining[voice] <= 6'd32;
                        step_div_active[voice] <= 1;
                    end
                end else if (envelope_sample_tick) begin
                    case (envelope_state[voice])
                        ENV_IDLE: begin
                            envelope_level[voice] <= 0;
                            envelope_fraction[voice] <= 0;
                            envelope_elapsed[voice] <= 0;
                        end
                        ENV_ATTACK: begin
                            if ((envelope_elapsed[voice] + 1'b1) >= attack_samples) begin
                                envelope_level[voice] <= 16'hFFFF;
                                envelope_fraction[voice] <= 0;
                                envelope_state[voice] <=
                                    (sustain_target == 16'hFFFF) ? ENV_SUSTAIN : ENV_DECAY;
                                envelope_elapsed[voice] <= 0;
                                step_dividend[voice] <=
                                    {(16'hFFFF - sustain_target), 16'b0};
                                step_div_quotient[voice] <= 0;
                                step_divisor[voice] <= decay_samples;
                                step_div_remainder[voice] <= 0;
                                step_div_remaining[voice] <= 6'd32;
                                step_div_active[voice] <= 1;
                            end else begin
                                envelope_level[voice] <=
                                    envelope_level[voice] +
                                    envelope_step_q16[voice][31:16] +
                                    envelope_fraction_add[voice][16];
                                envelope_fraction[voice] <=
                                    envelope_fraction_add[voice][15:0];
                                envelope_elapsed[voice] <=
                                    envelope_elapsed[voice] + 1'b1;
                            end
                        end
                        ENV_DECAY: begin
                            if ((envelope_elapsed[voice] + 1'b1) >= decay_samples) begin
                                envelope_level[voice] <= sustain_target;
                                envelope_fraction[voice] <= 0;
                                envelope_state[voice] <= ENV_SUSTAIN;
                                envelope_elapsed[voice] <= 0;
                            end else begin
                                envelope_level[voice] <=
                                    envelope_level[voice] -
                                    envelope_step_q16[voice][31:16] -
                                    envelope_fraction_sub[voice][16];
                                envelope_fraction[voice] <=
                                    envelope_fraction_sub[voice][15:0];
                                envelope_elapsed[voice] <=
                                    envelope_elapsed[voice] + 1'b1;
                            end
                        end
                        ENV_SUSTAIN: begin
                            envelope_level[voice] <= sustain_target;
                            envelope_fraction[voice] <= 0;
                            envelope_elapsed[voice] <= 0;
                        end
                        ENV_RELEASE: begin
                            if ((envelope_elapsed[voice] + 1'b1) >= release_samples) begin
                                envelope_level[voice] <= 0;
                                envelope_fraction[voice] <= 0;
                                envelope_state[voice] <= ENV_IDLE;
                                envelope_elapsed[voice] <= 0;
                            end else begin
                                envelope_level[voice] <=
                                    envelope_level[voice] -
                                    envelope_step_q16[voice][31:16] -
                                    envelope_fraction_sub[voice][16];
                                envelope_fraction[voice] <=
                                    envelope_fraction_sub[voice][15:0];
                                envelope_elapsed[voice] <=
                                    envelope_elapsed[voice] + 1'b1;
                            end
                        end
                        default: begin
                            envelope_state[voice] <= ENV_IDLE;
                            envelope_level[voice] <= 0;
                            envelope_fraction[voice] <= 0;
                            envelope_elapsed[voice] <= 0;
                            envelope_step_q16[voice] <= 0;
                            step_div_active[voice] <= 0;
                        end
                    endcase
                end
            end
            for (int pair = 0; pair < 4; pair++)
                pair_sum[pair] <= pair_sum_next[pair];
            for (int quad = 0; quad < 2; quad++)
                quad_sum[quad] <= quad_sum_next[quad];
        end
    end

    always_ff @(posedge Clk) begin
        if (Reset) begin
            clipped_sample <= 20'sd0;
            x_clamped <= 16'd32768;
        end else begin
            clipped_sample <= clipped_next;
            x_clamped <= x_clamped_next;
        end
    end

    always_ff @(posedge Clk) begin
        if (Reset) begin
            e1 <= 0;
            e2 <= 0;
            y_unq_reg <= 20'sd32768;
            modulator_phase <= 0;
            modulator_silence <= 1;
            audio_out <= 0;
        end else if (!modulator_phase) begin
            y_unq_reg <= y_unq;
            modulator_silence <= (x_clamped == 16'd32768);
            modulator_phase <= 1;
        end else begin
            modulator_phase <= 0;
            if (modulator_silence) begin
                e1 <= 0;
                e2 <= 0;
                audio_out <= ~audio_out;
            end else begin
                e2 <= e1;
                e1 <= err;
                audio_out <= dout;
            end
        end
    end

endmodule
