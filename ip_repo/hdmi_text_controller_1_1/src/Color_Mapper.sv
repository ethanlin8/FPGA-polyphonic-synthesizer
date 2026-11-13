//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0]  DrawX, DrawY,
                       input  logic [31:0] doutb,
                       input  logic [31:0] palette_regs [8],
                       output logic [10:0]  bram_addr,
                       output logic [3:0]  Red, Green, Blue );

    logic [5:0] bram_col;
    logic [4:0] bram_row;
    
    assign bram_col = DrawX[9:4]; // DrawX / 16
    assign bram_row = DrawY[8:4]; // DrawY / 16
    assign bram_addr = (bram_row * 40) + bram_col; // (bram_row * 40) + bram_col
    
    logic char_select; // to select the char in the word
    logic [15:0] current_char; // the 2 bytes containing inverse bit, code, fgd idx, and bkg idx
    logic [6:0] code; // the code from current_char
    logic [3:0] fgd_idx; // fgd_idx from current_char
    logic [3:0] bkg_idx; // bkg_idx from current_char
    logic inverse_bit; // the inverse bit (msb) from current_char
    
    assign char_select = DrawX[3]; // msb from DrawX % 16
    
    always_comb begin
        case (char_select)
            1'b0: current_char = doutb[15:0]; // byte 0 and 1 (least significant char of word)
            1'b1: current_char = doutb[31:16]; // byte 2 and 3 (most significant char of word)
        endcase
    end
    
    assign inverse_bit = current_char[15];
    assign code = current_char[14:8];
    assign fgd_idx = current_char[7:4];
    assign bkg_idx = current_char[3:0];
    
    logic [10:0] font_addr; // 7-bit code to select glyph and 4 bits for glyph pixel row
    logic [7:0] font_data; // 8 glyph row pixel bits
    logic pixel; // pixel glyph bit
    
    assign font_addr = {code, DrawY[3:0]}; // font_addr = code * 16 + DrawY % 16
    
    // instantiate font_rom module
    font_rom font_rom_inst (
        .addr(font_addr),
        .data(font_data)
    );
    
    assign pixel = font_data[3'd7 - DrawX[2:0]]; // since font_rom is mirrored, pixel = 7 - DrawX % 8
        
    logic draw_foreground;
    assign draw_foreground = pixel ^ inverse_bit; // flip pixel if inverse bit is high
    
    logic [3:0] fgd_r, fgd_g, fgd_b, bkg_r, bkg_g, bkg_b;
    logic color_select_fgd;
    logic color_select_bkg;
    assign color_select_fgd = fgd_idx[0];
    assign color_select_bkg = bkg_idx[0];
    
    // get foreground and background colors from palette registers
    assign fgd_r = palette_regs[fgd_idx[3:1]][(color_select_fgd*16)+8+:4];
    assign fgd_g = palette_regs[fgd_idx[3:1]][(color_select_fgd*16)+4+:4];
    assign fgd_b = palette_regs[fgd_idx[3:1]][(color_select_fgd*16)+:4];
    assign bkg_r = palette_regs[bkg_idx[3:1]][(color_select_bkg*16)+8+:4];
    assign bkg_g = palette_regs[bkg_idx[3:1]][(color_select_bkg*16)+4+:4];
    assign bkg_b = palette_regs[bkg_idx[3:1]][(color_select_bkg*16)+:4];
    
    always_comb begin
        if (draw_foreground) begin
            Red = fgd_r;
            Green = fgd_g;
            Blue = fgd_b;
        end else begin
            Red = bkg_r;
            Green = bkg_g;
            Blue = bkg_b;
        end
    end
    
endmodule
