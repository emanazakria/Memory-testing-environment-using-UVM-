class Driver extends uvm_driver #(Sequence_Item);

	`uvm_object_utils(Driver)
	
	function new ( string Name = "Driver" , uvm_component parent = null )	;
		super.new(Name,parent) 						;
	endfunction 
	
	virtual intf 	Driver_intf 			;
	Sequence_Item 	Sequenc_Item_Driver 		;
	
	//build phase 
	function void build_phase (uvm_phase Phase) 	;
		super.build_phase(Phase) 		;
		
		if(!(uvm_config_db #(virtual intf)::get(this,"","vif",Driver_intf)))
			`uvm_fatal(get_full_name(),"Error!")
			Sequenc_Item_Driver = Sequence_Item::type_id::create("Sequenc_Item_Driver");    
			$display("driver_build_phase-->done ") 	;
	endfunction
		
	//connect phase 
	function void connect_phase (uvm_phase Phase) 		;
		super.connect_phase(Phase) 			;
		$display("driver_connect_phase-->done")		;
	endfunction
	
	//run phase 
	task run_phase (uvm_phase Phase);
		super.run_phase (Phase) ; 
		
		forever begin	
			seq_item_port.get_next_item(Sequence_Item_Driver) ;
			
			@(posedge Driver_intf.clk )
				Driver_intf.rst  		<= Sequence_Item_Driver.rst 		;
				Driver_intf.en  		<= Sequence_Item_Driver.en 		;
				Driver_intf.wr  		<= Sequence_Item_Driver.wr 		;
				Driver_intf.Addr  		<= Sequence_Item_Driver.Addr 		;
				Driver_intf.Data_In  		<= Sequence_Item_Driver.Data_In 	;
				
				$display("%p",Sequence_Item_Driver) 					;
				seq_item_port.item_done() 						;
		end
		
	$display("driver_run_phase-->done");
 	endtask
endclass
