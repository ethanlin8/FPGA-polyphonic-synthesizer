// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Thu Nov  5 04:17:22 2026
// Host        : Ryan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/rlin1/ece385_labs/ip_repo/hdmi_text_controller_1_1/src/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    wea,
    addra,
    dina,
    douta,
    clkb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1200" *) 
  (* C_READ_DEPTH_B = "1200" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "1200" *) 
  (* C_WRITE_DEPTH_B = "1200" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 47424)
`pragma protect data_block
lbbHJDfgTjd5l2tl94+emEinEAntQM+TaAkIWAgMiW8zt6TbshAxb+BpHx6WbjFo/rNxXYIXfrlx
tErQizu8uxDuewmKNyIzYr7Mxsh9hKPgdpYFcvO+Vt1aETGjTctw4A3BXbzpvrdEawjyklPz9mV2
xHHdOmWIHH9xeDozA2P2EBdyeFZdMToXvLP9Ei/B1FxsTDgpXFwXPaaSKvcz49E6Fm5QxRyQytzF
zzXrB4atmahiwLeWp+cGYaeZ2jRazojRvXadSRJonzDO85FkO3l7n6JngdEHFW4QoU/CKcp9Ilq9
J/mGmFMWEG02oa+PMCGjMwB37Hhrbjk2inuePeaYL0luD+68my6FS/JplwuU6aVI5Umtp0fXtd6E
UW1/EOUfJljgEClb+9H6IzQtw/Zpfahz5zE+xXHQByrHEYqhStjH1xGV5NB/sO3SaMnsOAlmBSgv
zxS1e3M19ODWtwnkK9eEAKk6bDwGuwht/WQzby9j6NciALqS5aJZM1P6Joi4/gofRP15Re3o42Mj
BLR4CGG9qRgKTxZnVvDVNy54Hk+2LLurzeu8jmBb3u4Dkc0a8axtqKi9cH+OnRiZcXzj7mZexfbz
qmSsye0D8jXgK/wf2BIzvUxrLdZIjedblIgR6mMHvAzXm2v7cAKvEOjyAePASvOEPG2uthG8bY8R
bK2m2KxTfQkZaer1HF6GzXwEqMbZ89EOphA/gyY4JjEaNh449O5Kk/OK0OSBWG3JZps73QJ3tgm7
ddvLNSjBcuQjPR8XFA2F1TxQpdfUUyoUjZYiTECOmgvwLDzfQWAdvBaSIbUYvboN0BNRhNtc+s3g
iIdb3DgPtNDOS7QOftIMGOX6zSR6DVleejWS8uQe+B2zjmXcCHuay1ubrfuaYs1v21SzZYY8kWDg
XeFufrLrlAS2MowbD1ZjURROrIeD4VVMo0XBytx1BLAh0hv1gU3zweGHehRcaXEvitm9zL+E5r79
GZ1drjioNFZ7fZGb5qrd18gudCb5/35vKIRwaqRig37d4RhE1X9oBG/mg+BVpZUge8ql7HMEmAE/
0+zkcjpX4cIXl0fsmafH+s9pxJuly02JUBWa4zK3Bmwxn0xBshNZVAMY2sLy83R7Hi0MpascLG3Z
jl+EUH1+hKu34B1S6axvOg+XZKldB12MJIrtiVx9bYXT6OxLZqPaHL5hZaGhVa22e7SpVnHr+5by
/z9RLSiOeU65rOW85QII2AiUoY6d9ctJhUeoZNmk95usuSC1vqzTQNGgl3zsisUvFkURuZ5j4g9V
xjL7PMF0gscf/+ldP4ZTGKLD6Uf7kjk2gYRz7v3008QSgFFW204coyNl7jRBL9FtRYyvCMR7ZXzF
37GYcICaRKD6li3bsXnShejQKnQD6MIfim/Ws7Wj1o4/JwzRVSEJG263X1PGMzVOFX4KJSI7xIHh
l61FQLr7eHbodXDMLBqhWyxI9rpJcOUrNFRVTZuk1OXkc273qXKHvPhyVNcy6QosIeJ3U3AeDsyQ
EF1W+k6pOyun7o+qpkqvgtQU5IvEq7jejJp02cdosOrd8+znOSWCE4+z9EaX3+VlPfsr9MVC42wB
Pk21SWUBgzZT/xoPnJaIbPYtU8utg1hXEnt2o/oAXFSpieptL6W+AlKvZc7a8SNtP2+rRVpYvd56
tovzeeWGCmd6KKb9zkLPv4qypwDaufeQa7c2O1LhsXOefbQe275mmKh2bG1dJ2yuwYhAVYAEq3cg
y+EqZREdh5i6WagVR7f4WYHl5evVGPvoIo/qse/Z1OPsERRWBPDHxYx0WovdttCq53dDAhMU0Oh0
1WP0bsEDVbIq/KfBQxtrJMmb9AMZGa6NGX6omGPkDILci8C5Xe613kqXeSNQoRVxysT1kCD7Fwd/
aWHq7GNrTeXn76I4bKGTPsx1XVuzbc9mAuWYTL9jaqE0CvDes79ZRQMurchFaxoMLA8LEaa9Aurn
cG1t9c5iFw7l/LMXTM9xg2JCJutSDP3bRBd4fhx52+goKV7KrbJVa+MdzbaKTeqE+LB9S+XlCtjg
L/SfqUijpp6B8w8ceqlLC/wVQ4c8I4qXjShoZPwAj1RT9SjPSIWeGMDSsEkUR15vppN44MyEUcxQ
f8f2+UmEKOPdgQKPikOY0hMyvBD3YvL7rTnPwqVKDHPKnXt1Hs3pYCUOqOYeHFDFbOvf0zpm9+IQ
biaJ34evOLfTIbIh9uUm/iknMSTj83BviPBGKOFBeA1tUH6GN0UhIeicJLbNHlgWVeYURmScDIp3
j9v2yqRTaOxyYvj0Y/nIJ92TOTqX5Vb+t23gK/Q2vF7zfT1rQpf+MczXhs1DNedNUeHnT66D219Y
S7LxoXimU4/9FU7CZovK/cGW0UkQtJUtnkqGwJJWY0xN/JMSluj4vrU50jMZPSMbf2RKIdaoM8G+
tXN8ij0SyH9pScimoJmrnVMBBp8EdEGZNU6Wsin/55bMPkxdEtp1+RSPe+RToOelytemgknkz6YT
GhvVn7pto8kz5TTr7lki/sFHFMbKqiZrQoN6tW3rwNJX2Svqr8t49OtMkEXZEsWWFr0iLnJ3iTTl
t9F7NhuO0T/vwgikRolbRgP5Zx6wCcXrsqsO5rJQ5kF4oAXNROuNQ+JjX6ZtWulQ7uNTt9jDgK7l
CEMhGVyVrF6a/pajRwK4iYlKi+wGmgT3mm6+Y0LPg1PiOBd+9YPi9r4Wy8hrP72xpS26lGTKP1OI
Vp/dwZAD6FNg7UTjMYcTlTvQC2eECg7EUc5M0I9hIr3Dq4o8TISqgfCm0Klwe0Q/ITxJSYDm7Wpy
EMbG4IjsXEYXICQ4ESnXCf2W+Hncj9BD78KArQwoDRIRYz6mmH7PUBRmYf1igJCXqdQF49Y7SGKF
m81jTxhwo3hHvg2nRHapMv7j42FZl1jsgxiQD7pMRjOA1/bHfoeVIS/vSnRcrzKZswplODjl2h1a
xPjwXE+NLrCj3Ny4Wc0OBibJoIJPr/0C+qXtF91jraM8uPsEGDOleeZP8j5Wsjt7EvSSWA+6qFIf
uC/nVFTMXIsH/2wO88hblisbHNiNNj3HkyTtV1IUT+3RwU9rj5h+8ffa7dUnPrLeuqXdv0HUDkS2
fIwUV5c2rAMlHk6elHtQqzdnKfdCEV+CCEqc/udkpkzg2HvvrbOygPJ2/pGGfQKDsNiZaUh+xBkG
Ki2PctAgHopgye/ud6LV1horvZ9FXunbvvrz9SJaiMo+1o2fHGLyGHSxLIlJi32Ikweb/49qTXtI
xvw/p+sq7YByCFR9L5HeMCEJinmJxVJiZTtOaDgPxAZ/GzbhixLcFDmv3TIEcFXbaaoYMwAqIQsN
Bj/0ZyI2+zCKPGiQ5bvz3FrpW7ffndQxsLUVzvEFPnfY1Dt2deghC0PRSdyKMm2nsl+vQaHv39yp
fJwEjQ0Aw43XWpTkPwu5FUMjonwr8AE16h3NP9qKwiTw68yEjf60uyi1L9q3al/yYq9oHv9WJuuV
RGkWU05G+EmsBaA40pe7EUDHOClop6Y+5xIY6sX3sbAD1CRK/LXOpzmJzLdLTYgcoSRXfSRtYTIN
qXJwEXBdmboEnB1g/5q66tm5HsIog/H9EPdimg8Y1qDBTUFXecxlXlSTRnFk10oJvEk2RRnLfhu/
s1URJiGS4oCd7II4OMtg0VXqu3KTGKBb1D1t7vuL7vgvSR5X7Ydzc0YYLnRHUt+oZzZZhzSYHf4r
W/rWrjyGQ5a5sT6tUTFBanVhtGlk3+4fT+N9oB/y28tozFQcDugfijffdEflHaPz21i/xzNX+P00
is46EeuCzkWA0q2X0EzLxv7edyWg2jKrq8UGORLUBzFAwHHRVj0eajJwHpLGeu5KBhMH+FNY68Kh
S1aC8gi2lYIEaNDpu/EsXGq3ovYMX1V995AKwF19/MSKtVkITf1dgSWHsuKH4OM9YWrEAEmBog9D
feZqNMMqYTOgML4U/7tfFeHUEmkN6+ek1CqtxMPM7vM5Y7Vdp/EVcg4yI++jfZVBEcB6isH4HXB9
jpK11JT2ipUlCRH7ky2lB6iQbV8YIHQOT0O5B0KQV/kmbPEXRtsvYpu63s/ghZmYCsPZhNrDCvLj
FKuek+m1zq+yny5UTP4iKikcMhiMnhgfheB2D2lfHTPmxCDYt6yD1EludHH/7z3/gSibSLIb53/T
yQ0JYxHTMK7KEecXOtKNyWwmfwIra+eE2Rwy8JStuRaxRXjt/UVhLWA3jg89P/+PQt/lihp8T/Fh
J+LHFWXQbMhOyMfThgUoePR42Dp6jM5z5cu1oJGTrYZZvq9gzB+Gm3DtQq+KAUQjkutnMFjT94+C
4hliiBNUvJn1C2+oPglVkeYKU/0/TcyQD/G5/4rUUxKsuc+08Y3Et0DGKE9/G5UcHuLHIgFVqIoE
yHTiN3ex/Ei/A8PTvqkGyDxLzzJkAaZoWh2hW8kvMm0hl7tlMmWNrsCCQ8yoJKxXxUOaP7eWnDG+
zjvhOfS+mGtYQdxzFErrUQVSaBA9Nkq2huBuO4ltFRfs/BdHTWLy3v9TUa+ZWks5015Slwupkrhw
7g6mWTLP+1KGd91SaGIy8u5HeamXAotRHrJdAT8oXTOwbSu/cMBsKWzk2OaMure2NwnSHwMHypxl
+veitBzeU9MjIXqrdmfnmVkgO08XF2sP1VjYKS70EjWdSQKaVByOtDL9NSaN/EqQWB7wPRmZQqq7
YVIlyNZzvsE1aElXoRPgAAzP9tYkAPu8/1EkeaoiH5lMbFDKToAkL7YlkLLped5Vi2yn8bsP9CNB
pq0/dvUI22ntDG1TvXBSCJlEEpgzPdabpLIMeSqLwKTi0STsGdkzvFUMhhxj8/A0QwGrJY0Jxu33
iftClNSbhspUmLarIhXDCmQc9dnJpbvTDZIxmrY/mrwfz0zfA3DCnOtemca/k0iQ2YOvvaErZ04x
8+Zsx5DU9KSo2uAEVxzOlUWcbs9ZH8ceWYfDUuhyZhsl0K1uhuUbeeZ32GQoTb4oglHeFSiM00K1
oyESKOTvAbYFFlwdsG7ycS+EioI2vvm6Vq0wpdaKXxA8gWkKmoaQhnSHlMjKY9HKyAPPPWhjpeYF
lliQgiusl22v3jRdNXgBs4WlVPbhRsWJI+dDRESO6zK7IPWJQagszG40q0CfPrGDr9Hbe1TA14oA
0Bn6YJO9WuG0xE/Ig4QLAM/SKMlVstyVlhqrPSOGPjfdEpnZM0NUaSUXOKX0my9mauAOgsJL5/je
rDWamCWeyQymDCgR1tDed08xCmqCGtFU7U77YRDhgfeJ+bCg289zVAPX3FEMMp4jOjPKCu1oWNgt
tB7BEwd1dmph1B6UHKmhNv88jbOX7liR9S3GlzKjslmtu/nvlN9lASIYT1FE5Tg4r2QkWIDKfVoc
p4P8uZ7/xfMGVfDN4jwcOnn5GLiITYuxkMtUyH6c0EClw7KNSYDu/rHQFM1LRWLvMzCJqnIz5EEQ
dJJhFUoiWKlsHZnPMKSviiSzPHb373GdC+mCpJdiz4v92lBRsnYgX/NQAXg17Uk5wezDlJm5zXGU
LEqej+17jBkKKpIBsW/ufSHmu6x9qBSYr7tjJCziqDNEmIfKGGcMxT0vE3BKtyhmWTmMXDm3y2XR
lM3leH4YVvIeV7SYbD6s4UQBplixYh8agcVVaF1ZBSejb2OwKSXb7MXeTBF0xG902kqnJUNPBHzW
d62vCQJTwvObL1FfoBTczjFEKEntZ3hQLXStRppLBgAgOAtyhAhKCZIqABb07xQ6pgIxxuxAVSxB
RL/cA9b2DwuTNFA2BAt1VYv5Ppd0jInZ7M7Y4qsHkkfUXP3EKcDE2o6qmSVDmvKrYBom8cheQtvJ
8z4uS9QBlwAhHxK+1+bgR4Mrc7csSAKF217TnMosFvG+QPfj5bdGKfV9pzykKuBxtjHpMZiXPxRl
+EbDY+NyL0d9xoFXm3ajgYOuwcKmUCwRJxj4Q5rj12P1h0iZPUBuJ4q6ZdHj5196mwqmOT+tvmfZ
wrSWHf49jrZf75rdKPfZsFWEcgpWIDUPiLMXzYjStOUt6/FGJzrS6YdRW1Flvr8B1i/HWgKrM2j7
oA/uc6X/ASgLmQGsIuLnRbrsnmM+DDm3jrRbX+oOktYDCI4shba6vZQJoHUfJRmT2ixztDHrD96A
4l1aKqFlad2X6AOTfVdzUxdwlJmMmRfzyKxJRkfvxbXG0PDAdKqx//ipJO5WtHpD6tlZuPep2qwa
c7k8gq4BZoM69qIs3Cr43K3b8SNE9S0tAbfdeW6fvyCAdhsSBJ4S/LqtwY9hfUuYcEwJHUtw3w36
4Y58ZTulSBB6MmsVo2DnHt4FS3RyBJRZGpIhpDtg4eSSi7XhJm5tJw4bzFkjy5N+fOia8lKigrqa
/F8sr2wrrxQM04UUNZyTq3ijtxQIK90s1N8VmFz+7hl1/CsyV9CcnH9NCOC/zPZ+E/vMhqzsgLvZ
/xOXQHvrZXuiaYgMhxVjJO6pSnF2MSLL2DL3mZwrXpB1S6ONKSl+M0nUSiVTNivTLPiaPO7GhNJP
OUQkarMLyF4dUuUc/ZFB12+YTIfdR74yjb1NIakUfg7i2MJg800rxxyBHClBfcdoGZ604oizkLQz
kz0yh9ghwC4QM7YH5yMV+RnrqFaHxQYMzmsrUCn1kcmWmFDYatVxXu9b4htmu7V/btanw3XowpjK
74iUTDvrUBwGGnWbYa90PakWGEQh3j1VAUnK+kBs15qo4p0cKexlLJ/+d6MSyrnu1mGYzL+gAYE3
YtOsWGT2cuApyoZeAR5nMZ8Qf5M6Bkn9wWT5sdWkpcYgfgvi4Rhk/I6JtxIslMS6PBeNXQ0n4IUn
H8nsbHTJRpcluj/iSrLOiY/Jp37Y5IIsbiy9xbMCU+njA800ogJgeGQQ0dkxLma8+R2yGj4PXd1X
nhQkqIoAOSVWxXCZmcOsZpqsHzzMX1XDmBxGOqm80A0AvjrRKgjN6LLpdyKr9y/e3FMly5jDVBRH
4u7jQd50RU+hGuy0v8HO1XS732qmpAwtZkAaYKWac1Qosk749pd/TvM3qVM7LQ/skvE74+KYHgGl
MbsKbt1O3PanWjBFDHGId7n2RaSXUzc3bMeipKJrs8pb5fpJnA/orEIoA2ar+rmuCYXE5y1Vnxhj
ugN7RSv91J640TEQ1O1kP4vdkcit1EzLg1Wu45WOOyLS9lkHZn1aRpQ8DOh+9yMvu5cDYQvm4UDM
HfSZ8XwI7uf5q9ojgoWqxAo3EqXPIdwHhHMsukOyRQTdXcS3nfYW18ZLF5f+hdh1lRA8OzBWnL6L
c1shqzRC6XrBVJ+KmDgofMXbKwGTMwNCsuLkW2PTOuAvm8Bnxk5eosbU8GmmNUtA8qvNg7F3F+TO
ij82vYj8UoZPGj9xWskYbtSK+nA+ohg/Zqxrjtrsa/hSSpnS9vewGdnpbHxwNGfPFOCCtAD0i5aY
l59P8pbMywz7e2M2QL9Ck4kBMNOqGw1cC0aK0OU/BBXCPCOxyo+e1EuDJe5g90x6BoRZ7jS05ZlF
dDs9L6G3FgL2WjNDqI/tM0jnSVGR0T9nVx+75ZbLJpqxMdKTYL8/pPFHgYN1Zk5KYVwv3BhAaNQo
02wMn2li4RoDI0mCOWoZP+iXaNQkSJD8YFUn4xkxv4OIjHmoMnEf+DWAgfYQQXD2AimOSBldMOcW
m55GIpL4p6Hx5LyrIWEn9EJudJ+WaEH/6oCusmhTWx4fdudDR26KcRmDUqSwo70vyPmx2WCBe5oZ
CX2CEcxkwYfFhLTZglDoyHz96xY+Vgj1L/SbG7ChlVXmErHPclCOYS5DO9rCH8fnTrhVDjSXH72j
ip/JoUeG6L4XgF1ezEvsQX5NzowK4z7V8nn4epnj3tv4Ufadx8kGnYcYChXc0KuFvI/+2DfEJzuA
IOSAPvHcXMVLjVn8dwwlfm8oEDPfWNDWEMH1i7uYOhI8SFXoBsXB6y/pPdl3ncAflHAo5SgBwSsW
Noo+JNV5KAddwPMopsfvyyFSeIwUTJWlH/WfhuPkown9yRH78evUJ1CDIydLBQOls0vEVTaeIgGD
p81jjedPsJekJIStFrf/iEsnMoTuoMcwiUzuUeLQICaA+6scdH9DtADkLR4fuIYCRioRNpGXZfIs
7K55co84RBQqm6u2Q5u+PLzQ2vc559U5ygbjiqUlQkNGPOU5uRhg6USyXfhrUJkkXv3FgzZQONyQ
JFUbr//CgcnxCF9eHUo1HaDI/nd7nZvNCtd96V2xn2k2SUlG74QBmF91pk9J43mv414qjmhOCuYG
q/D86gFwz6UA7Ffgj4lbkbKvinNg7cgwWDdpMEQXN5uyEUOv/6sx2LGnH0HkvJO6SYgQgB6nn0Tw
NolGqpbrjqBvogsEAMLjN3BQRB8hvgUF/ueiiLMTt2hsaLUrrREQNZRcYMS6BlV9UsUyL8XTmyx1
4okvasCT1LyVH8Kq7myFKhEWgnRPyUJDRCAez4cD+tngvyZ87SD7s9O05D5GQ1FqMcRuyTRqCxNF
7zQXOYAo3oUXJCZYtC7QvSpoS1UBMFiem36C1S4lmtdC+Q9AggzC0oPdiiBO/AOZTcOMHTExOizA
0b6CaJT1VkVKRlZv1+yER5UWrDkndb25zGcnHdNT/NXXope19nM8TuP8l5Lr/X6/bI6Tx5S5kexA
9COXOd+CS4lLR1L9xWIOLiL9SSCV/7wPh2DSfkba0u5VkGCfCxgcgo9gckTvFhoBlo9BaGFwdrGy
fg7bCyoSlkoA9inEfOkh6nXO8LJKVEHiHoSYRbtR6sMc5X4DYzs0VC6d82jl7RuJWoyaAB3DNvY2
tlTfQ2ICFXYFqjxqthOi7SG87Uu9yX80pcsMW6ZQcDrB7Ea42B79s//GDy16qKLDkTvKYCU09M9N
5gCAaHtP1F72c9Li0gHWH19lpA+FHIbmXAt+DCe6788PMLogdSVUVkV/B1P7xEfUO2mCNEhIPWjY
Ghz8GPy/HpQeLUk6bbMtu27+R3J/aGu2CePrcYnbfwNQ5iue5obXk+jz3zZW4MHQRX2xS18I90mT
N5Cz9B24mTP6AGlFFXM+pC6IPrPIORFXKFA5Azooh3p/VRQT+hOG1iRhEk52wilXaA6jVydIgTer
BCOD5p8pGPaiMMRB2PM6z9EIO+5jM2Gx3PSbzcX82pBHcZfICdIG8i9AGlbjPCw6/04HqZbaxt67
Cdvh04+m7xEfsmKPWPpSBCMjNv1EpKgRiDd7eInphvSMFD05ymtvqigUuhnOMPJZ+JfhScrWZBon
7IGrnp5aZTDo/0uGy8iihSyP8ZPiSHywK34Qqurzr8fedLZ3vsBhoZ8aLGK1PjS2Qgoul7RHqAp/
ay8W8e5gygRUoGUielJueekQBGLUsKjdWhQZjUeCa57bjj9NR9dzLFCygw2+pPt/EUXK9BuYEuHn
M6+yA6zi7fbh+XmignDTpWoe98yxobzQCEC8gEZpiKZmi3XXqalUbjSmZHKz3+WikoHLEQn0GnYC
DnXcHHhSvDi/b65CkGI1EIXPXjowIBZLrggABkCkUp0wUICMbf0+9tWhOjD34HdBq1aNPvIfd1fZ
NO84fOiLEjakVIR1IkBsb7HfqjkRtth1Eu5+rmriVCQc3x9fQMZaCHukQIS1Jk+/NBQgy65/7q8b
gf3Z4T+XC3owYpw+aHgTOqrEyib/TuenaghmMgc4Zleyie1/nMFrQTB4sbYmGK+cql3kOw4Nphck
9GuPUtfnlDQToa0ND++PQaoeZcq3+zlJVIvT1nGfmV88utQ/E7GMLHIYggi+N7K8M8GOup328+Xd
k0G7nF0L/xozqLi0S/WCYBbKaUGZ8dUi3Twtd5l194A+wkzvgVuZ3z2yNEoh7GAS5e4YHM8a5KVL
PUTkD30ZjLe40HrFvKuLuVEsYlFYnzCIlibOUcRb0p+xxC0cuWGssai9YCnmrODn6+qncsa7sJlE
KkqM6YATDRQh+IwJulOLTtQQms7qW9RGe/5HUL148Rmg1zTIHcnaRhLFjE6FZRPdTEwQbGR8MajL
nIxP63306cdRX/xWdTwMPhOGT+iADyA7ZDVgYyhAIHsaGV2q6rfp++uocv3AkTVlSdUsBpCgPJWk
033kTp+C27eL0aFukUrbMwAfbfl1LKJ4YbN1rzQo4mYWQyga02/sdISZT66BNJ/5XjgFJyuhOjYI
KFwJTM3ke9laQSKT3kY0Fw2jz6CcoGrlylO50VtsaF22eVxs8zy2arM2bD2dqsdBDxGF45qe2PWs
YNu7MNAc9b5IuStzbK4MKZR0IekLWRNC/sMdkNAjdwZGTUitn//myU+PFYgHivjjsUZ3ltcn0FWj
VO7m3xooNddSE0ghFxN9E5AmWjOIyl3wzpe+iO5i/EA4PtdTGpaYyIbfke5TQ7CW0PtJEtwAwgyS
pPVQfo4WVFu8eq7CsTtRDX9TyqfEI4uJ9J0DnrizzG4YiplbHb0xmnn4lkujux7VaUkdzgo26e7+
Bj+VgatNtEniaCTtsPwnTqVuxe0NbsaOdzKqkqmQfkZvjuH+jdOjBVqQxPE7bJgjAUxi8LkuFizb
HndKeJ0apf82V406+uBZoYDQLwZS2T8kyzSY69LXjXg+wk6bbb/2IGU9Pc3kXPKJYD/MAxGYDk4F
sNeUnv/9RakjcUUt01ioV/TfYA3lTzJ8CpSNGgu7VDfOfNBjTxpLTWZGbt4XdJDcOzJXeHzrs7BS
5iAW92pe1mdjqVzJTLI4yLO2/n581pkFOElQXgLq4JGHobF0mhFacM0nFm9eKfyDJWu+wmIshr5+
v5hTGUg4ECbANrsgYR0GveSnzSOZMB9aLdzmk+G4Sn6eJSCHfcXThJYhr+AQtNp7CzWkCP3UQc9W
+evL/7Wbin2TBIUMG15Lulu68YFOBNiuf0HrbY9v2X8buhqjOKP0q9pAjsEasJGb8/awlx+pJ8su
7y+UTvyNLA29Jq9/JKc1ckpRVEzcPQBJ2aD5uXBW3gsW5SQzX3qElQcb/inzlnDY/7AAtoHaKFBR
O6eBqUis/G8XWOqkoFTgd5KZCelojHtCRg/gFCiBMIj9g/qNcSv4SZJ9dKXP1o/bq056LYutlsOe
9bOkkrQazvbvQFWKghT8GNXpPdptusDMyYwOON6JgSWU8G7DhVpoMcanvCZgQ/TtZUG6Hdq/5Zxc
s7fv5EYdq0S2pWiHxTKa88CJgLAVaVpTQ1lZm1A5lAJ1K9C7mQbaWJfJUb0ffZ/nL3aXoN+m6axC
1zvrVbEQhr4MQS3yWgRpUeQe4NJQev/HnlCziKa2slcEVwAdth4/hz21LEJBkAUK32uBkQpgzJII
bAbaVllCkVq2zbKMrd19BfBjCAc8t0j8UyxjSZc4fnvf2GCrPTCydmRNk1h8CA7n+381yvJX159J
JN3lr2L60/Y73S7qqHWLqFRsG5aTjR8QjV2Vzhtyr39nhSS5IB+w65w2ftOGlrMi3pQUzOWLUlFU
Qoedqz0yQKiwqkpQjbZTFxP7wku8shFVINXD3HGbqPHgb2Vl+6CCn0iZexGvyxAAX+k54oxpZpnE
3FD4Pqo1zt/kTJ9ecrRpoHnDsCV6ZrX4ISuCf0UCKrGY+iXH5yfpnwgtAwITcjkvmDc4WLowELMo
w5PSxXZZgT1SOv/CpuZCg9skmcOwjrV8ncB7eio2BdRHNBMHPwVlr4urEnM1Odup9DQtN+UgXT5r
DCRLCY2ZpyYw9blCeHBoS+ZjCOj7PEFVZ1HWHdzqvMbDFX7+x+YNY1ODMguI5/WZHGM/QfqxaXF4
MXJfNq8zKN79gNwgDe5i5P7qdPxm+i8N7s5MW4aD6K7dIbp6JFNzJawCuaxa5Kk4MSblXSyHBJ3U
ZmclFGt1yXTvuFPZeACR/3TDqaEju1WvGdkFlUwhzXsa03DBimbrzZ4GlfgliAU6xWWHdvlfjmJ6
tnTigABtGPfjXGrkF5rCqKO5KHi/QG+LusybZInxY4nBO99QU/jAhJq/zqvPIwwrScw7Csy/BZ2Y
CIhUe9hVzP73M+Q13gXJGM7fRNUOmrSIMIpcWfqe+PF8z34rYKPTAhECWXTiu5Be4okSex5+V4D9
UD+r2u6Os51w8H4T9WQzXG2vF3+IcR7R0e+x5Ych7+wADuZ7h1BxLhmprPHmaguVfkZthR0f9S0T
4HUUMhuWzbFD+R0hfdiNNKCApP+mY8IshzQ8dm+GJkJHeJHRSEFxrMzHI2I6Rlt7Ao4Ol6VIkQJP
69p19rM7OEgWG8IqmnCY/ZxnuC6vSfqkCcJzsBbvJ3aeuBzZ0EKBD84BUflkfS8xpKdpwOMe4jVY
g2SWfay6koemoaCBZN6c7oh/0RaWuZxnVZPUraGgKTDIVCZF9yNBqhuZ3zGTVrSmk0veWOFHu5GN
NtQbVGklMd99w8h/dJhglr79wAtY3ZjVi9ygvdbHbI243kpPbjOzXNXIryMC1Vk897IDyBjFyWPL
uaN+Vh0CjuG+Boa+Y2zp95+QY92xfWvHFcXxkjnrskCBM/4XyxVZApaHcHJ31s4Yx9KYyFI/PCvA
rH87dMDu/91Vvvmu90AX9geTZRnERJwl+hy58F385c31vRpAFkfzDwzS5rT8QcaJunUyPI0BE/CM
Wl9M0nmkU8VYHJBiwUNkne0IV9L2VU/AdrfNO8GWfgpMyYy9Q4DGuFZxW4X3kTMnbLZkG7UzzpBC
9qML89IHurDInQbAEQVekaE0uC/H/N/JeQo55m4Ql8Nhq9VeoBA/GLa5VKrvSOwewaIQX+Ux1x25
Nvyaas2vjuh4joNCrwI2WPItW4dZPmERaM62Y+xL2uINXFgvv4ptV/FqT15NqGew/S/JS/G3JvNT
/CblE9vXfPXwNx7KBr1TZJ3ZV52FLZbj52q6POIYQg7MpHAmBRwtD1ab/AYyQONoP9MSS5GabG7y
L+GfCT8VukWu9dmjPH7DWpJgfmQxz7DFcLs0LB/RDwPg/xluQpZmDU6MA3/vSZ5rR2w/Gbupab0t
FOHhhB0jT5IUe58KlYADDbElskLm96p1ZKbqtPidoB47Gzjno0ZItZVNnSWb/I7W2Gijjo88DtfJ
n4vV3lX31PTf+kYXVTouWSiWtODU2Dbwr+fGyK+yI2wIeTPckNQHAzLxxyf2AJVUOB5mkLhUuLjE
jX+Lw8bfUq/7keoLwgs7aOEml/WQasnEmzhaaYnENCWoUpzQPcj8EKePSf+zyeDHUyoEoVQ6FvQV
ri+TTf1L3L5bc5T6pIQEIZs3Z5+2c+Q2y9giKGyyfroDguIvalrWLHnqSQXShkDqo8I3kTSIdLy0
MKDAGrOh0t6+d8K6UpEmcGJoUnBfTgiosImLjPljZkkrpfyPb+V6UD/oT6tYvQIhEM4IjgWzngas
3+y3ATVKH5+ibPs2Zo0xrtcxtiRGHqJGgh2K7JtaTYTiEiSQhR0uHO37s91ENucOB6m10/OHIdVU
/WYJPw71I2OGISn4J8holt7/wFdtA3CPpuQRS8A06o6feIviLV6jTsVrCoeFQfT/901LZL+ZfnZu
ctAgxUnectQA1y2L2fYQB0dVIrGSHo6kp/IWyiFbhfuKu8U1tGX222W4jmZdVnw7aW7jQ/U1ixbV
gh73HiukC1Jb/rGM7AT6Bjzi4jAHCc+2IxWK9xOPV0qPiRn2HrJINsCtxjQgcdoxY7fg6SlJPzON
WUXYmObn4j744/4mXacwcrIXaXxHuextDH5pZ+VmbmLtpsZgJ86Zv/+cLXeyj9AbMd5WdLGBColy
HEeXmNjs4C52jDRHr45dOpdmPFo8y+AzpNWmPgSxsuBcjYqf9QJ97JEOQNXL+C8Ujp7j1nNa4tTd
fxUCSvQTfORRigR8aKZa/QKa/4I6eoqivM6AqBT7ugBmq7PAVoGnl3icWcS2PleMgI9wpsdUfl33
10azvhokNlEZklX2YzK4K9pcXN7d2rDKqWIfAabHAta54IJSLJmewWhT5KM4VZ+mezMr+yJSKMoD
PbvPG0WS9dtFqaoj8UVp41JTe6WDpHwj4r5Enuw2vkmREYZiRkv0LIbpHhwUZzbISWHwrAjNh8k3
+oENOqBNSDYTIYvPKlFDu8cPobRWeR5Q6MRXZka1U8KAuo7rJEv9NX+tcE3H6pvPHcmhFAdg4Exw
GlkHpUMCuj3o08Zqxi3EtmmaJUbOQP0wE5/wdi6wB3cXvgl/9DzBRF0C0qlQSxRg6uIWmfpJJU52
45K/BvS6jKTSq/sH/zZP7fPB5cayK+mwIUH3Toika/rutDfJwUS62pVLUwDrBcSj1KjzNkOvxLNL
+RBPrWWpX48pgCU9giHQ2ujGBmHdJFOq9GXl3qV44K4KqK98yjTk1/kWyuc3sZZAfwRiwHqaaw3W
GSss/ZYN02SVvDeg/Ws1AOS0usC+NtiDg4C99kH3yYQ4auu6VQopOaC0qM1xNAt1/0v2iMrE33cV
DRY0CMGkEXgIvVuj0U/eZA7scnoFPm76KGsy9OlkGgu055zefqnI6KnpRgICYriNwWj43MbfkE9i
JiSv3E6gFb1rEmZMv+qFVR6pZuVGvHwU/CMdg7BXVaaV/HJvmulKaHdK79yPJd5KjxYjxCgzFw91
RFvEZuYX/zOBhYrTb5MH453mPZp+Bgx/lYjIOBw+HunrA/qY/ZqWqIcTiayhoKgSAth45XFrxqhv
iTl4kdPdI4Giz4oxpk598WddJcbi8YKZSXU+Iw/wJKztR6fwu8ZFsGiWlZd+R0wCiCVcfN22CH5N
VdH1mCjdgmqYbVjS+NBLCRTUds+E+v7lb3J8D7LbKk1bLOm6Nn/b1lSixBkGNxwyMya47UFYJSL2
HRXn+myYVXqyJnhcrHrbScM7t+mXD3hkqLJpsDcIhuDT+WRshntpB0bG5StCKyGd88RLQdMWESJP
iw9QGdiZ7NMUIG/WSgaioqtz99vpOLj1WiOC5xe9Qwd402RuhRxVqdysopovK7PUqMj+lkr/H/Ka
7Wu808Z9imgixFyI8l5W/YfHH/XkISO7C6yVc3CeeL6XOS4uFzbtVZrGOM8XHPH5fGiQ6Bs58rGk
xrzpa3T/70q1jR8S/745yIl3lMhdGhNSkBmB7zzAv6JT5ZyrjBncJxJ0mvCALnfzJIr2oYV74MQq
GZBhuR9pwJQh5NJuP+UXfyX0Lq/XU4Nu4uTYFYadJyfnhDkV8dQ7wc4etIb7l3jRBTynVrhGiiwa
6plcFvNnrsmhjsyUnzoM8KugHEkY+83HS3naEUaSX0q+ve1sG9USXZCCJZsGCkL59bZi07rYULuw
m6zz0GmDcnl+XkafHylzdvji9Y0Vy4l2T8yRd72gmH8QkAcK+x65Rk3pntIbk2ZAJKqkKW23u25t
mBWUjidM1qRMfG5uqd6n1xVAlPZ+YZv5rH4MyxBHTqjS3DGtX8r9RPXNQOkLhwgS72bMYk/5E/Hq
Ihy7yyf1G9Oqnk1efs091UmbOXBMtKgT1qPhrFl7NthPqRFRCrbuCPDiPpN/2cicjd2+tOJIzKJb
D1ebqs3odliAIEcrDyk0lYWymdfhGNqHaqX4PFZobkeSkoEO8PbeXPKHaJDd4mUMSNeeCu/qnuJG
XA5JfHQDWzAXL1tp/xfOZbUyU3Ngmmm2I6lO7igNCJETaQP0123w67njKYiyPn6on11PkGyWE3gU
3QhrvOUObMuNMQ+bpZ8S/gQOGeAUESi54CoRwss3Jj8EqhHBAcJRE0RLB1G1DUEqwlAwl9WoNdHw
uqfXejZJNvj1HYUDarOuidPcDn3NEfgR4h2RjmvNTwgTLxrziOFkNkv84VU5WgUG5SkgGpe6Z28h
mH3OvVh8p1PLzxUskQtH7KdCLv3H4RCsTI7Bvv+svT9SxdOP+9G4N6GW1L+UNIfa48buO5WASmpm
ljaHtE7uc0ea5K60pgKwvOnuA1s0He+uQxZjW+iPdeYDyOADQ6PYe41NuaYaxHobRZhnvt++KonD
iowb5npfF1SS20+b5U6iPvhwlkZhOh1/iN2kc2mbUqVl0CHDYJrzIeWkiyynt42fSkesjdA3qMVp
P8m3m17VEDeYIOFGFtGB2DxMnJhioDgeg1qHmj/79NukcXYxuZpdhbsMHilRk57VBWnIr5JjCgg4
NRMVpL1mSFiQGtwkxdBnWyaQrdPKs6uygUyAyc0ZW5TIw+uo3a7RYh703BOoszcVn7et2jwBFyKO
gH/qzi+KxHDeRSnKX2aEzndCla9CKE8gkYX8mrgcqDi6RavfExzBjs70zoUhj0mApdqPyH3NP+20
fa5FTyDswSzNJgz8uIAFrtIyPWCDmTOcKevTr573c3vbYiz/4a4W+a/RjQVQt1EtszuTZWeyMPoq
FogRHY1cshanJUoLltkSJ0+ToXrnrHISd1H9njfyp31FpAy2UTdVpdpGuw0rZioFwUJJwJe1rDbZ
oy9PJb7/6+zFJEoXIT4KjoGOs+HgTzaWA/EW9up9Zea+GwoWQUsiUjWdyrPVfJoXI7ftKEa8bQII
mZbuV2Qrsohh25ZbMtuh4w1cjlEGI0JcYsI+2dm5r7DMClt+Jg/XKoj3mRQCxrD6oax9+eFBiZB3
1XjXJUcqwDgCKA9dOPGJl8QCqYIfvBgG4W26/VCLBJIPw9a1UcByhCye+Pji+DfxeodhDE4ryvaN
MyOlthYIhNVlMJwSo6ktlwd7GyH0vxtNI97J6bpjFQTujZBFhCtURet7+mquk1yr237RiuKNpvcX
Wv6meAOKXtGqjFgo5Orf7jjLU+wNdxJflQjtHNvtcRW/IsaIE99aU4UP8ZUpCm+K3DwgoUwHwoSX
2qYGapdcauRrwqbEKMoIDz/z3zeszAc9vqe1j4gNH4kE01aB1/V5BEGGDI+pwNcc/cWtbgYU7xrf
LCsWbQFMK+S07HOkaBXkGd8MU9XvtIWG1sUKFQdgz5PJTnMkufh/mRcLAsUZ24wOjy78H503sQgW
uiR1nr037Q/7nkkI1+NjX17p9tksEQYh2FGfl+CGvemaT2HrbnXFyz+Yf9D1Yqe0tXPxn46qaFCw
BPKW1sTYkXA8iNUSPfJFkADx16XmQpQa8nJpmgH6xHRLgPkBDgofne4lXyXPJe1R04xT+ERPRhHJ
ccRO96ceDmk12dqpzc62VBpHmN/czcGzQrfu3yj4s4RNZjjx8qLV01YuzZlXkVg9Lb01Wdx9Iajm
L78CQdgf1bPpWczH8iJ6XhUI/W0hh2X2YTTcI/YFq5t/DWU7puy6UVJYpiy9VYNQBrUDIXR+8QPL
TGw0RRsCu689eeJc2rp8lniaWFeI25GBB6DQKKdg5hhrdv/0R/mwTRArQfP/gV34qEVW5cPEDseZ
KSfo+RIkTUaEgLYzgn2CL8YUa7y/EdF6UX3VsVTN5Zhat3GIv9bhjEZ+EPlE+oW4hXjFDqK68nQV
lR/MX5nHCB++yP3ZxjJSUy9f5i8f+W7wcZQQFSqskKpgPvvSUqMuZv29OAgOfDsSaA1kG450+EJx
FdiOS6Ypra6RP4EnrSezkBIIliKhk0SsGc+IQnkNUPYjhZ5xKIRWTa/sKOYF7z9ShdfHjO1IzWgv
LkPR0UYTdRrYsYPlHp6oOQTGSzkze1/O/ZaLzP2MxYjpJ7HP8Gh2ZCvWk5IHbCsg8FXf0cKedq0I
Ofs2LBVMMJ4PB+q9LNbbIyL6YWLzLsAeY3psQKLYuhbEvVJanX1+04ZINUWHLtqXUQ1uO1KhSbe/
wy7CYmHHbsGI7Zb+aQszpIY8WoOJgfSmEfll6HPZR71ZoD2UbEPcwpru/y6RNInLpb6uVggpQqXA
QRiJOnMOKjgnGVNkF2SDC5D8rAlKqEu4jhhFrBF3Z1S+sdQg/DVQ7IDvsVFVjZgtr6dCtwhXRbuo
7zG6avusrwGhOtkae5shBgxPe6sXJH1UYxwa09khVPSyasbEEgTBhtI9GgQoV0dPhLw3TToCQYnV
2CUgnXuwoYDEwPPfas4pTexvIt/JQBdUvhwJpSUAu5b0pp3GPUPbU2BUge6+q+pKanyW1B0kwkxx
LOyxiFzl2LRSTUE4HuzoLIcjNHBK4bCawrWVv0RXHbm1o44cpKd/nsKTjB3+FvDqSTdCCVl4RZLI
Yr0zMu2EU3y8HiUt/4AqkShTWvE0gKIvxn6R+/6bD8bydb9zJHvCenc1M1yP9mX4YgKUaYuUypcF
6WdHOKm+iWGaCN8hmWFuL5oPdenbKGXsfrHL5nW/M1026IlmXtuDNpgUibPRoEuvosS6BMHxdql1
9x3twh4oWjqxT4xeF+P3b9e0U5TBLLijQEPZ+SzgdyHbAcSX8Fopo+9LMaYaQtQomYU3hQsad8do
M6EPwhrmjsSLMIp0LapvgKCA3hvbg1M/YY6HZKQWYmKl25FVOXsKLRjkWPZHdMVyLQZgrPsuyXee
TSzGwUMUl8kQL9iqQZhEjZQfJD7BJgxY0PWDa1peNkGklQ0b1AyEOXYpU3wH4I1NTlRQHywzO1sy
b3KLKNEnyMH2g6qOj4HUBiL2U9l+9zef1I5vFqFfAlTcHbL1nhtKTyuHJwvh1jce0ySZDQYYAe4B
zUd46P/YALYx7m5ENQX7OSPivMzGazXYbPwIpxcL6bVj0b4nU4M3G8hXZLpwUwuJ951jZx1l/Kmp
N8lng9zIUpKk5GKGo9L9cN29bI3TVKJpEOoo2MZmp2Ovn5WWmx1Ibep9GDN6jyYMqdMlBPsbL1ai
NoVv+T8c9Y7dDlDE+4MQ8rS5yQjPTETf54XEDVTESqsX46vIIHWP71+hM6zxfjkbbcVv7RkSH/nh
2DkHBMXhZSNmu2GuCXHdJXl2IZH6CxC0dX+rd3wyjQ/gEbhv6VPBnhY+NGeX04C3+9VFUJo0oT3D
inVjhusAasBqdhb1+FUkn5823E1qoeBCrLWMibpDAAc3wPA56T8JcdesYqOPHkPQ/wHUuDh9sT6h
Vpv2rfK3b6uSIl//JZJN/2Vxfzc02uJF+PUgDaGUDOgEuuSFhZdXz1oLW1rKLFbSXIEntt7EUPEp
5BRheCACKhNhmvtmmsR+2Gi4SH2V8xM7sJghA+bA9r0BHY5U3d0wucGLYgUXSemnrbc9fMYyoMga
8DYajC8yFTXm/0XNwQPk8F9es9YXBylSh6rlq7P8dHLpl164ykvO7DDQqsRxYA+WTWhVfEde+P3f
buCxUhpZUP0YRkRMQw1zvi8zIWt4Gk4M76Y3vMs2EpohTXkK+YylJyy9Is7RaOXgUW9+EJHpyGnR
O+N7g2ZaoKa+gharYEsfbkJZw8LS14XfkyqnW0G0EW0LRMgcAEgsOwgYvFulNQ38GiLD+TrR9K11
oW7GyUHHe//uhZU2b5y8BjJajljAJXG1AP3f3IJUM4Z7Iw0XfJSU7xOdZouycdEYPCpEOOmj0zVZ
C1ZNsZeA2fuYXOxzQPlaOfMutf2GEIUgO+hDXI1emN43A0ek6lonaCJRvsjOyNunrvluywKqMZBb
EXn6AsQMJjljlUuaFeUZZbU1amKvE9JulaeFx+9gQ4joPlMGifdMNlRhmdvC+8M1IMNLux7zZr6i
ZLgp8pHEbbADkGLmiESDK+ejPaW7CMRBqmsGDZT1rNV+LKtcQ32qA4EURsZ+pwzttMN3N7G257G7
IljJYnYNwhMSUO0B/lyz6yde3zBfRWcRtAUue9jEFMv7wkLbHVHqnT5iBQZmaM/wuWaEsZ5KVTfD
EoMKTBVidA/Rwn0k2Zl2VRKpDU0un5zCOMIpQq6ysIbJz9TmK4k4oh4wonViloOg6gbgn82kxjMs
Ne8AM6a2kZyZKsEHb27qH83mDWDJGRyBMmUSVuBcqTDbyB/qjSREPx/Ab+GZtWs5vKl05iMF8+Gr
XUzODTTy4+FyfRZ9qQpVa4LW1m4Bo7/c3zTpV3ThDiv4E/NJQp4ZrpDq3rB7h+KrUrKm9u9i+NzK
+LNZ+AEArcjQCdjyiae3o4QvudEpuMxLjMvyA/FL1XlWnW32QHa3A5Zntj6FOEcum5FL3QI9wj/I
UKlaXzfrnUdB87Vjqy8tqKCTFsckpiEeDD/nXeO92p2fnn2gadet/uWkxFU2zB2EnkfSMNbfUJs1
lDcxXYmPUTXc2mKZsNofrS/tIATDPAK8U/kV4w0Bmysc+ZNw2nHYSlcdrnmWlRgq4X+HarFfwDdC
j6Vd7OZuxm5Wqw9skRr2LYs5xtE7buLUfBGVUQ2uRjmDqkDby2JSb7jmVyz7y+2NeHbfjFsbJK/f
paKjebj9cm/JrYqTiMEFAp4yQ3I/kd1+zz8639tLCLaZmmIjdNGIt8SUHStTbqxdllGpX59QYE9i
xsfgYsUuQ+z9lhdegGWu741BqCxrjR0eoyY2DpzBKxu4c1fJ8HoTvI8QpSFguSg1nej8gHH0g3iz
6FeoubIAwC6nhyLj43iXnzZ3t3SbPgzs3Sj+jWrl5Lte1Et6IjO3LETidL3jWAnMCWpjSXTtWWeZ
wf/3LF7VE+77GsOpddtGL88Gw5ZH6G77E7DaU0fcxyKeSNEgLgCAV9E58hcgNUieJ6a/cSH405l3
21+i8WYcvIWPM0DdiY4ypMS4D1oX7SBumuXoETL9QfJzHzgan2B4CsZgWCG22/O5VQ/qT0kcqkR6
gXycH6WGm8veyIObuwVYFDeHcI/jngfSF20DilH9kX5qDK3o2G07a9UvD56MnfY3KsoarnyP1hWG
WyQP9pXfzE/YD/cB+cJZprp9+0Qd0yBjAUZTE8jFn236IrOdX82U6cjICsYn3E9jGGGAWbLkJJI2
nridWygiQmdHNYDP8SOSCN39iDUFpgze0XS8CLA/DsX+G4Eee+Fo1cBd5cIOABsWJlTgrgU4F/K5
6NyZjCPnItVgrfqD1rKx5NxbK354qP65kPBeAY3IBMbJBBhIMfW8RRT7/ITlUdT0pjCZ/h+mBTgC
kfyq5aHUU+QTUB3OrM5V3nvQwFY0MbNv7RIB5WFOyQ/gZxBg4UMZ5Ik2b/r5ivzLITLJ0wPOPC2m
+2vXE2hmkRQqg6aLeeI7B8qjk8o+7sYRBbz27NJ571WCigSJU7HCvY3bioC2qtj4LoLJLbcIe4ja
lUJtCFk3j4qGImTcFWJFPIIDNmsimZFqKj6oHDM5fM6Ld0i8l5PnC9cy4c1oS1hweC8ctUxcQMTk
YyLVAo4mxRlfLguiRJ7QBr13o3eUcRC8eNcru5Mz8E28J7Zk+mveFCVp82OOgDPzPZmDk/qTlkq9
PLQohHTi/8gGYOORa32sk3hh8UdflmhpsoA5+C7k91mJ9QrjZxH1YABZ9L9spP/hh7vTR9/ZuP2k
dWP/ptB55uAfMnOVLeLK61L4VxZGdQYUh7qSVIDIjAeDdkAJeu+TktXu95dO74gDmjOiGvRTVaBd
uF41vHlTvrRW+BPHysi/9mT/hpRg5L5C1so+Oe/6UE5PRCtvEnQap/k8QX3cxJm0T3qjMgOF+gJa
14IjrO+d1M33rH6WkHc0YBLVfUXrUgb0d8z5oaI9AEgYn/W07bS4mnKOB6KUQoriURpPKRIMytVs
73St/9o+/2RdTPZEcsHz3B/9ge1A5O0MfG7cJWSBZ4v66lvMyvsmm5nladD0Phz8zl8LYb22fN/j
XcdtOU4I92R+Pw9pcDnpedgj/hx8m78cnntY3977IpOYf4a2KT3dLquYKJbmSOMrAh0ev28Hu77z
SJrKfKRpWR8ymdTEnQTWS1ftyZNbnN0IZ/vvTAV4KzbOFMG9BNd5qQRjbbOu2h77uchsfk2plPN1
1T1Zkn46sr8SdKTVF8tto37tjmGbLD2gAoOjTqmZl4XDd89f/BQhcmSBiW+vLZUiICoWrOiRRpKy
gSfpORA2OVpUbpKDDyZQCSjQp8F5XRbfytyCkn0WTPHK81BZeTLiWhLEk/Rses8xPbreCe2IAXtu
OVK1Jh4wLunxar0/z9LxElhFMi+UcLPddjLWLo9yGG8Xu1Gh5LWftaFijtb17vukr1e4zJydWI1Y
QIVL5GAZWgqIyHImgLHyZRSFBUwS1v+hbfWGUsFF6gyRL/uUUGzPdVtLVUQv3WPYnHHi3hAOSSl1
nOOmV5/92FnDz5oPC11tyS/052R2euPxF46VS0ZXgzYoyiQGhR+SSF7NMx28YwYnYU7ekAGNu0he
BbKxT/+P4Mz/VeuV47o74zdsoMxQ1nOseUdJDxV2rIkWSuMG/NnsTfuGFUB1SuSh+ORfpcMNBov4
f/M+EOVe5mbHJC4j+2uFlZ8s2vKs3V8DOvgHO+MS7OUm5NCVTzSUdFZDbgvyamchcbaUpjHViWCl
DQW/xbTdG70z7YLEAmVm1t/Gc7qzXx1EczBHVSrwDAPgHMTnszBLkF8Nj2+xhtQXZYJ2gwxhHCI/
oFiWp8bC7xVyVNgp6PedklVeDCoe4mxDYNxmQ81SuVxJym/XEERiKoBCJsMBYQ2ETraepDF8IMzt
8Znz0+HCjUe7Xt2b1xWr24u5pXNxGTkuFl4GfyJaIIQki0kz0lXM0ew9c3BTvcVvkh0z8JGeLTVl
BvAGq8XxS5ME6626gAs1rX92amOqIaKht/XP0j9594utdY7l+VqYXrrPmnNg8K1Oar7yKOHZ7asu
kIkDgTZQ70CDdhAF3OGmYSEGgi1NLXeKkY2+0yRAuC4cMopoCyJgAVxJezrz5lx9wZcLPwIrPiXr
oNQU3nDPOEF4iXVIlIQ4HngX79ix6L1iYN2cHho+IRlEupmpBZ/6L/9CqM5yUXyL4uxeh4ntF9A8
SyxYV1uehl0M+93HN8FUXB5CXASL75uIbZdQ5ZVfz1QR6ipDRu9Jwc5O9YZdU1j8a46stxSqOlWk
vKLWTomgpr8UO6OhH4CIdfwDCzvVT2rU7UZaWnRZIo5xvJZmQAHLWN7I25bLQ96zS6FKvvIJUrgp
tKlhD9sjE/2GTFPn3sPq+ths6Bj6RejzhnQX76qtFJWpv5TPx1bbs/DX2dLun05mYE9MXV0o59Xr
iwKrIj94ctwljoZpZQsZq0wHPkm7+Qbrjjoz/d5cudTVa2OpQxSQ5YpRTOeeR9ofRS5vhgmNsK64
Q1g78iE/XHwoDlCP8fhzykBJt6FU1bpdZ0t2UOUZdJg0GZR3oE1WgS821OPp5bwkeDTHBcCpjjuy
pTkyUyIsqfNOSlFTeLWUGoZ81uFpwOCkHHUVVcQR78yY6xhVxItW16yHX3KXqlA5qJ/D/V/G7p5w
/RQVeOpPfEYmBGvggAW2iQY4LRNxysY7W0mVKH+f/qjKi641liDEzVYxRrNDjP133XQe4Tga+dTj
O3P+0B4qYHRnzrISPNZ7fx097VnhJD86VKNrfkwqV8pr70Y5Xcf+F+DpXENAyicqSmH7g/I20mmp
HyG6wBY8mJ0ftPhm6JnyJwvsOo8jp9pa49dor0o2KNxE2fvj4UrrXi6Dn9/ENgYLT2sNTStblsVG
zB9yc3Vsunp5sp/0H1GAj9tAzjtObVuPEfP2EHhfLvqiTpmAAuqGt/AdS+ujiOiEYbrEyHmMtPuO
JFE03ioGXyR4U+Pzs6IWnYtmt1qT/eyBbxcc0ImPIUcnPbSSJGZJxzKzxfZTn5AMx1ZnPwc0P09K
WjWUGqQHyiXrvvdj3uufymJy9yIw7iVC/33RFdyuMBj5BaxUSoQKxWyTcV5B2BiN8DxbUmGnYuEd
a+QOhxbt4fOI8ORnJh6XMB4ed8GmN5ciTyqeqsVwVMmYY7ZrfkC1eetc+dTro9LkFznVoKzwCgxt
kQLmZuuto+E2R7fsVr4YJ3A7Tfc7lJvEP3DOnXcL5VqAK7TXetHKVd7DueGna1803zY4A8rzDs4D
MGMWj+6HWuDzNfG41Npf9IbFbkyZPw+67FNGE3TYjGLemtbQ4JiNkRLyuuVN+nXgS3jGytTtgJBl
ZCKR+dpBXuol56ecpYopCf2CkrwyDe9CHE3GQqDSdPMTQxPZRKPjUPUvU5aqIsEZzJDYlM3jAMIW
8wObZ1u+mLaBf3uQ8k0z+idwlsaI5ZdVEWBRMpZyHsqquuQzzZtLUu9LGHv4bOtQl1g8l3uT/0M6
l7q2E+yj87+ilZSfVDuPKSc33gtB89eooXdyKSw6QC1cRaJ7kpysFNPqM7kFaGSjxgK3fJzl7jiF
01khCA8TU6VxgbAyOcpbHPhwLze0iuGulGidTQYSK6+2rlocgRqhzhpXZ8WfL6CyhboPlssMMkwT
5mgsPOMl/iUKPXTytdR9mKBIUZXljb5Kwi6/3CQogrD9hPFyM+4VcT5xfAy9AbCKqXcJgnf8wKGB
jvOfaAuWShZD9oZ93f14UEGRVQE6g27I+NLcBsfLIxb24+fyt/4XCTasdA8nxTrp2DVVA1VjAs1C
lSK2lEznnWnL1pLoxLsWD8KyAQHEV8tsg4ON9cOqQKOAtL8j/2/Il8m7MYg4m3g2TEqtvhR1qJX1
3Uoq6bUtI7NSIJ1DykhQvG4iJPbLsUEC3lAvUTpBaya4WTv7btRYj2xomdeH6gw4Lk88+zZKw3lh
b3aQt5b8gn6YDxD480uHsaKOSezu7lzmA6m898QYJUKram1Wq1FBJQ8BU/CONAwEeKkJvz0OQ7CU
nKcoJ6Xb+F8pOgssuEOhCJqfECiuzXaKv+DGXePcsowdZkzeRMMJEvYGsJhaeyNCLnexqqleuGiZ
z39gQAQhH4aOcvQNxc8CGDxbbp5ev7HisXhH1SsS5z+zBAFU/6CzJWhx9PxCquozsZ96pSPI+ZXG
fn/gBgZlfbv1pDXfmZ0dPioZA51zfT+Qzcx4fSZ55gVI1eF8NC2Hdw6d3Gyg8q2K+wP9QH63wlSw
xtC+bpsxEPGlXP9m40vMEdacEO264iIPYWXRQE4ilVxF28caPPl3jZqiF0BJ5DGMtFKKuMc24DVr
Cc9QWuRU9cxWC1CHaKFAIotLa3M75DtMMQveXcLZUiNJFbKslnGE9qBbuXBhIfmHXbs1chb+grOR
0E2YWApetdAOsFSPmh2NJcxkwzSVti3YSaIEYQ4LcTsjy2wdy0hS2496373lurUI1rJSSbsHGNZR
8M500euZxEUtLg7UMgf8xDU2fd7K1Nw4u8DuiQnAO9dvGaszBFNAbUb8uLgH2FmMY9Ye8qg5yFgd
KZwZoEKn6M6IzR9tHkpCgA2gvOK8+ZjII1ZUFcVMGUIx2J05xLOZADzp2LYwmCZbCAw08u6KAB3g
Rso/mSp7BGJlXalLv4kWfTRKF4IDRgSdL6OOr998AKWXgQqsrnRMfgouxy9dgFSm64d8g0GBNj5i
Z6gVH0wHSVKq5n9kyxV9OS+XpgJyDqViAyjbjAcMSpWifN7qID1oonL2swFgwje46hK+f3drCQ+o
JevYoVPLLbWBBJcpl3XQCTqaPjQHbkPCLOtOr7JZzHxvYXtplVP72hxOPNyHpg2ZDd0TkngkE0+x
8r2AL7RVuxKFCC0yB2W/BlNLGkxwnbNtI9Zn7YbA82Vr6sd8vqwbR/hqTFo8Zy+BXtScUP8EsiEH
+jOP7BeolqzOPlB83W8tPJa2rf9sMJdnGdxI0lK2RnKJxBSBkBwnEhL/CSRLY0JwXGxfPZAt/qqB
YaLynfbkj8F00cXsyAjb1NUtPsaUqx4fBZJMFR0wf2/hsCGNr2CEgvXpVuDLw9wXyEJk0V1384Ki
Ykee8LscVwPYkWCHjWexQbcF488Vcm3lOVLxNIHfd2EWELMfdTRQXoOWRxAhvj2sc3CuL4VYEq5V
GTbq2xq2qK5wO9L0U1FSH9uL+hrjb0u4Kfu+AAfA8GlhEYBAGtxqSYCsZxmJZe5blqQH0bzmGQGo
y4mdSsf7Blpk+/KshPX/uQdUr/OjXq9RJLXZilhWgMF7UT8mjpptdoMWPq+iuxOCJGocuQgjombP
AwMDGK+uMqn0YdQNcERgNgwRK0XbXhL1Tla6uAOqm+a1I5iRuTI0a4fnk3N2Qwoxydvy+r6wjUdn
W6gaLJjIUongdfysakD6qM2KoBpd5o3cRY9no+uQO4KPVXrSWcsdwhV1eRRgHZWlbsPAHi23y5D+
aB9EGd0K+wxkfFa6jgbvsOtPX8ILUMRayMH8J6d5IOgdpQxiC0pM8S7czw0yEaCDlmnEWcNbxis1
wjVLaqPfyHB/B0br63POwIwl0J3sgoA09DtIEUOH696sDtKQUJakUa2mRK203M6/XaORyqXziiVU
UFdqtD7pMFyLvUrSyT7kD/g0KwIDp/PRYPwFeIxJzxeC0aTKZUINti5BBb08o+gP0mx2SSG2MQpA
W18wzSmhIM6N4zxExiz8Zy3QJ+ukcnk0oCzxwKwLvoLwLeseCSOM/yVKm2w3e0Z0s2jaVy8xAqR+
MUr9UGuC1PAtPuHMYvhDK8JKFkxJR1N4EuZwwuZtLRNjr+bh913smv62ZSMWqxPeZFx03a4sZ2wX
1WZ6nxGRGWjJgDQxdZ+TU9mBW8ugYQEqrvNZj516AERUbP7Ae6zZJ/aYFJiDi29QrmHBCsoDuXiB
ZfIaJLDP/3We5EYvPyLMeH1gLFDWw97ALNc0OcAx2XZ8XJd381UYRf/QZZJjKHwI0SG008FCVnka
DjlC3f56feCpxVyNJ6sqGxNkBZDMswD4/ZXZecWttotW5DzPEz5kEM9/zbvHYsZvL6eEhCe5z/5E
DcTSWoWMpjxA2ben1uZq7uViIYcgnMZAf9xaLKi/Y72424vkqXqlxpdlyJw8W4PXmEO+OFZE4lwV
jEqswKYZfHdYt/1Stp9d79KrH6aSxF0LGDqi845zj4PAKGXIT9bPHQkwdI70HiY9BElilTq/2+2k
gtHMRKS2yxk9bkln3NwoQ5gCpXtsq2kZw5GsSKq2Y2GTZaoLwFymGsYwWb5M5+Bkxnguhex7DzNP
pEx946ljSQoOjkFYCwcjDblTAWQW/tX94mvaW64qeFfPtQhS3d1M94RPid4Et0RduvuDZ3uAedaT
4/oL7YXfE8bKNh8bGiW33OzU7bJUi5dnjBSi9Ewrs073rDKCMGBoLUGbAjv8n0f8WMQb5cMSTApe
PK+CVJT7I6jLRE4Iq82tLvuHqCYM0DivWfoF0whyHvuhsxu1zfhQyHHvpy+Di8LtU2go+i4VTYMU
KL+fMv8iHl5LCTW4VTkTqWPYATGNBZZufdpVTy+IpULKdBdDgWG43fEC+rUZyuy2nCN1My+oTwyg
8nrXeXV1YjEl5CX+QcopeVV01d9mKepz+Idwx9K4Oz9O73Q3rorovK4nXyHwQwNZNH6AuKxUuYNl
MYYgrH0C47e3QKucWDca+cTV+O6s5F9BimuLxKbac8EjPeJkZNjVGkNMAf7bDnKBXFSaTYulIn1r
KzPiPFmCdPkfv2QzNROghQbJpWKIFbQhWX3GI3d+7b+cHJ4AoJX7gHzXnbCm2pQRrbMH1xFb7c6s
ic8igzc1KM4ys2JAJajM/YI0LQ4TixuWj9SUBDr0ELSI4uU29OWwLP6a+vy4sXaY6H6cP/ziIsyH
NjhWHPO3GdF1TKdZYOKDyVQP42OsC4Ol8No7Ov2k7hhu8aLje0I/AVT67zmf2HJICs6ERafy77Op
CIonMrdTIEcw65+YchJdewaEy4LMpjxQGZ5LH2gKWtuAWyts4GmgPCegpMHaWVm8WFQmMA0HKsmJ
JClK9erGmJgpOyqVNKeTIiZEqEbM5YbyjE8iyjBiIPcZwz8WChQtTTI08ZmAS432TgbmumL8SPCL
ivwMQ5U1SfgLE8oCX6kXc0foBdMEG9MA5NmNKxwzWkzZapbEz10sVkQ/COfiEayXeIpsz8aCLwnC
t+V7ZMDE6Ul9y0IMyA+5w0ldwnMggHkyVHBbXoxUuRJfnjWCY+zlwiE6G4iKN4LfG9QUS+M188z9
4w4jpTSgu62Q4VCzSBKNwBtaAnLCen1RvvN0XTWTWy1gsaMyPYDS6b4KrkieVj0cbBgASGuNQxUm
IyWaZA+8s127jWFj3gCyqWNP3w1CB1ykYWly9dCudzuzdgo57bujZ4dZAHE4513s2sOmvzTANXeu
LDaragX5E276tcyah0w+cZPBEMavw3BVPGJbfdSN8y9wN15DNBdIFGvzNctQ4DGPwXLw9xbPkCr/
FnXszdYFGd3/m29WyG4mH+nAPm5Ulhy3Gv0A8+izO7un7yhpj7xuM5P1iM0gbBSTF1+SkMR7IHNs
E3AS/vHg2xz78eqiGxm2g2hiZpDV5MWvC2sfq8YVCbn9mYJZRXXrbDweM1+MOXuqP3xz70UD/EZe
tsbu3imMvbaRoErftViT42be5O7lxSAtcPuqpGsUUHdKCaY9dXnCylTbnGBh0stj/fF/2eWc2/Wi
frF4wT8uXqe13aMtQzDKvzMX5MDKW0ZCEFvi9lp6cWGdRWm1qrm5EWSTF6g9aYVwha7bHwlmZlDT
ZP2496HZeqrWB7YWxgC2RZ/OxXjeMAGTrc+MIuNFUgnZ3AhH/aZwaSWS1wVbUFkBApMZOzLjo29h
CdYhoYuamqypj6Oog8zcKaivFMGnwfUuWGWAYnq9EIrvu2dG/Sibk+7xhn0z0HDHCLwQrO+I/2VK
u31yOwrqcFdencGUXc4rJXtjmUcIXMbkGAfiuNbDhupwP5mASOiNiXTzazqLffwlgl7YQNXlUQaM
oLbxvBCa2JF3GFdt1ku54fz7wg7mmwkiQZtFA1W+FVz01UacGKJaCvGw6ZlVntO+C4Iegq1Xkvoc
0zrYctlOJrhnbtDnJTb8POqo9EliK4ZtckQidYqVXhpH7VR4vCMdh6wDv6t8zGzvi5u1BwnOPPS3
I58kw50+UKCfzmCzv4R9OV0iHU3MRj1kVgP9SsOiA+qwJt7+bFM8M+roEiHx9+aGcCYb6UZPphzB
ZKVo/LAPUL33+swqSv20Cx2F1lADSNTqDkXZJ0o+M8OmdWd52Xj998Nxh9NwOTnZ65nSXL9A6TlY
cOENthQrI0fqJd+sh87VH0oa4E8YR4bSo/RQIZGd57e0FMyp9pcb71SlPJhwiMDe70KZ4U5nLv2Q
LECy9EwDYqO7ohHF31MS0qUImDzS6S1c7W57yJ1LhrX9MU57zh9XB8xedI+nUmBhWah8i4l/YdhW
8WyGg/EsUpmqgZBlbfPwctIFIWnZNYt2yHsLE1Ui8EluVeRPgZzI74vZwKC2enklB8qfPsTJlK3M
0HY/Gi71z8wvbQzX53yWG/BoE4aC659kKvCGlgJdcyQCKKid5A797A5/QXhEQJcbGzKwrUzYyU9a
Fa8Wd61d9PRDbZE54LZlJvv1RCeCwakayv09IiK8LxYM34UvexShDkWFC/iBKhOwH8ElQBJGCct4
ZLz+Q+nmLCX9sakFV8L+crRZm+JPiFIZrwPrKtMRTh6C/859xml1bTXazrLrCwqa7IeB1a3TAEg1
s0LuhmfZS4dddhT/5pDDTuscsuQ68ZUVbV8o++QZJdGfJPUPcWRCg+pbIK0lxvuioHmFrrvUnAZm
N0JR8m2pmtweQtDi8DeYink8yD5P0lLy0Imq5kJQquWm14foEyMoCZTkRhwElQSr9uwQJEsoKtd8
rqhAhwH3LgLqE8lCeExCZcs15/sNRS33CQQUEcb8D5jZi5oL78971uXnmTcQktmfw+bxc8ZfOgZu
jGBBdKtz/TWYRsG9RcaoL2cxlQOGOXz2vbbLVVKxGutUsgaJb/1B79J1wqzEdclk62wcbF9mH/Qo
r4XHCSGjJDaYO/0apObPiT15d50F0a2zVl8FR4K3ft1+ZKfoNeKhR1T17rN9I/O8e5NEm3bOZlRg
fr6qFqQj1+0NfS2K89qdUBXlGFFPmY7n65Tc3mC8DsLB+n4DAXHh/MpgDwls1Xf+w52uLfXBiVOi
skgF7auSd9W3fa5pQuWKN+qWlSS3TuLvNtzfATKROA809D0QgVRVeglVpbdJylOl26mRMw8ydM1I
maC7eKLz5A8A26ct4jbwwTy/atgvvzEgKCi7vAcRYuYskA66IFEiO91V7xeMdlSTmej3FhxaoUzk
1sJ6dY+6TcZb9ZQWbZ8KfHdX7EVE+f419BN5VCGUS84wrB82LR5CtUq8EhWxt4aoZG+zIkWex1Lz
wFsyDVJMxm6QhPDYqnVj3xZd0rnbFjQQFsBEGbTG7Js1AVERDk0KzK9qd7nXYvsT4Pn+kwzcgMZ1
N9+hpcWFayeijzuWU5vV9oIOVYDBaQAQRoQ9wbL4YohhrVHIGoPcfSJRstYi8ugcJgOA+Joby0Zj
37vPwxz3ElI7wt8KnyXFcPRYe7H450y9Dy2iVb2BW3rd2OOSFpiprjX2kVQCGKjRJAKplsUBT3PV
MPzpSJZrY27TmG82yYQEIl81IZFmovh9wQO5BdjVY9PjESUbxFe1c/K8fEXUHEwDebjVRNz2aMBM
gQHWR49dBPYGvdqZX/FQY+JJwxxYEJ/vk6n5Zd59S+YxdZ4r1KTQRz5Rl7eIFm8mYjNJXrXwOLRD
jAPVWi+Hnwo/7SE4dDRG5cqBGCkGjEi9ID9u3jtrXb4LYjbp6dPg0cnnXmyWvLZMGJPY97CYX3f6
IcZGG6LpByKsKLsf8/D6RFfIU0x+U88K3H0ROpCI7k1pKROXlcqsompG8w6I74L3zv3q7qISDV4C
IlUfzGjYzLvCJVtM+zUhzbLY7yfNov8JiQaDA4tRgfn3EH6Ugx6ewK5HAxqBtgiOyYoIWDXYlmh7
Luay3LNNoAEdKpycJN5ooSIsvOWiJ33QO1gHtkkgnku3qgvo58W73LNRFL/laIWe8jFM25vqP5EH
SDfy6I49hA7X3QJhb2uhGCLCKErMQDC/ceSjCJy0glWYMgqaEpEPgi9ArFtVoTx3Ytc9EPbjgjCR
co0CTK9YhM80TcV/8jYn/WM00/2iAwHfgTcMEidhtdGA/FTqePFX4iBsycp4ntN6WJ8ELejQtdul
KSzbdS7xseK7C0E+9JubWmb9hUoUIUn0vY3SFXEzk64Tz56Tk6JoLy4kj//IAB+fPnXaun/0Yune
XJxITwWOOV5cQK+LbL7Vs4LoAIyDLeqaMkwxXT31G7Y3DThIhEtrreqepD1tTNWxjE/k1GOTv4PF
PC887kdKFOK9AgjDBAimFbLS8LOC+Mxf2TwZqVOxIYw7g8sgkPt1w5bBw0Hz0u0bMPpHNW9JEi2R
Q8zquW3yX41LYbHrSYQJruDtLg2oFwkt43JRLkJ1yt3kkibtp05dsPn/Hm2nibNj/SFpOeKl6cuW
ymMfSNwVRelDHREsF2d0qd+nwpdybYm6wEwC19NyYKWWLkAUljt2K1/yCC4a/yvUnpS/BMSbQDjb
Do80Sc3LrzNarDYdGerEIsDWuefHGSU9mls79NhKxKuq3FuZr2Bm77M35SFHmCwB+uLM/69Y97Hn
8HXVS/ojXnOu3DFc8Ng2k8+ZAQa/RRDIGQWXZU87NveepEgtuycZrWICU7LVtC2hn9RfrAxmwE+S
zu/zjvu4fHy7e3+Yp2NjXqkqtlqO/ybwX5x0yW0BMz3/x1Sytx4jkupwvxQ8yiLzUPk0y6fxeWnH
/g2yv98uvpwa+0nf8qe5BKKgGe3Hiz5+JqzYYUsZE5h2dNUq7SFiAu93xEpKr9lPnhTpM6Sc5fy3
Byxc64xud74n6ozVHteaE/1+8uNlrbbiWqzqm/zbwtHbtIRJSAVaOBGXqcgVyBPFXHMUeq9mDO9y
/bbqQuyU/Zi8OLONYsbqiwCVC/lXUXY7QUEaNtSfPbxEYXh2qYoPvTQdyHjg9QYMcVCIT6Vi6G0m
m1PHXy9hv3vvVP2bBdAZdPPiynWlOAsI9llTJ4cL030YeuyFZast4sGdpk/JgLBGb/GImbHGgLZu
YsUVVcV2l5JeyrpAbIYtrLfBfpvAv1EjAd48JYwQ9StJfGkoDKD/JuRek3G2QsoDXb0heIAyMIlS
5taZMHiLteEOFPoQUfgQzBfHr5xKpZO0WRKmMjpBhwPF/lhlVa6+U6/8EAs7u31TomfmfDSHia0X
K3ISWtAJTBrzywGK3Fw2H+/ABcMuxVR5/KcHgp7c4mrZgCK6X1MUxhwibS9KJPK1oap6wQsql9mE
WupnDmlIg1y6EmoSddjkiPhm7Rk1e2/8DF+aBjJFYAIMr8pqBA6J54eF2IQTnyp01EhdtifshzaZ
RsZ62qnQMFee171u7Y8BwS6j4oylwfRebI0evf6oflAPW5autlHxuTRGSzitz8bBPraLbeqYBUBy
q03gU6iaTD7tc27Sa3LlyK5toWSxMKT5/EztFmu0cLXNvL/LfvYNtGc+zjxxfGnnjLmONBHQqWEH
Y5OHLzSEAZjQ6A6kSBmW0hEFgmxy6ogk7uFfwLiTXMwmlT5AXoC5lHozj26QvAXG71SYd/IrwXPm
iJ1AVrsA/xgdHTWxt7JhJOhlslSDsPqAA/cpJYmo3Eh7cUkGyqCSSw8VNZX7u9V+UyBTfVTU1VoG
0ozMR39xBgohor5nXGfvYCpW7LdeyBno0g8x6GizZAzeJjp5u56OYZW4brxu78ajy8okq8oWHI+e
fDB6KndpodMMsUbC5ba5oEUJpDaBooTTqAu88wFgl/IRoiZYzeCriU+2ISwS94deqBAlcX3AIR91
7MwCcPAFnMsdzORFc6Rd/H4T+gsny9Z+88mWjI4P+92j5fYgN8tgcEK1I9V9WFpbLB1joSTlFtn5
+yn1XjKLNpaFVZNW6bkKUvACwua0IA7gBTL+0C7U1XK2kxYvIvb/I8bzrg0MTN7dCOphnEGmmu79
U8kGdXUbndc8yD7l1nrVI3haKe48KzVoNXpVa8hXSV6nSOSP2KBnb6RruKuFKinODSaHvxVKEEsa
rj7a/Y7FdmtzpiL9xibvFVV1KVVmeUVUhXqJUehBfDUKcmyDSr73MGiyMd9zESGOj5YJg5QcB/xi
PKEqUIr+m+mSPGi4BTqOwbYufZQx8LEuN/8VyFpBrEEYjuih06uVAsjcTncmdWTHtoEVJOD6b/b+
u3A5Xfba5UyPD3MRTwMFPHvrgS7aBsJ2mzydeelBohpLzQbqh7UEJWcai/1gCLuATw3OFMNg2sac
tNzwFMz+THyQ3JM+zUuRO4r8J++gEFtjlNcMORLkDbMo7sesh9yhNgz8A73dTkkFTh0fEFaMbKaw
9DfP6gTiqB6X1UK5rl0NHcz2VHhl0OP1uV7cE6gwojOHt9LOOY00pyS1D08/WYHnqugUO4+/QBTH
i2arDh8uVEgweu78I/A9eesE4WF+H0xkt5pUGbZiIXb00M5Lcnejd/g16WKXLx1r8NurfZ9070RL
uT3mBZyki5ZAMWu42hJxJyxN9kC+ASAy1W5BN8hfJ6rSzkfezBFE7DbrbH0K1bgrU3ZMSILFMvVq
Qw9/6FWLfcE7or7kLguRdbLW6LqWdsTER/g/j2EVyFC4suaIyz9GBnqVLIQldc0YSG2lPyVmRGa9
3ibt+V2ee0L6p40WBljHWobwcjHhOWE74fzhent8N+VoDSgDWiHikm0Q+Ha1Ngwt4pxp9WoM+4om
OLVBiRPWlxMA1s8qu1v9T3qORh1sn18z9+L/q5k7zFgtHIPo44OYbDDL2b4j49BI5AyHu8PsyFGH
l+CXOwomES0gPO+tt9nCJpYnVBmJu4lD/gAUNWsbVsPxNTvgFRyPG6wzwdKCBJqF5Ylxwlmx6M6p
6DsSPmxEJsGFBYqAxo6Xa2mbLEn6/wlvm5419clhGSARqOUhcro1+P+lMOXh3rL+dZHUAOWG8bmf
AkkDRnytnPdOZVobJzLkNyfkDCsps0rkd5sKHZl4bXLNYeicZNyyaUi7OA6R+ZhzrM4e6Jm2/RWO
J3h5H0ElY109Upgf110nWkzHbEEc+GIvLZbqGomiz4qRiNe7kfZFzJibcrKb6Ov6+ZlbBNpRB23V
zc20BbzaECnF471mJe6oRZKS0LbtASKSWoLxbTe+osqfYBLOqdM2FXWhkG2G1ao8iHccIMC8UkU7
zzxx80MRgMVq5rbjNtQZaWxfUSOSDDSbXNDQYiCd7SY8JkA0BuSUiLRwa3D4382azzl8fZ3lUdnD
rqyiV6biKOvN9ebeFB2UM4dAAg1eJtXe4XfOkJT4g85ma0c8oXnKnHadgg1bSQ1tg642JBATu+uo
DMoeIX9D0vJwUOuLxPkvNGoEaHgdhX2et2aE+Ds5eKIfuRMHkjd9gW1EBYijwv4WxbePgA4lp5WU
VtJE/3JMI17TDnXNwmlIdKRjC3U3iEFJE28s3ry4EJo3b7yIuY3TrFrzusvrfHs44k31kR0WPkMQ
r0lYv/8gwtfF3fNAVExWgMEDOwdwttSGxSXaz2/IXERZpTfN+X/DKvnvEdxbX3bKi3R+OHrsih/e
UrK8jVA+G0fII5izFhyCMXgrUGVJCLa4gU6DIZsBk2jjAcxufhoWx8Q033pfjVKYhiAf0gzgafUM
gPlD3pT8giwfnVGD9REC0cDd+V1m83OcR2l4GwRN43GNwYyQmRDsJkTg+UYbiBdRJ2exDGQ7ekP/
d6H6mg1nQB5+BwaZf7RVA5s3ShVwIF1qhPV9MSObPDhhMkgK5chyONXLrReVWCCpJ61ZZ4ezaIrB
dJ467mw1ta3JZEpjMpRCTkhpslKddmUnhQamAZRCCzgA2FQGS8J6LTb+njFgBY8pSZxY02FQCzkp
/tnzZNCrIMOq5LgkCCtgmOKWsA47OU2gBJ89UGZtMoQNe9YhyHecu5iRT+U/AQhugi98ot6XYByf
RWvI3XE3L+rYIOB+1pdPDBHWnd6R7a8WKmyZ/XRAJfXhIrQxmfzQ1ES68albLt77BnfScdK25KjR
ftw6n7aLbeI7tywsqJwEoYlfjAO6xy8LAkj/Qv+EkF2JqZAVJBf2bb3WGlTwEaKehLMuSCeJd3ol
8zn8ABtUPFAfiMSb7LHb7mRpR2cIqh3uyJhXPUDpo2CV8YgJiqedPZ9EaF4tQgjhOG+lYpfdSbrx
0xd5P9UfCNdJLes79u9YwOGgBCaKW6+jHFCDRGpbXsnr37PaTIxIDRzNo78IZgjtPlOxcVVT4b06
rP4EQvlb0QW/fj0TSsgpI9kX8OmW7JhEcQKcRKM7Pxplp0uiN5SiD4XtfzzAP4UBpIeLp75WRC4P
wXSB0QQe+TA/Jq2o3VzRpitGeX2yhUmhi3Cu4Pb/nsuZ5QsXpoyPLwngO2xOCob82jpTEFFZXg5h
5dTBOfNlWYbTmXN/CE90y9qRpKWRHmN+k6TyOJLaOsuuiuyYzY4lxW8rTuu+lXMu0qzch/cLgf2o
21PrTfTSJ5FDPVU2TggakMmKPQe/TCLNDNEaMnsG57fGhxB3O+SGlhaFkb4xBOSicl8ssPKT8YNO
fxLmXJwgiOMEioqXgUmBovdF0HJWfPjp01OVEJiT0N7hEt+x+l0VLU0DVdvCFUAgmExDY9m/y2dj
S2FwHebAJTAC3I5WrqcUqCXnO1pQ2sVLeCISW+F+nDzij2qLHzfbNzABZlXjs37Zv8nsv+FSeriu
nc3+xExjTjME7uduZ0tFXHHrrmQNqwEyahTImmujkWSQbtMZSdi5INp0uARZINpSrR2mATdFRXY5
PoWqUMxSaf9gf/mfWp67Dnwli+vbXcuAiWZJzZkZSgnOqF/+nfv3X6QeKIOh+n0+eOubk4Ay9Y8k
mHJr842EUm87B4MIr5qYcEmQwPWQ8Ys8cEcdgfqBRgLZakEBfH4axow3Lubss9c5uzUH4JRjWmFX
e87up3sPRB58f6drwkVD6l9hjtVK56rRWiC6eoSMCPfk1tcLGO9YtW2eDuSAyfa0JB1c1llnf2uu
vFK++KJJPUUJSLsz0cfqulOraUphycM20seFnLcrxfB8qD9c+yGFD8cyRAFVG/byQ+JVLGzuNyvQ
+Xv9WGWpTQNf0t1MZtYBLNQnHsae0vGgHoveRYpX2zZpFB72WKH79lMscVo6uqBEyMSv6s2iN0qR
/UZ0oA5V/8qA5kEFicWIiN19nXZsDedYJzvmcg9invu0Kyk3mDFQuSS/fEy/oPa2dzsAg9IBq5Ja
p01NdesV1EOVpMOeX0Zq38Z0o6e8XlxwP2BsufPjBV5gyTR3DMdCB0dx0nRA3K838RFNYivrEuPz
zss+tK67n6Zv4U/yVY2Gws/Vn0RQc+1wrcEhPOWkSmFnio5kxNdYgQA5APyVVETxf9YVR14kfwoG
EsKodJdYdlT4psv+dNqyW/Dt/cmC1OPe6JIJTBD9Sfspic/RZQQzjFL6+uDsfj72+iVSzbYiafOR
MPVo1smRRfX21Qh5KlCOUdlLpO2MDYTQ74D74X2t23FfUkFpfCuoBOKmBRQbllnnjdm1mOprZW6K
8ZrgAgUAQQR5fWyz2AlZi+KWIjKuZEB/T8szXGOeUIJ48fOqd1HHivxG92n+QwRRgw0nMcbPR7r3
M7Z8zgXkHRubmwMbBUvOGTKePNKeRL7bsL00Wlm/0+JMZVe0SYODw7a1oEoRD0CZwTYPS5LsfKc5
CrsPXaRCPP4Kjrr5m79Fwug1cPvq3RlZc/NCl6G8uTAp+1ldIqJoEsSGNWxNj1H2VBBgJsYJjzrs
ZpserMHWRxgL+MymFVXN9GKhQ2EDTBrjKE90+uTy49kXlSRLUh19bAYxW5w7vVUqiadYYeV3Yw6b
c1ffqsaGE+Tv3gVNeQCDccsues6oewS2aK2rHY1NWFIvhphEUrotBGc18MHE0ijTyevLazIKPzKY
gUNAVNd1XcVfrcj9/RlLtSl76Tl2+nqvmOafIBMjLNKqfnb69ygdy+KsDczN2eK+93pdKuCCmWH7
ctHklAweu3kFForkswTfdBLsoX94+Rq/0MM3SX8+U1fdN+SCoFIePt2xFgE8/2Q4SkTxEEm38g6Y
bFmiaVj3y2REqCMlOy+Lp0ssZ6jK57zLYuUdJTz1TrhS4I1UMI2wWHz7h3v9shqxdCZNKqFO712L
LclEqdqpYyT0VtVCxE17mPj3/lEk4kPbTOVzuz2TzbU8XW4xoAyQfojagpUBqDcpIEB25hJOpxMu
eknXSjhd4eIO41BT+owD5ce8GoeIhPh7FmcZfr0EGDnszhkJXgt3/zb/+ARNXMFZ3fLAqYBy72Tx
VI8jn/wnObw82vHnLu5YHeG6vxH/XlPlBl52mHWedCHTFvooqaoh9G43FkspG1Cgbh7e/AkB0k6W
K3++0EufHJVX7bNP6ZMwZXV9yB+QAOkBULFaPE2xsj0uqlQ2rlhk19i9p4OA9hz/PRBL9oa0K1xe
HPjFamgabYmY1LHcrutOqEmpdwkxwndModcGqmVwRQs9le9TN9Mxkfwi/VSZiwc0n70eB+IlMt9R
4ha0pZF//Ub+3Uev9PuSBCc8JssdxS/w+f66dOoFSO28Pkprhe8cQpL0USaYhGBMSeXv0Dn4mDdV
MOdkh86aWGi+ldoDOPuHJLR9I6R5CV/3Tsr19CyCta15/rzeOMUKGbd9CVc485oU/2U5+6/WlBpt
uZzLlYehGhLsa/p48huXgOzVoulXjhWNiEx7/5WT/RmoS+SpUGiwOa+R+uYc5sdH9yHellE/FDoA
gT2Svonby2WyomYMUIU0jf2c1lu5uOIaRePBm7DxKY6U8V1RqYbdqP0E2LxE8Ncd9QzMrPVCy5EL
N8/ylXo/GRCW7RogoXWb4nbu1JDl2nLCfV8WXn9K+Imla5+j3Kbqxrgnqw6v5tbh04FWwVRa5VMu
htcty8vXTgl1UVoafH6Sspemvvv5srPsN6nLqgsJtXpIWEf4XNYWPj6taeYqh3XDsQmBs3unkyGR
IsY1KGQwWENKfZ56gmtiaBDjM9MHi7u5ixS/aDrBwSwGkN950SZJkg5GmI3xiZWxeDqfQLB+UyKE
BUx5h+1NzvCO8sZ2uoFyLpZcs5M4pr3sew6WEzJ9HWdwxbcXnNE+BMjQasItdwjgg6nEmrr/pF1w
e38wkTSiTqbgb6gVzOQVv90MCJnlDAMNzdvU7zy0iukLxf5ACuCB4IdkSQ48F4awpXOqoc5uq4X4
RqBD0lWBcWiE60l3tMlmQWR+9GwfC6Xs+jvaTEAM8P1mGCLw/9yaK653/ng4RXLI4B8OuQRRExI3
yKiX8fhmc4k31m8oalc5YJH26o5UKWrtAy8v5w+BIO8VlNPTxQBA+/6vvlsRuBFILJHEcoSktZj+
hhZuPcRDVrxwzUYX29djAjGSRmCzvQ9/TGPK0MVhUeQh3l0wYbAjKEby7JLAuxd2Hrr98jX/d7Ws
9Aq4vMAnZobbZ3X5ej+EIaaPTdSrVbemlBBbFpGyVsKJ6cBlkGH9CF08wCm7G+YZGZEnfQRbtmum
d9p1xPAdyw+0kJE6KXQIZEaC+JFuBdsx0oLz5IzScU6TPGSv2bXcPG2Zav8erkBXntt8NGxFgnQE
jnnQlF3ymNzSaa5Bax7YKwoarq4yb+zV2tad15fPrpbHgoM6bV4rUapwM9wfIBafLNpaVkqjr61j
8KVgKUNam2tQGFckmwYzPwacDkSuWWmPxW8xc+xwISb/g4e4Li/wM1Z72DB6U9Eaj/Jm1Q16QZCE
tW25oonBMzd4kQdxuud+vu3K0QnkYK7e85t8pq3zPVUvseWCzy+aLE8MYS2qymmDq4IkFQXuAucR
TMKQm+0ZhCAwRYDPdQ5d7Ga4UhgvRFWtOfdEnIViOfB04FwrH31Du8HJ57E87OsPaZFVJnOlIch7
2vepOJ1DtALY1jm8uvzTar6tM6e7yNK576CWf3ut7ZXA49iwS2woX/inb/sbtJsw6C31GHUFF69H
Ag3x2oOuoH0zcodKjidCqYy7gdZffLcTRLr54RT/WWbbHzokDhx+Fs5gu+6v5I9k3wv+d/VJW606
PfLEWF68DqDLKLRfuOvyAYSk6CbvWIh0TcluApC0fUdLwYYmLgAygfB1t5RYfE9C0AtsNyeUGIk9
hwbz8fhp18aahAEe72OfXqcR1/lJ26B2DSRzjgwLYc7ckQICfyGXEETmIk9Wph0mSsxGQ2YVquLu
kZL2QYvqNiNlxLykNwnZB+bwZo5SK83ChlVy+aIhBGgKfxRZ0q3bvW1nNkG3KLz+Teoph0r7qfV9
rXu1Y+KhsnSzrQRNaz0s6vbcVWImp1nqx3Iwlk6TjhgYGhc9KuBbluQvV8wPkbTxT1wgabjJgidT
R9eSl3urWOI3yb/YB497wXBPihJgBQpG8dKXoRDtVEydQWxp3pioYSqTmXAoL1qOrXc4Z88Wf3tJ
biKAae/rEXDwIlv2ePz+fMSD2janBc+jZ+9NJiNr0f1dOptCIEIsN1oUjuu8RtXgr4km/ajsyd7T
85JqEWHIzJZYY9UT7827Bc+1+ROwmsV0joQRO/cWbod/0dRLhG6l9QET3vHqWHNdVABvX6Vfs+KS
Tam5S8hBrKm0OBTfTOzbL7jtlEyuNBelltMeXRYZ03Np4lkypSEn57TQI+H4wQ9uT9fsEfdC+taq
6jNzKxF0NvFB4LZJiWhVeGUBqZ1DA2TzdGzkeVagS4p19UdEqXzYxZVbA8G1SLrmCHZnSv3LWM87
K7LfsCiSaGnHDVO6EUglQuzNt1x83BBnKOcMGpwWKZtlfjKMCUYhF/HYiDnVXKpnVSdusrFlUrCc
nlBobd52kjqagIF86mLo99aw9+NHc7lSZMMi3RbE9/XtBnQd2svO+WXz8TMEiOIoqGzkqzKrhAN9
vfx7odNUCmKeOxFNC1qXBAgcv8Qe/TSR3vn3olZiFGW4X0ZEsVD2RJDpFt+A6vWC5u1yGqMOEIGB
wr2wY7u1lyspx4LixVx/jfOo2FTaCaIhwq1S3LWmOu8uH2xHjCah148wn2YFFzchLt68BVO/RNAt
DtcZyKSJPa+tIhV/0w9AOJg9xNuBbHiADgf7sxX+pYT2d/nVZR8V6gZ5zgrKWDueCxfEw2Z/cA7G
+3Zk0v/eup6Qvo/+e/0pAUgNU4Md6ho+O/KR8V9HuLNusnuJV0Zktb/nikUvO7vCkhIyscIppUwA
HSJ4/iMXLhcQGIXw3hfc2DNRmislKoToZLxL+G0DLgMwryKjbMb7979OvCnCsnnQOz/tuyjJrQAv
Ne1kdwLuKTVxJvZ2S/y5ujLPphe2HG5Xl+NbbMBOlWJvMWw5qciCR9G4IDwDeLAdEG5bueuqqy8P
oMXwi5c/f+v6Yy94gs614FjMTx7BDhJCr39R6hCGbxR8nEIAvAyoQLruAvQDD9CIwQwvu/gu+kHs
nCZmYLmO1lEcqGbrFW5NtFQO0j4EUZaK4b53SSAZ7e3vJLA+iYU2J+lQNdPGWEHmhVLiJcobLFLT
tjynSdvFzSb+fHNUFbX5IddPIobcDDOlMWRVcpZjOFWF+H4EoJzQ0WjPbqnlAlA5hSGVN0y3xPol
QbHMD3zQhkf5dg8nBTId9dZ66D287jBAhOmj+l+r19dsiOsf/ANpzGnZM4h34VNnvd57BUmw55Nz
3dtzPQgjzzBoLEnA0/4O/42kvbPhTBlVS7X008yWC3g6eZQfR6rf642ctqJ3wo5hEfAsjlDkeiXp
KubeCtOQkeXPEsfYpAXFvIAGxGWE+cYT6XfzY49OjSl47tMtbRRolOwcgE7/k/Hj+B54M5PRTaHE
i0qlim8nXaxJWX0l2cCd8tPocERkGpIkrhavwPajgA+XmVMcMKnmkKET2hIs6RDLj1887KVPe+or
8oZXSEMDZo3IPuzuQfIDWmcwD4B9fr2IxOS1QC6RDZYwvcUpy00Z2Yeu1dreTPrijKZg48T1YMtZ
v+6y+ajEBQ+BT06eNppy/kAXvGY8SMCPinMUA22a7rcInr1bdHDOyy+5XBjXm/L/KOY1N2G6V2LZ
r79EBtm1W9rCDYU2Zrh790cfO90T3d6GNXNm2rdxcqvfV9orkpQbx08W5V2VYe1O/jbhdsgh5sVy
l6sQk+UbhTZkOJ0JEe46ZLgRVZvOq5TrpBk5/GEEul91nYmDWehNn8FnuYfloPAbIxAPYtLYof/C
DsBGKmjsFRHklRqW8N50pAKhFb88ECkpVkEPTJ9hMaexi8Hwqk+CGwWcgcR3xKqZAm2p+ZzxCIX3
wL/2wXi/MIrz3un7snoGHB1gQdf38j3ObaJiTKItqp7ZPRSwzXU8dPDYuKS7fvVvJVB3KdhX8vPC
ayT3yBdT55AIGpQjra5ELq2ayRhRIRJrwiQbKQBtLwOpnmr8Po0r71kUtYUmytD8AezrU13FXmuR
cVHimuVo11Ph2tz5v+XW44Yqk3MAQ4RNRaE595v1xeR058af1KVBABoRVbojSBoo0hydPkOMoqd4
gJz2nogtsifPC8rpCQ55Kd5h9kQJbG8CXOEXNMH3z7f+j+gRN6eLo81gs5fznOagWXhNwLFqHVSF
Qumt+27OsGXR8zQnXdh5undv1c2LrRudz7oHSWVKWebYbvvUY6vvkrmKxIn/s3P71cIoncldU+Rl
6HDkY/RREDcAVGSko2iUh10O0WG/2V75OhM4ri8FALm3sCG0d9nlv/+eBtP2Q0YyvARVFo65EUX7
C5ppKVUimK50OJbix/LtoJKH54IYV/xRVBZmpxT19vC96PIF1s4b09IUzQy67NdNp7Zdfqbkor89
0d2+6iL+pyhwzRsuiiVi9dlWIHO0beEF/EB1g3997paiOcgRhtw2faynUUKTMYUmPnEEJYjzOsrz
cf4bqcatxq4BudrPEaDePNKyNc6uIeQczwEANt9BDqaSmdswv/dXwbtydvyMw49g1UTjn8QBF/lb
eF4i/ZzuZ8EnjYQPCnH/pngOmkwxjn0vEq8g3QkV4r9JECJo39ovkYPVIQqQjoz2K95f63JIMtVk
pIkrF7uLlI4nkxqndD8fhlWLEirntqWDHg0DxNOx4L+MpWBtdrrVOPN82MFjenl8S9tOS6WBeojV
nQNx2lgaf+gPRjBogh8TqAmaP/OsTjJAceLVsmuLBy2H72NXUi2J4Cd6Mp0y4pbUbDXtVh52uz2l
nwF3S7GnTX0142LyEBO5BsXu+aECNu9XP3gyMN7XDG1aLgLRntSJfOhT5qDoymFJ1L1hEkL8nmF2
kLDzXXwd1+PiWemcCt5eJq8zZHGa9AYOe7ZqzTq6btkL8hpqAHXIM14zljMJuJzGjZS8p7Rk2yV2
3QnAe3p5IBgEk44dGrHcCLXYYkpa5l1GYBDVs9E1MCDCKxsL8nb6xrFW5UgjUBTuVxMB3aQJsZsf
KZuJRCLxABdqUPyOAsAMuvg44NyXsajUJtqXAq/mCCelG3V8X3xSj49b/A/MnAbbGMcegQ5VKu5N
67W0mqy5HpLskFkiKsZhAyflvt6a+2yCqnU7lK/hG62jCGa9/H0ESmsKcgTCQwhupsitX8dDwc+l
lreRYB3GuQ3l/q2IjLGf9KXBuOWnLkmhJeEv/YD5AEXGtoKApaUt9hKwMbeJdPFTIfB3Q/1MgFYJ
r8uMz9NWNYKgc2hSwtG1B6f5JIvCfLDQBdG1n1SZbFWqZ1ebtZcN5f25eZeoCb+y7peZaDLF4C/p
BoyjTlZjqo6M8OYvzzDkjn0L9fAxsuwJqt/4dKANoaFbdJQxkAvk7PZesPovyNYzZucunyErMUyB
tM3hJnkat7zBBUpHGJTjhreVyTKVDdkcVugmn5cVT+2oD+04qQXRuRTSoUTA8AHvtfxxEPJ4WwSZ
OcBE1h7FUavIb56l5pMuga7ZXyxh1DK6maT7CCJC0vAjIaOJkMdA53BSuBlMtS21spTexpFsJjjV
theTfhopbZ6P7PZQT0+oFo2zzweBS3R3N5WZ/jvvA+x4oyBXoXjqlFfdNR872z9Suk7T9S+RD4gQ
z5+BN0N8BWeR1AbxZG+t/g29PB7Ios8tA510BQ+PnOOB0I2UKLf5V8ysQRFURCS0QvpoNSfOB57t
Vgl2iN/TI6xBriGXvrJJ55qrJNG9Tzo9QBlXaroAPIclTN5Pw6niFNSUTEQNp3RnFV3Ad7PwQF9n
63lYfeJjYFoBdrD0OuRsI1Cf/EpSPyabUcB0oisAYXgwLuuhfgdM8bXFg2xSNHrrPnOFrFFUmZCJ
lN5o8e+Xpn90FL9zW6ian+A2hnFCEYDR5BGEiVaWkTsLuT/UDpBosukSoMfi4wQHp7ht4YKjJ6Bu
/ZS1FQ7tX01F04RZshHA4FvN3YhHxAeNvh/r2i/MjLNGT2Y056+Ysu0gKVz1WusVW97rXBiBo9kn
gzzryrHOlyJxaQoFZVFAeqpWqabQkKeyAOQXekMpz2znhV8FI9x7wt/8mYrB76rYN0fOIOaBNPsm
3GUhk0GovswWJHIarwgcGf/D2bXHByyIG83og3AZB457IhRjZ4clWvpbcL5QMvZwCe0eVCsS7gJe
Ua2DVl2daB4UXgD8Ar+0oxBgmS7TaGzmpjorF5JVlWkEN/FFyDXaugx0LoTelDNWie6u1OMP6Peo
3C6mdE1/ijlXXRYAmNFzzfugcyhY70gDHlpZ1ZtOp8g5rhAU91JRZrQbsHOVrAUJ0N2D2lNSajWI
VpxiAN+f5WX1tt8neMWFhdwGp3e2JD22bgTNUlP8Jyt7GoxZ3ecSmxmPLocbAfJ3iAghmBtNgnT4
aqpO/7oONW1mHpqeBeSuls+FW3AOcSJDtsqKAKcT+TdLAbAqLy2GQmA8FtjgJRDJbLqieQdGubHd
3Q+5nv94V8KTak8gx4MvN8/phKjTuoAN5D4WGzROjhTH9HQ3nzNEfgKz7HjLRceI3AJN2UdUxznv
BYP9749Wzkcz7if7I8hN4M975tW5bVU+p98/s4nDJlIwSRSJasAIxNbY0Q/5BEqdxvsOTfelOZIw
0NxbVisJGgM2zMcWimnAtsUw25RSMSGnsX9F0C/CvjFqwGnru/aW+9hWBL505tRbaqZY0SI+2P27
e2/6pnMa3d3+Gj/AknVJl+qYAEIruoPFo+XsATS3Y+wkBLYtOOUEG9KUScKOuxYccwn9Cup02yZd
4/oycyF6vFf4MrlzcvQcSdkT6ztXJzcY6sRDwoCmNaKJGw14UpuO+DRlZDVaA0syRN1Dunf3Sh7U
2S6PWL9APstBkqwnDEpm2Q2IqzsUs459FGGHn18M3NhsVipG0GSe7SPcR3yacVEeak8IWCyNLVSt
3LU8zQRW//CMaUG+/uLA22/+3fme+x9C62YWJWqwh1pDQiIVEvlIJ/7XPEnijmHhgi1sYV5IwtN1
k/g89/rzNsLiX6Dnw4y/Oea1n98WMOtrvIY93vaCn9Mts4yGpkXsBJLMVYKd3fkGzqLMTH9UF8F5
WaA9Iznl3iJ7hWmWIQ13iTY3HNN9MiUVhtfkiwvIfZFK0PdEAe5SMSJlb+HG1ZEJKMoLbKlnKvaj
8tSX4r+5ak8pYggX6H/NSnF96kPQB7JrzqdbcNppnK84ErBtJo0J8r6QTYsLfBepW320hoqqDgia
lax8TFk2H5PVGYzhXkuE8fsUTOXvJBQ7Yp9rOGuggDm4sD7g2s+gumrWjExpVb6/N/lhBHJ6gSM5
gFfONIaYdEB2mP5OMLklcgbCeTYPwKxG/OjyePzclpdRWQ1Z6A1Y4VFYSI6uAxkrngCeIJ+mXAkE
awwD/FH12HQiq67xR1UxCokzMQkeEbSZJ3KRuBo7YvAQ8u/fmsoimFkDeQvm72Hr9ewsDRxOAo5G
Mn6pb5f7O3R6rtwxLYEExyBsEIvYNqna0OZLWnQppftNUaTSX4XXfwR8sXvb3IyjKK9TeYgtxuoW
Y29qgPTpIcq3k5PVgj/RuTcpmEI5L4Isp5ae2eqO4x6jtWgDTtdkMu1b/tCLvteO6JA1BlQ61LAJ
Yz9xI11ZXk1pTynnD/AzW2WJH+puY9mH65ZUqsSy1nEt7jTBFYhe3iuwwmY72lGFiGqeT18SYW5S
1oimGV0lxmt/vRwX1FR/Ha+gL9NVjVYwxXqHfsUyQuA1pcjWya+/NgARW1aBXIBh5ZZVlHRhdRip
PnrcEShPf7Y6c2AWcOUab21cvhbw52mqo51d4QfEVgzFu9pnlgwl+8aMMZoI5aU3GPaCUiGizPZz
Gxb+r59oB5OscvHAfQb+l+tOGq6zLs68JShDSAx0YJMT7UsfEFOCqTvkBGq8XTZUDirLhFsFQrX6
u+pXDTtRZpWfhi0rzgT3bKMsxeJwNWJiTLwvOM+rWJPeZc5TJbn86H/ZYTnAPeuQiVLI+BHmxtut
9U8c87ebiAtsJ0s6Ngd8k8JsHnlRZZmTf1/W18o4JPx20dLZ32kTB7yNeJf6gtfjkl6d/kNkRW2H
blxB+YF88BtOtvQ0h6+AlSh3njAhfiE60a+I1q9IeogFXsew+OCu//Jh4s07fq/Q5ekEGp4wmBkw
sacIVD2s8IOrwdyrqeAerCXwM2cD1voMCdjBdmO0d9hM1Xkcm8e8GcwEzwRiFWzWiy16rLUrUXml
bfoiHITg0c2Qf0xf14DD15fIwVrjkUZsciuBcAi/9G/jjj+88Lb5ZEpmxhDjHZrfvu4s4oCzD98B
HqQaDDzVncM6KIxK5eMdvIrlpOAiXWDC6BrjE4d5d+5LrE6SxOBKxZ1dRczBegPUkPHUngXuCOhw
fD0fCJWnIp7lFTkQVf6uTKG7jiHzC2q9XXhojuqIlfNUxmqzfLH5MgtcXnTeLH1m/Hz2aILvJDxr
yzPU9m4uHaS6GjU6S77YyRB3WqzB089xyBMWDDV3fBsF4VraCkU0aG4Kc/e4JYcwnfPzyD+74qWM
DlP/IkmMheNWlr5EkPdEPL3BalEs9Xl7HY4W9i055sVz1wg+SftwQ1Src6FtVfNxN/Mb0qTiXCDi
E1XA0CQkohDsAkTkzPuFPe45VYzLMw0ISrLIqMLvsn8Q7JVRw27N8TWDcAAQqleM8w+WBHMSlEuV
Fgn+X8rp8Pf7X2WlPEp26/y6Qzho4D1ZkWgGgKBkyV7AP7HnBEw3MQOIHDi5qebGPqygTeFpZm42
AM42KGffzAOdZDJa5tLawgEqqg+0om8HD3dY9of2zdQWwxeHOUuPv9cjXKuOyXvkDWqaY6cd7mpn
B7duYJz8DRIrf1vvcUJOCFfmJWXMjDmo1u6JphcSjGwm+HQ2WEvRs+GYaYGnJebrr1vQ2clv3po+
TIhmFel6k+BRCxBKcNpN8IVuQRGlzhv8nfJiw7xSyhN7l5iU9mb/hqppGCDJUzrfNZ2xaL3l7Ajg
K87Mb7mRMc5x8uQvZ4tGQHFhtH/Oi8/L7HCKG3A3B8tDq3V5hKo3gFWzEQS0/NslE8ZpwZxUHKnP
xm5cvLlMrQ8g049Yq2saAIyk1EUYq3xda01Ybe/ENELig31b+CRqBUfx3MFnCeunNmEdJcUJAElC
VpPhmKDR/upHyXWNXZ2tsR0f3Z+qh9fwf4ZVPnS7/JT1PbBMfbLIC0a6TtCqdGXdp+u4T6jI0DvW
XZlV9LUSRblrRyIlwKO2xy6LGOVRxsJcpL2zQ4yf8q8Hxrh0dfEWiHOm9X/2/2cMO6JUmHj76P72
YPbRJ7fvfNKyRGgs3XP/r4Jjlg5z0WQIsZIY+yOvpDj/6jAT1TR7RvSKaQ9qkDbCdgevNH28YVLh
fcgfsSNUgWf6kvuvOg4aAsVjsCmiML9VLVoE1Pa0ji5M1KQtgggKeATg23CPbxBiPIXey3KtC/WF
pkCT0Fg9Je0exmtpHMrTKN0uzKJ73itg3qeZwUaUB+w9I5Hogl8nCZZMS+BQMljky2mpTCBHOrag
n8jaPFsAED5QfwLXQ5eMoDMiZMp5moIUGCm+4MozkjlDSPqVGTSr/Y4F71apLkyncMFVUFJ6S466
pYgO7QL/rFNVGGHH+0UTGpoue9Qxk3NQVFHJQ2h5oNCt5a0M7WNtfL9B0xs9OL+7mdqvWBo9vDAH
/sILz0svAMKzH7oPLEgUWvXisTeaPkEBYv8bcLDnE2H947YYdXFIBlpK/mml8qZaWnYxyl+/L/eG
RcPakOz6e1iVAuohmlSHl6mUnxzLKpMTZcNXTm2bsI6QccNTD0hbGB3m0ZKiaLKv38hQQpdGdnIY
BTGr+Ydp96fI07STkoAccG7TEB4pB6KzwisfHMZnmCJAdr5TtGgYBL7wQCdILhmLPsx9kDjHsTPR
wMGKziVX4VkNpO39Eu2LqHnlwVkJoad6JzSkxTMPwdic9wYizp0TmW7JrSDh3BSWgeLdRJh0pRqY
kJrP3Iri2kPIaYz2z3x9MqkmCa/YdRtjWQDNGG8jEPq7jiGQaRj6e9WT3idcY7tVrcYZxcrtD0kh
MW1sF+xENrDr1dyk/paq1kWMLA0VEPTph9sXvwoIU+L0F0Yc99a1sxMhPviJIs2tSLcNFuarQeHJ
C5nO1nV+uNHQ4GA/9BzsYz4nCthtWIRmkWUjn4iQShg9swc4A29bHnxx1Bz31AK9lZ2+XSos/5gh
vJ0+o/ZFPa2H+fEgUoSD4Ne1P+SnuOxsDXig180w3u2IlnTbPAyvK2EyjipuRlBTUQ1s2EbOcMFr
ZGJsGu0eT8DTbo44by7+JL14W7aeTvZLucTHBT9PnZnvnukld7IH2Bn8NjvRkgPOzn6J6darW432
KL4ktscJ6eoGas0QmiWmQ2v3RkM2u24/sQBsVl8QZejFg7hBDVaqYuEdkqzJ/VvoEfml9F4DAwbR
T0NMMZUm2SmrNl+hMC0s1en0XcBr6S/kMaR2zGCI+nq0jIlJsFQXXCC0ge5kihKtPEE0NNI1tFyL
DKmKBPaePqPv/MWkapZU/Y8AQVmipzMt89cIn5+6tYqb7Ddn1Iun46Y+uWKghz3HqiReXk9l6pVG
RMd6LuWVFfxIqE8e6/iOtb9uXxSMvy4dbg3jX/qyj+VzXIW/bMyLD86NSAwid0MvtELgr4xs66mH
cHuVjHwxm7md65831BiK1XrhweMSK85hNETUlaauTF0iEio8+G3G3xfHCaHaEwmbz9eA9zmCSU+a
cRh4TFNEwbJowCLyYQtOe2jxXl7cPWror+dziuOeivbHJ4tMaEbDq85GWDlOUBzZgWiD3wuORSgf
kOa5bjrR8JxOCR0ed7Axaw52FCbKnQHV2fpJ6WqWL/vx9purThQkrMNAUr0LmOctoV7PuqVq+fnQ
yjL2ysxavePR9HUj5geZveJiMnMZE1e0LXWVh2o3IaVNUtr32uOl64hDwc5BeQOmGKatj3aVmcwG
TZbLDzaSi7YSjF88tYTzy/FuQkvOLti+D7VLY+15lruRCz4n+k8rSL6XtZL5M3B2MffUDcou3ril
QG1KtWGhyfPCLm6YohN1jjv7Ybo1ZJFMWJkJe/c5OH0gnfSrfK8heIrWJUOaDP8RwVrjNLyYZtJg
ORAHvr4hxnHc+B+sR6eoQ1RZ5wI/LxSz6w/jsKX27HiD7+YG9b8SaaZkF6kH91Vb74OmIrhSdNXM
LdMjjDvlXaSRkoU9ALRN9o6vfYXr9c/y0VF94LBY/UfCIAK2l2rOGaj50Cr+JQCdKlbkzroYZPIk
jZcIiNGcNB/vtGZw154v0oMTxn5sHfZxe6SWhbLzhTrYwCDG6XWIRa9cEzsdTozEDtACAoKT1eT0
TdzyAI+4fVlm9BrR9SRFtVWVVjU/MG/DA0/d79myMPxQ3RLsx4BpNO6GInpM/RxGTLK9UzMQp3Kn
t8gnohP1TCOVaCs/is8XUlWwvAR3cQXWyLhA9J73jwVSlfPrGdeN/KG9TwbgDElkMMIM7hCQK4VA
2Jg2zqofbTkLVks5iubz4Uhjz4tpIu12fRMiKt5bUqHROC/7sVsm9btMg3T6pNnNIu168ZBly7G4
UUkG5qze0xfsdbbh5YmI3298H4eEhiPkSc5vzeuHeulSUPCV5fYWtwQJikSOfwtuxQuYvuavOeD8
qqP55qcXaPTWSSG4CU9PnRyQfuNxiDjaFokN8Dh/BMb/bEZp0dhD5N6CeOEis0z9IkShH5x5Aqw9
w11dUODcgxERfC7fCMlwo1CqNzDSR2+t4HVcOmpRVy/Uzv26bTWA5pOYKqSwaJa2jEssSOv0CaDL
bLYWTLbG/JJlZhuzQUk39ex2h7pQDVfvpepIJDvC6ai9rU5dCU7H8p3DQp/5Afal0iVuuM0nTjhV
WbdCq+NS5AAsSemt5uGvV1MZonwAmTCAOMks/IcttbC2pxOOJ1/vMwyvwNnp4/UgvK421DIE+XOY
TvJP9N0bcZnNIMl2LVAy+5erncAUQMhy9HZgRKGhB9sO4KQ1L4l7BpbOSB0wydyZslVKOtQzbdYq
FW3x2NVGarzF/6BraAdUEc66SGvL2hv1cdsCI8L2BuLS+YuINLdCBODUBlqG+WslgQ5iyYdjj1OB
5b/C23bTgm3KcJIX8ioE3A7O4RRussOTvbek9dPPIasGFq0X0KSlxg42ZlMdIkEDSgnNTvFsitbX
PWNBlMQ0V3KDfYo8ogsiliTbDM9xHzajdsvdkFi47/KihaHWUZwH8mUDscl81CZcoWtdGHAT6woU
YzQ54W5F+yJmv2CyZ3HU2H234/ZG8SKdnWITnVz1K+QdjOukl5xhTv7cuqJuSPmFzmQpmvFhqNwL
4wYZ1OBXDSaZIPn8/OhmntBa5RqqfvPgJ03h2k/zi4NbZdf0qVefKDBATZHGTmp0aoQkz4J/WNPq
0CJfePJX8YhyZ441StbRlvq4EOYwVhWIAifKjJGuhaUHwanOYEtQt/emZMo9bGBmODxkNTezWERN
T6InwluHB2JcVsv7aw7uhk70cjyvN6c+zQtO2fIsBJCNOVOaU6rlUu82AjwWp1NONNtwnsty0cR4
iaWcbmvqNyCtgTfkqfSKFBls65hiBojtvPn/zyad2kMlImMFOxFQd/ysgjOnegJZU/8vFYEbotjN
p5d37uGBi/cMNb444tB8ltyAPxPv8kLmkrjTcaSlFDYnCm5dHQurAXKSzzBqMUzwh3mGWO6YKrhr
Zzr2WgCWSjx+r+fCOTd7tE0Xg5P7eOZNyyfqpz5CYh8qZpgaGzuGl2nV7zNzz5pktfijqmTwNjxA
d+rOj1XWuuhv8dix9wz9liOZ65g+zf77oUt/zO1DCtawRkA2/HgOMc7yCT+slOii5PlELUHL5kd6
tgtD2Eoh7DaZPPxGE9NVTMTGIQksYjyMrxrFahsHeY7/eJ+eLWdMHzFEYY4Uf+T1Qqdkl7tX1FTK
BqwJm4MLKDhpJmkofCQ+RIEWjV5j53AI1gdmjTKv4O+Z/AXF5nmxfAaLsmFwP3pDXyXODgGmY/GE
iWisE5j/94CisHTA6nTASFESO1wHm0EHc21ubahOlaRPXhM5d1KstiqccqNgsKdlWweeS3T/Fj4T
BNUeCTNUdcx/dAy7/lGcdYr9XWWVfBdeUIltEglmlTt38c7/F7Qvzmt/LtrM7RAXvVx7X9n+7oyQ
c4v7Gj6SyHOme8e/KBpeNH1OLxAEaAXZnP86pj5zDIKe1NNkdHxVHes5dcWgxTgQV1z3ZEytGK4s
wDzEHKlWpxMulcMi5Tn9pJ6Qtwsgk7htIaeZTsJmh+070tjrcMKgLSGpx8tVoJcbCea/oa5WT7wD
/sec2+92VOWMTKxtPXZKJyXt8xS6EPl0LFcWyJh/E/foGy1sH6tajNgkZ8+eB/Qd1aDnPKgtic46
GLpyQmXSXY464qCz5ZoNutlbWn0lO87DRTojbeU3QFmEabNzX0iWMrOY9iI98fOu2s37hbdgFkXo
XUI9/dVh0V3etPRG6pL5h0eXtW72MCwf8Me6R0I9X3NxBf6kqEzqLXF/8Aeu9DvbNeEB38svx9w3
kSlhLy7mtWVrwp5xkJieaPwpJVgPo+BhCmGDTqomyohmyUWBSuMf5+YvANlAvOejnpyOi7v++87e
dVePmaXnxp9TXD7+Bqgkhyc113FwcFupwsUH/SsYzxeAcFsVUpxIrnaZtZ9hB8MR0d6jAmEFWoX+
cLZJHO7NNXVerzsBJg8qWQeMQeOYQcumhyinHR1oKeD/T4/pLqjrV/IhP5w5h3UAeHKAbxDKH2cl
/Rf9F1TmWxoEK08ilRPDPjjRJ2+DRI5ePHgizounbnbf/NSvUOdpV4RXz4Oo055LtJxlQ3KmS4Fc
2WgpNxAbnY32MWjZw+c49qOEq/8Hsn1vUNobYE2S81tYfioyQuojbRdZEQq+wvxgIpcAl4DaK5+7
lQ9nw8Hbxu84/BFcUuKy/z0STFDt2DZ+mZJmYNOtCtdWYYnX6ZCJjyyOAfvqHcv9px33kicVipwK
5VUEt8yFMsEHM8hMQf+q1h+1VbP9tzMyAu7Xi1tt79M1WHh+lcUBbXO1JohcS6mK5VM4UZ3OzHz4
PbtF55qpUnp3H/yQz2LeewvGy2IuT6BOmQclIICq9kfvDsnRUfalIumGiWIbDA+lQCTvJUh+NjIG
DzpE8FMcHF/0hjAfQIzf4ZoZ3EIHtn6LmwMru9zZtf0bXtu0/ZDdpnMFhy2YRxVSCrcVQXg2ddTz
E8smpxe3ZHFoMPZN4Eto1GU1fNXrLTufu74wSDMqH+aZyo5nCOiC9iT69ze5QZawqspM/u4br8GH
j9F2eJfaNUV+/IJfBjOtY8AoDAgIiq3KqFRZGr4l301LTcqrZudayOObKMvehekbjCzvWALtm06C
qVgPRa84fQ85DTkVp6P/o78xNXtt/g32IXb3xl04quntmSUEamsymzm+h4v1hubWRCUioJcLQGaD
3DYKJhpqvLmkwy5SsMELoU1JmrcdPHPevR0D+M2o+09gSvdKpHujZ5e9karFdpWAt3Smo4YD+tWT
XSbsVpuHdI5uZO4orKhab3KgfZrHtNhGyu97a4BDl3sjgAfS6i3OeJBcmh/iYLSF4HQFinQQiXVH
o5DsTbK3viGVnxn5SEmquZOlb2ZdgSsdWDnAsCZxFvfVzdcKZ2dtbnum//TdOE+oAWWC+Y824vZM
+ufAvg4oQniucAdRhw8qjBAQ18tYMMTWYEmBNK7gr4tljrTv/83rZPODon5OWg20fkTZxCPUT8HB
Tk8btiB6Fu6SpX24zzh/ascbFfTVMCyhowT8sXnFYXq7SI7uu7Md5jsKV3rx4z0T6fdy0gsGFQ7h
P601RDABfE/dSM1jkInYbmzByurkjRDR8zHr5QfUTzVzU+A4bVGo+cgdAu+62R+1gr0xpsYjr7Ps
2nwJn/m0GICdHex7iT/UJoCrQN2eWezLRUoX2FOE09yywpvjLp93PGSk4vu+nZ7vi2q/pFPrPj5I
BLCPFgG06FtRE1Xn1uztZlbXB4VpxbF+JAbOD2QqwPPU3VgZ/2bcCq0VkgVkWeYUzt65r8/iKgSU
dB9RHvCXTpd5MtewQiHQmsUZzaKrUbn9tGR63pvm3DLVnEvsrefHT3ANr/FY3BH13Ikl+A4M6LGD
3O5VUVa/ET8qyOr+4CTI4lG/C9UE9SVVDDxTejNRwfPUyNCN/EVCsErxHqcEACxVqPyZjdfHXgJ+
6UaY3avVb0FEcBSHABgEUIwJbm4+yq0jIEDPqdx498Cztqcor77aXU0lhmLHWHel0a65f1+cXMG9
yWS87Dm1lR3pjoKabtyjEFiknGMOJ/CdgqLBYq3WEEh9t3UFDHc2yLjpyjDeDlMsCQJpjh0faZb/
cs1PXnOBymh8pMkMy2YcZFQzRvbOMIoXd4c/G1vioZ7rWd2V1CSlMcRVU+IOePvA1Q6nrdsu4pOq
N2K7kPaUkr8XcldJsNjbmnLY9F+bfjyE/kNrZXuzSTjaTKfnFwCjSi+xDospvdCRfLJ4PGmhEniY
5tQwrg/HdGerZfuBxB7MpiGin4Y2MUNOm30HJhOD8jAJ6W5z6wMT0tw/ArWYeVM9NbOVpn/FRxSK
0HhCtV755MSeXhSu6kK6GYdJDVF03mDewO3TwzUPWI3ykjfVYXxWYQUpTFfz1EafKbFRxm89dPjg
vtrzoS3fawsbuX+qnQAPEWoVvqxmpCRt1NIRCU40jIEi3cdxhYI4PuzXZzX7WOEFSAmw+1olLXCy
ZiA+9XPiTC2tHIS1BLLrX8VXBJSDiPoBI22wJREAMKBxgVkJ3wQ7CbqDzlvOiHea3e7fkSeMyo0G
PcwDinL1UUPtV16/kKmPCledBMtz77l/Caafgj11dzmm1JvqdFQpiHCyCSGwJSoYGFTJNPwkxEea
IUXikblsbiArDnFrWkKY+Y+a4Tu3WPcPef2Oe5EzL1wVUGP22sdaBXbPCRNEMGDbvay/N5pFK1W+
gvsjmM5GnrHSIHNgnsriImADq31CicaWAHjQ1clZouov/PksYp/SUoT1UvcojgM3dVzXeaSE3sct
ET7QA0na430kHlibqZ4GG2IaoLTNKglQrSRS6/i3UmeX7zEeYHt/5KJIaWwCDabP41kbmoMz6VwF
sIo3/GLZV2GEGa7PSnz9JP24TzIkdfdhBCzn0yPWLgBK1THjvTuQ6ZtOFzdJ1BY6qsDTbLStnUoC
yUpKNgsxJ94CgWAKe4VXr76B/ZYNPvhebs75SdzrkldqN44KQuwLfuKWjSz5ONwSQnfBWh91E0XN
ejysiNdRLdSm/uvpvVrr9Fns5DBaYozeGUwdP0Z/A+YPJd6WfFwe/HuXJX9XUvI5a3HUo3cr5XIN
rrA/hBYHSarDcKeXkIKQZctv/MyJVavaDNgWHWOGQbb1UtTnG6Zgay3YR9O1LYjdp6aV0pOtpHEi
VMGLYzbLdRgN8PrrK0wqWxbmaaEGooglfp53pl6p9XsCzD0ia00lZ4bHPTQFzt55ve9dXTr87Pcc
tw7MNdkqRss0tBrqwuMjpfj+sLGea/pZjkDd4MLWGW+ex3QtRqPRvGmqyHxLQJpYg3D8ksTtEDSz
TEUrMAvQvhSBzceJxDgoSIDgKI48g/UxbO5+MTijcDfW+vf9AB+pDa4ILQW6tcK0fJG2Tvtbz4lw
zuLRq2itmV3c+5+K3DhGqXxLlDgx0hl4Oi5qFodlQMzTxKLD4cXjp0rA2naMHoxyETD7KWjs/0PQ
O9omNIsGq0xFW5+R7krSopSYr1v2kVF+Cb8EUTX5RHkcHPBUgMQQr18Lhz7zXKzZciebgrwkBSCB
yc0nMagrfZ8Wr8LEql6LhAonLafja/e1AVGoQDw0aYbvulsvOW4R6EYAV+Pisheh24fg0rChfPg+
QyE0mL9EnYEtU3twAAul3I2yceauh61HdSslGUbdo5I1G3Uc3VRSvPBrSXTqwQrinR8PAYS5lDNw
AZTcpyzMRx+J2IhANs5LIT4fh091OrUsxS6AHGXfTCTnxeP79qgB+rZ8oeQ1kj0kaM3ZJosLtKiu
0je5HJPT/BgPJu96+/tjxVn5GKeUVCaXxsx9aspK/gh2nCn5oB3mkGFkU+m4jqYN4v2RCyHefKmB
/CGVBX7/Xo9EPI4Jek9lxUl/vb2p4sWDwBnqWwkv5PLFfe7PCUPX/LEIgTo6t+B3U2/1YeEeTCW6
XyWT+DRQqg0oO1Uta1eEr6WPQzkjH/11DXCZ1FqX3lKqfWtRNKrKs67EgiEyf9A2+CW8j9URnCyX
jbkwWlewIORia9473AMGNoXtIbkZeD4JG4+3j/VV+Oxuh3EgbYN6hdapnm8r+Ln91JS2xmsGHWJd
/uu/wha1JJRrvlnkkfccA/VaJ6kP11zdes+116uGWBwUaxk8p4BKy4MYgn/LdStRKfonPdt5hrTY
7O9mfk9fvt5qZJeJcHULdfpoedhox4g253MGRpj8L7Cdb6cYYcdrAol7qfFyYVrzIUuKRRlQdWAc
gFZCL5+ZdrinLAk43q3UQLbSi9NN0Ma/B0uGzeFaHNwWGfv9M/aTv7yf6hUhcNFiFKRsl9czGBX6
gRQyrOyvGDXbKb3Its2hmLfHfDIyyVqDNoAkJQKFIEmMvq9UOa64SVmNBPViQf9iv6nQRUKids/a
B1WV/N2yp1rSSBgAa3x23wzfm6/GNQV/pf3IrO7s29Hz846jh1bZJBGxVkjkSGriVS3H53vK+5ke
IL5sfu19L4ek9rk4Gp7sKt/1jwlL8ESQ2hbtPuckkUEa8eWAwrFGGaiMx61m7EzonlsFZxe4sKfc
xhHgCPmfpJVFYOG8zM5dmb3Z7ApfuujG64mPwJTCt95qyKPW6AwdLLShQVvlYFDS+vVF4Ykrg8/o
9LcH0hqQ35r/mbVfcXJRqXPEGNxLOzOWXrFpbuSQtXCAIUU6WJlCtJ04I8Wv4V9HAVuQabN9Awml
OoLHIplYjCrbtX7LJn93lyToMmPSSupcFQpNHL8TW9q5K7zJnPGw7ShqIwTPguMKB3wFlvphcTQj
eyKEr6SEuUIl69Ch900ev6raA7XBYcHRVIdqicGRYDCRKUbX2E6G8C4qqjBH2T3ddrIAYEc7MSUJ
A8zq0AHTioPFYRolmWFehDNE5VvoYxGKrwqWGHQteGa3IbK8vxqsB/nSQSZ44X/dhEjZbp7LLj3P
tNSkqf8iJBP1unOowtyb7rZJX4TJPX0DwSpx/kGauHaoJdKiTkYRp0p35fxtuSkMtJbpK+Q+0FSQ
aiv/r52Nla6PPsSr84RKzrfT+G6NW1PjHXmnLnbwZ0edwySFSHT4FvIvFWXEQZKjZh5V5aaRildh
kWPiunooSFljjbH8f6XoBgWYNzAtl8T12Pv1V8vVox5A3vh9oiwXo1DcFRYxUfY9f5PHC0KLwc5k
Fiv+elw/otorxFH1w6ggWxyQwG+R+AaNC2FAn1ZNa32C80FFzcR8N1kQv1hAqgOXrf8NPR3m2nJc
JIjMLAR+Ao4L1iZv43y0mlxGoGvmQeF/u3rNwqYzsZqBcoX1Ph/h4kYnuMrJDevSlCcX6itFVBFV
3PDjKYTIRMH+90injZXKeCOc9FaNZut0z2nwDYB54IE7LsX+AhN7sZnVrRtnKKz9K9VWxhgYPJK2
rXeM7aAejiviZ72ERVr/DDDZ+OUe94VwrNGnloddoM0LI0koqJEhBL16dl12p34Bv4CG1qROYAAl
T5rvCHOxDUVWsckuCVhKQhS2vMpWFZucz+epTwBurYLgocPjwiM4/297Gp0J9/zC4X89TrRLcu4l
VI6lZ+CqhEnyeRHjX2ZSFo19CGiQ4hQLqx7ku2ci4kjz81IAj9IgWi6BjDyAw01TfptW4OsUbECb
ISQtHNwJkntevDKzR2sY+Hf6RGg8o7PZ576+cWj/q3sOeQ4uKGkOBdtLV9jkRjvRWwRZkGje/7zT
TRh07Ihky2eelIgeKa4dD2g6OwXGBiOsqs7hGY9viWabJsKJXxgZ2UlTcCZaMFw/PEMz6NCX6/EE
hhqO2AcdT5RWA48kc4BDVNB4DWwA6tlClbG+Bbbm/obTVpPuKZ6rqvoDSqPLTS8w0xTUp6hhGyL7
/DaZkQcmhddUXZt6fu3Ym8DX9CWX0BMhW4z5fdGiyIDgjTfIOCijrHs57hvduFmsTM9fjdKeDD1J
hoyEiF6GQr6nnpJatF8SDyElrlyWsIKi7Mv9WqadgpdcJb5pl2whwOLaheMd3PQX0w1RtRBQi/L5
0wAsNCyF9ig2MBnEqO5QHquJWCbtdD2flyHq0eYzYJi8SJU+eQFykLcu+LfW2fVM9hDzdPhcrMlq
PqyM9PfcmYbe7XhKtz20fygBueOXqgyULZfK8UGCI54c9VQdmMq0Z7nzJjtY3q7nmGLPc/U6mAht
+u09Y6CGiwZZ+OLtA9ivZLUv1QWvIgGb3x6o7vL+f3VF1JTcKl86P8509eTBAtrN9j+gAj5aYNnF
Zb4rhxsNEQGTMIFOAA2CwpPsyXnN9oLxZIfkftuIM2SbmMTJtMnzbbN51cF/WfVN1V+IExSnxUrA
J0nTgU+xekKtr/qRGOzK3M+5yFfqXehpHp+UqMK3JiQ1Ce9FeVDnh7MZNUsWRYXtapfDfFYM786U
D0/9n6DZXJi3Pulj5k/T8hjzwALHVej9Y+cjY/7UXfS/g249ws5Dbox5DxHspVd/SbJj/tyVGxUR
mUb524KzCGWThpODlI3xM+micnpX4qI8U2xR70GiX5fWb0DHZTGdbtVWh2FT6nAw63lLnPY2U7mL
lL6utlKYtc+elY7hz2SF/nJrGVhfYCunqv3vdehCH+hRUW3XqSaIDygE/Ui+97JXSdFnejjJokl6
5j6Z5RE9+aypaadvQuERQeq/EfPjIrb1y5qVwMR6shfhvtoShNQEM1gFXmO+gFq+hBM7kd0VhFyP
CA6+pX5q5Hrl8v1ajQPts7G2P30W841Sck+i7aNpGJtQJ2JR56GN7ctrj6Khb5P8lDsQpreOGFo7
sqsZbb4m2VzxzMj5YfYncl/LiLmva60VsBkH/2ZeMc0fpRIpaCfceIpnewJPvPHtjjLHpPUUtJJe
fQFsWMIvwD9Dh5GJXQxFTY4iaHTIFsrNxCxe8fWi2bIkY5oN6sNVF1DhVNHLjRh4Ac6pBevahYqh
MpMF1ADxZKhHHgzcCi+zHbY3lxitGRsNffpMIy/8FfXovUzzFbHv2sBxBf6Wc5bUF9oSBIaV/48D
03AeKIjvwMX6JszRLr8fphxZz1fDhwwk0jO81+z8g8rHEqQg+VkOKMRXLzUjLQWEl8c7RJVvdTQR
G7dVZ97beTxCN07OzygpHUMK97X9bGShsmU4b8zOPAcLBX2iEPDrUnzkaaQu+MeA1il3kAowYK06
cmYOQQ5V/AMafF2HsfDBZWZUyEkxfqcY0yZYdH0z6g7Cw1JM4+2Xt3usfZuUzf3AMZkPzVBgyrU7
J2A4IREIEcqARIvQ+uB0WgvWk5+VilXuoUIdNKohIiF51mdG/qpnhA+SLQZ8FAdJWU/NFntL09HP
yRYLM7kxLbPtKBSo2rllnTW6MPAkTg+WB1U8PflEg4RqqO1j6zChImXW8A1yJBJ8NNsMOYWTlE9V
/Fc4Em7lS7RtBb2bYK6QOQJFSh/Myauvdb5YxfqZWKQkq5fCnnzkDMuzctkGQbR4UCEcX9EZe+5U
c8KJHetElOWT/hOItbvtLLwIhcpxz+pDnhGvoHAbFgBsI5tVI6k3sqvfnO46FMQ/FCXUQcTNhMZ3
O67HiKsO7Pb3nEf64rcQrPr8zaddQwMfyE1rfWNo8R2g8Y9tD73ZkXBUDA3pddzEc5qkLRKqDHcG
HbRCykMgtJBDrxpru90X73EvZPOymajnSxbKZbJlrglW96IzADCz1f+q/yzKVPs4FEZ2g/+ImV6k
E/1T8coqF8g25EqbQWJgeLgLgZkms+NPcPPhRljW9zfj6H2XeIr3MTd99rwzA992CXPKogpNGDqd
QIUIsibhIOhNy71HlkuC5oT/zYt14qVbYQX8aJmWcEgvWy770dNpV0WTS3tYmje9tTSPt0EmvL/c
5eBKue4RO7zooIsGa+cFwvhlHekR4EPMI7xQ2nYQRyqYs86WdKqzwpHveBX71y1PPJjI2dQipJkn
5/LQQMv3p5KCEFIxFRUrixll9Je41PNCa245r3o/brWOWNXshF0jeZtrjhrUKl6Th2BXvFg2iaqR
t7jHYNPl2gFiM/Ws5nN8tlZ/TA6CVw9v8/+FV8otQ65IKUvFpIuRGU3ziSxnj7csoOIYqp2yjDz5
CLy91AuKF4zwEAdppGZUY6b1KegsLO59uUTnWpvGIUEG5lghyKutQPP3N/uiqeOu0GM+lXRmGf/6
VFW4vpxQHbdfMqwzagM+HnHO0PzdrgG/wZzJ6RrWtNbyUJUAcR2G5vl+SSlLLUmxZ/dOC3X2ypJ8
dQvobA/DtCh+v/3JCyjhmvON4blUZvQh6qLrsyuSVkW0jJE5w8/X2ryUNeapkDvb+NL31gJtLoNG
iizIJlNh72yNrZuf5XC5dzPNkIJy7ghMy2NShK/IiOLbaww3WLHLOQ0WGd7vkm+g0LhA0mrc2TW+
vRau2xaa2AR7y2oJvUIjMhuMbqaxcI5fW2AV0LPQdn88UK7gRhmANaf0kYBZx+016oh2isBQBE2g
x27N4HpQiTHM+oFK4sdj4JJd4o6zIjCtaXce5loY1/uS85xdqqNQ89WtllRgBUuqRreVLqkJWdxy
lwG/NijnO7YlGbPnjAga9jpB15zuSR5jOlkDLoVjjQmScgDdfHS9pBYXSKHroTG4isWeTYjedB2L
XgFSqB/AWmiDoW8GvEY7QDpb4wQ7SRxq+Hf4VeJLVKGPeSJGGEKFP3ZXD40bs9QBY5f81p3ukICs
fHKTV1MCztkXAkcgteJrZJHuFzB5LolaGXEXlzbhinfpk7SNMSAfZTzKU8KoEhHYcOZ/0/qlxv3N
GlogfDQa7cn5eL8mUFD7JBymBZwhb8xEhoP4p0nBWvSe76GNvIBAsLjtfroDQx7hMSb9DiBlkOb5
7QrRMowXsCTKCPpngyiEYl9B+AEfxrqOES4HFkE/32pbdVwJsmcJ+Ep3stfvnoVRT8CixhytQuXa
p7wp6Rj9lN5NTWLtNNg/bf/a63Iw6+Ct89v6MVCHUfa+BfSYYwZ4l5VklU6rxG1+n67BC4AvMk8F
0YdPMLiBWxBfWmRK7mAk4Z75vPDY1HfH/xge6D6AOgtbaqAMdEnM/qHTT3h8LVhxzqp/2MqRT+by
zCdM63jVuX7rzJyoGC7Ygze8xUmnRdiOzPjwWeM4oq4ZGgEaasGhw2Xlmt9X5FVFwpexcQYRmLyg
q7CQo18X/ML/W1uUB5J00roOTzSlgzXO+B1cvx5rjkvLfHNgjD8A1Vk7OBNMYtTU37PYkqzpwVhJ
aZBfoOO2ZipEpnfmfa8RXVlxexq39wJXFH0LmK1a5L6dTRuPJKgtvZwsXjM6mR4rG2CDT8APJ1GW
wA8wCAhad1FLtOOJwAQzCX06sjvXWUP/RCWyL5fW3R1zIXLYOO99ccviEisvlgC8x0TGClw1HD9E
m8IVfKWbkuBCapwcRNHhMdWyEO3PMjHPoAyaAVUZbUhyvWGqIT3AaesY9VAuBNk/LSrCJcWLRbKn
zu4JVlWh8eLp1u3NR7ydSfeHRtTtESagTXrZijBpQPntYKUCMlOSMlb/dYjLwckM1gc5ptNA6v0f
ek8EOW2RjbInUbd89VZRMNO74PoIStRa/zQILNpxvQ40Zzxwd4oSaenBLqJCzgvWVWsJuQkSLP+X
MytxfolJNk0817E35K1tnI5sDOd8R/tuVwxaqtUDgJ3TT/yaXlVxkWcIVE95Qaxkj/TqffCjRhIH
XbzUgXqUkmjVgtPo0GiCHL+Ycmvc0QC5EvWYhp10DvyUrCSPevyLkP0QsLuL3URBJe2sji5DuWHh
xVCSs3wm2j29Y8CV9PdJQ+Qx+f8UB2h/wWWULSG/uaKENHQMgXn6+rDR0RRNQCp71V7Kx8vWQ6Bi
881AXqd3pqUsjKUSbWQFlvuY92Nnohmnl2SKuynoCQJXx83/o3j7RF4LY72ubNeDtJOUyi46iLb+
ZUQmtUKk31ySW5KBkP5YPMcAtDi1xCteePRVutBQIGASvcaUvd2MBrB2bLa67fQwEuEVyhI5JPv7
/Zy4HPKFsXgydOPiCd5gPlUAOZim3RHVevY/Y/Iqrncm7Relr4XzdKCA7LYtSb4gQih5+Arvik/7
des08Nc2fD5DrpK/DtIkW7b1LxJ7OYG+Q+cEvwOB8EZZTuX9Y3r4u6pV9GVDtb6Ljv8iQeRZblgV
fQDplljsbJmbFmo6Wp5nuHJqg/TNK5CBLxUpcVvwCu2EZOH37+apNeSpo9oR9E+GxHFX3TomikH3
E4Bjf9O1iaJmsxENdhUcVo2yQ10uReAcpL4fzEZM0LFLTZTTsM8TUJZidlqlFgWLfyFeAiHkiyS2
GfW/gBct+liZ0VNb/HyAe5xolHyI6sNtwttfgEmiZN/3xHPIbilVfVA3ViuLdjfWnZ4GnqUC1qt4
pXaDG17+HLLD2Gc5a7gOoWSbJBLxTtF9JTNPW6GOy4hURzXg9DpxYaPCxwuqLmFs2oTq5z8+gd2W
fAidaHGm8ItNBBNG6GduCS8szIbDGnw8zM3gLLUzD1Tc5hzTvq3t9WmXMoz8DfI6Cnf+4Vt3J76+
b37u5DPfcBoKX1ldLZ4MOs3hOpzBBFYpNOTNjaKdQpUQUk43oo1vLSFA6rbsyk+0UHZtkwjLxLqy
1OEku7rtrCXEdeVo6tbddIpyeDtWBvjET+HXx218AzyZCXgUX8Suypb7JoMZBZpR/WjkxfdAd50e
ibbff40qlrnXScNY/yKg86eo8ztc5N4LSXe6PozIDz28M45CPwlLAPL7lPkkE9R96p63oX093Bx8
J7War6YXomoDf32+0ky7rj1D67Ro2tQ6HRXKFTyhdXAFx23teTdgXxHhur053j/qb6x9HcNLOED/
39AZwfpKIjjOEi6MhJfh37stKD/0mFlcDjNB3aU4mVLoG4ZmYZWW8sG8D+Pr8rMHRJJ3P7zfrcLS
IpBGqumjIUcXqHH7NWkRISgophynbvUFgpvjSYtZwbh0GKBu+CpKALs8FwGnYbIcx3clQMsMMTIK
GCfJYtRfbZ/2tZsBeQE0f4orv7BMM5PQ/4L0uhh6BIblNKnaGt5aNDDqIlK7Kjd/7HGxSv2Us8aR
ut/oW1NxJ0jZuOszboHT+Mvdgp+27Ctb1zlAEciNt2x/8TanfHqeuBmHJMNCbYeKbFuN+pa4FKND
gikM9Zxm96/4Udr3ajlTxsKmPIu75ft6rkdjWy/MPeDmSLeK0UQLpGFX5AIbBCOhCalS5OBDFzDy
3mdiOuuvoFncRsaWiUrAsE5fRnSZL0TK+z88Mzr5V7XQNW8/qPOrRB0f4jb6//xLieUev4qs0+Fm
Cro83cHYprvE00a7WFmi6Dtf+gWO6Y3TZ8zlrBXyzficUlEl93x8Bzxaezj7v9pYiMwBMvTRg/xF
hgt++4PFOg2W65Xjmtep9R8zDlyjGZkUvn9JwoqY50Or0ddeR2pE14Gp/jZQST0VO3mPdrta/dl1
mvOyHyS9jgH79u8RpC42F/vOAetuqeI9WJMbX5MDEULhFrqGSnuWSe0CCKY6eAfGDB8SHEdhWToj
deW7esloYiLtYXxqjI5M3pKe6MAYmt/YtMP25vbQAT+RF+IEiA/iQFgJmg/XnKwFXqrnOcig4WNB
WfaBLAId6zTfJkbjU+pQKZKoif+eLdhedOnGMD9kSB8l4h7mR0hfrZYbFx6Hd40EQ89YW3eJ2uOH
m8TFBCKTVgoefHuMAW/vzi0app95fQs5yErs3+D+7506BtP3jjUFG8zGE+rPvWppeuP/7eNcluNk
aJVgENKfTysd8l/prUdZPoWnwJXtu/d8qR3psZRNvljq1b/fFcBwQ4JyShdag1lXgLZzjbojQ84Y
hGzBdAYz3QyEHbNQHSZrAwDxlpVBBMNE4jwp1JMbyjFa6Hwr4Y9huBrJ6I2HuAJDR/z1IvaJz6tw
dCtlTsxTG4BthGZ9MOvq/hXGm+RH+8RLXOh3yNdtvMVIaKX1yGrde+BmaxJkS0TO3JWWjh98Ufww
OMMfZQkeX6m3Z2Z0I3UQ84oR9OKcW4HmZJfCcCfMcuM0liv/VKqn9BzSVWNGYLeonSm2oy3GL7W6
J0jPTcuHKhtAWWsCve+C5RMGDYwvFo1BWvHy8JtNnJsyNbGr26VvB3/XOGlkPK6jtCDlQv1SqR3J
7SRVPWp2b0DjPtU09H4oS+pY+aAa2Avxs2v2HFpxyy8XemxHkqeTFBMPgBr8B5SkWbggvtP7nKY1
bIjo+0la8h40Q8o54Ju5iw2E6kI772f8uEdgJOTVRxK0XyqAlEi5Cyexq/u120wCjE74GGDXXL45
Jawu1kA7JUEIhoRctjFXIMpSOWNOHRPdtm/POOH8GJbbwp04Xo5fXQtud5N797/FZWeBafRaY4Rq
0fgAjg14K0Fm1SoRryKbDMcSoxjHcHlt5jG6UCRBYyHU+ccOX+4d60iFFJ609yggHlf6hQk7GriX
0nKUsNublsCYr+i1vrJ2H1ZRTzGYiUPfoNo+LbfJuWZWLgZ6dXM8vSyNF88FA2s1l9ujBXrf1m3m
ojJI18P8bet5OtI52WsmH8SZjcIAps7qwcbDeoKBZNw+D6Jiu7GKYaEmqFQ6coCIIMlOjpj3NNmt
posKGZasAw5Ec8WMNTcUHq3vfMmxm2Eo8LzUKLK6k7sPiqjyRQez0mE2STsnbfABPMaokZswERzw
8LWS5OWGtqeoOCoF41exyDZoRbW144GkDYCjpqzVxn5RjwPMYTpbF1r7IJUgygwzHf7wqT9qZce5
pVEx9/7uroCJE76Pp4smqTVqgiuVZu7rOgVELk+sGvk8xzF4McNIAwYEmAKTawujlmRK2w2kU4Ss
ASF3xO49C26xyqW4B6pYmDMKLc5bsb+eBXAEKc5dG/TABtBmrXbABzlGncmzT0EiBGrrQXYjcfiI
klLEWYbUTTUfHuRY5R053PFlIxIU0DFmilXO7aXWShaEY12ygirUCEbWiQBI/nLlPqXNZ4ECQVmn
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
