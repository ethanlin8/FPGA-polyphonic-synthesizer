//HDMI Text Controller Example Testbench for ECE 385
//Spring 2026 Distribution

`define SIM_VIDEO //Comment out to simulate AXI bus only
                    //Uncomment to simulate entire screen and write BMP (slow)

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

        // Wait for a complete frame so the rendered keyboard can be saved.
        `ifdef SIM_VIDEO
        @(posedge pixel_vs);
        @(negedge pixel_vs);
        save_bmp("lab7_2_sim.bmp");
        `endif
        $finish();
    end
    
endmodule