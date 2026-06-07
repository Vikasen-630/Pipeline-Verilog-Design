module fir_filter_tb;

reg clk, reset;
reg signed [7:0] x;
wire signed [15:0] y;

fir_filter uut(
    .clk(clk),
    .reset(reset),
    .x(x),
    .y(y)
);

// clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    x = 0;

    #10 reset = 0;

    // input samples
    #10 x = 1;
    #10 x = 2;
    #10 x = 3;
    #10 x = 4;
    #10 x = 5;

    #50 $finish;
end

initial begin
    $dumpfile("fir.vcd");
    $dumpvars(0, fir_filter_tb);
end

endmodule