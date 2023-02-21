class Agent extends uvm_agent;
	`uvm_component_utils(Agent)
	
	Driver 			Driver1  	;
	Monitor 		Monitor1 	;
	Sequencer 		Sequencer1 	;
	virtual intf 	Confg_intf	;
	virtual intf 	Local_intf 	;
    uvm_analysis_port #(Sequence_Item) my_analysis_port;
	
	function new (string Name = "Agent" , uvm_component parent = null);
		super.new(Name,parent) 	;
	endfunction
	
	//build phase
	function void build_phase (uvm_phase Phase) 						;
		super.build_phase(Phase) 										;
		
		//TLM
		my_analysis_port=new("my_analysis_port",this) 					;
	   
		Driver1 		= Driver::type_id::create("Driver1",this)		;
		Monitor1		= Monitor::type_id::create("Monitor1",this)		;
		Sequencer1		= Sequencer::type_id::create("Sequencer1",this)	;
	   
	   
		if(!(uvm_config_db #(virtual intf)::get(this,"","vif",Confg_intf)))
			`uvm_fatal(get_full_name(),"Error!")
		
		//connecting virtual interfaces
		Local_intf = Confg_intf ;
		
		uvm_config_db #(virtual intf)::set(this,"Driver1","vif",Local_intf) 	;
		uvm_config_db #(virtual intf)::set(this,"Monitor1","vif",Local_intf)	;
		
		$display("agent_build_phase-->done") 									;
	endfunction		
	
	//connect phase 
	function  void connect_phase (uvm_phase Phase)					;
		super.connect_phase(Phase)									;
		Monitor1.my_analysis_port.connect(my_analysis_port)			;
		Driver1.seq_item_port.connect(Sequencer1.seq_item_export)	; 
		$display("agent_connect_phase-->done") 						;
	endfunction

	
endclass