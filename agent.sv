
class agent extends uvm_agent;
	`uvm_component_utils(agent)
	monitor m;
	drv d;

	config_dff cfg;

	uvm_sequencer #(transaction) seqr;

	function new(string name="agent", uvm_component parent=null);
		super.new(name,parent);
	endfunction : new

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m=monitor::type_id::create("m",this);
		//d=drv::type_id::create("d",this);
		//seqr=new("seqr",this);
 		 if(!uvm_config_db#(config_dff)::get(this, "", "cfg", cfg))
    			`uvm_error("AGENT", "FAILED TO ACCESS CONFIG");
  
 		 if(cfg.agent_type == UVM_ACTIVE) begin
    			d = drv::type_id::create("d",this); 
    			seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this); 
   		 end  
	endfunction : build_phase

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		d.seq_item_port.connect(seqr.seq_item_export);
	endfunction : connect_phase

endclass : agent
