// 4-STAGE PIPELINE PROCESSOR

module pipeline_processor(
    input clk,
    input reset
);

// Instruction Memory (simple array)
reg [7:0] instr_mem [0:15];

// Register File
reg [7:0] reg_file [0:7];

// Pipeline Registers
reg [7:0] IF_ID_instr;

reg [7:0] ID_EX_instr;
reg [7:0] ID_EX_A, ID_EX_B;

reg [7:0] EX_WB_result;
reg [2:0] EX_WB_dest;

// Program Counter
reg [3:0] PC;

// Temporary signals
reg [7:0] result;
reg [2:0] opcode, dest, src1, src2;

// ---------------- IF Stage ----------------
always @(posedge clk) begin
    if (reset) begin
        PC <= 0;
    end else begin
        IF_ID_instr <= instr_mem[PC];
        PC <= PC + 1;
    end
end

// ---------------- ID Stage ----------------
always @(posedge clk) begin
    ID_EX_instr <= IF_ID_instr;

    opcode = IF_ID_instr[7:5];
    dest   = IF_ID_instr[4:2];
    src1   = IF_ID_instr[4:2];
    src2   = IF_ID_instr[1:0];

    ID_EX_A <= reg_file[src1];
    ID_EX_B <= reg_file[src2];
end

// ---------------- EX Stage ----------------
always @(posedge clk) begin
    case (opcode)
        3'b000: result = ID_EX_A + ID_EX_B; // ADD
        3'b001: result = ID_EX_A - ID_EX_B; // SUB
        3'b010: result = ID_EX_A & ID_EX_B; // AND
        3'b011: result = ID_EX_A | ID_EX_B; // OR
        default: result = 0;
    endcase

    EX_WB_result <= result;
    EX_WB_dest <= dest;
end

// ---------------- WB Stage ----------------
always @(posedge clk) begin
    reg_file[EX_WB_dest] <= EX_WB_result;
end

endmodule