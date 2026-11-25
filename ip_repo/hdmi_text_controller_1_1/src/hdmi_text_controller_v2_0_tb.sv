//HDMI Text Controller Example Testbench for ECE 385
//Spring 2026 Distribution

module hdmi_text_controller_tb();

	//clock and reset_n signals
	logic aclk = 1'b0;
	logic arstn = 1'b0;
	
	//Write Address channel (AW)
	logic [31:0] write_addr = 32'd0;	//Master write address
	logic [2:0] write_prot = 3'd0;		//type of write(leave at 0)
	logic write_addr_valid = 1'b0;		//master indicating address is valid
	logic write_addr_ready;				//slave ready to receive address

	//Write Data Channel (W)
	logic [31:0] write_data = 32'd0;	//Master write data
	logic [3:0] write_strb = 4'd0;		//Master byte-wise write strobe
	logic write_data_valid = 1'b0;		//Master indicating write data is valid
	logic write_data_ready;				//slave ready to receive data

	//Write Response Channel (WR)
	logic write_resp_ready = 1'b0;		//Master ready to receive write response
	logic [1:0] write_resp;				//slave write response
	logic write_resp_valid;				//slave response valid
	
	//Read Address channel (AR)
	logic [31:0] read_addr = 32'd0;		//Master read address
	logic [2:0] read_prot = 3'd0;		//type of read(leave at 0)
	logic read_addr_valid = 1'b0;		//Master indicating address is valid
	logic read_addr_ready;				//slave ready to receive address

	//Read Data Channel (R)
	logic read_data_ready = 1'b0;		//Master indicating ready to receive data
	logic [31:0] read_data;				//slave read data
	logic [1:0] read_resp;				//slave read response
	logic read_data_valid;				//slave indicating data in channel is valid

    logic [3:0] pixel_rgb [3];
    logic pixel_clk, pixel_hs, pixel_vs, pixel_vde;
    logic [9:0] drawX, drawY;
    logic [31:0] tb_read;
    logic [31:0] expected_tuning [0:7];
    logic [15:0] env_level_after_100;
    logic signed [23:0] expected_stage1_product;
    logic signed [40:0] expected_stage2_product;
    logic signed [23:0] expected_scaled_sample;
    integer midi_event_count = 0;
    logic [23:0] last_midi_event = 24'd0;
    integer stress_idx;
    logic [7:0] stress_note;
    
    //BMP writer related signals    
    localparam BMP_WIDTH  = 800;
    localparam BMP_HEIGHT = 525;
    logic [23:0] bitmap [BMP_WIDTH][BMP_HEIGHT];

    integer i, j, reg_idx;

	//Instantiation of DUT (HDMI TEXT_CONTROLLER) IP
	hdmi_text_controller_v2_0 # (
		.C_AXI_DATA_WIDTH(32),
		.C_AXI_ADDR_WIDTH(16)
	) hdmi_text_controller_v1_0_inst (

		.axi_aclk(aclk),
		.axi_aresetn(arstn),

		.axi_awaddr(write_addr),
		.axi_awprot(write_prot),
		.axi_awvalid(write_addr_valid),
		.axi_awready(write_addr_ready),

		.axi_wdata(write_data),
		.axi_wstrb(write_strb),
		.axi_wvalid(write_data_valid),
		.axi_wready(write_data_ready),

		.axi_bresp(write_resp),
		.axi_bvalid(write_resp_valid),
		.axi_bready(write_resp_ready),

		.axi_araddr(read_addr),
		.axi_arprot(read_prot),
		.axi_arvalid(read_addr_valid),
		.axi_arready(read_addr_ready),

		.axi_rdata(read_data),
		.axi_rresp(read_resp),
		.axi_rvalid(read_data_valid),
		.axi_rready(read_data_ready)
	);
	
	initial begin: CLOCK_INITIALIZATION
	   aclk = 1'b1;
    end 
       
    always begin : CLOCK_GENERATION
        #5 aclk = ~aclk;
    end

    always @(posedge aclk) begin
        if (!arstn) begin
            midi_event_count <= 0;
            last_midi_event <= 24'd0;
        end else if (hdmi_text_controller_v1_0_inst.midi_event_valid) begin
            midi_event_count <= midi_event_count + 1;
            last_midi_event <=
                hdmi_text_controller_v1_0_inst.midi_event_packet;
        end
    end

    // Hierarchical references to internal DUT signals
    assign pixel_rgb[0] = hdmi_text_controller_v1_0_inst.red;
    assign pixel_rgb[1] = hdmi_text_controller_v1_0_inst.green;
    assign pixel_rgb[2] = hdmi_text_controller_v1_0_inst.blue;
    
    assign pixel_clk = hdmi_text_controller_v1_0_inst.clk_25MHz;
    assign pixel_hs  = hdmi_text_controller_v1_0_inst.hsync;
    assign pixel_vs  = hdmi_text_controller_v1_0_inst.vsync;
    assign pixel_vde = hdmi_text_controller_v1_0_inst.vde;
    
    assign drawX = hdmi_text_controller_v1_0_inst.drawX;
    assign drawY = hdmi_text_controller_v1_0_inst.drawY;
   
    // BMP writing task
    task save_bmp(string bmp_file_name);
        begin
            integer unsigned        fout_bmp_pointer, BMP_file_size, BMP_row_size, r;
            logic   unsigned [31:0] BMP_header[0:12];
        
            BMP_row_size = 32'(BMP_WIDTH) & 32'hFFFC;
            if ((BMP_WIDTH & 32'd3) != 0) BMP_row_size = BMP_row_size + 4;
    
            fout_bmp_pointer = $fopen(bmp_file_name, "wb");
            if (fout_bmp_pointer == 0) begin
                $display("Could not open file '%s' for writing", bmp_file_name);
                $stop;     
            end
            $display("Saving bitmap '%s'.", bmp_file_name);
       
            BMP_header[0:12] = '{BMP_file_size,0,0054,40,BMP_WIDTH,BMP_HEIGHT,{16'd24,16'd8},0,(BMP_row_size*BMP_HEIGHT*3),2835,2835,0,0};
        
            $fwrite(fout_bmp_pointer, "BM");
            for (int i = 0; i < 13; i++)
                $fwrite(fout_bmp_pointer, "%c%c%c%c", BMP_header[i][7 -:8], BMP_header[i][15 -:8], BMP_header[i][23 -:8], BMP_header[i][31 -:8]);
        
            for (int y = BMP_HEIGHT - 1; y >= 0; y--) begin
                for (int x = 0; x < BMP_WIDTH; x++)
                    $fwrite(fout_bmp_pointer, "%c%c%c", bitmap[x][y][23:16], bitmap[x][y][15:8], bitmap[x][y][7:0]);
            end
    
            $fclose(fout_bmp_pointer);
        end
    endtask
    
    // Always procedure to log RGB values into array to generate image
    always @(posedge pixel_clk)
        if (!arstn) begin
            for (j = 0; j < BMP_HEIGHT; j++)
                for (i = 0; i < BMP_WIDTH; i++)
                    bitmap[i][j] <= 24'h0F0F0F;
        end
        else
            if (pixel_vde)
                bitmap[drawX][drawY] <= {pixel_rgb[2], 4'h0, pixel_rgb[1], 4'h0, pixel_rgb[0], 4'h00};

    // AXI write task
    task axi_write (input logic [31:0] addr, input logic [31:0] data);
        begin
            #3 write_addr <= addr;
            write_data <= data;
            write_addr_valid <= 1'b1;
            write_data_valid <= 1'b1;
            write_resp_ready <= 1'b1;
            write_strb <= 4'hF;
    
            wait(write_data_ready || write_addr_ready);
                
            @(posedge aclk);
            if (write_data_ready && write_addr_ready) begin
                write_addr_valid <= 0;
                write_data_valid <= 0;
            end
            else begin
                if (write_data_ready) begin
                    write_data_valid <= 0;
                    wait(write_addr_ready);
                end
                else if (write_addr_ready) begin
                    write_addr_valid <= 0;
                    wait(write_data_ready);
                end 
                @(posedge aclk);
                write_addr_valid <= 0;
                write_data_valid <= 0;
            end
                
            write_strb <= 0;
            wait(write_resp_valid);
            @(posedge aclk);
            write_resp_ready <= 0;
        end
    endtask

    task axi_write_staggered (
        input logic [31:0] addr,
        input logic [31:0] data,
        input logic address_first
    );
        integer previous_event_count;
        begin
            previous_event_count = midi_event_count;
            #3;
            write_resp_ready <= 1'b1;
            write_strb <= 4'hF;
            if (address_first) begin
                write_addr <= addr;
                write_addr_valid <= 1'b1;
                repeat (3) @(posedge aclk);
                write_data <= data;
                write_data_valid <= 1'b1;
            end else begin
                write_data <= data;
                write_data_valid <= 1'b1;
                repeat (3) @(posedge aclk);
                write_addr <= addr;
                write_addr_valid <= 1'b1;
            end

            wait (write_addr_ready && write_data_ready);
            @(posedge aclk);
            write_addr_valid <= 1'b0;
            write_data_valid <= 1'b0;
            write_strb <= 4'b0;
            wait (write_resp_valid);
            @(posedge aclk);
            #1;
            write_resp_ready <= 1'b0;
            if (midi_event_count != previous_event_count + 1)
                $fatal(1, "Staggered AXI MIDI write pushed %0d events, expected one",
                       midi_event_count - previous_event_count);
            if (last_midi_event !== data[23:0])
                $fatal(1, "Staggered AXI MIDI packet mismatch: %x", last_midi_event);
        end
    endtask
    
    // AXI read task
    task axi_read (input logic [31:0] addr, output logic [31:0] data);
        begin
            #3 read_addr <= addr;
            read_addr_valid <= 1'b1;
            read_data_ready <= 1'b1;
    
            wait(read_addr_ready);
            @(posedge aclk);
            read_addr_valid <= 0;
    
            wait(read_data_valid);
            data = read_data;
            @(posedge aclk);
            read_data_ready <= 0;
        end
    endtask

    task wait_midi_pipeline_empty;
        begin
            wait (hdmi_text_controller_v1_0_inst.midi_engine_instance.fifo_count == 0 &&
                  !hdmi_text_controller_v1_0_inst.midi_engine_instance.pending_note_on &&
                  !hdmi_text_controller_v1_0_inst.midi_engine_instance.allocation_stage_valid);
            repeat (2) @(posedge aclk);
        end
    endtask

    // Test vectors
    initial begin: TEST_VECTORS
        arstn = 0;
        repeat (4) @(posedge aclk);
        arstn <= 1;

        axi_write(32'h00, 32'h00000005);
        axi_write(32'h04, 32'h00000001);
        for (reg_idx = 0; reg_idx < 8; reg_idx++) begin
            expected_tuning[reg_idx] = 32'h00000100 << reg_idx;
            axi_write(32'h08 + (reg_idx * 4), expected_tuning[reg_idx]);
        end
        axi_write(32'h28, 32'h000002A5);
        axi_write_staggered(32'h2C, 32'h00903C64, 1'b1);
        repeat (4) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.hw_active_keys[39] !== 1'b1)
            $fatal(1, "MIDI note-on did not set the hardware piano key");
        axi_write_staggered(32'h2C, 32'h00803C00, 1'b0);
        repeat (4) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.hw_active_keys[39] !== 1'b0)
            $fatal(1, "MIDI note-off did not clear the hardware piano key");

        axi_read(32'h00, tb_read);
        if (tb_read !== 32'h00000005)
            $fatal(1, "active_keys low register readback mismatch: %x", tb_read);
        axi_read(32'h04, tb_read);
        if (tb_read !== 32'h00000001)
            $fatal(1, "active_keys high register readback mismatch: %x", tb_read);
        for (reg_idx = 0; reg_idx < 8; reg_idx++) begin
            axi_read(32'h08 + (reg_idx * 4), tb_read);
            if (tb_read !== expected_tuning[reg_idx])
                $fatal(1, "tuning_word[%0d] readback mismatch: %x", reg_idx, tb_read);
        end
        axi_read(32'h28, tb_read);
        if (tb_read !== 32'h000002A5)
            $fatal(1, "voice control register readback mismatch: %x", tb_read);
        axi_read(32'h2C, tb_read);
        if (tb_read !== 32'h00803C00)
            $fatal(1, "MIDI event register readback mismatch: %x", tb_read);
        axi_read(32'h30, tb_read);
        if (tb_read !== 32'h28991204)
            $fatal(1, "ADSR configuration reset value mismatch: %x", tb_read);
        axi_write(32'h34, 32'h00000015);
        axi_read(32'h34, tb_read);
        if (tb_read !== 32'h00000015)
            $fatal(1, "firmware status register readback mismatch: %x", tb_read);

        force hdmi_text_controller_v1_0_inst.synth_instance.envelope_sample_tick = 1'b1;
        axi_write(32'h2C, 32'h00903C64);
        repeat (100) @(posedge aclk);
        env_level_after_100 =
            hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0];
        if (env_level_after_100 == 0)
            $fatal(1, "ADSR attack did not raise the envelope");
        repeat (200) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0] <=
            env_level_after_100)
            $fatal(1, "ADSR attack did not ramp upward");
        repeat (11000) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.synth_instance.envelope_state[0] != 3'd3)
            $fatal(1, "ADSR did not reach sustain after attack and decay");
        if (hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0] < 16'd39000 ||
            hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0] > 16'd39600)
            $fatal(1, "ADSR sustain level is outside the configured range");
        @(negedge aclk);
        expected_stage1_product =
            $signed({{8{hdmi_text_controller_v1_0_inst.synth_instance.voice_sample_reg[0][15]}},
                     hdmi_text_controller_v1_0_inst.synth_instance.voice_sample_reg[0]}) *
            $signed({16'd0, 1'b0,
                     hdmi_text_controller_v1_0_inst.synth_instance.voice_velocity_reg[0]});
        expected_stage2_product =
            $signed({{17{hdmi_text_controller_v1_0_inst.synth_instance.voice_velocity_product[0][23]}},
                     hdmi_text_controller_v1_0_inst.synth_instance.voice_velocity_product[0]}) *
            $signed({24'd0, 1'b0,
                     hdmi_text_controller_v1_0_inst.synth_instance.stage1_envelope[0]});
        expected_scaled_sample = expected_stage2_product >>> 23;
        @(posedge aclk);
        #1;
        if (hdmi_text_controller_v1_0_inst.synth_instance.voice_velocity_product[0] !==
                expected_stage1_product ||
            hdmi_text_controller_v1_0_inst.synth_instance.voice_scaled[0] !==
                expected_scaled_sample)
            $fatal(1, "Pipelined velocity/envelope scaling did not match the staged products");

        axi_write(32'h2C, 32'h00803C00);
        wait (hdmi_text_controller_v1_0_inst.synth_instance.envelope_state[0] == 3'd4);
        env_level_after_100 =
            hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0];
        repeat (19000) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.synth_instance.envelope_state[0] != 3'd4 ||
            hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0] == 0)
            $fatal(1, "ADSR release ended before the configured 400 ms");
        if (hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0] >=
            env_level_after_100)
            $fatal(1, "ADSR release did not fade the envelope");
        repeat (1000) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.synth_instance.envelope_state[0] != 3'd0 ||
            hdmi_text_controller_v1_0_inst.synth_instance.envelope_level[0] != 0)
            $fatal(1, "ADSR release did not reach idle at its configured duration");
        release hdmi_text_controller_v1_0_inst.synth_instance.envelope_sample_tick;

        repeat (4) @(posedge aclk);
        for (stress_idx = 0; stress_idx < 8; stress_idx++) begin
            stress_note = 8'd48 + stress_idx;
            axi_write(32'h2C, {8'h00, 8'h90, stress_note, 8'd100});
        end
        wait_midi_pipeline_empty();
        for (stress_idx = 4; stress_idx < 8; stress_idx++) begin
            stress_note = 8'd48 + stress_idx;
            axi_write(32'h2C, {8'h00, 8'h80, stress_note, 8'd0});
        end
        wait_midi_pipeline_empty();
        for (stress_idx = 0; stress_idx < 4; stress_idx++) begin
            stress_note = 8'd56 + stress_idx;
            axi_write(32'h2C, {8'h00, 8'h90, stress_note, 8'd100});
        end
        wait_midi_pipeline_empty();
        if (hdmi_text_controller_v1_0_inst.hw_active_keys !==
            ((88'hF << 27) | (88'hF << 35)))
            $fatal(1, "Allocator failed to prioritize release voices: %x",
                   hdmi_text_controller_v1_0_inst.hw_active_keys);

        for (stress_idx = 4; stress_idx < 12; stress_idx++) begin
            stress_note = 8'd56 + stress_idx;
            axi_write(32'h2C, {8'h00, 8'h90, stress_note, 8'd100});
        end
        wait_midi_pipeline_empty();
        if (hdmi_text_controller_v1_0_inst.hw_active_keys !==
            (88'hFF << 35))
            $fatal(1, "12-note burst did not retain the newest eight gated notes: %x",
                   hdmi_text_controller_v1_0_inst.hw_active_keys);

        axi_write(32'h2C, 32'h00B07B00);
        repeat (4) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.hw_active_keys !== 61'd0)
            $fatal(1, "All Notes Off left hardware piano keys highlighted: %x",
                   hdmi_text_controller_v1_0_inst.hw_active_keys);

        axi_write(32'h2C, 32'h00901564);
        repeat (4) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.hw_active_keys !== 88'h1)
            $fatal(1, "A0 did not map to the first native piano key");
        axi_write(32'h2C, 32'h00801500);
        repeat (4) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.hw_active_keys !== 88'd0)
            $fatal(1, "A0 Note Off did not release its native key");

        axi_write(32'h2C, 32'h00906C64);
        repeat (4) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.hw_active_keys !== (88'h1 << 87))
            $fatal(1, "C8 did not map to the final native piano key");
        axi_write(32'h2C, 32'h00806C00);
        repeat (4) @(posedge aclk);
        if (hdmi_text_controller_v1_0_inst.hw_active_keys !== 88'd0)
            $fatal(1, "C8 Note Off did not release its native key");

        // Wait for a complete frame so the rendered keyboard can be saved.
        `ifdef SIM_VIDEO
        @(posedge pixel_vs);
        @(negedge pixel_vs);
        save_bmp("lab7_2_sim.bmp");
        `endif
        $finish();
    end
    
endmodule