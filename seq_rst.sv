//valid reset

class seq_rst extends uvm_sequence #(transaction);
	`uvm_object_utils(seq_rst)
	transaction trans;

	function new(string name="seq_rst");
		super.new(name);
	endfunction : new


	virtual task body();
		trans=transaction::type_id::create("trans");
		repeat(5) begin
			start_item(trans);
			trans.randomize with {trans.reset==1'b1;}; 
			//trans.reset<=1'b1;
			$display("----------------------------------------------------------");
          		`uvm_info("seq_rst",$sformatf("d=%0d | rst=%0d",trans.d,trans.reset),UVM_NONE)
			finish_item(trans);
			//repeat(2) @(posedge dif.clk);
		end
	endtask : body

endclass : seq_rst
