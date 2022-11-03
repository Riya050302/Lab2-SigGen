module rom #(
    parameter ADDRESS_WIDTH = 8,
    //define parameters of address width, 156 locations
                DATA_WIDTH = 8
)(
    input logic                    clk,
    input logic[ADDRESS_WIDTH-1:0] addr,
    // this means (adress width - 1): 0 aka 7:0
    output logic [DATA_WIDTH-1:0]  dout
);

logic[DATA_WIDTH-1:0] rom_array [2**ADDRESS_WIDTH-1:0];
// The rom array will contain 256

initial begin 
        $display("loading rom.");
        // the sinerom.mem file  file contains 256 samples of a single cycle cosine v
        //alues with a number ranging from 8’h00 to 8’hFF.

        $readmemh("sinerom.mem", rom_array);
        //the  $readmemh(.) function allows the ROM to be loaded 
        //with the contents stored in a file with numbers stored 
        //as hexadecimal code.

end;

always_ff @(posedge clk) 
    //output is sychronous
    dout <= rom_array [addr];
    // ROM output data on pos clock edge 

endmodule 
    
