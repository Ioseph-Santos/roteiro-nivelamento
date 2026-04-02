#hello:
	#echo "Hello, World"

SCRIPT_TCL = estatisticas_conexoes.tcl
RELATORIO = relatorio_completo.tcl
SHELL_SCRIPT = tarefa.sh

all: $(RELATORIO)
	bash $(SHELL_SCRIPT)

$(RELATORIO): $(SCRIPT_TCL)
	tclsh $(SCRIPT_TCL)

clean:
	rm -f $(RELATORIO)
