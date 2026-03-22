set arquivo "contador_netlist.v"
# Os módulos são somador, contador e flipflop
set fp [open $arquivo r]
set contanet 0
set nome_in {}
set nome_out {}
set nome_wire {}
while {[gets $fp data] >= 0} {
	set data [string trim $data]
	
	switch -glob -- $data {
		"input *" {
			set nome [lindex $data 1] 
			lappend nome_in $nome
		}		
		"output *"{
			set nome [lindex $data 2]
			lappend nome_out $nome
		}
		"wire *"{
			set nome [lindex $data 1]
			lappend nome_wire $nome
		}
		
	}
	}
	puts $nome_in
	puts $nome_out
	puts $nome_wire
	close $fp
	
