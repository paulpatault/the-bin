timer:
	gcc ./c/timer.c -o timer
	sudo mv timer /usr/local/bin

latexinit:
	ocamlopt ./ocaml/latexinit.ml -o latexinit
	sudo mv latexinit /usr/local/bin

all:
	make time
	make latexinit
