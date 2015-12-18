///////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version : 3.6
//  \   \         Application : 7 Series FPGAs Transceivers Wizard
//  /   /         Filename : gtwizard_common.v
// /___/   /\     
// \   \  /  \ 
//  \___\/\___\
//
//
// Module GTWIZARD_common 
// Generated by Xilinx 7 Series FPGAs Transceivers Wizard
// 
// 
// (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


`default_nettype wire

`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration************************

module gige_sfp0_gt_common #
(
    // Simulation attributes
    parameter   WRAPPER_SIM_GTRESET_SPEEDUP    =   "FALSE"     // Set to "true" to speed up sim reset
)

(

    output          PLL0OUTCLK_OUT,
    output          PLL0OUTREFCLK_OUT,
    output          PLL0LOCK_OUT,
    input           PLL0LOCKDETCLK_IN,
    output          PLL0REFCLKLOST_OUT,    
    input           PLL0RESET_IN,
    output          PLL1OUTCLK_OUT,
    output          PLL1OUTREFCLK_OUT,
    input           GTREFCLK0_BUFG_IN,
    input           GTREFCLK0_IN
);

//***************************** Parameter Declarations ************************
    parameter PLL0_FBDIV_IN      = 4;
            
    parameter PLL1_FBDIV_IN      = 1;
    parameter PLL0_FBDIV_45_IN   = 5;
    parameter PLL1_FBDIV_45_IN   = 4;
    parameter PLL0_REFCLK_DIV_IN = 1;
    parameter PLL1_REFCLK_DIV_IN = 1;

    // ground and vcc signals
wire            tied_to_ground_i;
wire    [63:0]  tied_to_ground_vec_i;
wire            tied_to_vcc_i;
wire    [63:0]  tied_to_vcc_vec_i;
wire PLL0RESET_I,cpll_pd_i,cpll_reset_i;
(* equivalent_register_removal="no" *) reg [95:0]   cpllpd_wait    =  96'hFFFFFFFFFFFFFFFFFFFFFFFF;
(* equivalent_register_removal="no" *) reg [127:0]  cpllreset_wait = 128'h000000000000000000000000000000FF;

//********************************* Main Body of Code**************************


