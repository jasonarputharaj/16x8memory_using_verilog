module memory_tb();
    reg clk, we, re, rst;
    reg [3:0] w_add, r_add; 
    reg [7:0] data_in;        
    wire [7:0] data_out;      

    // DUT instantiation
    memory dut (
        .clk(clk),
        .we(we),
        .re(re),
        .rst(rst),
        .w_add(w_add),
        .r_add(r_add),
        .data_in(data_in),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    initial begin
        // Init
        clk = 0; we = 0; re = 0; rst = 1;
        w_add = 0; r_add = 0; data_in = 0;

        // Reset
        #10 rst = 0;

        // Write operations
        #10 we = 1; data_in = 8'd10; w_add = 0;
        #10 we = 1; data_in = 8'd8;  w_add = 1;
        #10 we = 1; data_in = 8'd5;  w_add = 4;
        #10 we = 0;                  

       //write operation
        #10 re = 1; r_add = 0; 
        #10 r_add = 1;           
        #10 r_add = 4;           
        #10 re = 0;

        // End simulation
        #20 $stop;
    end

 
    initial begin
        $monitor("t=%0t | rst=%b we=%b re=%b w_add=%d r_add=%d data_in=%d data_out=%d",
                 $time, rst, we, re, w_add, r_add, data_in, data_out);
    end
endmodule
