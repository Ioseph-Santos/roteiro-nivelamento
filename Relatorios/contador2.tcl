set arquivo "contador_netlist.v"
# Os módulos são somador, contador e flipflop
set fp [open $arquivo r]
set contaff 0
set contasomador 0
set contacontador 0
puts "=== Hierarquia do Design ==="

while {[gets $fp data] >= 0} {
	set data [string trim $data]
	
	switch -glob -- $data {
		"module *" {
			set nome_modulo [lindex $data 1] 
			#Pega a segunda palavra indice '1'
			puts "\nMódulo: $nome_modulo"
		}	
		"flipflop_D *" {
			incr contaff
			
			}
			
		"somador_4bits *" {
			incr contasomador
			
			}
			
		"contador_4bits *" {
			incr contacontador
			
			}
				
		"endmodule*" {
			if {$contaff > 0} {
				puts "\n Submódulo: flipflop_D($contaff vezes)"}
			if {$contasomador > 0} {
				puts "\n Submódulo: somador_4bits($contasomador vezes)"}
			if {$contacontador > 0} {
				puts "\n Submódulo: contador_4bits($contacontador vezes)"}
			if {$contaff == 0 && $contasomador == 0 && $contacontador == 0} {
				puts "\n Sem submódulos"}
			puts "--------------------------"
			
			set contaff 0
            		set contasomador 0
            		set contacontador 0
			
			}
			}
		}
	close $fp