always @(posedge GTREFCLK0_BUFG_IN )
begin
  cpllpd_wait <= {cpllpd_wait[94:0], 1'b0};
  cpllreset_wait <= {cpllreset_wait[126:0], 1'b0};
end

assign cpll_pd_i = cpllpd_wait[95];
assign cpll_reset_i = cpllreset_wait[127];
assign PLL0RESET_I = PLL0RESET_IN | cpll_reset_i;



    assign tied_to_ground_i             = 1'b0;
    assign tied_to_ground_vec_i         = 64'h0000000000000000;
    assign tied_to_vcc_i                = 1'b1;
    assign tied_to_vcc_vec_i            = 64'hffffffffffffffff;

    //_________________________________________________________________________
    //_________________________________________________________________________
    //_________________________GTPE2_COMMON____________________________________


    GTPE2_COMMON #
    (
            // Simulation attributes
            .SIM_RESET_SPEEDUP   (WRAPPER_SIM_GTRESET_SPEEDUP),
            .SIM_PLL0REFCLK_SEL  (3'b001),
            .SIM_PLL1REFCLK_SEL  (3'b001),
            .SIM_VERSION         ( "2.0"),

            .PLL0_FBDIV          (PLL0_FBDIV_IN     ),	
	          .PLL0_FBDIV_45       (PLL0_FBDIV_45_IN  ),	
	          .PLL0_REFCLK_DIV     (PLL0_REFCLK_DIV_IN),	
	          .PLL1_FBDIV          (PLL1_FBDIV_IN     ),	
	          .PLL1_FBDIV_45       (PLL1_FBDIV_45_IN  ),	
	          .PLL1_REFCLK_DIV     (PLL1_REFCLK_DIV_IN),	        

           //----------------COMMON BLOCK Attributes---------------
            .BIAS_CFG                               (64'h0000000000050001),
            .COMMON_CFG                             (32'h00000000),

           //--------------------------PLL Attributes----------------------------
            .PLL0_CFG                               (27'h01F03DC),
            .PLL0_DMON_CFG                          (1'b0),
            .PLL0_INIT_CFG                          (24'h00001E),
            .PLL0_LOCK_CFG                          (9'h1E8),
            .PLL1_CFG                               (27'h01F03DC),
            .PLL1_DMON_CFG                          (1'b0),
            .PLL1_INIT_CFG                          (24'h00001E),
            .PLL1_LOCK_CFG                          (9'h1E8),
            .PLL_CLKOUT_CFG                         (8'h00),

           //--------------------------Reserved Attributes----------------------------
            .RSVD_ATTR0                             (16'h0000),
            .RSVD_ATTR1                             (16'h0000)

    )
    gtpe2_common_i
    (
	     .DMONITOROUT                    (),	
        //----------- Common Block  - Dynamic Reconfiguration Port (DRP) -----------
        .DRPADDR                        (tied_to_ground_vec_i[7:0]),
        .DRPCLK                         (tied_to_ground_i),
        .DRPDI                          (tied_to_ground_vec_i[15:0]),
        .DRPDO                          (),
        .DRPEN                          (tied_to_ground_i),
        .DRPRDY                         (),
        .DRPWE                          (tied_to_ground_i),
        //--------------- Common Block - GTPE2_COMMON Clocking Ports ---------------
        .GTEASTREFCLK0                  (tied_to_ground_i),
        .GTEASTREFCLK1                  (tied_to_ground_i),
        .GTGREFCLK1                     (tied_to_ground_i),
        .GTREFCLK0                      (GTREFCLK0_IN),
        .GTREFCLK1                      (tied_to_ground_i),
        .GTWESTREFCLK0                  (tied_to_ground_i),
        .GTWESTREFCLK1                  (tied_to_ground_i),
        .PLL0OUTCLK                     (PLL0OUTCLK_OUT),
        .PLL0OUTREFCLK                  (PLL0OUTREFCLK_OUT),
        .PLL1OUTCLK                     (PLL1OUTCLK_OUT),
        .PLL1OUTREFCLK                  (PLL1OUTREFCLK_OUT),
        //------------------------ Common Block - PLL Ports ------------------------
        .PLL0FBCLKLOST                  (),
        .PLL0LOCK                       (PLL0LOCK_OUT),
        .PLL0LOCKDETCLK                 (PLL0LOCKDETCLK_IN),
        .PLL0LOCKEN                     (tied_to_vcc_i),
        .PLL0PD                         (cpll_pd_i),
        .PLL0REFCLKLOST                 (PLL0REFCLKLOST_OUT),
        .PLL0REFCLKSEL                  (3'b001),
        .PLL0RESET                      (PLL0RESET_I),
        .PLL1FBCLKLOST                  (),
        .PLL1LOCK                       (),
        .PLL1LOCKDETCLK                 (tied_to_ground_i),
        .PLL1LOCKEN                     (tied_to_vcc_i),
        .PLL1PD                         (1'b1),
        .PLL1REFCLKLOST                 (),
        .PLL1REFCLKSEL                  (3'b001),
        .PLL1RESET                      (tied_to_ground_i),
        //-------------------------- Common Block - Ports --------------------------
        .BGRCALOVRDENB                  (tied_to_vcc_i),
        .GTGREFCLK0                     (tied_to_ground_i),
        .PLLRSVD1                       (16'b0000000000000000),
        .PLLRSVD2                       (5'b00000),
        .REFCLKOUTMONITOR0              (),
        .REFCLKOUTMONITOR1              (),
        //---------------------- Common Block - RX AFE Ports -----------------------
        .PMARSVDOUT                     (),
        //------------------------------- QPLL Ports -------------------------------
        .BGBYPASSB                      (tied_to_vcc_i),
        .BGMONITORENB                   (tied_to_vcc_i),
        .BGPDB                          (tied_to_vcc_i),
        .BGRCALOVRD                     (5'b11111),
        .PMARSVD                        (8'b00000000),
        .RCALENB                        (tied_to_vcc_i)

    );
endmodule 

