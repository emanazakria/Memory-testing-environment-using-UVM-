class Subscriber extends uvm_subsriber #(Sequence_Item);

    `uvm_component_utils(Subscriber)
    Sequence_Item Sequence_Item_Sub;
	
	//cover groups
    covergroup Addr_cov_grp;
			Addr: coverpoint Sequence_Item_Sub.Addr 
			{ bins Addr_range[32] = {[31:0]}; }
	endgroup
	
	covergroup data_cov_grp;
			DATA_ZERO	: coverpoint Sequence_Item_Sub.Data_In ;
			DATA_TOGGLE	: coverpoint Sequence_Item_Sub.Data_In
			{
				bins ZERO_ONE = (32'h00000000 => 32'hffffffff);
				bins ONE_ZERO = (32'hffffffff => 32'h00000000);
			}
	endgroup
	
	
    function new(string Name = "Subscriber" , uvm_component parent=null);
      super.new(Name,parent)		;
      Addr_cov_grp 	=	new()	;
      data_cov_grp	= 	new()	;
    endfunction	
	
	
	//build phase
    function void build_phase (uvm_phase Phase)						;
		super.build_phase(Phase)						;
		Sequence_Item_Sub = Sequence_Item::type_id::create("Sequence_Item_Sub")	;
		$display("subscriber_build_phase-->done")				;
	endfunction

	//------- write method ------//
	function void write (Sequence_Item Sequence_Item_w)	;
		Sequence_Item_Sub = Sequence_Item_w 				;
	
		Addr_cov_grp.sample()								;
		data_cov_grp.sample()								;
	endfunction	
	
endclass
