class Env extends uvm_env;

	`uvm_component_utils(Env)
	
	
	function new (string Name = "Env", uvm_component parent = null);
		super.new(Name,parent);
	endfunction
	
	//instantiations 
	Agent 			Agent1		;
	Subscriber 		Subscriber1	;
	Scoreboard 		Scoreboard1	;
	
	virtual intf 		Confg_intf	;
	virtual intf 		Local_intf 	;
	
	//build phase
    function void build_phase (uvm_phase Phase)							;
		super.build_phase(Phase)							;
		
		Agent1		= Agent::type_id::create("Agent1",this)				;
		Subscriber1	= Subscriber::type_id::create("Subscriber1",this)		;
		Scoreboard1	= scoreboard::type_id::create("Scoreboard1",this)		;
	  
		if(!uvm_config_db#(virtual intf)::get(this,"","vif",Confg_intf)) begin
			   `uvm_fatal(get_full_name(),"Error!")
		end
		
		Local_intf = Confg_intf 							;
		uvm_config_db #(virtual intf)::set(this,"Agent1","vif",Local_intf)		;
		$display("env_build_phase-->done")						;
	endfunction	
	
	//connect phase
	function void connect_phase (uvm_phase 	Phase) 						;
		super.connect_phase(Phase) 							;
		Agent1.my_analysis_port.connect(Scoreboard1.my_analysis_export)			;
		Agent1.my_analysis_port.connect(Subscriber1.my_analysis_export)			;
		$display("env_connect_phase-->done")						;
	endfunction

endclass
