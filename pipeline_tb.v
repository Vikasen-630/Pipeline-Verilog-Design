`timescale 1ns/1ps

module pipeline_tb;

reg clk;
reg reset;

// Instantiate module
pipeline_processor uut (
    .clk(clk),
    .reset(reset)
);

// Clock generation
always #5 clk = ~clk;

initial begin

    $dumpfile("pipeline.vcd");
    $dumpvars(0, pipeline_tb);
    
    clk = 0;
    reset = 1;

    #10 reset = 0;

    // Run simulation
    #100 $finish;
end



endmodule