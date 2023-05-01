// random rst and input

class seq_rand extends uvm_sequence #(transaction);
	`uvm_object_utils(seq_rand)
	transaction trans;

	function new(string name="seq_rand");
		super.new(name);
	endfunction : new


	virtual task body();
		trans=transaction::type_id::create("trans");
		repeat(8) begin
			start_item(trans);
			trans.randomize;
			$display("----------------------------------------------------------");
			`uvm_info("seq_rand",$sformatf("d=%0d | rst=%0d",trans.d,trans.reset),UVM_NONE)
			finish_item(trans);
			//repeat(2) @(posedge dif.clk);
		end
	endtask : body

endclass : seq_rand
