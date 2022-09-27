`timescale 1ns/1ns
module test;
  wire clk,fire;
  reg reset_n,en;
  reg [3:0]data;
  reg start_evnt,end_evnt;
initial begin
      // Dump waves
      $dumpfile("dump.vcd");
      $dumpvars(1, test);
end
ovl_win_unchange #( .width(4)) assert_win_change (.clock(clk), .reset(reset_n), .enable(en), .start_event(start_evnt), .test_expr(data), .end_event(end_evnt), .fire(fire));  
 

 initial begin
      
      // Initialize values.
      reset_n = 0;
      en = 0;
      start_evnt = 0;
      end_evnt = 0;
      data = 0;

      $display("ovl_win_unchange   does not fire at reset");
      wait_clks(1);
      
      
      reset_n = 1;
      en = 1;
      
       
      wait_clks(1);

      
      start_evnt = 1;
    data= 4'b1010;
      wait_clks(1);
      start_evnt = 0;
    data= 4'b1001;
      wait_clks(2);
      end_evnt = 1;
     
      wait_clks(1);
      end_evnt = 0;
      $display("ovl_win_unchange : check finish");
      
     
      $finish;
   end

   task wait_clks (input int num_clks = 1);
      repeat (num_clks) @(posedge clk);
   endtask : wait_clks

  ivl_uvm_ovl_clk_gen #(.FREQ_IN_MHZ(100)) u_clk_100 (clk);  
  
  
endmodule : test