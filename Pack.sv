`include "interface.sv"

package Pack;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	//classes
	`include "Sequence_Item.sv"
	`include "Driver.sv"
	`include "Monitor.sv"
	`inculde "My_Sequence.sv"
	`include "Sequencer.sv"
	`include "Agent.sv"
	`include "Scoreboard.sv"
	`include "Subscriber.sv"
	`include "Env.sv"
	`include "Test.sv"
endpackage 