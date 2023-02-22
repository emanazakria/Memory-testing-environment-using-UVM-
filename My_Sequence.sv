class My_Sequence extends uvm_sequence ;

	`uvm_component_utils(My_Sequence)
	
	function new (string Name = "My_Sequence", uvm_component parent = null);
		super.new(Name,parent);
	endfunction

	//instantiations 
	Sequence_Item Sequence_Item_In ;
	
	//create sequence item 
	task pre;
		Sequence_Item_In = Sequence_Item::type_id::create("Sequence_Item_In");
	endtask 
	
	task body;
		start_item(Sequence_Item_In)			;
		Sequence_Item_In.rst =  1			;
		finish_item(Sequence_Item_In)			;
		
		#10ns
		start_item(Sequence_Item_In)			;
		Sequence_Item_In.rst 		=  0		;
		Sequence_Item_In.Data_In 	=  0		;
		Sequence_Item_In.Addr 		=  0		;
		Sequence_Item_In.en 		=  1		;
		Sequence_Item_In.wr 		=  0		;
		finish_item(Sequence_Item_In)			;
		#10ns
		
		// case for write
		for(int i=0;i<32;i++) begin
			start_item(Sequence_Item_In)			;
			Sequence_Item_In.rst     	= 1		;
			Sequence_Item_In.en 	   	= 1		;
			Sequence_Item_In.wr 	   	= 1		;
			void'(Sequence_Item_In.randomize())		;
			finish_item(Sequence_Item_In)			;
			#5ns
		end
		
		// case for read
		for(int i=0;i<32;i++) begin
			start_item(Sequence_Item_In)			;
			Sequence_Item_In.rst     	= 1		;
			Sequence_Item_In.en 	   	= 1		;
			Sequence_Item_In.wr 	   	= 0		;
			void'(Sequence_Item_In.randomize())		;
			finish_item(Sequence_Item_In)			;
			#5ns
		end
		#100ns		
	endtask
endclass
