
class transaction extends uvm_sequence_item;
	rand bit d;
	rand bit reset;
	bit q;
	bit qb;

	`uvm_object_utils_begin(transaction)
	`uvm_field_int(d,UVM_DEFAULT)
	`uvm_field_int(q,UVM_DEFAULT)
	`uvm_field_int(qb,UVM_DEFAULT)
	`uvm_object_utils_end

	function new(string name="transaction");
		super.new(name);
	endfunction : new

endclass : transaction