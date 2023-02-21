class Scoreboard extends uvm_scoreboard 	;
	
	`uvm_component_utils(Scoreboard)
	logic [31:0] wr_Data [0:31] ;
	logic [31:0] Addr 			;
	
	function new (string Name = "Scoreboard", uvm_component parent = null);
		super.new(Name,parent);
	endfunction
	
	//Instances
    uvm_tlm_analysis_fifo 	#(Sequence_Item) my_tlm_analysis_fifo	;
    uvm_analysis_export 	#(Sequence_Item) my_analysis_export		; 
    Sequence_Item	 		Sequence_Item_In 						;	
	
	//bulid phase
    function void build_phase (uvm_phase Phase)						;
		super.build_phase(Phase)									;
		my_tlm_analysis_fifo 	= new("uvm_tlm_fifo",this)			;
		my_analysis_export		= new("my_analysis_export",this)	;
		$display("scoreboard_build_phase-->done") 					;
	endfunction	
	
	//connect phase
    function void connect_phase (uvm_phase Phase) 					;
		super.connect_phase(Phase) 									;
		my_analysis_export.connect(my_tlm_analysis_fifo.analysis_export);
		$display("scoreboard_connect_phase-->done") 				;
	endfunction	
	
	//run phase 
	task run_phase (uvm_phase Phase) 		;
		super.run_phase(Phase) 				;
		
		forever begin
			my_tlm_analysis_fifo.get(Sequence_Item_In);
			
			if(Sequence_Item_In.Valid_Out == 1'b0) begin
				Addr = Sequence_Item_In.Addr;
			end
			
			if((Sequence_Item_In.wr == 1) & (Sequence_Item_In.rst == 1)) begin
				wr_Data[Sequence_Item_In.Addr] = Sequence_Item_In.Data_In;
			end
			else if(Sequence_Item_In.Valid_Out==1'b1) begin
					if(Sequence_Item_In.Data_Out == wr_Data[Addr]) begin
						Addr	= Sequence_Item_In.Addr;
						$display("test passed : data_out=%d , data=%d",Sequence_Item_In.Data_Out,wr_Data[Addr]);
					end
					else begin
						Addr	= Sequence_Item_In.Addr;
						$display("test failed  : data_out=%d , data=%d",Sequence_Item_In.Data_Out,wr_Data[Addr]);
					end
			end
			
			$display("data_out=%d",Sequence_Item_In.Data_Out)	;
			$display("valid_out.%d",Sequence_Item_In.Valid_Out)	;
	
		end
		
		$display("scoreboard_run_phase-->done")	; 
	endtask
endclass 