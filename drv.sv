
class drv extends uvm_driver #(transaction);
	`uvm_component_utils(drv)
	transaction trans;
	virtual d_if dif;

	function new(string name="drv", uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		trans=transaction::type_id::create("trans");
		if(!uvm_config_db#(virtual d_if)::get(this, "", "dif", dif))
			`uvm_error("drv","unable to access uvm_config_db")
	endfunction : build_phase	

	virtual task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(trans);
			dif.d<=trans.d;
			dif.reset<=trans.reset;
			`uvm_info("drv",$sformatf("d=%0d | reset=%0d",trans.d,trans.reset),UVM_NONE)
			seq_item_port.item_done();
			repeat(2) @(posedge dif.clk);
		end

	endtask : run_phase

endclass : drv
