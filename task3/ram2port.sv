module ram2port #(
    //Dual port ROM

    parameter ADDRESS_WIDTH = 9, 
    // in order to have 512 x 8 bit dual-port RAM component change
    // address width to 9               
       DATA_WIDTH = 8
)(
    input logic                    clk,
    input logic                    wr_en,
    input logic                    rd_en,
    input logic[ADDRESS_WIDTH-1:0] wr_addr,
    input logic[ADDRESS_WIDTH-1:0] rd_addr,
    //add additional address and output 
    input logic [DATA_WIDTH-1:0]  din,
    output logic [DATA_WIDTH-1:0]  dout
);

logic[DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];


always_ff @(posedge clk) begin 
    if (wr_en == 1'b1)
        ram_array[wr_addr] <= din;
    if (rd_en == 1'b1)
    // add shift of 90 degrees to rom.sv to address input
    dout <= ram_array [rd_addr];
end 

endmodule 





