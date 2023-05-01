
class env extends uvm_env;
	`uvm_component_utils(env)
	agent a;
	scoreboard sc;
	transaction trans;
	seq_rst srst;
	seq_q sq;
	seq_rand srand;
	config_dff cfg;

	function new(string name="env", uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a=agent::type_id::create("a",this);
		sc=scoreboard::type_id::create("sc",this);
		trans=transaction::type_id::create("trans");
		srst=seq_rst::type_id::create("srst");
		sq=seq_q::type_id::create("sq");
		srand=seq_rand::type_id::create("srand");
		cfg=config_dff::type_id::create("cfg");
		uvm_config_db#(config_dff)::set(this, "a", "cfg", cfg);		
	endfunction : build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		a.m.send.connect(sc.rec);
	endfunction : connect_phase

endclass : env
