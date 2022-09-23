`timescale 1ns/1ns

module test;

   wire clk;
   reg rst_n;
   reg delt_high_sig;


   // Instantiate OVL example
   ovl_delta u_ovl_delta ( 
			     .clock     (clk),
			     .reset     (rst_n), 
			     .enable    (1'b1),
			     .test_expr (delt_high_sig)
			     );

defparam u_ovl_delta.width=4;
defparam u_ovl_delta.min=2;
defparam u_ovl_delta.max=4;


   initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);

      // Initialize values.
      rst_n = 0;
      delt_high_sig = 1;
 wait_clks(1);
delt_high_sig = 2;
wait_clks(1);

      $display("ovl_delta does not fire at rst_n");
      delt_high_sig = 0;
      wait_clks(2);

      rst_n = 1;
       delt_high_sig = 1;
      wait_clks(1);
      $display("Out of reset");

      delt_high_sig = 2;
      wait_clks(1);
 delt_high_sig = 3;
 wait_clks(1);
 delt_high_sig = 9;


     // $display({"ovl_delta expect 1- OVL_ERROR ",
       //         "when delt_high_sig is FALSE"});


      wait_clks(10);

      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);

endmodule

