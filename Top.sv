`include "Pack.sv"

module Top;

	import 		Pack::*			;
	import 		uvm_pkg::*		;
	
	
	intf	intf_in() 			;
    	memory	mem_16_32 
	    (
	      .clk(intf_in.clk)			,
	      .rst_n(intf_in.rst)		,
	      .en(intf_in.en)			,
	      .wr(intf_in.wr)			,
	      .addr(intf_in.Addr)		,
	      .data_in(intf_in.Data_In)		,
	      .data_out(intf_in.Data_Out)	,
	      .valid_out(intf_in.Valid_Out)
	    );

	initial begin 
        $dumpfile("dump.vcd")							;
        $dumpvars(0,Top)							;
        uvm_config_db #(virtual intf)::set(null,"uvm_test_top","vif",intf_in)	;
        run_test("Test")							;
	end 
	  
	always #5 intf_in.clk=~intf_in.clk 					;
endmodule 
