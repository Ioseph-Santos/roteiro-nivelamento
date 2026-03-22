set arquivo "contador_netlist.v"
# Os módulos são somador, contador e flipflop
set fp [open $arquivo r]
set contaff 0
set contasomador 0
set contacontador 0
set bloco 0
puts "=== Hierarquia do Design ==="

while {[gets $fp data] >= 0} {
	set data [string trim $data]
	
	switch -glob -- $data {
		"wire *" {
	    		set bloco [lindex $data 1]
	    		if {[regexp {\[(\d+):} $bloco match numero]} {
			puts "\n número de fios (MSB): $numero"
	    }
	}		
		
			}
		}
	close $fp
