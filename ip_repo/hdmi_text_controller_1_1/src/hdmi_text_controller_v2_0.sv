//Provided HDMI_Text_controller_v1_0 for HDMI AXI4 IP 
//Fall 2024 Distribution

//Modified 3/10/24 by Zuofu
//Updated 11/18/24 by Zuofu


`timescale 1 ns / 1 ps

module hdmi_text_controller_v2_0 #
(
    // Parameters of Axi Slave Bus Interface S00_AXI
    // Modify parameters as necessary for access of full VRAM range

    parameter integer C_AXI_DATA_WIDTH	= 32,
    parameter integer C_AXI_ADDR_WIDTH	= 16 // 12 bits are needed for 604 registers with 4 bytes per register
)
(
    // Users to add ports here
    
    output logic hdmi_clk_n,
    output logic hdmi_clk_p,
    output logic [2:0] hdmi_tx_n,
    output logic [2:0] hdmi_tx_p,
    output logic audio_out,

    // User ports ends
    // Do not modify the ports beyond this line


    // Ports of Axi Slave Bus Interface AXI
    input logic  axi_aclk,
    input logic  axi_aresetn,
    input logic [C_AXI_ADDR_WIDTH-1 : 0] axi_awaddr,
    input logic [2 : 0] axi_awprot,
    input logic  axi_awvalid,
    output logic  axi_awready,
    input logic [C_AXI_DATA_WIDTH-1 : 0] axi_wdata,
    input logic [(C_AXI_DATA_WIDTH/8)-1 : 0] axi_wstrb,
    input logic  axi_wvalid,
    output logic  axi_wready,
    output logic [1 : 0] axi_bresp,
    output logic  axi_bvalid,
    input logic  axi_bready,
    input logic [C_AXI_ADDR_WIDTH-1 : 0] axi_araddr,
    input logic [2 : 0] axi_arprot,
    input logic  axi_arvalid,
    output logic  axi_arready,
    output logic [C_AXI_DATA_WIDTH-1 : 0] axi_rdata,
    output logic [1 : 0] axi_rresp,
    output logic  axi_rvalid,
    input logic  axi_rready
);

//additional logic variables as necessary to support VGA, and HDMI modules.
    logic clk_25MHz, clk_125MHz, clk, clk_100MHz;
    logic locked;
    logic [9:0] drawX, drawY;

    logic hsync, vsync, vde;
    logic [3:0] red, green, blue;
    logic Clk;
    logic reset_ah;
    logic [10:0] bram_addr;
    logic [C_AXI_DATA_WIDTH-1:0] doutb;
    logic [C_AXI_DATA_WIDTH-1:0] palette_regs [8];
    logic [63:0] active_keys;
    (* ASYNC_REG = "TRUE" *) logic [63:0] active_keys_sync1;
    (* ASYNC_REG = "TRUE" *) logic [63:0] active_keys_sync2;
    (* ASYNC_REG = "TRUE" *) logic [60:0] hw_active_keys_sync1;
    (* ASYNC_REG = "TRUE" *) logic [60:0] hw_active_keys_sync2;
    logic [63:0] display_active_keys;
    logic [255:0] tuning_words;
    logic [7:0] voice_gate;
    logic [1:0] wave_sel;
    logic wave_override_enable;
    logic midi_event_valid;
    logic [23:0] midi_event_packet;
    logic [31:0] adsr_config;
    logic [255:0] engine_tuning_words;
    logic [55:0] velocity_words;
    logic [7:0] engine_voice_gate;
    logic voice_clear;
    logic [7:0] voice_idle;
    logic [60:0] hw_active_keys;
    logic [1:0] engine_wave_sel;
    logic [1:0] selected_wave;

    assign bram_addr = 11'b0;
    assign display_active_keys = active_keys_sync2 |
                                 {3'b000, hw_active_keys_sync2};
    assign selected_wave = wave_override_enable ? wave_sel : engine_wave_sel;
    
    assign Clk = axi_aclk;
    assign reset_ah = ~axi_aresetn;

    always_ff @(posedge clk_25MHz) begin
        if (reset_ah) begin
            active_keys_sync1 <= 0;
            active_keys_sync2 <= 0;
            hw_active_keys_sync1 <= 0;
            hw_active_keys_sync2 <= 0;
        end else begin
            active_keys_sync1 <= active_keys;
            active_keys_sync2 <= active_keys_sync1;
            hw_active_keys_sync1 <= hw_active_keys;
            hw_active_keys_sync2 <= hw_active_keys_sync1;
        end
    end

// Instantiation of Axi Bus Interface AXI
hdmi_text_controller_v2_0_AXI # ( 
    .C_S_AXI_DATA_WIDTH(C_AXI_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_AXI_ADDR_WIDTH)
) hdmi_text_controller_v2_0_AXI_inst (
    .S_AXI_ACLK(axi_aclk),
    .S_AXI_ARESETN(axi_aresetn),
    .S_AXI_AWADDR(axi_awaddr),
    .S_AXI_AWPROT(axi_awprot),
    .S_AXI_AWVALID(axi_awvalid),
    .S_AXI_AWREADY(axi_awready),
    .S_AXI_WDATA(axi_wdata),
    .S_AXI_WSTRB(axi_wstrb),
    .S_AXI_WVALID(axi_wvalid),
    .S_AXI_WREADY(axi_wready),
    .S_AXI_BRESP(axi_bresp),
    .S_AXI_BVALID(axi_bvalid),
    .S_AXI_BREADY(axi_bready),
    .S_AXI_ARADDR(axi_araddr),
    .S_AXI_ARPROT(axi_arprot),
    .S_AXI_ARVALID(axi_arvalid),
    .S_AXI_ARREADY(axi_arready),
    .S_AXI_RDATA(axi_rdata),
    .S_AXI_RRESP(axi_rresp),
    .S_AXI_RVALID(axi_rvalid),
    .S_AXI_RREADY(axi_rready),
    
    .vsync(vsync),
    .DrawX(drawX),
    .DrawY(drawY),
    .bram_addr(bram_addr),
    .palette_regs(palette_regs),
    .doutb(doutb),
    .active_keys(active_keys),
    .tuning_words(tuning_words),
    .voice_gate(voice_gate),
    .wave_sel(wave_sel),
    .wave_override_enable(wave_override_enable),
    .midi_event_valid(midi_event_valid),
    .midi_event_packet(midi_event_packet),
    .adsr_config(adsr_config)
);


//Instiante clocking wizard, VGA sync generator modules, and VGA-HDMI IP here. For a hint, refer to the provided
//top-level from the previous lab. You should get the IP to generate a valid HDMI signal (e.g. blue screen or gradient)
//prior to working on the text drawing.

    //clock wizard configured with a 1x and 5x clock for HDMI
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(reset_ah),
        .locked(locked),
        .clk_in1(Clk)
    );
    
    //VGA Sync signal generator
    vga_controller vga (
        .pixel_clk(clk_25MHz),
        .reset(reset_ah),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );    

    //Real Digital VGA to HDMI converter
    hdmi_tx_0 vga_to_hdmi (
        //Clocking and Reset
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        .rst(reset_ah),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde),
        
        //aux Data (unused)
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_clk_p),          
        .TMDS_CLK_N(hdmi_clk_n),          
        .TMDS_DATA_P(hdmi_tx_p),         
        .TMDS_DATA_N(hdmi_tx_n)          
    );

    
    piano_mapper piano_instance(
        .Clk(clk_25MHz),
        .Reset(reset_ah),
        .DrawX(drawX),
        .DrawY(drawY),
        .blank(~vde),
        .active_keys(display_active_keys),
        .Red(red),
        .Green(green),
        .Blue(blue)
    );

    midi_synth_engine midi_engine_instance(
        .Clk(axi_aclk),
        .Reset(reset_ah),
        .event_valid(midi_event_valid),
        .event_packet(midi_event_packet),
        .voice_idle(voice_idle),
        .tuning_words(engine_tuning_words),
        .velocity_words(velocity_words),
        .voice_gate(engine_voice_gate),
        .voice_clear(voice_clear),
        .hw_active_keys(hw_active_keys),
        .wave_sel(engine_wave_sel)
    );

    poly_synth_core synth_instance(
        .Clk(axi_aclk),
        .Reset(reset_ah),
        .tuning_words(engine_tuning_words),
        .voice_gate(engine_voice_gate),
        .velocity_words(velocity_words),
        .voice_clear(voice_clear),
        .adsr_config(adsr_config),
        .wave_sel(selected_wave),
        .voice_idle(voice_idle),
        .audio_out(audio_out)
    );
    
// User logic ends

endmodule
