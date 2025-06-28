`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/28/2025 07:32:49 PM
// Design Name: 
// Module Name: tb_Synchronous_FIFO
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


`timescale 1ns / 1ps

module tb_Synchronous_FIFO;

    
    reg clk;
    reg rst;
    reg r_en;
    reg w_en;
    reg [7:0] data_in;

    
    wire [7:0] data_out;
    wire full;
    wire empty;

    
    Synchronous_FIFO dut (
        .clk(clk),
        .rst(rst),
        .r_en(r_en),
        .w_en(w_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    
    always #5 clk = ~clk;

    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, tb_Synchronous_FIFO);


        
        $monitor("Time=%0t | clk=%b rst=%b w_en=%b r_en=%b | data_in=%d data_out=%d | full=%b empty=%b",
                 $time, clk, rst, w_en, r_en, data_in, data_out, full, empty);

        // Initial values
        clk = 0;
        rst = 1;
        w_en = 0;
        r_en = 0;
        data_in = 0;

        /
        #10;
        rst = 0;

        // Write 
        @(posedge clk); w_en = 1; data_in = 8'd10;
        @(posedge clk); data_in = 8'd20;
        @(posedge clk); data_in = 8'd30;
        @(posedge clk); data_in = 8'd40;
        @(posedge clk); w_en = 0;

        // delay
        #10;

        // Read 
        @(posedge clk); r_en = 1;
        @(posedge clk);
        @(posedge clk);
        @(posedge clk);
        @(posedge clk); r_en = 0;

        
        #20;
        $finish;
    end

endmodule
