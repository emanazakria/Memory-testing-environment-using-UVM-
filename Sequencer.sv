class Sequencer extends uvm_sequencer #(Sequence_Item)				;

	`uvm_object_utils(Sequencer)
	
	function new ( string Name = "Sequencer" , uvm_component parent = null );
		super.new(Name,parent) 						;
	endfunction 
	
	//build phase 
	function void build_phase (uvm_phase Phase) 				;
		super.build_phase(Phase) 					;
			$display("sequencer_build_phase-->done ") 		;
	endfunction	
	
	//connect phase
	function void connect_phase (uvm_phase Phase) 				;
		super.connect_phase(Phase) 					;
			$display("sequencer_connect_phase-->done ") 		;
	endfunction	
	
	
	//run phase 
	task void run_phase (uvm_phase Phase) 					;
		super.run_phase(Phase) 						;
			$display("sequencer_run_phase-->done ") 		;
	endtask	

endclass
