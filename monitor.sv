
class monitor extends uvm_monitor #(transaction);
	`uvm_component_utils(monitor)
	transaction trans;
	virtual d_if dif;

	uvm_analysis_port #(transaction) send;

	function new(string name="monitor", uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		trans=transaction::type_id::create("trans");
		send=new("send",this);
		if(!uvm_config_db#(virtual d_if)::get(this, "", "dif", dif))
			`uvm_error("mon","Unable to access uvm_config_db")
	endfunction : build_phase

	virtual task run_phase(uvm_phase phase);
		//@(negedge dif.reset);
		forever begin
			repeat(2) @(posedge dif.clk);
			trans.reset=dif.reset;
			trans.d=dif.d;
			trans.q=dif.q;
			trans.qb=dif.qb;
			`uvm_info("mon",$sformatf("d=%0d | q=%0d | qb=%0d",trans.d,trans.q,trans.qb),UVM_NONE)
			send.write(trans);
		end
		//send.write(trans);
	endtask : run_phase

endclass : monitor
