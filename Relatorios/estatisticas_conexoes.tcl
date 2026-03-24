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