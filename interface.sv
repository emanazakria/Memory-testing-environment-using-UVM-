interface intf #(parameter Add_Width = 32 , Data_Width = 32);

	bit 						clk 		;
	logic 						rst 		;
	logic 						en 		;
	logic						wr 		;
	
	bit 		[Data_Width-1:0] 		Data_In		;
	bit 		[Add_Width-1:0] 		Addr 		;
	
	logic 						Valid_Out 	;
	logic 		[Data_Width-1:0] 		Data_Out 	;
	
endinterface
