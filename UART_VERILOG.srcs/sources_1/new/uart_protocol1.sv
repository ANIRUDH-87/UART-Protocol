`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.02.2025 19:01:43
// Design Name: 
// Module Name: uart_protocol1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_protocol1#(parameter BAUD_RATE = 9600, CLOCK_FREQ = 50000000)(
    input wire clk,
    input wire rst,
    input wire [7:0] tx_data, //data to transmit
    input wire tx_start,     // signal to start transmission
    input wire rx_serial,   // serial input for rx
    output wire tx_serial,     // serial output for tx
    output wire [7:0] rx_data,   // recieved data for output
    output wire tx_done,       // tx done flag
    output wire rx_done      // rx done flag
    );
      //internal signals
      wire baud_tick;
      //instantiate baud generator
      baud_generator #(
        .BAUD_RATE (BAUD_RATE),
        .CLOCK_FREQ(CLOCK_FREQ)
        )baud_gen_inst(
         .clk (clk),
         .rst(rst),
         .baud_tick(baud_tick)
         );
       //instantiate uart tx
       uart_tx1 uart_tx_inst(.clk(clk),
                             .rst(rst),
                             .baud_tick(baud_tick),
                             .data_in(tx_data),
                             .send(tx_start),
                             .tx_serial(tx_serial),
                             .tx_done(tx_done)
                             );
       // instantiate uart rx
       uart_rx1 uart_rx_inst (.clk(clk),
                              .rst(rst),
                              .rx_serial(rx_serial),
                              .baud_tick(baud_tick),
                              .data_out(rx_data),
                              .rx_done(rx_done)
                              );
endmodule
















