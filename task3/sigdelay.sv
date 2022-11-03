
module sigdelay # (
        parameter A_WIDTH = 9,
        //change address width
                  D_WIDTH = 8
)(
    //INTERFACE SIGNALS
    input logic              clk, //clock
    input logic              wr_en,
    input logic              rd_en,
    input logic              rst,
    input logic              en,
    input logic[A_WIDTH-1:0]   incr,
    input logic[D_WIDTH-1:0]    offset,  
    // offset needs to be on write address cause you havent read from new address yet         
    input  logic[D_WIDTH-1:0] din,
    output logic[D_WIDTH-1:0] dout
);

    logic [A_WIDTH-1:0]       address; //interconnect wire 

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en(en),
    .incr (incr),
    .count (address)
);

ram2port sineRam (
    .clk (clk),
    .wr_addr (address+offset),
    .rd_addr (address),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din (din),
    .dout (dout)
);

endmodule 


