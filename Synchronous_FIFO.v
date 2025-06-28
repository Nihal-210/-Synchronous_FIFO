`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/27/2025 10:19:29 PM
// Design Name: 
// Module Name: Synchronous_FIFO
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

module Synchronous_FIFO (
    input clk,
    input rst,
    input r_en,
    input w_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output reg full,
    output reg empty
);
    parameter width = 8;
    parameter depth = 4;

    reg [width-1:0] mem[0:depth-1];   // FIFO memory
    reg [1:0] r_ptr, w_ptr;           // 2-bit pointers for depth=4
    reg [2:0] count;                  // count from 0 to 4

    always @(posedge clk) begin
        if (rst) begin
            data_out <= 0;
            full <= 0;
            empty <= 1;
            r_ptr <= 0;
            w_ptr <= 0;
            count <= 0;
        end
        else begin
            // Write logic
            if (w_en && !full) begin
                mem[w_ptr] <= data_in;
                if (w_ptr == depth - 1)
                    w_ptr <= 0;
                else
                    w_ptr <= w_ptr + 1;
                count <= count + 1;
            end

            // Read logic
            if (r_en && !empty) begin
                data_out <= mem[r_ptr];
                if (r_ptr == depth - 1)
                    r_ptr <= 0;
                else
                    r_ptr <= r_ptr + 1;
                count <= count - 1;
            end

            // Update full and empty flags
            if (count == depth)
                full <= 1;
            else
                full <= 0;

            if (count == 0)
                empty <= 1;
            else
                empty <= 0;
        end
    end
endmodule
