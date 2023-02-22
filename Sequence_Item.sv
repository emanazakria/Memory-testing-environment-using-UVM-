class Sequence_Item extends uvm_sequence_item;

	`uvm_object_utils(Sequence_Item)
	
	function new ( string Name = "Sequence_Item" );
		super.new(Name);
	endfunction 
	
	//parameters 
	parameter Add_Width 	= 32 ;
	parameter Data_Width	= 32 ;
	
	//class variables 
	bit 							clk 		;
	logic 							rst 		;
	logic 							en 		;
	logic							wr 		;
	
	logic 							Valid_Out 	;
	logic 		[Data_Width-1:0] 			Data_Out 	;
	
	//random variables 
	randc bit 	[Data_Width-1:0] 			Data_In		;
	randc bit 	[Add_Width-1:0] 			Addr 		;

	//constraints for random variables
	constraint c1 	{Addr 		inside{[0:31]};}			;
	constraint c2 	{Data_In 	inside{[0:31]};}			;
	
endclass
