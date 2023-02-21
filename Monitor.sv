class Monitor extends uvm_monitor;

	`uvm_object_utils(Monitor)
	
	function new ( string Name = "Monitor" , uvm_component parent = null );
		super.new(Name,parent) 			;
	endfunction 
	
	virtual intf 	Monitor_intf 						;
	Sequence_Item 	Sequence_Item_In 					;
	Sequence_Item 	Sequence_Item_buffer 				;
    uvm_analysis_port #(Sequence_Item) my_analysis_port	; 
	
	//build phase
	function void build_phase (uvm_phase Phase);
		super.build_phase(Phase) 		;
		
		
		Sequence_Item_In 		= Sequence_Item::type_id::create("Sequence_Item_In")		;
		Sequence_Item_buffer	= Sequence_Item::type_id::create("Sequence_Item_buffer")	;

		my_analysis_port		= new("my_analysis_port",this) 								;		
		
		if(!(uvm_config_db #(virtual intf)::get(this,"","vif",Monitor_intf)))
			`uvm_fatal(get_full_name(),"Error!")   
			$display("monitor_build_phase-->done ") 	;
			
	endfunction
	
	//connect phase
	function void connect_phase (uvm_phase Phase) 	;
		super.connect_phase(Phase) 					;
		$display("monitor_connect_phase-->done")	;
	endfunction	
	
	//run phase 
	task run_phase (uvm_phase Phase) 	;
		super.run_phase (Phase);
		
		forever begin
			@(posedge Monitor_intf.clk)
				
				Sequence_Item_In.rst  		<= Monitor_intf.rst 		;
				Sequence_Item_In.en  		<= Monitor_intf.en 			;
				Sequence_Item_In.wr  		<= Monitor_intf.wr 			;
				Sequence_Item_In.Addr  		<= Monitor_intf.Addr 		;
				Sequence_Item_In.Data_In  	<= Monitor_intf.Data_In 	;  
				
				if (Monitor_intf.Valid_Out) begin
						$display("start of monitoring")	;
						Sequence_Item_In.Data_Out  		<= Monitor_intf.Data_Out 		 								;
						Sequence_Item_In.Valid_Out  	<= Monitor_intf.Valid_Out 										;	
						$display(" Monitor	: data_out=%h , valid_out=%d",Monitor_intf.Data_Out,Monitor_intf.Valid_Out)	;
				end 
				
				#1 $cast(Sequence_Item_buffer,Sequence_Item_In);	
				$display(" Monitor	: data_out=%h , valid_out=%d",Sequence_Item_buffer.Data_Out,Sequence_Item_buffer.Valid_Out)	;
				my_analysis_port.write(Sequence_Item_buffer);
		
		end
		
		$display("monitor_run_phase-->done");
	endtask 
endclass