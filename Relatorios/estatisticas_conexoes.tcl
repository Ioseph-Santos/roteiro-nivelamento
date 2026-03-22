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
            # Se a linha tem '[', o nome real é o 3º elemento (índice 2)
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


puts "=== LISTA DE NETS (TAREFA 3) ==="
puts "Inputs:  $nome_in"
puts "Outputs: $nome_out"
puts "Wires:   $nome_wire"


set todas_as_nets [lsort -unique [concat $nome_in $nome_out $nome_wire]]
puts "\nTotal de nets únicas encontradas: [llength $todas_as_nets]"
