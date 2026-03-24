# Relatório completo





# Tarefa 2
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
	
	
# Tarefa 3

set arquivo "netlist.v"
set fp [open $arquivo r]

set nome_in {}
set nome_out {}
set nome_wire {}

while {[gets $fp data] >= 0} {
    set data [string trim $data]
    
    # Limpeza: remove caracteres que "colam" nos nomes
    set data [string map {"," "" ";" "" "reg" ""} $data]
    
    switch -glob -- $data {
        "input *" {
            if {[regexp {\[.*\]} $data]} {
                set nome [lindex $data 2]
            } else {
                set nome [lindex $data 1]
            }
            if {$nome != ""} { lappend nome_in $nome }
        }        
        "output *" {
            if {[regexp {\[.*\]} $data]} {
                set nome [lindex $data 2]
            } else {
                set nome [lindex $data 1]
            }
            if {$nome != ""} { lappend nome_out $nome }
        }
        "wire *" {
            if {[regexp {\[.*\]} $data]} {
                set nome [lindex $data 2]
            } else {
                set nome [lindex $data 1]
            }
            if {$nome != ""} { lappend nome_wire $nome }
        }
    }
}
close $fp

puts "=== TAREFA 3 ==="
puts "\nLISTA DE NETS:"
puts "Inputs:  $nome_in"
puts "Outputs: $nome_out"
puts "Wires:   $nome_wire"

set todas_as_nets [lsort -unique [concat $nome_in $nome_out $nome_wire]]
puts "\nTOTAL DE NETS ÚNICAS ENCONTRADAS:"
puts "[llength $todas_as_nets]"

# Array para armazenar o fanout de cada net
array set fanout {}

# Reabrir o arquivo para analisar as conexões
set fp [open $arquivo r]

while {[gets $fp linha] >= 0} {
    foreach {match porta net} [regexp -all -inline {\.(\w+)\s*\(\s*([^)]+)\s*\)} $linha] {
        set net [string trim $net]

        if {![info exists fanout($net)]} {
            set fanout($net) 0
        }
        if {$porta ne "y" && $porta ne "Q"} {
            incr fanout($net)
        }
    }
}
close $fp

puts "\nTOP 10 NETS POR FANOUT:"

# Converte o array em lista
set lista_fanout {}
foreach net [array names fanout] {
    lappend lista_fanout [list $net $fanout($net)]
}

set lista_ordenada [lsort -integer -decreasing -index 1 $lista_fanout]

# Pegar os 10 primeiros
set top10 [lrange $lista_ordenada 0 9]
foreach item $top10 {
    set net [lindex $item 0]
    set valor [lindex $item 1]
    puts "$net: fanout = $valor"
}

puts "\nNETS COM FANOUT ZERO:"
set erros 0

# Ordena alfabeticamente para facilitar a leitura
foreach net [lsort [array names fanout]] {
    if {$fanout($net) == 0} {
        puts $net
        incr erros
    }
}

if {$erros == 0} {
    puts "Nenhuma net com fanout zero encontrada."
}

# Tarefa 1

set arquivo "contador_netlist.v"

set conta_and2 0
set conta_xor2 0
set conta_flipflop 0


set fp [open $arquivo r]  
                    
while {[gets $fp data] >= 0} {

        set data [string trim $data]
        
      
        if {[string match "AND2 *" $data]} {
                incr conta_and2
        } elseif {[string match "XOR2 *" $data]} {
                incr conta_xor2
        } elseif {[string match "flipflop_D *" $data]} { 
                incr conta_flipflop 
        } 
} 

close $fp 

puts "Relatório de Instâncias"
puts "AND2: $conta_and2"
puts "XOR2: $conta_xor2"
puts "flipflop_D: $conta_flipflop"

