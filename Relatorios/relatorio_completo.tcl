# Relatório completo

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
