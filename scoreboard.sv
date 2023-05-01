
class scoreboard extends uvm_scoreboard #(transaction);
	`uvm_component_utils(scoreboard)
	transaction trans;

	uvm_analysis_imp #(transaction,scoreboard) rec;

	function new(string name="scoreboard", uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		trans=transaction::type_id::create("trans");
		rec=new("rec",this);
	endfunction : build_phase

	virtual function void write(input transaction trans);
	this.trans=trans;
	if(trans.reset) begin
		$display("===================================================================================================");
		`uvm_info("sco","The dut is under Reset",UVM_NONE)
		$display("===================================================================================================");
	end
	else if(trans.reset==0 && trans.q==trans.d && trans.qb==~(trans.d)) begin
		$display("===================================================================================================");
		`uvm_info("sco","Test Passed",UVM_NONE)
		$display("===================================================================================================");
	end
	else begin
		$display("===================================================================================================");
		`uvm_info("sco","Test Failed",UVM_NONE)
		$display("===================================================================================================");
	end		
		
	endfunction : write

endclass : scoreboard

//&& (trans.qb==~(trans.q))
