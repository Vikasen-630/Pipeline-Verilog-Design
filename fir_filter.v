module fir_filter(
    input clk,
    input reset,
    input signed [7:0] x,
    output reg signed [15:0] y
);

reg signed [7:0] h[0:2]; // coefficients
reg signed [7:0] x_reg[0:2];

integer i;

initial begin
    h[0] = 1;
    h[1] = 2;
    h[2] = 1;
end

always @(posedge clk) begin
    if (reset) begin
        for(i=0;i<3;i=i+1)
            x_reg[i] <= 0;
        y <= 0;
    end else begin
        // shift register
        x_reg[2] <= x_reg[1];
        x_reg[1] <= x_reg[0];
        x_reg[0] <= x;

        // FIR equation
        y <= h[0]*x_reg[0] + h[1]*x_reg[1] + h[2]*x_reg[2];
    end
end

endmodule