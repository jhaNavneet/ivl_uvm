`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   reg[3:0] dec_high_sig;


   // Instantiate OVL example
  ovl_decrement u_ovl_decrement ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (dec_high_sig)
			     ); 

  initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      rst_n = 0;
     dec_high_sig = 4'b0000;
	wait_clks(1);
  	
      rst_n = 1;
  
	wait_clks(1);
       
        dec_high_sig = 4'b0000;
	  
	wait_clks(1);
  dec_high_sig = 4'b1000;
	wait_clks(1);
dec_high_sig = 4'b1011;
	wait_clks(1);
dec_high_sig = 4'b0110;
	wait_clks(10);
      

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule

