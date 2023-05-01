// valid input

class seq_q extends uvm_sequence #(transaction);
	`uvm_object_utils(seq_q)
	transaction trans;

	function new(string name="seq_q");
		super.new(name);
	endfunction : new
 

	virtual task body();
		trans=transaction::type_id::create("trans");
		repeat(5) begin
			start_item(trans);
			trans.randomize with {trans.reset==1'b0;};
			//trans.reset<=1'b0;
	  $display("----------------------------------------------------------");
          `uvm_info("seq_q",$sformatf("d=%0d | rst=%0d",trans.d,trans.reset),UVM_NONE)
			finish_item(trans);
			//repeat(2) @(posedge dif.clk);
		end
	endtask : body

endclass : seq_q
