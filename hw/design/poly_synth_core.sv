module poly_synth_core (
    input  logic         Clk,
    input  logic         Reset,
    input  logic [255:0] tuning_words,
    input  logic [7:0]   voice_gate,
    input  logic [1:0]   wave_sel,
    output logic         audio_out
);

    logic [31:0] phase_acc [0:7];
    logic signed [15:0] sine_rom [0:255];
    logic signed [15:0] voice_wave [0:7];
    logic signed [15:0] voice_scaled [0:7];
    logic signed [16:0] pair_sum [0:3];
    logic signed [17:0] quad_sum [0:1];
    logic signed [19:0] mix_sum;
    logic signed [15:0] clipped_next;
    logic signed [15:0] clipped_sample;
    logic [15:0] x_unsigned;
    logic [15:0] x_clamped;
    logic signed [19:0] e1_ext;
    logic signed [19:0] e2_ext;
    logic signed [19:0] y_unq;
    logic signed [19:0] err_wide;
    logic signed [17:0] e1;
    logic signed [17:0] e2;
    logic signed [17:0] err;
    logic dout;

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
        for (int voice = 0; voice < 8; voice++) begin
            voice_wave[voice] = 16'sd0;
            if (voice_gate[voice]) begin
                case (wave_sel)
                    2'b00: voice_wave[voice] = sine_rom[phase_acc[voice][31:24]];
                    2'b01: voice_wave[voice] = $signed(phase_acc[voice][31:16]);
                    2'b10: voice_wave[voice] = phase_acc[voice][31] ? 16'sh7FFF : 16'sh8000;
                    default: voice_wave[voice] = sine_rom[phase_acc[voice][31:24]];
                endcase
            end
        end

        for (int pair = 0; pair < 4; pair++) begin
            pair_sum[pair] =
                $signed({voice_scaled[pair*2][15], voice_scaled[pair*2]}) +
                $signed({voice_scaled[pair*2+1][15], voice_scaled[pair*2+1]});
        end
        quad_sum[0] =
            $signed({pair_sum[0][16], pair_sum[0]}) +
            $signed({pair_sum[1][16], pair_sum[1]});
        quad_sum[1] =
            $signed({pair_sum[2][16], pair_sum[2]}) +
            $signed({pair_sum[3][16], pair_sum[3]});
        mix_sum =
            $signed({{2{quad_sum[0][17]}}, quad_sum[0]}) +
            $signed({{2{quad_sum[1][17]}}, quad_sum[1]});

        if (mix_sum > 20'sd32767)
            clipped_next = 16'sh7FFF;
        else if (mix_sum < -20'sd32768)
            clipped_next = 16'sh8000;
        else
            clipped_next = mix_sum[15:0];

        x_unsigned = $unsigned(clipped_sample) ^ 16'h8000;
        if (x_unsigned < 16'd2048)
            x_clamped = 16'd2048;
        else if (x_unsigned > 16'd63487)
            x_clamped = 16'd63487;
        else
            x_clamped = x_unsigned;

        e1_ext = {{2{e1[17]}}, e1};
        e2_ext = {{2{e2[17]}}, e2};
        // 1.5/-0.5 taps keep 18-bit state bounded; 2/-1 wrapped in simulation.
        y_unq = $signed({4'b0000, x_clamped}) +
                e1_ext + (e1_ext >>> 1) - (e2_ext >>> 1);
        if (x_clamped == 16'd32768) begin
            // Alternate at exact silence to guarantee a 50% DAC duty cycle.
            dout = ~audio_out;
            err_wide = 20'sd0;
        end else begin
            dout = y_unq >= 20'sd32768;
            err_wide = y_unq - (dout ? 20'sd65535 : 20'sd0);
        end

        if (err_wide > 20'sd131071)
            err = 18'sh1FFFF;
        else if (err_wide < -20'sd131072)
            err = 18'sh20000;
        else
            err = err_wide[17:0];
    end

    always_ff @(posedge Clk) begin
        if (Reset) begin
            for (int voice = 0; voice < 8; voice++) begin
                phase_acc[voice] <= 32'd0;
                voice_scaled[voice] <= 16'sd0;
            end
        end else begin
            for (int voice = 0; voice < 8; voice++) begin
                voice_scaled[voice] <= $signed(voice_wave[voice]) >>> 1;
                if (voice_gate[voice])
                    phase_acc[voice] <= phase_acc[voice] + tuning_words[voice*32 +: 32];
                else
                    phase_acc[voice] <= 32'd0;
            end
        end
    end

    always_ff @(posedge Clk) begin
        if (Reset)
            clipped_sample <= 16'sd0;
        else
            clipped_sample <= clipped_next;
    end

    always_ff @(posedge Clk) begin
        if (Reset) begin
            e1 <= 18'sd0;
            e2 <= 18'sd0;
            audio_out <= 1'b0;
        end else if (x_clamped == 16'd32768) begin
            e1 <= 18'sd0;
            e2 <= 18'sd0;
            audio_out <= dout;
        end else begin
            e2 <= e1;
            e1 <= err;
            audio_out <= dout;
        end
    end

endmodule
