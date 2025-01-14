module rom #(
    //Dual port ROM

    parameter ADDRESS_WIDTH = 8,               
       DATA_WIDTH = 8
)(
    input logic                    clk,
    input logic[ADDRESS_WIDTH-1:0] addr1,
    input logic[ADDRESS_WIDTH-1:0] addr2,
    //add additional address and output 
    output logic [DATA_WIDTH-1:0]  dout1,
    output logic [DATA_WIDTH-1:0]  dout2
);

logic[DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];

initial begin 
        $display("loading rom.");
        $readmemh("sinerom.mem", rom_array);


end;

always_ff @(posedge clk) begin 
    dout1 <= rom_array [addr1];
    // add shift of 90 degrees to rom.sv to address input
    dout2 <= rom_array [addr2];
end 

endmodule 


