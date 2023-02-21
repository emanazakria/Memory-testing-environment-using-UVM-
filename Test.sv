class Test extends uvm_test;

	`uvm_component_utils(Test)
	
	function new (string Name = "Test", uvm_component parent = null);
		super.new(Name,parent);
	endfunction

	//instantiations 
	Env 			Env1		;
	My_Sequence 	My_Sequence1;
	
	virtual intf 	Confg_intf	;
	virtual intf 	Local_intf 	;
	
	//build phase
    function void build_phase (uvm_phase Phase)								;
		super.build_phase(Phase)											;
		
		Env1			= Env::type_id::create("Env1",this)					;
		My_Sequence1	= My_Sequence::type_id::create("My_Sequence1",this)	;
	  
		if(!uvm_config_db#(virtual intf)::get(this,"","vif",Confg_intf)) begin
			   `uvm_fatal(get_full_name(),"Error!")
		end
		
		Local_intf = Confg_intf 											;
		uvm_config_db #(virtual intf)::set(this,"Env1","vif",Local_intf)	;
		$display("test_build_phase-->done")									;
	endfunction	
	
	//connect phase
	function void connect_phase (uvm_phase Phase)	;
		super.connect_phase(Phase)					;
		$display("test_connect_phase-->done")		;
	endfunction
	
	//run phase
	task run_phase (uvm_phase Phase)				;
		super.run_phase(Phase)						;
		phase.raise_objection(this)					;
		$display("Before_start")					;
		my_sequence_in.start(Env1.Agent1.Sequencer1);
		phase.drop_objection(this)					;
		$display("test_run_phase-->done")			;	
	endtask
	
	
endclass