`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "transaction.sv"
`include "seq_rst.sv"
`include "seq_q.sv"
`include "seq_rand.sv"
`include "drv.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "config_dff.sv"
`include "agent.sv"
`include "env.sv"
`include "test.sv"

module tb;

d_if dif();

dff dut(.d(dif.d),.clk(dif.clk),.reset(dif.reset),.q(dif.q),.qb(dif.qb));

initial begin
dif.clk=0;
end

always #5 dif.clk=~dif.clk;

initial begin
	uvm_config_db #(virtual d_if)::set(null, "uvm_test_top.e.a*", "dif", dif);
		//`uvm_error("top","unable to access uvm_config_db")
	run_test("test");
end

/*initial begin
	$dumpfile("dump.vcd");
	$dumpfile();
	//#100; $finish;
end*/



endmodule : tb
